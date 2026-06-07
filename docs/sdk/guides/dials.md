# Dials & Touch Strip

## Overview

An **Encoder** comprises the physical dial and a portion of the touch strip together, enabling plugins to receive dial and touch events while providing visual feedback through layouts.

This guide covers how to implement dial actions combining the physical dial and touch strip portions of Stream Deck devices for plugin development.

---

## Layouts

Layouts display information on the touch strip display using composable layout items in JSON format. The canvas size is **200 × 100 pixels**.

### Built-in Layouts

Six pre-built layouts are available:

| Layout ID | Description |
|-----------|-------------|
| `$X1` | Title and icon placeholders |
| `$A0` | Full canvas with overlaid canvas and title |
| `$A1` | Title, icon, and value display |
| `$B1` | Title, icon, value, and indicator bar |
| `$B2` | Title, icon, value, and gradient indicator bar |
| `$C1` | Title with dual icons and dual indicator bars |

#### Usage in Manifest

Reference built-in layouts via the `Actions[].Encoder.layout` property:

```json
{
  "$schema": "https://schemas.elgato.com/streamdeck/plugins/manifest.json",
  "Actions": [
    {
      "Icon": "action-icon",
      "Name": "Action One",
      "Controllers": ["Encoder"],
      "Encoder": {
        "layout": "$B1"
      },
      "States": [
        {
          "Image": "state-image"
        }
      ],
      "UUID": "come.elgato.test.one"
    }
  ],
  "Author": "Elgato",
  "Software": {
    "MinimumVersion": "6.6"
  }
}
```

#### Programmatic Assignment

Apply layouts dynamically using `setFeedbackLayout()`:

```typescript
import { action, SingletonAction, WillAppearEvent } from "@elgato/streamdeck";

@action({ UUID: "com.elgato.test.one" })
export class IncrementCounter extends SingletonAction {
  override onWillAppear(ev: WillAppearEvent): Promise<void> {
    if (ev.action.isDial()) {
      return ev.action.setFeedbackLayout("$B1");
    }
  }
}
```

---

### Custom Layouts

Custom layouts use JSON files within the plugin folder with the same 200 × 100 pixel canvas constraints.

#### Example Custom Layout

```json
{
  "$schema": "https://schemas.elgato.com/streamdeck/plugins/layout.json",
  "id": "hello-world",
  "items": [
    {
      "key": "title",
      "type": "text",
      "rect": [16, 0, 136, 50],
      "font": { "size": 32, "weight": 600 },
      "alignment": "left"
    }
  ]
}
```

#### Manifest Reference for Custom Layout

```json
{
  "$schema": "https://schemas.elgato.com/streamdeck/plugins/manifest.json",
  "Actions": [
    {
      "Icon": "action-icon",
      "Name": "Action One",
      "Controllers": ["Encoder"],
      "Encoder": {
        "layout": "custom-layout.json"
      },
      "States": [
        {
          "Image": "state-image"
        }
      ],
      "UUID": "come.elgato.test.one"
    }
  ],
  "Author": "Elgato",
  "Software": {
    "MinimumVersion": "6.6"
  }
}
```

#### Programmatic Assignment of Custom Layout

```typescript
import { action, SingletonAction, WillAppearEvent } from "@elgato/streamdeck";

@action({ UUID: "com.elgato.test.one" })
export class IncrementCounter extends SingletonAction {
  override onWillAppear(ev: WillAppearEvent): Promise<void> {
    if (ev.action.isDial()) {
      return ev.action.setFeedbackLayout("custom-layout.json");
    }
  }
}
```

#### Validation

Use the CLI tool to validate custom layout files:

```bash
streamdeck validate
```

Example validation output showing items exceeding canvas bounds:

```
8:13  error    items[0].rect[0] must not be outside of the canvas
8:13  error    └ Width and height, relative to the x and y, must be within the 200x100 px canvas
```

---

## Updating Layouts

Update layout item values at runtime using `setFeedback()` by referencing items via their `key` property.

### Value-Based Update

```typescript
import { action, DialUpEvent, SingletonAction } from "@elgato/streamdeck";

@action({ UUID: "com.elgato.layout-image-test.increment" })
export class IncrementCounter extends SingletonAction<CounterSettings> {
  override onDialUp(ev: DialUpEvent<CounterSettings>): Promise<void> | void {
    ev.action.setFeedback({
      title: "Half way there",
    });
  }
}

type CounterSettings = {
  count?: number;
  incrementBy?: number;
};
```

### Property-Based Update

