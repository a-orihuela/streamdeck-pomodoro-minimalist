# Plugin Environment

Source: https://docs.elgato.com/streamdeck/sdk/introduction/plugin-environment/

---

## Host Environment

The architecture of a Stream Deck plugin is comparable to a web app, with frontend and backend components. Unlike traditional web apps, Stream Deck plugins are hosted locally on the user's machine, with all hardware communication managed by the Stream Deck app.

### Secrets

> Stream Deck plugins run locally on the user's machine and it is not recommended to include secrets, for example private API keys, when packaging and distributing your plugin.

---

## JavaScript Runtimes

Plugins use separate JavaScript runtimes for different layers:

| Layer | Runtime | Responsibilities |
|-------|---------|-----------------|
| Application-layer (backend) | Node.js | Main logic handling events from Stream Deck, such as key presses |
| Presentation-layer (frontend) / "property inspector" | Chromium with DOM access | HTML views rendered in the Stream Deck app for user configuration |

### Runtime Versions

The latest JavaScript runtime versions supported by each Stream Deck release:

| Stream Deck | Node.js (application) | Chromium (UI) |
|-------------|----------------------|---------------|
| 7.3 | 20.20.0, 24.13.1 | 130.0.0.0 |
| 7.2 | 20.20.0, 24.13.1 | 130.0.0.0 |
| 7.1 | 20.20.0, 24.13.1 | 130.0.0.0 |
| 7.0 | 20.19.0 | 122.0.6261.171 |
| 6.9 | 20.19.0 | 122.0.6261.171 |
| 6.8 | 20.18.0 | 118.0.5993.220 |
| 6.7 | 20.15.0 | 118.0.5993.220 |
| 6.6 | 20.8.1 | 112.0.5615.213 |
| 6.5 | 20.8.1 | 108.0.5359.220 |
| 6.4 | 20.5.1 | 102.0.5005.177 |

> From Stream Deck 7.1, Node.js versions are automatically updated to the latest versions supported by Stream Deck.

---

## Manifest

The manifest is a JSON file located at `./*.sdPlugin/manifest.json`. It contains plugin metadata, action definitions, and version compatibility information. Stream Deck reads this file to understand how to load and interact with the plugin.

### Example Manifest

```json
{
    "$schema": "https://schemas.elgato.com/streamdeck/plugins/manifest.json",
    "UUID": "com.elgato.hello-world",
    "Name": "Hello World",
    "Version": "0.1.0.0",
    "Author": "Elgato",
    "Actions": [
        {
            "Name": "Counter",
            "UUID": "com.elgato.hello-world.increment",
            "Icon": "static/imgs/actions/counter/icon",
            "Tooltip": "Displays a count, which increments by one on press.",
            "Controllers": ["Keypad"],
            "States": [
                {
                    "Image": "static/imgs/actions/counter/key",
                    "TitleAlignment": "middle"
                }
            ]
        }
    ],
    "Category": "Hello World",
    "CategoryIcon": "static/imgs/plugin/category-icon",
    "CodePath": "bin/plugin.js",
    "Description": ".",
    "Icon": "static/imgs/plugin/marketplace",
    "SDKVersion": 2,
    "Software": {
        "MinimumVersion": "6.6"
    },
    "OS": [
        {
            "Platform": "mac",
            "MinimumVersion": "10.15"
        },
        {
            "Platform": "windows",
            "MinimumVersion": "10"
        }
    ],
    "Nodejs": {
        "Version": "20",
        "Debug": "enabled"
    },
    "ApplicationsToMonitor": {
        "mac": ["com.elgato.WaveLink"],
        "windows": ["Elgato Wave Link.exe"]
    },
    "Profiles": [
        {
            "Name": "My Cool Profile",
            "DeviceType": 0,
            "Readonly": false,
            "DontAutoSwitchWhenInstalled": false,
            "AutoInstall": true
        }
    ]
}
```

### Manifest Fields

| Field | Description |
|-------|-------------|
| `$schema` | JSON schema URL for validation and IDE autocompletion |
| `UUID` | Unique reverse-DNS identifier for the plugin (e.g. `com.company.plugin-name`) |
| `Name` | Display name of the plugin shown in Stream Deck |
| `Version` | Plugin version in four-part format: `major.minor.patch.build` |
| `Author` | Name of the plugin author or organization |
| `Actions` | Array of action definitions (see below) |
| `Category` | Category name shown in the Stream Deck action list |
| `CategoryIcon` | Path to the category icon (without file extension) |
| `CodePath` | Relative path to the plugin's main entry point script |
| `Description` | Short description of the plugin |
| `Icon` | Path to the plugin marketplace icon (without file extension) |
| `SDKVersion` | Stream Deck SDK version; must be `2` |
| `Software.MinimumVersion` | Minimum Stream Deck software version required (e.g. `"6.6"`) |
| `OS` | Array of OS requirements with platform and minimum version |
| `Nodejs.Version` | Node.js major version to use (e.g. `"20"`) |
| `Nodejs.Debug` | Enable Node.js debugger; set to `"enabled"` during development |
| `ApplicationsToMonitor` | Apps whose launch/quit events the plugin wants to receive |
| `Profiles` | Bundled profiles to auto-install on supported devices |

#### Action Fields

Each entry in the `Actions` array supports these fields:

| Field | Description |
|-------|-------------|
| `Name` | Display name of the action |
| `UUID` | Unique reverse-DNS identifier for the action |
| `Icon` | Path to the action icon (without file extension) |
| `Tooltip` | Short description shown on hover in the action list |
| `Controllers` | Array of controller types: `"Keypad"`, `"Encoder"` (dial/touchscreen) |
| `States` | Array of visual states the action can display |

#### State Fields

| Field | Description |
|-------|-------------|
| `Image` | Path to the state image (without file extension) |
| `TitleAlignment` | Alignment of the title text on the key: `"top"`, `"middle"`, `"bottom"` |

#### OS Platform Values

| Value | Platform |
|-------|----------|
| `"mac"` | macOS (minimum version uses macOS version number, e.g. `"10.15"`) |
| `"windows"` | Windows (minimum version uses Windows version number, e.g. `"10"`) |

#### Profile Fields

| Field | Type | Description |
|-------|------|-------------|
| `Name` | string | Profile name |
| `DeviceType` | number | Target device type identifier |
| `Readonly` | boolean | Whether the profile can be edited by the user |
| `DontAutoSwitchWhenInstalled` | boolean | Prevent automatic switch to profile on install |
| `AutoInstall` | boolean | Automatically install the profile |

---

## Plugin Lifecycle

Stream Deck manages the full plugin lifecycle automatically. This includes:

- Launching the plugin process when Stream Deck starts
- Establishing the WebSocket connection between plugin and Stream Deck
- Restarting the plugin automatically if it crashes (failure recovery)
- Shutting down the plugin when Stream Deck exits

Plugins do not need to manage hardware communication directly — Stream Deck handles all device I/O and forwards relevant events to the plugin via the SDK.

---

## Further Reading

- [Manifest API Reference](https://docs.elgato.com/streamdeck/sdk/references/manifest) — Complete manifest field documentation
- [Getting Started](https://docs.elgato.com/streamdeck/sdk/introduction/getting-started/) — Setting up your development environment
