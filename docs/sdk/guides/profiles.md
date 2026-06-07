# Profiles

Stream Deck Profiles are shareable layouts specific to a Stream Deck device that can include pre-defined actions, icons, and settings. Bundling Stream Deck profiles into your plugin can be useful in scenarios such as streamlining the user's setup experience, or providing additional functionality utilizing the full Stream Deck canvas.

## Creating a Profile

Profiles are configured by dragging plugin actions from the Stream Deck app's action list onto the canvas. Once your profile is complete, navigate to the profiles tab in Stream Deck preferences, right-click the profile you wish to export, and select "Export" to save it as a `.streamDeckProfile` file.

## Bundling

After obtaining your `.streamDeckProfile` file, add it to the `*.sdPlugin` directory and register it in the `Profiles` array in the plugin's manifest.

> **Note:** The `Name` in the manifest should be the path to the `.streamDeckProfile` file, relative to the manifest, **without** the extension.

Example manifest configuration:

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

### Profiles Manifest Properties

| Property | Type | Description |
|---|---|---|
| `Name` | `string` | Path to the `.streamDeckProfile` file, relative to the manifest, without the file extension. |
| `DeviceType` | `number` | Specifies which Stream Deck device type the profile targets (e.g. `0`). |
| `Readonly` | `boolean` | Controls whether the profile can be modified by users. |
| `DontAutoSwitchWhenInstalled` | `boolean` | Prevents automatic profile switching upon initial plugin installation. |
| `AutoInstall` | `boolean` | When `true` (default), users are prompted to install the bundled profile when the plugin is first installed. Setting this to `false` defers the prompt until the plugin attempts to switch to the profile. |

## Switching to a Profile

Plugins can programmatically switch to a bundled profile using `streamDeck.profiles.switchToProfile`, passing the device ID and the profile name as defined in the manifest.

```typescript
import streamDeck, { action, KeyDownEvent, SingletonAction } from "@elgato/streamdeck";

@action({ UUID: "com.elgato.example.action" })
export class IncrementCounter extends SingletonAction {
    /**
     * Occurs when the user presses the key action.
     */
    override onKeyDown(ev: KeyDownEvent<CounterSettings>): void | Promise<void> {
        streamDeck.profiles.switchToProfile(ev.action.device.id, "My Cool Profile");
    }
}

type CounterSettings = {
    count: number;
};
```

### `switchToProfile` Signature

```typescript
streamDeck.profiles.switchToProfile(deviceId: string, profileName: string): void
```

**Parameters:**

| Parameter | Type | Description |
|---|---|---|
| `deviceId` | `string` | The unique identifier of the target Stream Deck device. |
| `profileName` | `string` | The name of the profile to activate, as defined in the manifest. |

> **Important:** Plugins do not have access to user-defined profiles and therefore cannot switch to them. Plugins can only switch to profiles distributed with the plugin.
