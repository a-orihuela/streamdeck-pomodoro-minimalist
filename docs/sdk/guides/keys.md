# Keys

One of the two primary types of actions available to Stream Deck plugins; keys are found on all Stream Deck devices, and allow users to activate your plugin's functionality.

## What Are Keys

Keys represent plugin actions displayed on Stream Deck canvases across various devices like Stream Deck XL and Stream Deck Pedal. They provide visual feedback through titles and images, activated when users interact with physical hardware.

## States

The manifest configuration determines an action's behavior and defaults, including displayed imagery. Every key action requires at least one state, though multiple states are supported.

### Multi-State Keys

Toggle functionality like on/off or mute/unmute can be represented using two configured states. When users press keys, states toggle automatically, with the new state index accessible through payload information.

> **Important:** Stream Deck supports up to two states; although adding more states is possible within the manifest, its functionality is not fully supported.

Users can configure icons for each state within Stream Deck's interface. Automatic toggling can be disabled if manual state control is preferred.

### States In Multi-Actions

Assigning a `Name` to each state in the manifest enables users to specify desired states when implementing actions in multi-action sequences. States are then accessible as indices (0 or 1) through `ev.payload.userDesiredState`.

```typescript
import { action, KeyDownEvent, SingletonAction } from "@elgato/streamdeck";

/**
 * Example Discord Mute action.
 */
@action({ UUID: "com.discord.mute" })
export class Mute extends SingletonAction {
	/**
	 * Occurs when the user presses the key action.
	 */
	override onKeyDown(ev: KeyDownEvent) {
		if (ev.payload.isInMultiAction) {
			// We can access the user's desired state via...
			ev.payload.userDesiredState; 
		}
	}
}
```

## Titles

All actions include titles, rendered on key images at top, middle, or bottom positions. Default titles come from the manifest; runtime updates use the `setTitle` command. Users can monitor title modifications through the `onTitleParameterDidChange` event.

**Display Precedence:** Rendering priority follows this order:
1. User-defined content
2. Runtime-set titles/images
3. Manifest defaults

### Setting Titles

```typescript
import { action, KeyDownEvent, SingletonAction } from "@elgato/streamdeck";

/**
 * Example action that updates the title.
 */
@action({ UUID: "com.elgato.hello-world.increment" })
export class IncrementCounter extends SingletonAction {
	/**
	 * Occurs when the user presses the key action.
	 */
	override onKeyDown(ev: KeyDownEvent) {
		ev.action.setTitle("Hello world!"); 
	}
}
```

You can also specify a target state when setting the title:

```typescript
import { action, KeyDownEvent, SingletonAction, Target } from "@elgato/streamdeck";

/**
 * Example action that updates the title.
 */
@action({ UUID: "com.elgato.hello-world.increment" })
export class IncrementCounter extends SingletonAction {
	/**
	 * Occurs when the user presses the key action.
	 */
	override onKeyDown(ev: KeyDownEvent) {

		ev.action.setTitle("Hello world!", {
			state: 0,
			target: Target.Hardware,
		});
	}
}
```

## Images

Images update via the `setImage` command, accepting file paths or base64-encoded data URLs. Supported formats include SVG (recommended), JPEG, PNG, and WEBP.

> **Note:** The `setImage` function does not support animated image formats, such as GIF.

### From SVG

Dynamic SVG strings enable customized images before rendering, useful for conditional visualization.

```typescript
import { action, KeyDownEvent, SingletonAction } from "@elgato/streamdeck";

/**
 * Example action that updates the key action image from an SVG on key press.
 */
@action({ UUID: "com.elgato.hello-world.increment" })
export class IncrementCounter extends SingletonAction {
	/**
	 * Occurs when the user presses the key action.
	 */
	override onKeyDown(ev: KeyDownEvent<CounterSettings>) {
		const { count } = ev.payload.settings;
		const isRed = count % 2 === 0;
		const svg = `<svg width="100" height="100">
						<circle fill="${isRed ? "red" : "blue"}" r="45" cx="50" cy="50" ></circle>
					</svg>`;

		ev.action.setImage(`data:image/svg+xml,${encodeURIComponent(svg)}`); 
		ev.action.setSettings({ count: count + 1 });
	}
}

type CounterSettings = {
	count: number;
};
```

### From Data URL

Base64-encoded image data URLs support multiple MIME types for flexible image delivery.

### From File

Images can reference files stored locally within the plugin directory.

```typescript
import { action, KeyDownEvent, SingletonAction } from "@elgato/streamdeck";

/**
 * Example action that updates the key action image from a file.
 */
@action({ UUID: "com.elgato.hello-world.increment" })
export class IncrementCounter extends SingletonAction {
	/**
	 * Occurs when the user presses the key action.
	 */
	override onKeyDown(ev: KeyDownEvent) {

		ev.action.setImage("imgs/actions/counter/key.png"); // image path
	}
}
```

### Options

Optional `ImageOptions` specify target destinations (hardware, software, or both) and state values (0 or 1).

```typescript
import { action, KeyDownEvent, SingletonAction, Target } from "@elgato/streamdeck";

/**
 * Example action that updates the key action image with additional options.
 */
@action({ UUID: "com.elgato.hello-world.increment" })
export class IncrementCounter extends SingletonAction {
	/**
	 * Occurs when the user presses the key action.
	 */
	override onKeyDown(ev: KeyDownEvent) {

		ev.action.setImage("imgs/actions/counter/key.png", {
			target: Target.HardwareAndSoftware,
			state: 1,
		});
	}
}
```

## Temporary Feedback

Functions `showOk` and `showAlert` provide visual user feedback, displaying success checkmarks or warning triangles.

> **Best Practice:** It is best practice to accompany `showAlert` with a log entry to help diagnose what caused the warning.

## Events

### onKeyDown

Triggered when users press action buttons, providing event information including source actions and contextual payload.

### onKeyUp

Triggered upon releasing pressed actions.

## Commands

Available commands for key actions:

| Command | Description |
|---|---|
| `getResources()` | Retrieve action resources |
| `getSettings<U>()` | Get action settings |
| `setImage()` | Update the key image |
| `setResources()` | Set action resources |
| `setSettings<U>()` | Persist action settings |
| `setState()` | Set the current state index |
| `setTitle()` | Update the key title |
| `showAlert()` | Display a warning triangle indicator |
| `showOk()` | Display a success checkmark indicator |

All commands return `Promise<void>` or typed promises, enabling asynchronous operations.

> **Note:** Some events are applicable to both dials and keys, such as `onWillAppear`. To invoke a key-only command within these event handlers, you need to first assert the action is a key using `Action.isKey()`.
