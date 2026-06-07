import streamDeck from "@elgato/streamdeck";
import { PomodoroTimerAction } from "./actions/pomodoro-timer-action";
import { PomodoroSkipAction } from "./actions/pomodoro-skip-action";
import { PomodoroSessionsAction } from "./actions/pomodoro-sessions-action";
import { pomodoroTimer, type PomodoroSettings } from "./timer/pomodoro-timer";

streamDeck.logger.setLevel("trace");

streamDeck.actions.registerAction(new PomodoroTimerAction());
streamDeck.actions.registerAction(new PomodoroSkipAction());
streamDeck.actions.registerAction(new PomodoroSessionsAction());

streamDeck.settings.onDidReceiveGlobalSettings((ev) => {
	pomodoroTimer.updateSettings(ev.settings as Partial<PomodoroSettings>);
});

streamDeck.connect();
