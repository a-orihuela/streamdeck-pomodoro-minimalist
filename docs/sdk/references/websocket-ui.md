# WebSocket Messages — UI / Property Inspector

Reference for all WebSocket message types used by the Property Inspector (UI) side of a Stream Deck plugin.

Source: https://docs.elgato.com/streamdeck/sdk/references/websocket/ui/

---

## Registration

### `connectElgatoStreamDeckSocket`

Invoked automatically by Stream Deck on DOM load. The Property Inspector must call this function to establish its WebSocket connection.

**Parameters:**

| Parameter    | Type   | Description |
|--------------|--------|-------------|
| `port`       | string | WebSocket connection port |
| `uuid`       | string | Unique identifier for this Property Inspector instance |
| `event`      | string | Registration event name to send back during handshake |
| `info`       | string | JSON-encoded object containing Stream Deck application and OS information |
| `actionInfo` | string | JSON-encoded object containing details about the action instance |

**`info` object includes:**

- `application` — font, language, platform, version
- `colors` — button and highlight color preferences
- `devicePixelRatio` — display pixel ratio
- `devices` — array of connected devices, each with ID, name, and button grid dimensions
- `plugin` — UUID and version of the plugin

---

## Events (Received from Stream Deck)

These messages are sent **from** Stream Deck **to** the Property Inspector over the WebSocket connection.

---

### `didReceiveGlobalSettings`

Triggered in response to `getGlobalSettings`, or when global settings are updated by the plugin.

```json
{
  "event": "didReceiveGlobalSettings",
  "payload": {
    "settings": {}
  }
}
```

**Payload fields:**

| Field      | Type       | Description |
|------------|------------|-------------|
| `settings` | JsonObject | Current global settings for the plugin |

---

### `didReceiveSettings`

Triggered in response to `getSettings`, or when settings are updated by the plugin.

```json
{
  "action": "com.example.plugin.action",
  "context": "<context-id>",
  "device": "<device-id>",
  "event": "didReceiveSettings",
  "payload": {
    "controller": "Keypad",
    "coordinates": { "column": 0, "row": 0 },
    "isInMultiAction": false,
    "resources": {},
    "settings": {},
    "state": 0
  }
}
```

**Top-level fields:**

| Field     | Type   | Description |
|-----------|--------|-------------|
| `action`  | string | Action identifier |
| `context` | string | Unique identifier for the action instance |
| `device`  | string | Unique identifier for the device |
| `event`   | string | `"didReceiveSettings"` |

**Payload fields:**

| Field             | Type                       | Description |
|-------------------|----------------------------|-------------|
| `controller`      | `"Keypad"` \| `"Encoder"`  | Controller type |
| `coordinates`     | `{ column: number, row: number }` | Position on the device (optional) |
| `isInMultiAction` | boolean                    | Whether the action is part of a multi-action |
| `resources`       | `{ [key: string]: string }`| Resource map for the action |
| `settings`        | JsonObject                 | Current settings for the action instance |
| `state`           | number                     | Current state index (optional) |

---

### `didReceiveResources`

Triggered in response to `getResources`, or when resources are updated. Requires Stream Deck 7.1+.

```json
{
  "action": "com.example.plugin.action",
  "context": "<context-id>",
  "device": "<device-id>",
  "event": "didReceiveResources",
  "id": "<resource-id>",
  "payload": {
    "controller": "Keypad",
    "coordinates": { "column": 0, "row": 0 },
    "isInMultiAction": false,
    "resources": {},
    "settings": {},
    "state": 0
  }
}
```

**Top-level fields:**

| Field     | Type   | Description |
|-----------|--------|-------------|
| `action`  | string | Action identifier |
| `context` | string | Unique identifier for the action instance |
| `device`  | string | Unique identifier for the device |
| `event`   | string | `"didReceiveResources"` |
| `id`      | string | Optional resource identifier |

**Payload fields:** Same as `didReceiveSettings` above.

---

### `sendToPropertyInspector`

Triggered when the plugin sends a custom message to the Property Inspector via `sendToPropertyInspector`.

```json
{
  "action": "com.example.plugin.action",
  "context": "<context-id>",
  "event": "sendToPropertyInspector",
  "payload": {}
}
```

**Top-level fields:**

| Field     | Type      | Description |
|-----------|-----------|-------------|
| `action`  | string    | Action identifier |
| `context` | string    | Unique identifier for the action instance |
| `event`   | string    | `"sendToPropertyInspector"` |
| `payload` | JsonValue | Arbitrary value sent by the plugin |

---

## Commands (Sent to Stream Deck)

These messages are sent **from** the Property Inspector **to** Stream Deck over the WebSocket connection.

---

### `getGlobalSettings`

Requests the plugin's global settings. Stream Deck responds with a `didReceiveGlobalSettings` event.

