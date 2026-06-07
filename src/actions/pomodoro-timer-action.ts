import { action, SingletonAction, type KeyDownEvent, type WillAppearEvent, type WillDisappearEvent } from "@elgato/streamdeck";
import { pomodoroTimer, type TimerState } from "../timer/pomodoro-timer";

@action({ UUID: "com.aom.pomodorominimalist.timer" })
export class PomodoroTimerAction extends SingletonAction {
	private unsubscribe: (() => void) | null = null;

	override onWillAppear(_ev: WillAppearEvent): void {
		this.unsubscribe = pomodoroTimer.onChange(() => this.renderAll());
		this.renderAll();
	}

	override onWillDisappear(_ev: WillDisappearEvent): void {
		this.unsubscribe?.();
		this.unsubscribe = null;
	}

	override onKeyDown(_ev: KeyDownEvent): void {
		const { running, phase } = pomodoroTimer.getState();
		if (phase === "idle" || !running) {
			pomodoroTimer.startOrResume();
		} else {
			pomodoroTimer.pause();
		}
	}

	private renderAll(): void {
		const state = pomodoroTimer.getState();
		const svg = buildTimerSvg(state);
		const dataUrl = `data:image/svg+xml,${encodeURIComponent(svg)}`;
		this.actions.forEach((a) => a.setImage(dataUrl));
	}
}

function formatTime(seconds: number): string {
	const m = Math.floor(seconds / 60);
	const s = seconds % 60;
	return `${String(m).padStart(2, "0")}:${String(s).padStart(2, "0")}`;
}

function sessionDots(count: number, total: number): string {
	return Array.from({ length: total }, (_, i) => (i < count % total || (count > 0 && count % total === 0) ? "●" : "○")).join("");
}

function buildTimerSvg(state: TimerState): string {
	const { phase, running, remainingSeconds, sessionCount } = state;

	let bg: string;
	let label: string;

	if (phase === "idle") {
		bg = "#ef4444";
		label = "READY";
	} else if (phase === "work" && running) {
		bg = "#22c55e";
		label = "FOCUS";
	} else if (phase === "work" && !running) {
		bg = "#eab308";
		label = "PAUSE";
	} else if (phase === "break" && running) {
		bg = "#3b82f6";
		label = "BREAK";
	} else {
		bg = "#f97316";
		label = "PAUSE";
	}

	const timeStr = phase === "idle" ? sessionDots(sessionCount, 4) : formatTime(remainingSeconds);
	const sessionStr = phase !== "idle" ? sessionDots(sessionCount, 4) : "";

	return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 72 72">
  <rect width="72" height="72" rx="8" fill="${bg}"/>
  <text x="36" y="26" text-anchor="middle" font-family="sans-serif" font-size="13" font-weight="bold" fill="white">${label}</text>
  <text x="36" y="46" text-anchor="middle" font-family="monospace" font-size="18" font-weight="bold" fill="white">${timeStr}</text>
  <text x="36" y="62" text-anchor="middle" font-family="sans-serif" font-size="10" fill="rgba(255,255,255,0.75)">${sessionStr}</text>
</svg>`;
}
