import { action, SingletonAction, type KeyDownEvent, type KeyUpEvent, type WillAppearEvent, type WillDisappearEvent } from "@elgato/streamdeck";
import { pomodoroTimer, type TimerState } from "../timer/pomodoro-timer";

const LONG_PRESS_MS = 600;

@action({ UUID: "com.aom.pomodorominimalist.skip" })
export class PomodoroSkipAction extends SingletonAction {
	private unsubscribe: (() => void) | null = null;
	private keyDownAt = 0;

	override onWillAppear(_ev: WillAppearEvent): void {
		this.unsubscribe = pomodoroTimer.onChange(() => this.renderAll());
		this.renderAll();
	}

	override onWillDisappear(_ev: WillDisappearEvent): void {
		this.unsubscribe?.();
		this.unsubscribe = null;
	}

	override onKeyDown(_ev: KeyDownEvent): void {
		this.keyDownAt = Date.now();
	}

	override onKeyUp(_ev: KeyUpEvent): void {
		const elapsed = Date.now() - this.keyDownAt;
		if (elapsed >= LONG_PRESS_MS) {
			pomodoroTimer.reset();
		} else {
			pomodoroTimer.skip();
		}
	}

	private renderAll(): void {
		const state = pomodoroTimer.getState();
		const svg = buildSkipSvg(state);
		const dataUrl = `data:image/svg+xml,${encodeURIComponent(svg)}`;
		this.actions.forEach((a) => a.setImage(dataUrl));
	}
}

function buildSkipSvg(state: TimerState): string {
	return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 72 72">
  <rect width="72" height="72" rx="8" fill="rgb(207, 95, 19)"/>
  <polygon points="17,25 17,53 41,39" fill="#ffffff"/>
  <rect x="45" y="25" width="8" height="28" rx="2" fill="#ffffff"/>
  <text x="36" y="22" text-anchor="middle" font-family="sans-serif" font-size="10" fill="#ffffff">hold=reset</text>
</svg>`;
}