```typescript
import { action, DialUpEvent, SingletonAction } from "@elgato/streamdeck";

@action({ UUID: "com.elgato.layout-image-test.increment" })
export class IncrementCounter extends SingletonAction<CounterSettings> {
  override onDialUp(ev: DialUpEvent<CounterSettings>): Promise<void> | void {
    ev.action.setFeedback({
      indicator: {
        value: 50,
      },
    });
  }
}

type CounterSettings = {
  count?: number;
  incrementBy?: number;
};
```

---

## Reserved Layout Item Keys

Two keys have special handling — user customizations take precedence over plugin-provided values:

| Key | Behavior |
|-----|----------|
| `title` | User custom titles take precedence over plugin-provided values |
| `icon` | User custom icons take precedence over plugin-provided values |

---

## Trigger Descriptions

Trigger descriptions explain encoder interactions to users. They are shown in the Stream Deck application and cover four interaction types: **Push**, **Rotate**, **Touch**, and **LongTouch**.

### Manifest Configuration

```json
{
  "Actions": [
    {
      "Icon": "action-icon",
      "Name": "Trigger Description Example",
      "Controllers": ["Encoder"],
      "Encoder": {
        "layout": "$A1",
        "TriggerDescription": {
          "Push": "Play / Pause",
          "Rotate": "Adjust Volume",
          "Touch": "Play / Pause",
          "LongTouch": "Skip Track"
        }
      }
    }
  ]
}
```

### Programmatic Update

```typescript
import { action, DialUpEvent, SingletonAction } from "@elgato/streamdeck";

@action({ UUID: "com.elgato.trigger-description-example.increment" })
export class IncrementCounter extends SingletonAction<CounterSettings> {
  override onDialUp(ev: DialUpEvent<CounterSettings>): Promise<void> | void {
    ev.action.setTriggerDescription({
      push: "Increment counter",
      rotate: "Adjust increment",
      touch: "Increment counter",
      longTouch: "Reset counter",
    });
  }
}

type CounterSettings = {
  count?: number;
  incrementBy?: number;
};
```

> **Note:** Passing `undefined` to `setTriggerDescription()` resets the descriptions to the values defined in the manifest.

---

## Events

The following dial-specific events are available as overridable methods on your action class.

### onDialDown

```typescript
function onDialDown?(ev: DialDownEvent): void | Promise<void>
```

Triggered when the user presses a dial.

### onDialRotate

```typescript
function onDialRotate?(ev: DialRotateEvent): void | Promise<void>
```

Triggered when the user rotates a dial.

### onDialUp

```typescript
function onDialUp?(ev: DialUpEvent): void | Promise<void>
```

Triggered when the user releases a pressed dial.

### onTouchTap

```typescript
function onTouchTap?(ev: TouchTapEvent): void | Promise<void>
```

Triggered when the user taps the touchscreen.

---

## Commands

The following methods are available on dial actions for programmatic control.

### getResources()

```typescript
function getResources(): Promise<Resources>
```

Retrieves associated action resources.

> **Note:** Available from Stream Deck 7.1.

### getSettings()

```typescript
function getSettings<U extends JsonObject>(): Promise<U>
```

Retrieves persisted settings for the action instance.

### setFeedback()

```typescript
function setFeedback(feedback: FeedbackPayload): Promise<void>
```

Updates visual layout items on the touch strip display. Items are identified by their `key` property in the layout definition.

### setFeedbackLayout()

```typescript
function setFeedbackLayout(layout: string): Promise<void>
```

Assigns a layout to the action. Accepts either a built-in layout identifier (e.g. `"$B1"`) or a path to a custom layout JSON file within the plugin folder.

### setImage()

```typescript
function setImage(image?: string): Promise<void>
```

Sets the displayed image for the action. Only applies when the user has not customized the image.

### setResources()

```typescript
function setResources(resources: Resources): Promise<void>
```

Associates resources with the action.

> **Note:** Available from Stream Deck 7.1.

### setSettings()

```typescript
function setSettings<U extends JsonObject>(value: U): Promise<void>
```

Persists settings for the action instance.

### setTitle()

```typescript
function setTitle(title: string): Promise<void>
```

Sets the displayed title for the action. Only applies when the user has not customized the title.

### setTriggerDescription()

```typescript
function setTriggerDescription(descriptions?: TriggerDescriptionOptions): Promise<void>
```

Updates the interaction descriptions shown in the Stream Deck application. Passing `undefined` resets descriptions to the values defined in the manifest.

### showAlert()

```typescript
function showAlert(): Promise<void>
```

Temporarily displays a yellow warning triangle on the action for visual feedback.

---

## Notes

- Some commands require asserting the action is a dial using `Action.isDial()` when called within shared event handlers that may handle both key and encoder action types.
- The touch strip canvas is always **200 × 100 pixels**.
- Custom layout files must reside within the plugin folder and be referenced by their relative path.
