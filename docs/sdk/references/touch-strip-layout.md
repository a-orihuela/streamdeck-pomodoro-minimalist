# Touch Strip Layout

The Stream Deck + touch strip is shared amongst four actions, with each action able to render one quarter of the touch strip occupying **200 × 100 px**.

You can create bespoke layouts which allow you to completely customize how content is rendered on a Stream Deck + touch strip. Layouts can be represented as JSON files or programmatic objects.

## JSON Schema

A JSON schema is available for validation and intellisense support in layout files:

```
https://schemas.elgato.com/streamdeck/plugins/layout.json
```

## Layout Item Types

The following item types are supported:

| Type | Description |
|------|-------------|
| `bar` | Horizontal bar with a filler, e.g. a progress bar |
| `gbar` | Horizontal bar with an indicator represented as a triangle beneath the bar |
| `pixmap` | Image rendering from local files or base64-encoded strings |
| `text` | Text rendering with customizable alignment and styling |

---

## Common Properties

All layout items share the following properties:

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `key` | `string` | Required | Unique name used to identify the layout item. When calling `setFeedback`, this key is used to target the item. Cannot be changed at runtime. |
| `type` | `string` | Required | Type of the layout item: `"bar"`, `"gbar"`, `"pixmap"`, or `"text"`. Cannot be changed at runtime. |
| `rect` | `[x, y, width, height]` | Required | Array defining the item's coordinates and dimensions. Must be within canvas size of 200 × 100. Cannot be changed at runtime. |
| `enabled` | `boolean` | `true` | Determines item visibility. |
| `opacity` | `number` | `1` | Defines the opacity of the item being shown, based on a single-decimal value between `0` and `1` (in `0.1` increments). |
| `background` | `string` | — | Background color represented as a named color, hexadecimal value, or gradient. |
| `zOrder` | `number` | `0` | Z-order of the item, used to layer items within a layout. Must be between `0` and `700`. Items with the same `zOrder` must **not** have an overlapping `rect`. |

---

## Bar

A horizontal bar with a filler (e.g. a progress bar).

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `number` | Required | Value used to determine how much of the bar is filled. |
| `range` | `{ min, max }` | `0..100` | Defines the range of the value the bar represents, e.g. 0–20, 0–100, etc. |
| `bar_bg_c` | `string` | `darkGray` | Bar background color represented as a named color, hexadecimal value, or gradient. |
| `bar_fill_c` | `string` | `white` | Fill color of the bar represented as a named color, hexadecimal value, or gradient. |
| `bar_border_c` | `string` | `white` | Border color represented as a named color or hexadecimal value. |
| `border_w` | `number` | `2` | Width of the border around the bar, as a whole number. |
| `subtype` | `0`–`4` | `4` | Sub-type used to determine the type of bar to render: `Rectangle` (0), `DoubleRectangle` (1), `Trapezoid` (2), `DoubleTrapezoid` (3), `Groove` (4). |

---

## GBar

A horizontal bar with an indicator represented as a triangle beneath the bar.

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `number` | Required | Value used to determine the location of the indicator. |
| `range` | `{ min, max }` | `0..100` | Defines the range of the value the bar represents, e.g. 0–20, 0–100, etc. |
| `bar_bg_c` | `string` | `darkGray` | Bar background color represented as a named color, hexadecimal value, or gradient. |
| `bar_fill_c` | `string` | `white` | Fill color of the bar represented as a named color, hexadecimal value, or gradient. |
| `bar_border_c` | `string` | `white` | Border color represented as a named color or hexadecimal value. |
| `border_w` | `number` | `2` | Width of the border around the bar, as a whole number. |
| `bar_h` | `number` | `10` | Height of the bar's indicator. |
| `subtype` | `0`–`4` | `4` | Sub-type used to determine the type of bar to render: `Rectangle` (0), `DoubleRectangle` (1), `Trapezoid` (2), `DoubleTrapezoid` (3), `Groove` (4). |

---

## Pixmap

Renders an image within the layout.

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `string` | — | Image to render. Can be a path to a local file, a base64-encoded string with MIME type, or an SVG string. |

---

## Text

Renders text within the layout.

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `string` | — | Text to be displayed. |
| `color` | `string` | `white` | Color of the font represented as a named color or hexadecimal value. |
| `alignment` | `"center"` \| `"left"` \| `"right"` | `"center"` | Alignment of the text. Ignored if `key` is `"title"`. |
| `font.size` | `number` | — | Size of the font in pixels, represented as a whole number. Ignored if `key` is `"title"`. |
| `font.weight` | `number` | — | Weight of the font. Must be a whole number in the range `100`–`1000`. Ignored if `key` is `"title"`. |
| `text-overflow` | `"clip"` \| `"ellipsis"` \| `"fade"` | `"clip"` | Defines how overflowing text should be rendered: `clip` truncates at the boundary; `ellipsis` adds (…); `fade` applies a gradient fade. |

### Special "title" Key

When a text item's `key` is set to `"title"`, the property inspector automatically allows users to configure font settings. Additionally, calling `setTitle` will update this specific item. User preferences override hardcoded `color`, `font.size`, and `font.weight` values for title items.

---

## Color Specification

Colors can be specified in the following formats:

- **Named color** — e.g. `"pink"`, `"white"`, `"darkGray"`
- **Hexadecimal value** — e.g. `"#204cfe"`
- **Gradient** — using the format `"{offset}:{color}[,...]"`

### Gradient Syntax

```
"0:#ff0000,0.5:yellow,1:#00ff00"
```

This example creates a gradient from red (at offset `0`) to yellow (at offset `0.5`) to green (at offset `1`).

---

## Canvas Constraints

- All item coordinates must fit within the **200 × 100** pixel canvas.
- Items with the same `zOrder` value must **not** have overlapping `rect` values.
- `zOrder` values must be in the range **0–700**.

## Runtime Immutability

The following properties cannot be changed at runtime:

- `key`
- `type`
- `rect`