```json
{
  "context": "<context-id>",
  "event": "getGlobalSettings"
}
```

| Field     | Type   | Description |
|-----------|--------|-------------|
| `context` | string | Property Inspector UUID (from registration) |
| `event`   | string | `"getGlobalSettings"` |

---

### `getSettings`

Requests the current action instance settings. Stream Deck responds with a `didReceiveSettings` event.

```json
{
  "action": "com.example.plugin.action",
  "context": "<context-id>",
  "event": "getSettings"
}
```

| Field     | Type   | Description |
|-----------|--------|-------------|
| `action`  | string | Action identifier |
| `context` | string | Unique identifier for the action instance |
| `event`   | string | `"getSettings"` |

---

### `getResources`

Requests action resources. Stream Deck responds with a `didReceiveResources` event. Requires Stream Deck 7.1+.

```json
{
  "action": "com.example.plugin.action",
  "context": "<context-id>",
  "event": "getResources",
  "id": "<optional-resource-id>"
}
```

| Field     | Type   | Description |
|-----------|--------|-------------|
| `action`  | string | Action identifier |
| `context` | string | Unique identifier for the action instance |
| `event`   | string | `"getResources"` |
| `id`      | string | Optional resource identifier to request a specific resource |

---

### `setGlobalSettings`

Updates the plugin's global settings. Also notifies the plugin via a `didReceiveGlobalSettings` event.

```json
{
  "context": "<context-id>",
  "event": "setGlobalSettings",
  "payload": {}
}
```

| Field     | Type       | Description |
|-----------|------------|-------------|
| `context` | string     | Property Inspector UUID (from registration) |
| `event`   | string     | `"setGlobalSettings"` |
| `payload` | JsonObject | New global settings to store |

---

### `setSettings`

Updates the action instance's settings. Also notifies the plugin via a `didReceiveSettings` event.

```json
{
  "action": "com.example.plugin.action",
  "context": "<context-id>",
  "event": "setSettings",
  "payload": {}
}
```

| Field     | Type       | Description |
|-----------|------------|-------------|
| `action`  | string     | Action identifier |
| `context` | string     | Unique identifier for the action instance |
| `event`   | string     | `"setSettings"` |
| `payload` | JsonObject | New settings to store for the action instance |

---

### `setResources`

Updates action resources. Requires Stream Deck 7.1+.

```json
{
  "action": "com.example.plugin.action",
  "context": "<context-id>",
  "event": "setResources",
  "payload": {
    "key": "value"
  }
}
```

| Field     | Type                        | Description |
|-----------|-----------------------------|-------------|
| `action`  | string                      | Action identifier |
| `context` | string                      | Unique identifier for the action instance |
| `event`   | string                      | `"setResources"` |
| `payload` | `{ [key: string]: string }` | Resource key-value pairs to store |

---

### `sendToPlugin`

Sends a custom message to the plugin. The plugin receives this via a `sendToPlugin` event.

```json
{
  "action": "com.example.plugin.action",
  "context": "<context-id>",
  "event": "sendToPlugin",
  "payload": {}
}
```

| Field     | Type      | Description |
|-----------|-----------|-------------|
| `action`  | string    | Action identifier |
| `context` | string    | Unique identifier for the action instance |
| `event`   | string    | `"sendToPlugin"` |
| `payload` | JsonValue | Arbitrary value to send to the plugin |

---

### `openUrl`

Opens a URL in the user's default web browser.

```json
{
  "event": "openUrl",
  "payload": {
    "url": "https://example.com"
  }
}
```

| Field           | Type   | Description |
|-----------------|--------|-------------|
| `event`         | string | `"openUrl"` |
| `payload.url`   | string | The URL to open |

---

## Summary Table

| Message | Direction | Description |
|---------|-----------|-------------|
| `connectElgatoStreamDeckSocket` | Stream Deck → PI | Registers the Property Inspector with Stream Deck |
| `didReceiveGlobalSettings` | Stream Deck → PI | Delivers global plugin settings |
| `didReceiveSettings` | Stream Deck → PI | Delivers action instance settings |
| `didReceiveResources` | Stream Deck → PI | Delivers action resources (SD 7.1+) |
| `sendToPropertyInspector` | Stream Deck → PI | Custom message from the plugin |
| `getGlobalSettings` | PI → Stream Deck | Requests global plugin settings |
| `getSettings` | PI → Stream Deck | Requests action instance settings |
| `getResources` | PI → Stream Deck | Requests action resources (SD 7.1+) |
| `setGlobalSettings` | PI → Stream Deck | Saves global plugin settings |
| `setSettings` | PI → Stream Deck | Saves action instance settings |
| `setResources` | PI → Stream Deck | Saves action resources (SD 7.1+) |
| `sendToPlugin` | PI → Stream Deck | Custom message to the plugin |
| `openUrl` | PI → Stream Deck | Opens a URL in the default browser |
