# Deep-Linking

## Overview

Deep-linking enables plugins to receive messages through custom URL schemes registered locally. The Stream Deck SDK provides a `streamdeck://` scheme with a unique URL for each plugin.

## Receiving Messages

Register a handler using the `onDidReceiveDeepLink` event from the system namespace:

```typescript
import streamDeck from "@elgato/streamdeck";

streamDeck.system.onDidReceiveDeepLink((ev) => {
	// Handle the deep-link message
});

streamDeck.connect();
```

### Deep-Link URL Format

Each plugin receives messages via a unique URL structure:

```
streamdeck://plugins/message/<PLUGIN_UUID>[path]["?" query]["#" fragment]
```

Example with all components:

```
streamdeck://plugins/message/com.elgato.hello-world/hello?name=Elgato#waving
```

### Active vs Passive Deep-Links

**Active deep-links** (default): Stream Deck window comes to foreground. Requires version 6.5+. Recommended for OAuth flows and user-interactive setup.

**Passive deep-links**: Stream Deck stays hidden. Requires version 7.0+. Add `streamdeck=hidden` as a query parameter:

```
streamdeck://plugins/message/com.elgato.hello-world/hello?streamdeck=hidden
```

Passive deep-links are suitable for background setup operations that do not require user interaction.

### Example Implementation

```typescript
import streamDeck from "@elgato/streamdeck";

streamDeck.system.onDidReceiveDeepLink((ev) => {
	const { path, fragment } = ev.url;

	streamDeck.logger.info(`Path = ${path}`);
	streamDeck.logger.info(`Fragment = ${fragment}`);
});

streamDeck.connect();
```

Sending URL:

```
streamdeck://plugins/message/com.elgato.hello-world/Hello%20world#Testing
```

Output:

```
Path = /Hello%20world
Fragment = Testing
```

## Known Limitations

- Some authorization providers reject custom URL schemes as redirect/callback URLs.
- Keep messages under 2,000 characters.
- Deep-links only work locally.

## OAuth2 Redirect Proxy

For providers that reject custom URL schemes, use the Elgato OAuth2 redirect proxy as your callback URL:

```
https://oauth2-redirect.elgato.com/streamdeck/plugins/message/<PLUGIN_UUID>
```

The proxy forwards the following query parameters to your plugin's deep-link URL:

### Forwarded Query Parameters

| Parameter | Purpose |
|-----------|---------|
| `code` | Authorization code for token exchange |
| `state` | Optional supplied value |
| `scope` | Access level granted |
| `error` | Authorization provider error |

> **Note:** It is recommended you use your plugin's deep-link URL as the callback URL unless absolutely necessary.

## Testing

To test deep-links, enter the URL directly in a browser address bar or in the Windows Run panel (Win + R).
