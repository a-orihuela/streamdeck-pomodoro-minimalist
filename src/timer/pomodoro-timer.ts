import { exec } from "node:child_process";
import { platform } from "node:os";

export type TimerPhase = "idle" | "work" | "break";

export type TimerState = {
	phase: TimerPhase;
	running: boolean;
	remainingSeconds: number;
	sessionCount: number;  // individual pomodoros (used for progress dots)
	cycleCount: number;    // complete cycles (pomodoros + long break)
	longBreakAfter: number;
};

export type PomodoroSettings = {
	workMinutes: number;
	breakMinutes: number;
	longBreakMinutes: number;
	longBreakAfter: number;
	soundEnabled: boolean;
};

const DEFAULT_SETTINGS: PomodoroSettings = {
	workMinutes: 25,
	breakMinutes: 5,
	longBreakMinutes: 15,
	longBreakAfter: 4,
	soundEnabled: true,
};

class PomodoroTimer {
	private phase: TimerPhase = "idle";
	private running = false;
	private remainingSeconds = DEFAULT_SETTINGS.workMinutes * 60;
	private sessionCount = 0;
	private cycleCount = 0;
	private isLongBreak = false;
	private intervalId: ReturnType<typeof setInterval> | null = null;
	private listeners = new Set<() => void>();
	private settings: PomodoroSettings = { ...DEFAULT_SETTINGS };

	getState(): TimerState {
		return {
			phase: this.phase,
			running: this.running,
			remainingSeconds: this.remainingSeconds,
			sessionCount: this.sessionCount,
			cycleCount: this.cycleCount,
			longBreakAfter: this.settings.longBreakAfter,
		};
	}

	onChange(cb: () => void): () => void {
		this.listeners.add(cb);
		return () => this.listeners.delete(cb);
	}

	updateSettings(incoming: Partial<PomodoroSettings>): void {
		const num = (val: unknown, fallback: number): number => {
			const n = Number(val);
			return Number.isFinite(n) && n > 0 ? Math.round(n) : fallback;
		};
		this.settings = {
			workMinutes: num(incoming.workMinutes, this.settings.workMinutes),
			breakMinutes: num(incoming.breakMinutes, this.settings.breakMinutes),
			longBreakMinutes: num(incoming.longBreakMinutes, this.settings.longBreakMinutes),
			longBreakAfter: num(incoming.longBreakAfter, this.settings.longBreakAfter),
			soundEnabled: incoming.soundEnabled ?? this.settings.soundEnabled,
		};
	}

	startOrResume(): void {
		if (this.phase === "idle") {
			this.phase = "work";
			this.remainingSeconds = this.settings.workMinutes * 60;
		}
		if (!this.running) {
			this.running = true;
			this.startInterval();
			this.notify();
		}
	}

	pause(): void {
		if (this.running) {
			this.running = false;
			this.stopInterval();
			this.notify();
		}
	}

	skip(): void {
		this.stopInterval();
		this.advancePhase();
		this.running = true;
		this.startInterval();
		this.notify();
	}

	reset(): void {
		this.stopInterval();
		this.phase = "idle";
		this.running = false;
		this.remainingSeconds = this.settings.workMinutes * 60;
		this.sessionCount = 0;
		this.cycleCount = 0;
		this.isLongBreak = false;
		this.notify();
	}

	private startInterval(): void {
		this.intervalId = setInterval(() => {
			this.remainingSeconds--;
			if (this.remainingSeconds <= 0) {
				this.stopInterval();
				this.advancePhase();
				this.running = true;
				this.startInterval();
				this.playSound();
			}
			this.notify();
		}, 1000);
	}

	private stopInterval(): void {
		if (this.intervalId !== null) {
			clearInterval(this.intervalId);
			this.intervalId = null;
		}
	}

	private advancePhase(): void {
		if (this.phase === "work") {
			this.sessionCount++;
			this.isLongBreak = this.sessionCount % this.settings.longBreakAfter === 0;
			this.phase = "break";
			this.remainingSeconds = this.isLongBreak
				? this.settings.longBreakMinutes * 60
				: this.settings.breakMinutes * 60;
		} else {
			if (this.isLongBreak) this.cycleCount++;
			this.isLongBreak = false;
			this.phase = "work";
			this.remainingSeconds = this.settings.workMinutes * 60;
		}
	}

	private notify(): void {
		for (const cb of this.listeners) cb();
	}

	private playSound(): void {
		if (!this.settings.soundEnabled) return;
		if (platform() === "darwin") {
			exec("afplay /System/Library/Sounds/Glass.aiff");
		} else if (platform() === "win32") {
			exec('powershell -c "[System.Console]::Beep(880,400)"');
		}
	}
}

export const pomodoroTimer = new PomodoroTimer();
