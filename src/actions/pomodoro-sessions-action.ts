import { action, SingletonAction, type KeyDownEvent, type WillAppearEvent, type WillDisappearEvent } from "@elgato/streamdeck";
import { pomodoroTimer, type TimerState } from "../timer/pomodoro-timer";

@action({ UUID: "com.aom.pomodorominimalist.sessions" })
export class PomodoroSessionsAction extends SingletonAction {
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
		// Display only — no action on press
	}

	private renderAll(): void {
		const state = pomodoroTimer.getState();
		const svg = buildSessionsSvg(state);
		const dataUrl = `data:image/svg+xml,${encodeURIComponent(svg)}`;
		this.actions.forEach((a) => a.setImage(dataUrl));
	}
}

function buildSessionsSvg(state: TimerState): string {
	const { cycleCount } = state;

	return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 72 72">
  <rect width="72" height="72" rx="8" fill="#5886c7"/>
  <text x="36" y="22" text-anchor="middle" font-family="sans-serif" font-size="11" fill="#ffffff">SESSIONS</text>
  <text x="36" y="52" text-anchor="middle" font-family="monospace" font-size="30" font-weight="bold" fill="#ffffff">${cycleCount}</text>
</svg>`;
}
