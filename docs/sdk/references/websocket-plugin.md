# WebSocket API — Plugin Side

Reference for all WebSocket messages exchanged between the Stream Deck application and a plugin. The plugin connects to Stream Deck via WebSocket and communicates using JSON messages.

Source: https://docs.elgato.com/streamdeck/sdk/references/websocket/plugin/

---

## Connection & Registration

When Stream Deck launches a plugin it passes four command-line arguments:

| Argument | Type | Description |
|---|---|---|
| `-port` | `number` | WebSocket port to connect to |
| `-info` | `string` | Serialised JSON (`RegistrationInfo`) with Stream Deck metadata |
| `-pluginUUID` | `string` | Unique identifier for this plugin instance |
| `-registerEvent` | `string` | Event name to send when registering |

After opening the WebSocket connection the plugin must immediately send a registration message:

```typescript
type RegisterEvent = {
  event: string;  // value of -registerEvent argument
  uuid: string;   // value of -pluginUUID argument
};
```

**Example:**
```json
{
  "event": "registerPlugin",
  "uuid": "com.example.myplugin"
}
```

### RegistrationInfo

The `-info` argument contains a JSON-serialised `RegistrationInfo` object:

```typescript
type RegistrationInfo = {
  application: {
    font: string;
    language: "de" | "en" | "es" | "fr" | "ja" | "ko" | "zh_CN" | "zh_TW";
    platform: "mac" | "windows";
    platformVersion: string;
    version: string;
  };
  colors: {
    buttonMouseOverBackgroundColor: string;
    buttonPressedBackgroundColor: string;
    buttonPressedBorderColor: string;
    buttonPressedTextColor: string;
    highlightColor: string;
  };
  devicePixelRatio: number;
  devices: Array<{
    id: string;
    name: string;
    size: {
      columns: number;
      rows: number;
    };
    type: DeviceType;
  }>;
  plugin: {
    uuid: string;
    version: string;
  };
};
```

---

## Common Fields

Most messages share these top-level fields:

| Field | Type | Description |
|---|---|---|
| `action` | `string` | Action UUID from the manifest (e.g. `"com.elgato.wavelink.mute"`) |
| `context` | `string` | Opaque instance identifier — not guaranteed to persist across app restarts |
| `device` | `string` | Stream Deck device UUID |
| `event` | `string` | Event or command name |

### Controller Types

| Value | Used By |
|---|---|
| `"Keypad"` | Standard buttons, pedals |
| `"Encoder"` | Dials and touchscreens (Stream Deck +) |

---

## Events — Plugin Receives

These are messages Stream Deck sends **to** the plugin.

---

### `keyDown`

Fired when the user presses an action button.

```typescript
{
  action: string;
  context: string;
  device: string;
  event: "keyDown";
  payload: {
    controller: "Keypad";
    coordinates?: { column: number; row: number };
    isInMultiAction: boolean;
    resources: { [key: string]: string };
    settings: JsonObject;
    state?: number;
    userDesiredState?: number;
  };
}
```

**Payload fields:**

| Field | Type | Description |
|---|---|---|
| `controller` | `"Keypad"` | Always `"Keypad"` for key events |
| `coordinates` | `{ column, row }` | Button position; omitted when inside a multi-action |
| `isInMultiAction` | `boolean` | `true` when triggered from a multi-action |
| `resources` | `object` | Key-value map of embedded action resources |
| `settings` | `object` | Action instance settings |
| `state` | `number` | Current state index for multi-state actions |
| `userDesiredState` | `number` | State the user wants to switch to (multi-state only) |

---

### `keyUp`

Fired when the user releases a pressed action button. Structure is identical to `keyDown`.

```typescript
{
  action: string;
  context: string;
  device: string;
  event: "keyUp";
  payload: {
    controller: "Keypad";
    coordinates?: { column: number; row: number };
    isInMultiAction: boolean;
    resources: { [key: string]: string };
    settings: JsonObject;
    state?: number;
    userDesiredState?: number;
  };
}
```

---

### `dialDown`

Fired when the user presses a dial (Stream Deck +).

```typescript
{
  action: string;
  context: string;
  device: string;
  event: "dialDown";
  payload: {
    controller: "Encoder";
    coordinates: { column: number; row: number };
    resources: { [key: string]: string };
    settings: JsonObject;
  };
}
```

---

### `dialUp`

Fired when the user releases a dial (Stream Deck +). Structure is identical to `dialDown`.

