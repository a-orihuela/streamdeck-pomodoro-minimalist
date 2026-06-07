# Settings

The Stream Deck SDK provides support for managing settings associated with your plugin.

Two setting types exist: action settings (associated with specific plugin actions) and global settings (plugin-wide). Both are accessible only to their associated plugin.

Settings are persisted as JSON objects, meaning values can be `boolean`, `number`, `string`, `null`, arrays, or objects.

## Common Functions and Events

| | Action Settings | Global Settings |
|---|---|---|
| **Writing** | `ev.action.setSettings(settings)` | `streamDeck.settings.setGlobalSettings(settings)` |
| **Reading** | `ev.payload.settings`, `ev.action.getSettings()` | `streamDeck.settings.getGlobalSettings()` |
| **Changed** | `SingletonAction.onDidReceiveSettings(handler)`, `streamDeck.settings.onDidReceiveSettings(handler)` | `streamDeck.settings.onDidReceiveGlobalSettings(handler)` |

## Action Settings

### Writing Settings

```typescript
import streamDeck, { action, type KeyDownEvent, SingletonAction } from "@elgato/streamdeck";

@action({ UUID: "com.elgato.hello-world.counter" })
class Counter extends SingletonAction {
	/**
	 * Occurs when the user presses the key action.
	 */
	override async onKeyDown(ev: KeyDownEvent): Promise<void> {
		// Set the actions settings on key down.

		await ev.action.setSettings({
			count: 1,
		});
	}
}

streamDeck.actions.registerAction(new Counter());
streamDeck.connect();
```

> **Security Warning:** Security-sensitive settings, such as API keys, should always be persisted using global settings, never action settings. Action settings are stored as plain-text and are included when exporting Stream Deck profiles, and in their nature action settings are not secure.

### Reading Settings

You can define a type for your settings to provide insight into what their type might be. Note that this does not guarantee their underlying type at runtime.

```typescript
import streamDeck, { action, type KeyDownEvent, SingletonAction } from "@elgato/streamdeck";


// Define the action's settings type.
type Settings = {
	count: number;
};

@action({ UUID: "com.elgato.hello-world.counter" })

class Counter extends SingletonAction<Settings> {
	/**
	 * Occurs when the user presses the key action.
	 */

	override async onKeyDown(ev: KeyDownEvent<Settings>): Promise<void> {
		// `ev.payload.settings` now contains typed-settings.

		// Set the actions settings on key down.
		await ev.action.setSettings({
			count: 1,
		});
	}
}

streamDeck.actions.registerAction(new Counter());
streamDeck.connect();
```

#### Reading via Event Payload

Settings are available directly from event arguments. The following event types include settings in their payload:

- `onDialDown`
- `onDialRotate`
- `onDialUp`
- `onTouchTap`
- `onDidReceiveSettings`
- `onKeyDown`
- `onKeyUp`
- `onTitleParametersDidChange`
- `onWillAppear`
- `onWillDisappear`

```typescript
import streamDeck, { action, type KeyDownEvent, SingletonAction } from "@elgato/streamdeck";

// Define the action's settings type.
type Settings = {
	count: number;
};

@action({ UUID: "com.elgato.hello-world.counter" })
class Counter extends SingletonAction<Settings> {
	/**
	 * Occurs when the user presses the key action.
	 */
	override async onKeyDown(ev: KeyDownEvent<Settings>): Promise<void> {
		// Read the current count.
		let { count = 0 } = ev.payload.settings; 
		count++;

		// Set the new count.
		await ev.action.setSettings({ count });
	}
}

streamDeck.actions.registerAction(new Counter());
streamDeck.connect();
```

> **Note:** You can also request a **visible** action's settings using `ev.action.getSettings()`; as there is no guarantee the action will be visible, we recommend using the settings supplied as part of the event arguments where possible.

### Settings Changed Callback

Use `onDidReceiveSettings` to react when settings are updated from the property inspector (UI).

```typescript
import streamDeck, { action, type DidReceiveSettingsEvent, SingletonAction } from "@elgato/streamdeck";

// Define the action's settings type.
type Settings = {
	count: number;
};

@action({ UUID: "com.elgato.hello-world.counter" })
class Counter extends SingletonAction<Settings> {
	/**
	 * Occurs when the application-layer receives the settings from the UI.
	 */

	override onDidReceiveSettings(ev: DidReceiveSettingsEvent<Settings>): void {
		// Handle the settings changing in the property inspector (UI).
	}
}

streamDeck.actions.registerAction(new Counter());
streamDeck.connect();
```

