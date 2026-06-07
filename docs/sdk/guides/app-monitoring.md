# App Monitoring

The Stream Deck SDK enables plugins to receive notifications when registered applications launch or terminate, facilitating integration with local software through mechanisms like IPC.

## Registering Apps

Applications must be registered in the manifest JSON file via the `ApplicationsToMonitor` property to enable monitoring.

### Manifest Configuration

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

### Platform-Specific Identifiers

**Windows:** Applications are identified by executable filename, viewable in Task Manager's details tab or file properties.

**macOS:** Applications use the `CFBundleIdentifier` from the app's `Info.plist` file. Retrieve via terminal:

```bash
osascript -e 'id of app "Application Name"'
```

## Apps Launching

Subscribe to the `onApplicationDidLaunch` event to detect when registered applications start.

```typescript
import streamDeck, { ApplicationDidLaunchEvent } from "@elgato/streamdeck";

streamDeck.system.onApplicationDidLaunch((ev: ApplicationDidLaunchEvent) => {
	// Handle a registered application launching
	streamDeck.logger.info(ev.application); // e.g. "Elgato Wave Link.exe"
});
```

## Apps Terminating

Subscribe to the `onApplicationDidTerminate` event to detect when registered applications close.

```typescript
import streamDeck, { ApplicationDidTerminateEvent } from "@elgato/streamdeck";

streamDeck.system.onApplicationDidTerminate((ev: ApplicationDidTerminateEvent) => {
	// Handle a registered application terminating.
	streamDeck.logger.info(ev.application); // e.g. "Elgato Wave Link.exe"
});
```
