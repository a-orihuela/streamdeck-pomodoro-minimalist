import { action, type KeyDownEvent, SingletonAction, type WillAppearEvent } from "@elgato/streamdeck";

/**
 * An example action class that displays a count that increments by one each time the button is pressed.
 */
@action({ UUID: "com.aom.pomodorominimalist.increment" })
export class IncrementCounter extends SingletonAction<CounterSettings> {
	/**
	 * Listens for the {@link SingletonAction.onKeyDown} event which is emitted by Stream Deck when an action is pressed.
	 * Updates the counter stored in the action's persistent settings and updates the key title.
	 * @param ev - The key down event.
	 * @returns A promise that resolves when the settings and title have been updated.
	 */
	public override async onKeyDown(ev: KeyDownEvent<CounterSettings>): Promise<void> {
		const { settings } = ev.payload;
		settings.incrementBy ??= 1;
		settings.count = (settings.count ?? 0) + settings.incrementBy;

		await ev.action.setSettings(settings);
		await ev.action.setTitle(`${settings.count}`);
	}

	/**
	 * The {@link SingletonAction.onWillAppear} event fires when the action becomes visible on the Stream Deck canvas.
	 * Sets the key title to the current count stored in the action's settings.
	 * @param ev - The will-appear event.
	 * @returns A promise that resolves when the title has been set.
	 */
	public override onWillAppear(ev: WillAppearEvent<CounterSettings>): Promise<void> | void {
		return ev.action.setTitle(`${ev.payload.settings.count ?? 0}`);
	}
}

/**
 * Settings for {@link IncrementCounter}.
 */
type CounterSettings = {
	/** Current count value displayed on the key. */
	count?: number;
	/** Amount to increment the count by on each key press. */
	incrementBy?: number;
};
