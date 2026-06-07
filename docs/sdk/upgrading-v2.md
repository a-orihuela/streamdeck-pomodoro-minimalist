# Upgrading to Version 2.x - Stream Deck SDK

## Overview

This guide assists developers in upgrading Stream Deck plugins using `@elgato/streamdeck` to version 2.

**Installation:**
```
npm i @elgato/streamdeck@latest
```

## Breaking Changes

Four significant breaking changes exist in version 2.0:

1. UI namespace simplification
2. Dependency decoupling
3. Manifest namespace removal
4. Browser import removal

## UI Communication Updates

### Send to Property Inspector

The property inspector communication method no longer requires `.current?` notation.

**Previous approach:**
```javascript
streamDeck.ui.current?.sendToPropertyInspector({
  message: "Hello world",
});
```

**Updated approach:**
```javascript
streamDeck.ui.sendToPropertyInspector({
  message: "Hello world",
});
```

### Property Inspector Action Access

The current property inspector action is now accessed via the `.action` property instead of `.current`.

**Previous approach:**
```javascript
streamDeck.ui.current;
```

**Updated approach:**
```javascript
streamDeck.ui.action;
```

## Dependencies

Version 2.0 unbundles `@elgato/streamdeck`, enabling better functionality access and avoiding dependency conflicts. Previously isolated utilities are now accessible.

### JSON Types

**Previous import:**
```javascript
import type {
  JsonObject,
  JsonPrimitive,
  JsonValue
} from "@elgato/streamdeck";
```

**New import location:**
```javascript
import type {
  JsonObject,
  JsonPrimitive,
  JsonValue
} from "@elgato/utils";
```

### Logging Configuration

**Previous syntax:**
```javascript
import streamDeck, { LogLevel } from "@elgato/streamdeck";
streamDeck.logger.setLevel(LogLevel.TRACE);
```

**Updated syntax:**
```javascript
import streamDeck from "@elgato/streamdeck";
streamDeck.logger.setLevel("trace");
```

### Other Utilities

**Previous imports:**
```javascript
import {
  Enumerable,
  EventEmitter,
  type EventsOf,
} from "@elgato/streamdeck";
```

**New import source:**
```javascript
import {
  Enumerable,
  EventEmitter,
  type EventsOf,
} from "@elgato/utils";
```

## Manifest Access Removal

Runtime access to `streamDeck.manifest` has been eliminated due to DRM protection implementation. The manifest is now treated as a protected resource.

## Browser Import Restriction

Importing `@elgato/streamdeck` in browser contexts (property inspector) is no longer supported in version 2.0.
