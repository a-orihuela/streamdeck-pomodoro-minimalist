# manifest.json Reference

The `manifest.json` file is the entry point for every Stream Deck plugin. It describes the plugin's identity, capabilities, supported operating systems, and the actions it exposes. Stream Deck reads this file at plugin load time.

**Schema URL (for IDE validation):**
```
https://schemas.elgato.com/streamdeck/plugins/manifest.json
```

Add `"$schema": "https://schemas.elgato.com/streamdeck/plugins/manifest.json"` as the first key in your manifest to enable editor auto-complete and validation.

---

## Root-Level Fields

| Field | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `$schema` | string | No | — | JSON schema URL for IDE validation and auto-complete. |
| `Actions` | [Action](#action)[] | **Yes** | — | Collection of actions provided by the plugin. |
| `ApplicationsToMonitor` | [ApplicationsToMonitor](#applicationstomonitor) | No | — | Applications to monitor for launch/termination events on Mac and Windows. |
| `Author` | string | **Yes** | — | Author's name as displayed on the plugin's Marketplace product page. |
| `Category` | string | No | `"Custom"` | Label for the action-list group that visually groups this plugin's actions. Defaults to `"Custom"` when omitted. |
| `CategoryIcon` | string | No | — | Path to the image displayed next to the action-list group label. Omit the file extension. |
| `CodePath` | string | **Yes** | — | Relative path to the plugin's main entry point (e.g. `"bin/plugin.js"` or `"Counter.exe"`). Used on both platforms unless `CodePathMac` / `CodePathWin` are specified. |
| `CodePathMac` | string | No | — | Entry-point path used on macOS only. Overrides `CodePath` on Mac when present. |
| `CodePathWin` | string | No | — | Entry-point path used on Windows only. Overrides `CodePath` on Windows when present. |
| `DefaultWindowSize` | [number, number] | No | `[500, 650]` | Default pixel dimensions `[width, height]` of the property-inspector window. |
| `Description` | string | **Yes** | — | Plugin description shown on the Marketplace. |
| `Icon` | string | **Yes** | — | Path to the plugin icon shown in Stream Deck preferences. Omit the file extension. Provide standard and `@2x` variants. |
| `Name` | string | **Yes** | — | Plugin name displayed throughout the Stream Deck application (e.g. `"Wave Link"`). |
| `Nodejs` | [Nodejs](#nodejs) | No | — | Node.js runtime configuration. Required for Node.js-based plugins. |
| `OS` | [OS](#os)[] | **Yes** | — | Operating systems and minimum versions the plugin supports. |
| `Profiles` | [Profile](#profile)[] | No | — | Pre-defined profiles bundled with the plugin and distributed to users. |
| `PropertyInspectorPath` | string | No | — | Path to the HTML file used as the global (plugin-wide) property inspector. Must end in `.htm` or `.html`. Individual actions can override this. |
| `SDKVersion` | number | **Yes** | — | Target SDK version. Use `2` for legacy plugins; use `3` for new plugins. Allowed values: `2`, `3`. |
| `Software` | [Software](#software) | **Yes** | — | Minimum Stream Deck software version required to run the plugin. |
| `SupportURL` | string | No | — | URL to the plugin's support page (e.g. `"https://help.elgato.com/"`). |
| `URL` | string | No | — | URL to the plugin's marketing or product website. |
| `UUID` | string | **Yes** | — | Globally unique plugin identifier in reverse-DNS format. Allowed characters: `a-z`, `0-9`, `-`, `.` (e.g. `"com.elgato.wavelink"`). |
| `Version` | string | **Yes** | — | Plugin version in `{major}.{minor}.{patch}.{build}` format (e.g. `"1.0.0.0"`). |

### Root-Level Example

```json
{
  "$schema": "https://schemas.elgato.com/streamdeck/plugins/manifest.json",
  "Author": "Elgato",
  "CodePath": "bin/plugin.js",
  "Description": "Demo plugin with minimal manifest.",
  "Icon": "assets/plugin-icon",
  "Name": "Wave Link",
  "SDKVersion": 3,
  "UUID": "com.elgato.wavelink",
  "Version": "1.0.0.0",
  "Software": { "MinimumVersion": "6.6" },
  "OS": [
    { "Platform": "mac", "MinimumVersion": "13" },
    { "Platform": "windows", "MinimumVersion": "10" }
  ],
  "Actions": []
}
```

---

## Action

Each entry in the root `Actions` array describes one action a user can place on the Stream Deck.

| Field | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `Controllers` | string[] | No | — | Device controller types the action targets. Allowed values: `"Keypad"`, `"Encoder"`. Omit to support all. |
| `DisableAutomaticStates` | boolean | No | `false` | When `true`, Stream Deck will not automatically toggle state on user press; the plugin manages state changes manually. |
| `DisableCaching` | boolean | No | `false` | When `true`, disables image caching for this action's icons. |
| `Encoder` | [Encoder](#encoder) | No | — | Configuration for dial and touchscreen interactions (only relevant when `Controllers` includes `"Encoder"`). |
| `Icon` | string | **Yes** | — | Path to the action's icon in the actions list. Omit the file extension. |
| `Name` | string | **Yes** | — | Action name shown in the actions list (e.g. `"Mute"`). |
| `OS` | string[] | No | — | Restricts the action to specific platforms. Allowed values: `"mac"`, `"windows"`. Omit to support all platforms. |
| `PropertyInspectorPath` | string | No | *(manifest-level value)* | Path to the HTML file for this action's property inspector. Must end in `.htm` or `.html`. Overrides the manifest-level `PropertyInspectorPath`. |
| `States` | [State](#state)[] | **Yes** | — | List of visual states the action can be in. Most actions have one or two states. |
| `SupportedInKeyLogicActions` | boolean | No | `true` | When `false`, the action cannot be used inside key logic actions. |
| `SupportedInMultiActions` | boolean | No | `true` | When `false`, the action cannot be added to a multi-action. |
| `SupportURL` | string | No | — | URL to this action's support page. |
| `Tooltip` | string | No | — | Tooltip text shown on hover in the actions list. |
| `UUID` | string | **Yes** | — | Unique action identifier in reverse-DNS format. Must be unique within the plugin (e.g. `"com.elgato.wavelink.toggle-mute"`). Allowed characters: `a-z`, `0-9`, `-`, `.`. |
| `UserTitleEnabled` | boolean | No | `true` | When `false`, the user cannot set a custom title for this action. |
| `VisibleInActionsList` | boolean | No | `true` | When `false`, the action is hidden from the user-visible actions list (useful for programmatic-only actions). |

### Action Example

```json
{
  "UUID": "com.elgato.wavelink.toggle-mute",
  "Name": "Mute",
  "Icon": "assets/icons/mute",
  "Tooltip": "Toggle microphone mute",
  "Controllers": ["Keypad"],
  "SupportedInMultiActions": true,
  "PropertyInspectorPath": "mute.html",
  "States": [
    { "Image": "assets/icons/mute-off", "Title": "Unmuted" },
    { "Image": "assets/icons/mute-on",  "Title": "Muted"   }
  ]
}
```

---

## State

Each `State` object in an action's `States` array describes a visual appearance the action key can display.

| Field | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `FontFamily` | string | No | — | Default font family for the state's title text (e.g. `"Arial"`). |
| `FontSize` | number | No | — | Default font size (in points) for the title (e.g. `14`). |
| `FontStyle` | string | No | — | Default font style. Allowed values: `""`, `"Bold"`, `"Italic"`, `"Bold Italic"`, `"Regular"`. |
| `FontUnderline` | boolean | No | — | When `true`, the default title is underlined. |
| `Image` | string | **Yes** | — | Path to the state's key image. Omit the file extension. Provide standard and `@2x` variants. |
| `MultiActionImage` | string | No | — | Alternative image path used when the action appears inside a multi-action. |
| `Name` | string | No | — | Human-readable state name shown in multi-action configuration (e.g. `"Muted"`). |
| `ShowTitle` | boolean | No | — | Whether the title is visible by default for this state. |
| `Title` | string | No | — | Default title text shown on the key when the action is first added to the Stream Deck. |
| `TitleAlignment` | string | No | — | Default vertical alignment of the title. Allowed values: `"top"`, `"middle"`, `"bottom"`. |
| `TitleColor` | string | No | — | Default title color as a CSS hex string (e.g. `"#FFFFFF"`). |

### State Example

```json
{
  "Image": "assets/icons/mute",
  "Title": "Mute",
  "Name": "Muted",
  "TitleAlignment": "bottom",
  "TitleColor": "#FFFFFF",
  "FontStyle": "Bold",
  "ShowTitle": true
}
```

---

## Encoder

The `Encoder` object configures how an action behaves on dial/encoder controllers (Stream Deck+). It is only used when the parent action's `Controllers` array includes `"Encoder"`.

| Field | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `background` | string | No | — | Path to the background image rendered on the touchscreen behind the action layout. Omit the file extension. |
| `Icon` | string | No | — | Path to the icon rendered in the dial's circular canvas. Omit the file extension. |
| `layout` | string | No | — | Layout used to render content on the touchscreen. Can be a built-in layout identifier or a path to a custom `.json` layout file. See [Layouts](#encoder-layouts) below. |
| `StackColor` | string | No | — | Background color (CSS hex) of the dial stack (e.g. `"#D60270"`). |
| `TriggerDescription` | [TriggerDescriptions](#triggerdescriptions) | No | — | Human-readable descriptions of each interaction type, shown in the Stream Deck UI. |

### Encoder Layouts

Built-in layout identifiers for the `layout` field:

| Value | Description |
|-------|-------------|
| `$X1` | Empty / blank layout |
| `$A0` | Layout A, variant 0 |
| `$A1` | Layout A, variant 1 |
| `$B1` | Layout B, variant 1 |
| `$B2` | Layout B, variant 2 |
| `$C1` | Layout C, variant 1 |
| `${string}.json` | Path to a custom layout JSON file |

### Encoder Example

```json
{
  "background": "assets/backgrounds/main",
  "Icon": "assets/actions/mute/encoder-icon",
  "layout": "$B1",
  "StackColor": "#D60270",
  "TriggerDescription": {
    "Rotate": "Adjust Volume",
    "Push": "Play / Pause",
    "Touch": "Skip Track",
    "LongTouch": "Open context menu"
  }
}
```

---

## TriggerDescriptions

Describes each interaction for a dial/encoder action. Shown in the Stream Deck UI to help users understand what each physical interaction does.

| Field | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `LongTouch` | string | No | — | Description of what a long touchscreen press does (e.g. `"Open context menu"`). |
| `Push` | string | No | — | Description of what a dial press/push does (e.g. `"Play / Pause"`). |
| `Rotate` | string | No | — | Description of what rotating the dial does (e.g. `"Adjust Volume"`). |
| `Touch` | string | No | — | Description of what a short touchscreen tap does (e.g. `"Skip Track"`). |

---

## Nodejs

Configures the Node.js runtime for Node.js-based plugins. Only include this object when the plugin uses Node.js.

| Field | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `Debug` | string | No | — | Debugger arguments appended to the Node.js process. Use `"enabled"` to attach a debugger, `"break"` to pause on startup, or a custom string such as `"--inspect=127.0.0.1:12345"`. |
| `GenerateProfilerOutput` | boolean | No | — | When `true`, Node.js generates V8 profiler output files on exit. |
| `Version` | string | **Yes** | — | Node.js major version to use. Allowed values: `"20"`, `"24"`. |

> **Note:** Node.js plugins automatically receive these command-line arguments from Stream Deck:
> `--no-addons`, `--enable-source-maps`, `--no-global-search-paths`

### Nodejs Example

```json
{
  "Nodejs": {
    "Version": "20",
    "Debug": "--inspect=127.0.0.1:12345"
  }
}
```

---

## OS

Specifies a supported operating system and its minimum required version. Include one entry per supported platform.

| Field | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `MinimumVersion` | string | **Yes** | — | Minimum OS version required. For macOS use the major version string (e.g. `"13"`); for Windows use the build string (e.g. `"10"`). |
| `Platform` | string | **Yes** | — | Operating system identifier. Allowed values: `"mac"`, `"windows"`. |

### OS Example

```json
"OS": [
  { "Platform": "mac",     "MinimumVersion": "13" },
  { "Platform": "windows", "MinimumVersion": "10" }
]
```

---

## Software

Specifies the minimum Stream Deck software version required to run the plugin.

| Field | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `MinimumVersion` | string | **Yes** | — | Minimum Stream Deck software version. See allowed values below. |

### Allowed `MinimumVersion` Values

| Value | Notes |
|-------|-------|
| `"6.4"` | |
| `"6.5"` | |
| `"6.6"` | Recommended baseline for most plugins |
| `"6.7"` | |
| `"6.8"` | |
| `"6.9"` | |
| `"7.0"` | |
| `"7.1"` | |
| `"7.2"` | |
| `"7.3"` | |
| `"7.4"` | |

### Software Example

```json
"Software": { "MinimumVersion": "6.6" }
```

---

## Profile

A pre-defined Stream Deck profile bundled and distributed with the plugin.

| Field | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `AutoInstall` | boolean | No | `true` | When `true`, the profile is automatically installed when the plugin is installed. |
| `DeviceType` | number | **Yes** | — | Numeric identifier of the target Stream Deck device. See [Device Types](#profile-device-types) below. |
| `DontAutoSwitchWhenInstalled` | boolean | No | `false` | When `true`, Stream Deck does not automatically switch to this profile when the plugin is first installed. |
| `Name` | string | **Yes** | — | File path to the `.streamDeckProfile` file, without the extension (e.g. `"assets/main-profile"`). |
| `Readonly` | boolean | No | `false` | When `true`, the user cannot modify or customize the profile. |

### Profile Device Types

| Value | Device |
|-------|--------|
| `0` | Stream Deck (original, 15-key) |
| `1` | Stream Deck Mini |
| `2` | Stream Deck XL |
| `3` | Stream Deck Mobile |
| `4` | Corsair G Keys (cross-device) |
| `5` | Stream Deck Pedal |
| `6` | Corsair G Keys |
| `7` | Stream Deck Plus |
| `8` | Stream Deck Neo |
| `9`–`13` | Reserved / future devices |

### Profile Example

```json
"Profiles": [
  {
    "Name": "assets/main-profile",
    "DeviceType": 2,
    "AutoInstall": true,
    "Readonly": false,
    "DontAutoSwitchWhenInstalled": false
  }
]
```

---

## ApplicationsToMonitor

Lists applications whose launch and termination events the plugin wants to receive. Stream Deck will notify the plugin via `applicationDidLaunch` and `applicationDidTerminate` events.

| Field | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `mac` | string[] | No | — | Bundle identifiers of macOS applications to monitor (e.g. `["com.apple.mail"]`). |
| `windows` | string[] | No | — | Executable filenames of Windows applications to monitor (e.g. `["Notepad.exe"]`). |

### ApplicationsToMonitor Example

```json
"ApplicationsToMonitor": {
  "mac": ["com.apple.mail", "com.spotify.client"],
  "windows": ["Notepad.exe", "Spotify.exe"]
}
```

---

## Image & Asset Guidelines

| Asset | Format(s) | Size | Notes |
|-------|-----------|------|-------|
| Plugin icon (`Icon`) | PNG | 72×72 px (standard), 144×144 px (`@2x`) | Full-color; shown in preferences |
| Category icon (`CategoryIcon`) | PNG / SVG | 28×28 px (standard), 56×56 px (`@2x`) | Monochromatic white `#FFFFFF` |
| Action icon (`Actions[].Icon`) | PNG / SVG | 20×20 px (standard), 40×40 px (`@2x`) | Monochromatic white `#FFFFFF` |
| State image (`States[].Image`) | GIF / PNG / SVG | 72×72 px (standard), 144×144 px (`@2x`) | Shown on key face |
| Encoder icon | PNG / SVG | Circular canvas | Shown in dial area |

- Always omit the file extension for image paths (Stream Deck automatically resolves standard and `@2x` variants).
- The exception is `CodePath`, `PropertyInspectorPath`, and custom layout `.json` paths — these require the full filename with extension.

---

## UUID Format

Both the root `UUID` and each action's `UUID` must follow reverse-DNS format:

- **Allowed characters:** `a-z`, `0-9`, `-`, `.`
- **No uppercase letters**
- **Convention:** `{reverse-domain}.{plugin-name}.{action-name}`

**Examples:**
```
com.elgato.wavelink
com.elgato.wavelink.toggle-mute
com.aom.pomodorominimalist.some-action
```

---

## Version Format

The `Version` field must follow the pattern `{major}.{minor}.{patch}.{build}` — all four numeric segments are required.

**Example:** `"1.2.3.0"`

---

## Minimal Complete Example

```json
{
  "$schema": "https://schemas.elgato.com/streamdeck/plugins/manifest.json",
  "Author": "Your Name",
  "CodePath": "bin/plugin.js",
  "Description": "A minimal Stream Deck plugin.",
  "Icon": "assets/plugin-icon",
  "Name": "My Plugin",
  "SDKVersion": 3,
  "UUID": "com.example.myplugin",
  "Version": "1.0.0.0",
  "Software": { "MinimumVersion": "6.6" },
  "OS": [
    { "Platform": "mac",     "MinimumVersion": "13" },
    { "Platform": "windows", "MinimumVersion": "10" }
  ],
  "Nodejs": { "Version": "20" },
  "Actions": [
    {
      "UUID": "com.example.myplugin.my-action",
      "Name": "My Action",
      "Icon": "assets/action-icon",
      "Controllers": ["Keypad"],
      "States": [
        { "Image": "assets/state-default", "Title": "Hello" }
      ]
    }
  ]
}
```
