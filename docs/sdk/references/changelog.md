# Stream Deck SDK Changelog

## WebSocket API Changelog

### Stream Deck v7.1.0

- Added support for embedding resources within actions
- Added support for Node.js 24, configurable within the manifest
- Added in-app developer tools that track the current property inspector
- Fixed device type mapping for Stream Deck Scissor Keys and Corsair keyboards

### Stream Deck v7.0.0

- Added `deviceDidChange` event (occurs when device metadata or size changes)
- Added support for passive deep-link messages using `?streamdeck=hidden` query parameter
- Added `SupportedInKeyLogicActions` property to actions within the manifest
- Added device type for Virtual Stream Deck (11)
- Updated device `size` to reflect the visual size of the device
- Fixed an issue whereby linked plugins would not run on first launch after installing Stream Deck

### Stream Deck v6.9.0

- Added `SupportURL` option to the manifest with configurable help buttons
- Added device type for Stream Deck Studio
- Improved parsing of URLs when receiving deep-link messages
- Resolved an issue with updating layout item's `zOrder`
- Updated Node.js runtime to v20.19.0
- Updated Chromium to v122.0.6261.171
- Note: `beforeunload` event no longer emitted in property inspector

### Stream Deck v6.7.0

- Added `isInMultiAction` to property inspector action information
- Updated Node.js runtime to v20.15.0
- Updated Chromium to v118.0.5993.220

### Stream Deck v6.6.0

- Added support for Stream Deck Neo and SCUF controllers
- Added support for OS-specific actions via `Actions[].OS`
- Added ability to disable auto-installing pre-defined profiles via `Profiles[].AutoInstall`

### Stream Deck v6.5.0

- Added support for receiving deep-link messages
- Added support for switching to specific profile pages with `switchToProfile`
- Added `controller` information to `WillAppear` and `WillDisappear` events
- Added support for Node.js plugins with `.cjs` or `.mjs` file extensions
- Removed `dialPress` event (replaced with `dialDown` and `dialUp`)
- Updated Node.js runtime to v20.8.1

### Stream Deck v6.4.0

- Added support for Node.js plugins (beta)
- Added `DisableAutomaticStates` option to manifest
- Added `setTriggerDescription` command for Stream Deck + encoders
- Added `range` to BAR and GBAR layout items
- Added `text-overflow` to TEXT layout item
- Deprecated support for installing plugins using `streamdeck://` scheme

### Stream Deck v6.1.0

- Added `dialDown` event for Stream Deck + encoders
- Added `dialUp` event for Stream Deck + encoders
- Deprecated `dialPress` event for Stream Deck + encoders

### Stream Deck v6.0.0

- Added support for Stream Deck +
- Added `UserTitleEnabled` property to the manifest
- Added `Encoder` and `TriggerDescription` to manifest for Stream Deck +
- Added `Layouts` for Stream Deck + displays
- Added `setFeedback` and `setFeedbackLayout` events
- Added `touchTap` event for Stream Deck + displays
- Added `dialPress` and `dialRotate` events for Stream Deck + encoders
- Updated `willAppear` and `willDisappear` events to include `controller` property

### Archive

#### Stream Deck v5

- **v5.3.0**: Added support for Corsair Voyager
- **v5.2.0**: Added support for Stream Deck Pedal
- **v5.0.0**: Added SVG icon support; updated property inspector for global settings; added OS information

#### Stream Deck v4

- **v4.8.0**: Added state specification for `setImage` and `setTitle` events
- **v4.7.0**: Added support for Corsair G Keys
- **v4.6.0**: Updated `switchToProfile` command for editable pre-configured profiles
- **v4.5.1**: Updated `setImage` command to accept SVG images
- **v4.3.3**: Added `DontAutoSwitchWhenInstalled` manifest option
- **v4.3.0**: Added Stream Deck XL and Mobile support; added `systemDidWakeUp` event
- **v4.2.0**: Updated events for Multi-Actions; enhanced `switchToProfile` functionality

---

## SDK Changelog

### v7.1.0

- Added support for embedding resources within actions
- Added support for Node.js 24, configurable within the manifest
- Added in-app developer tools that track the current property inspector
- Fixed device type mapping for Stream Deck Scissor Keys and Corsair keyboards

### v7.0.0

- Added `streamDeck.devices.onDeviceDidChange` event (occurs when a device's metadata or size changes)
- Added support for passive deep-link messages using the `?streamdeck=hidden` query parameter
- Added `SupportedInKeyLogicActions` property to actions within the manifest (when `false`, action won't be usable within Key Logic actions; default is `true`)
- Added device type for Virtual Stream Deck (11)
- Updated device `size` to reflect the visual size of the device
- Fixed an issue whereby linked plugins would not run on first launch after installing Stream Deck

### v6.9.0

- Added `SupportURL` option to the manifest with help button functionality
- Added device type for Stream Deck Studio
- Improved parsing of URLs when receiving deep-link messages
- Resolved an issue whereby updating a layout item's `zOrder` would result in an error
- Updated Node.js runtime to v20.19.0
- Updated Chromium to v122.0.6261.171
- Quality of life: Stream Deck now appears in Dock on macOS when main configuration window is active

### v6.7.0

- Added `isInMultiAction` to property inspector action information
- Updated Node.js runtime to v20.15.0
- Updated Chromium to v118.0.5993.220

### v6.6.0

- Added support for Stream Deck Neo and SCUF controllers
- Added support for OS-specific actions via `Actions[].OS` within the manifest
- Added ability to disable automatically installing pre-defined profiles via `Profiles[].AutoInstall`

### v6.5.0

- Added support for receiving deep-link messages
- Added support for switching to a specific profile page when calling `switchToProfile`
- Added `controller` information to `WillAppear` and `WillDisappear` events for multi-actions
- Added support for Node.js plugins with `.cjs` or `.mjs` file extensions
- Removed `dialPress` event in favour of `dialDown` and `dialUp`
- Updated Node.js runtime to v20.8.1

### v6.4.0

- Added support for Node.js plugins (beta)
- Added `DisableAutomaticStates` option to manifest
- Added `setTriggerDescription` command for Stream Deck + encoders
- Added `range` to BAR layout item
- Added `range` to GBAR layout item
- Added `text-overflow` to TEXT layout item
- Deprecated support for installing plugins using the `streamdeck://` scheme