```typescript
{
  action: string;
  context: string;
  device: string;
  event: "dialUp";
  payload: {
    controller: "Encoder";
    coordinates: { column: number; row: number };
    resources: { [key: string]: string };
    settings: JsonObject;
  };
}
```

---

### `dialRotate`

Fired when the user rotates a dial (Stream Deck +).

```typescript
{
  action: string;
  context: string;
  device: string;
  event: "dialRotate";
  payload: {
    controller: "Encoder";
    coordinates: { column: number; row: number };
    pressed: boolean;
    resources: { [key: string]: string };
    settings: JsonObject;
    ticks: number;
  };
}
```

**Payload fields:**

| Field | Type | Description |
|---|---|---|
| `pressed` | `boolean` | `true` if the dial is currently held down while rotating |
| `ticks` | `number` | Number of ticks rotated; positive = clockwise, negative = counter-clockwise |

---

### `touchTap`

Fired when the user taps the touchscreen strip (Stream Deck +).

```typescript
{
  action: string;
  context: string;
  device: string;
  event: "touchTap";
  payload: {
    controller: "Encoder";
    coordinates: { column: number; row: number };
    hold: boolean;
    resources: { [key: string]: string };
    settings: JsonObject;
    tapPos: [x: number, y: number];
  };
}
```

**Payload fields:**

| Field | Type | Description |
|---|---|---|
| `hold` | `boolean` | `true` when the tap is a sustained (long) press |
| `tapPos` | `[number, number]` | `[x, y]` pixel coordinates of the tap within the touchscreen area |

---

### `willAppear`

Fired when an action becomes visible — on startup, when the user navigates to a page or profile containing the action.

```typescript
{
  action: string;
  context: string;
  device: string;
  event: "willAppear";
  payload: {
    controller: "Encoder" | "Keypad";
    coordinates?: { column: number; row: number };
    isInMultiAction: boolean;
    resources: { [key: string]: string };
    settings: JsonObject;
    state?: number;
  };
}
```

Note: `coordinates` is omitted when `isInMultiAction` is `true`. Multi-action support requires Stream Deck 6.5+.

---

### `willDisappear`

Fired when an action becomes hidden — when the user navigates away from the page or profile. Structure is identical to `willAppear`.

```typescript
{
  action: string;
  context: string;
  device: string;
  event: "willDisappear";
  payload: {
    controller: "Encoder" | "Keypad";
    coordinates?: { column: number; row: number };
    isInMultiAction: boolean;
    resources: { [key: string]: string };
    settings: JsonObject;
    state?: number;
  };
}
```

---

### `titleParametersDidChange`

Fired when the user changes the title or title styling of an action in the Stream Deck application.

```typescript
{
  action: string;
  context: string;
  device: string;
  event: "titleParametersDidChange";
  payload: {
    controller: "Encoder" | "Keypad";
    coordinates: { column: number; row: number };
    resources: { [key: string]: string };
    settings: JsonObject;
    state?: number;
    title: string;
    titleParameters: {
      fontFamily: string;
      fontSize: number;
      fontStyle: "" | "Bold" | "Italic" | "Bold Italic" | "Regular";
      fontUnderline: boolean;
      showTitle: boolean;
      titleAlignment: "top" | "middle" | "bottom";
      titleColor: string;
    };
  };
}
```

---

### `didReceiveSettings`

Fired in response to `getSettings`, or whenever the user saves settings in the Property Inspector.

```typescript
{
  action: string;
  context: string;
  device: string;
  event: "didReceiveSettings";
  id?: string;
  payload: {
    controller: "Encoder" | "Keypad";
    coordinates?: { column: number; row: number };
    isInMultiAction: boolean;
    resources: { [key: string]: string };
    settings: JsonObject;
    state?: number;
  };
}
```

`id` matches the optional `id` sent with the `getSettings` request.

---

### `didReceiveGlobalSettings`

Fired in response to `getGlobalSettings`, or when global settings are updated.

```typescript
{
  event: "didReceiveGlobalSettings";
  id?: string;
  payload: {
    settings: JsonObject;
  };
}
```

`id` matches the optional `id` sent with the `getGlobalSettings` request.

---

### `didReceiveResources`

Fired in response to `getResources`, or when action resources are updated. Available from Stream Deck 7.1+.