## Global Settings

Global settings are plugin-wide and persist across all actions.

### Security Recommendations

- **Do:** Use global settings for user-specific settings, for example OAuth2 access tokens or API keys provided by the user.
- **Do:** Use global settings for non-sensitive plugin-level settings.
- **Don't:** Use global settings for your plugin's secrets, for example API keys.

### Writing Global Settings

```typescript
import streamDeck from "@elgato/streamdeck";

streamDeck.system.onDidReceiveDeepLink((ev) => {
	// Set the global settings after receiving a deep-link.
	streamDeck.settings.setGlobalSettings({
		messageReceived: true,
	});
});

streamDeck.connect();
```

### Reading Global Settings

```typescript
import streamDeck from "@elgato/streamdeck";

streamDeck.system.onDidReceiveDeepLink(async (ev) => {
	// Get the settings.
	const settings = await streamDeck.settings.getGlobalSettings();
});

streamDeck.connect();
```

You can supply a type parameter when reading global settings for type safety:

```typescript
import streamDeck from "@elgato/streamdeck";

// Define a type that represents the settings.
type Settings = {
	count: number;
};

streamDeck.system.onDidReceiveDeepLink(async (ev) => {
	// When getting the settings, supply the type.
	let { count = 0 } = await streamDeck.settings.getGlobalSettings<Settings>();

	count++;
	await streamDeck.settings.setGlobalSettings({ count });
});

streamDeck.connect();
```

### Global Settings Changed Callback

```typescript
import streamDeck from "@elgato/streamdeck";

streamDeck.settings.onDidReceiveGlobalSettings((ev) => {
	// Handle the global settings changing in application layer.
});
```

> **Tip:** The application-layer can also listen for the global settings changing in the property inspector using `onDidReceiveGlobalSettings` in the `settings` namespace.

## Changed vs Requested

By default, when calling `action.getSettings` or `streamDeck.settings.getGlobalSettings` the relevant settings-changed handler is also called.

### Experimental Message Identifiers

You can opt in to experimental message identifiers to prevent the settings-changed handler from being called when settings are explicitly requested (rather than changed).

```typescript
import streamDeck from "@elgato/streamdeck";


// Only call onDidReceive[Global]Settings when settings change.
streamDeck.settings.useExperimentalMessageIdentifiers = true;

// ...

streamDeck.connect();
```

**Behavior comparison:**

| Scenario | Message Identifiers Off (Default) | Message Identifiers On |
|---|---|---|
| Settings changed in UI | `onDidReceive[Global]Settings` Called | `onDidReceive[Global]Settings` Called |
| Settings requested (get) | `onDidReceive[Global]Settings` Called | `onDidReceive[Global]Settings` Not called |

## Type Safety

Defining a `Settings` type provides TypeScript hints, but does not guarantee the underlying type at runtime. If settings have not been previously set, their values will be `undefined` even if typed otherwise.

### Runtime Error Example

```typescript
import { type KeyDownEvent, SingletonAction } from "@elgato/streamdeck";

type Settings = {
	name: string;
};

export class MyAction extends SingletonAction<Settings> {
	/**
	 * Occurs when the user presses the key action.
	 */
	override async onKeyDown(ev: KeyDownEvent<Settings>): Promise<void> {
		/*
		 * Even though the settings are typed, if they have not
		 * been previously set, their values will be undefined.
		 */
		const { name } = await ev.action.getSettings();

		name.toLowerCase(); // Runtime error!
	}
}
```

### Recommendations

Use default values when destructuring objects that might be nullish. For complex types, consider using a schema validation library such as [Zod](https://zod.dev/).

### Zod Validation Example

```typescript
import { type KeyDownEvent, SingletonAction } from "@elgato/streamdeck";
import z from "zod";

// Define the Zod schema.
const Settings = z.object({
	name: z.string().default("Elgato"),
});

// Infer the settings type.
type Settings = z.infer<typeof Settings>;

/**
 * An example action that demonstrates parsing settings with Zod.
 */
export class MyAction extends SingletonAction<Settings> {
	/**
	 * Occurs when the user presses the key action.
	 */
	override async onKeyDown(ev: KeyDownEvent<Settings>): Promise<void> {
		/*
		 * Settings can safely be undefined here, Zod
		 * will fallback `name` to "Elgato".
		 */
		const { name } = Settings.parse(ev.payload.settings);
		name.toLowerCase(); // "elgato"
	}
}
```
