# Embedded Resources

Embedding resources, such as audio or configuration files, into instances of actions makes them more portable, allowing you and others to easily share fully-working profiles that depend on your plugin.

Resources become self-contained when embedded into action instances. When exported, they compress alongside metadata into `.streamDeckProfile` or `.streamDeckAction` files for easy marketplace sharing.

Useful applications include audio players, soundboards, app scripts, and external configuration files.

> **Note:** This feature is available from Stream Deck 7.1 or higher.

## Embedding Resources

Similar to settings management, resources are managed using the following methods:

- `action.setResources()` — Associates resources with an action instance
- `action.getResources()` — Retrieves associated resources
- `SingletonAction.onDidReceiveResources()` — Triggers when resources are updated in the property inspector

The payload must be a key-to-file-path map structure, which allows Stream Deck to update paths during import/export operations.

### Example — Setting Resources

```typescript
import { action, type DidReceiveSettingsEvent, SingletonAction } from "@elgato/streamdeck";

@action({ UUID: "com.elgato.audio.play" })
class PlayAudio extends SingletonAction {
	override async onDidReceiveSettings(ev: DidReceiveSettingsEvent<Settings>): Promise<void> {
		await ev.action.setResources({
			audioFile: ev.payload.settings.userSelectedFile,
		});
	}
}

type Settings = {
	userSelectedFile: string;
};
```

## Accessing Resources

Embedded file paths can be retrieved through `action.getResources()` or via the `onDidReceiveResources()` lifecycle event.

> **Tip:** Resources use Stream Deck's new message identifiers, meaning `onDidReceiveResources` is **only** called when the resources were updated within the property inspector. This makes it straightforward to differentiate resource update events from resource retrieval requests.

### Example — Accessing Resources

```typescript
import { action, type DidReceiveSettingsEvent, type KeyDownEvent, SingletonAction } from "@elgato/streamdeck";
import { audioService } from "./audio-service";

@action({ UUID: "com.elgato.audio.play" })
class PlayAudio extends SingletonAction {
	override async onDidReceiveSettings(ev: DidReceiveSettingsEvent<Settings>): Promise<void> {
		await ev.action.setResources({
			audioFile: ev.payload.settings.userSelectedFile,
		});
	}

	override async onKeyDown(ev: KeyDownEvent): Promise<void> {
		const filePath = ev.payload.resources.audioFile;
		if (filePath) {
			await audioService.play(ev.payload.resources.audioFile);
		}
	}
}

type Settings = {
	userSelectedFile: string;
};
```

## File Paths

Resource payloads use a key-value map structure where values are absolute file paths. For example:

```json
{
    "fileOne": "C:\\audio\\track.mp3",
    "fileTwo": "C:\\config.json"
}
```

When an action is exported and then imported on another system, Stream Deck automatically mutates the file paths to reflect the new installation location. The directory is updated to a generated UUID-based path, while the original filenames are preserved:

```json
{
    "fileOne": "C:\\...\\7ae61d68-6882-41dd-8e90-3c54114fa2cf\\track.mp3",
    "fileTwo": "C:\\...\\7ae61d68-6882-41dd-8e90-3c54114fa2cf\\config.json"
}
```

> **Tip:** The file name of an embedded resource is unchanged when exporting or importing an action. Only the directory path is updated to reflect the new installation location.