```typescript
{
  action: string;
  context: string;
  device: string;
  event: "didReceiveResources";
  id?: string;
  payload: {
    controller: "Encoder" | "Keypad";
    coordinates?: { column: number; row: number };
    isInMultiAction: boolean;
    resources: { [key: string]: string };
    settings: JsonObject;
    state?: number;
  };
}
```

---

### `didReceiveSecrets`

Fired in response to `getSecrets`. Contains plugin secrets managed by Stream Deck.

```typescript
{
  event: "didReceiveSecrets";
  payload: {
    secrets: JsonObject;
  };
}
```

---

### `didReceiveDeepLink`

Fired when Stream Deck receives a deep-link URL directed at this plugin.

Deep-link URL format: `streamdeck://plugins/message/<PLUGIN_UUID>/{MESSAGE}`

The `url` in the payload contains only the `{MESSAGE}` portion — the prefix is stripped.

```typescript
{
  event: "didReceiveDeepLink";
  payload: {
    url: string;
  };
}
```

---

### `sendToPlugin`

Fired when the Property Inspector sends a message to the plugin via `sendToPropertyInspector` (PI side).

```typescript
{
  action: string;
  context: string;
  event: "sendToPlugin";
  payload: JsonValue;
}
```

The `payload` is the arbitrary JSON value the Property Inspector sent.

---

### `propertyInspectorDidAppear`

Fired when the Property Inspector for an action becomes visible (user selects the action in Stream Deck).

```typescript
{
  action: string;
  context: string;
  device: string;
  event: "propertyInspectorDidAppear";
}
```

---

### `propertyInspectorDidDisappear`

Fired when the Property Inspector for an action is hidden (user deselects or navigates away).

```typescript
{
  action: string;
  context: string;
  device: string;
  event: "propertyInspectorDidDisappear";
}
```

---

### `deviceDidConnect`

Fired when a Stream Deck device is connected.

```typescript
{
  device: string;
  event: "deviceDidConnect";
  deviceInfo: {
    name: string;
    size: {
      columns: number;
      rows: number;
    };
    type: DeviceType;
  };
}
```

---

### `deviceDidDisconnect`

Fired when a Stream Deck device is disconnected.

```typescript
{
  device: string;
  event: "deviceDidDisconnect";
}
```

---

### `deviceDidChange`

Fired when properties of a connected device change (e.g. name or layout size). Available from Stream Deck 7.0+.

```typescript
{
  device: string;
  event: "deviceDidChange";
  deviceInfo: {
    name: string;
    size: {
      columns: number;
      rows: number;
    };
    type: DeviceType;
  };
}
```

---

### `applicationDidLaunch`

Fired when a monitored application launches. Applications to monitor are declared in the plugin manifest.

```typescript
{
  event: "applicationDidLaunch";
  payload: {
    application: string;
  };
}
```

---

### `applicationDidTerminate`

Fired when a monitored application closes. Structure is identical to `applicationDidLaunch`.

```typescript
{
  event: "applicationDidTerminate";
  payload: {
    application: string;
  };
}
```

---

### `systemDidWakeUp`

Fired when the computer wakes from sleep.

```typescript
{
  event: "systemDidWakeUp";
}
```

---

## Commands — Plugin Sends

These are messages the plugin sends **to** Stream Deck.

---

### `getSettings`

Request the persisted settings for an action instance. Stream Deck responds with `didReceiveSettings`.

```typescript
{
  context: string;
  event: "getSettings";
  id?: string;
}
```

| Field | Type | Description |
|---|---|---|
| `context` | `string` | Action instance context |
| `id` | `string` | Optional request identifier echoed back in the response |

---

### `setSettings`

Persist settings for an action instance.

```typescript
{
  context: string;
  event: "setSettings";
  payload: JsonObject;
}
```

**Example:**
```json
{
  "context": "abc123",
  "event": "setSettings",
  "payload": {
    "volume": 75,
    "muted": false
  }
}
```

---

### `getGlobalSettings`

Request the persisted global (plugin-wide) settings. Stream Deck responds with `didReceiveGlobalSettings`.

```typescript
{
  context: string;
  event: "getGlobalSettings";
  id?: string;
}
```

---

### `setGlobalSettings`

Persist global settings shared across all instances of the plugin.

```typescript
{
  context: string;
  event: "setGlobalSettings";
  payload: JsonObject;
}
```

---

### `getResources`

Request the embedded resources for an action instance. Stream Deck responds with `didReceiveResources`. Available from Stream Deck 7.1+.

