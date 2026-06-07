# System

The Stream Deck SDK provides utilities for interacting with common system functionality. Beyond app monitoring and deep-linking capabilities, the SDK offers additional system interaction tools.

## Opening URLs

Plugins can direct users to websites in their default browser, which is useful for authentication flows or help documentation.

```typescript
import streamDeck from "@elgato/streamdeck";

streamDeck.actions.onKeyDown(() => {
	streamDeck.system.openUrl("https://elgato.com");
});

streamDeck.connect();
```

The `openUrl()` method opens the specified URL in the user's default browser.

> **Note:** All URLs are opened in the user's default browser. Custom URL schemes, for example `my-app://`, are not yet supported by the SDK.

## System Wake

Handling system wake ensures plugins resume seamlessly when the system awakens from sleep.

### Events During System Wake

During the system wake procedure, plugins receive:

- `onWillAppear` for all visible actions
- A one-time `onSystemDidWakeUp` event

### API Method

```typescript
import streamDeck from "@elgato/streamdeck";

streamDeck.system.onSystemDidWakeUp((ev) => {
	// Handle system wake.
});

streamDeck.connect();
```

The `onSystemDidWakeUp` event is suitable for restoring connections or state, such as websocket connections to APIs or IPC with local applications.

> **Warning:** `onSystemDidWakeUp` is only available in the context of the plugin, and is not available in the property inspector.