```typescript
{
  context: string;
  event: "getResources";
  id?: string;
}
```

---

### `setResources`

Update the embedded resources for an action instance. Available from Stream Deck 7.1+.

```typescript
{
  context: string;
  event: "setResources";
  payload: {
    [key: string]: string;
  };
}
```

---

### `getSecrets`

Request the plugin's secrets from Stream Deck. Stream Deck responds with `didReceiveSecrets`.

```typescript
{
  context: string;
  event: "getSecrets";
}
```

---

### `setImage`

Set the image displayed on an action button.

The `image` value can be:
- A path relative to the plugin folder
- A base64-encoded data URI (e.g. `"data:image/png;base64,..."`)
- Omitted to reset to the default image

```typescript
{
  context: string;
  event: "setImage";
  payload: {
    image?: string;
    state?: number;
    target?: "hardware" | "software" | "both";
  };
}
```

**Payload fields:**

| Field | Type | Description |
|---|---|---|
| `image` | `string` | Image source; file path or base64 data URI. Omit to reset. |
| `state` | `number` | State index to update for multi-state actions (`0` or `1`) |
| `target` | `string` | Which rendering target to update: `"hardware"`, `"software"`, or `"both"` (default) |

**Example (base64):**
```json
{
  "context": "abc123",
  "event": "setImage",
  "payload": {
    "image": "data:image/png;base64,iVBORw0KGgoAAAANS...",
    "target": "both"
  }
}
```

---

### `setTitle`

Set the title text displayed on an action button.

```typescript
{
  context: string;
  event: "setTitle";
  payload: {
    title?: string;
    state?: number;
    target?: "hardware" | "software" | "both";
  };
}
```

**Payload fields:**

| Field | Type | Description |
|---|---|---|
| `title` | `string` | Text to display. Omit or pass empty string to reset. |
| `state` | `number` | State index to update for multi-state actions (`0` or `1`) |
| `target` | `string` | Which rendering target to update: `"hardware"`, `"software"`, or `"both"` (default) |

**Example:**
```json
{
  "context": "abc123",
  "event": "setTitle",
  "payload": {
    "title": "Play",
    "target": "both"
  }
}
```

---

### `setState`

Set the current state of a multi-state action.

```typescript
{
  context: string;
  event: "setState";
  payload: {
    state: number;
  };
}
```

**Payload fields:**

| Field | Type | Description |
|---|---|---|
| `state` | `number` | New state index (`0` or `1`) |

---

### `showOk`

Briefly display a green checkmark on the action button to indicate success.

```typescript
{
  context: string;
  event: "showOk";
}
```

---

### `showAlert`

Briefly display a yellow warning triangle on the action button to indicate an error.

```typescript
{
  context: string;
  event: "showAlert";
}
```

---

### `setFeedbackLayout`

Set the layout used by a dial/touchscreen action (Stream Deck +).

The `layout` value can be:
- A predefined layout identifier (see table below)
- A path to a custom layout JSON file relative to the plugin folder

```typescript
{
  context: string;
  event: "setFeedbackLayout";
  payload: {
    layout: string;
  };
}
```

**Predefined layout identifiers:**

| Identifier | Description |
|---|---|
| `$X1` | Icon layout — title and icon placeholders |
| `$A0` | Canvas layout — full and partial canvas areas |
| `$A1` | Value layout — title, icon, and numeric value display |
| `$B1` | Indicator layout — single bar graph |
| `$B2` | Gradient indicator layout — colour-mapped bar |
| `$C1` | Double indicator layout — dual bar graphs |

**Example:**
```json
{
  "context": "abc123",
  "event": "setFeedbackLayout",
  "payload": {
    "layout": "$B1"
  }
}
```

---

### `setFeedback`

Update one or more elements in the current dial/touchscreen layout (Stream Deck +).

Keys in the payload correspond to element `key` identifiers defined in the layout. Values can be a `string`, `number`, or a `FeedbackObject`.

```typescript
{
  context: string;
  event: "setFeedback";
  payload: {
    [key: string]: string | number | FeedbackObject;
  };
}
```

**FeedbackObject fields (common):**

| Field | Type | Description |
|---|---|---|
| `value` | `string \| number` | The element's value |
| `opacity` | `0 \| 0.1 \| 0.2 \| ... \| 1` | Element opacity in 0.1 increments |
| `enabled` | `boolean` | Whether the element is visible |
| `zOrder` | `number` | Z-order for layering |

**Text element additional fields:**

| Field | Type | Description |
|---|---|---|
| `alignment` | `"left" \| "center" \| "right"` | Horizontal text alignment |
| `overflow` | `"clip" \| "ellipsis" \| "fade"` | Overflow handling when text is too long |

**Bar element additional fields:**

| Field | Type | Description |
|---|---|---|
| `subtype` | `0 \| 1 \| 2 \| 3 \| 4` | Bar visual subtype |
| `border_w` | `number` | Border width |

**Gradient bar (`gbar`) additional fields:**

| Field | Type | Description |
|---|---|---|
| `subtype` | `0 \| 1 \| 2 \| 3 \| 4` | Bar visual subtype |
| `bar_h` | `number` | Bar height |
| `border_w` | `number` | Border width |
| `bar_bg_c` | `string` | Background colour |

**Reserved keys** (user customisations override plugin-provided values):
- `title` — user-customised title
- `icon` — user-customised icon

**Example:**
```json
{
  "context": "abc123",
  "event": "setFeedback",
  "payload": {
    "title": "Half way there",
    "indicator": {
      "value": 50
    }
  }
}
```

---

### `setTriggerDescription`

Set the descriptive labels shown in the Stream Deck UI for each encoder interaction type.

```typescript
{
  context: string;
  event: "setTriggerDescription";
  payload: {
    push?: string;
    rotate?: string;
    touch?: string;
    longTouch?: string;
  };
}
```

**Payload fields:**

| Field | Type | Description |
|---|---|---|
| `push` | `string` | Description for dial press |
| `rotate` | `string` | Description for dial rotation |
| `touch` | `string` | Description for touchscreen tap |
| `longTouch` | `string` | Description for touchscreen long press |

---

### `sendToPropertyInspector`

Send an arbitrary JSON message to the Property Inspector for this action instance.

```typescript
{
  context: string;
  event: "sendToPropertyInspector";
  payload: JsonValue;
}
```

**Example:**
```json
{
  "context": "abc123",
  "event": "sendToPropertyInspector",
  "payload": {
    "status": "connected",
    "devices": ["Mic 1", "Mic 2"]
  }
}
```

---

### `switchToProfile`

Switch a device to a profile distributed with the plugin.

> Note: Plugins can only switch to profiles distributed with them via the manifest — not user-defined profiles.

```typescript
{
  context: string;
  device: string;
  event: "switchToProfile";
  payload: {
    profile?: string;
    page?: number;
  };
}
```

**Fields:**

| Field | Type | Description |
|---|---|---|
| `context` | `string` | Any valid action context |
| `device` | `string` | UUID of the device to switch profiles on |
| `payload.profile` | `string` | Profile name as declared in the manifest. Omit to switch back to the previous profile. |
| `payload.page` | `number` | Zero-indexed page number to navigate to within the profile |

**Example:**
```json
{
  "context": "abc123",
  "device": "device-uuid-here",
  "event": "switchToProfile",
  "payload": {
    "profile": "MyCustomProfile",
    "page": 0
  }
}
```

---

### `logMessage`

Write a message to the plugin's log file on disk. Useful for debugging.

```typescript
{
  event: "logMessage";
  payload: {
    message: string;
  };
}
```

**Example:**
```json
{
  "event": "logMessage",
  "payload": {
    "message": "Plugin initialised successfully."
  }
}
```

---

### `openUrl`

Open a URL in the user's default web browser.

```typescript
{
  event: "openUrl";
  payload: {
    url: string;
  };
}
```

**Example:**
```json
{
  "event": "openUrl",
  "payload": {
    "url": "https://docs.elgato.com/streamdeck"
  }
}
```

---

## Version Compatibility

| Feature | Minimum Stream Deck Version |
|---|---|
| `deviceDidChange` event | 7.0 |
| `getResources` / `setResources` / `didReceiveResources` | 7.1 |
| Multi-action support in `willAppear` / `willDisappear` | 6.5 |

---

## Related References

- [WebSocket API — Property Inspector (UI) side](./websocket-ui.md)
- [Manifest Reference](./manifest.md) — action UUIDs, monitored applications, distributed profiles
- [Dials & Touch Strip guide](../guides/dials.md) — in-depth `setFeedback` and layout authoring
- [Settings guide](../guides/settings.md) — patterns for `getSettings` / `setSettings`
