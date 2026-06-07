# Devices

The Stream Deck SDK provides a list of available Stream Deck devices.

## Device Types

Devices are referenced against the following enumeration:

| Type ID | Device(s) |
|---------|-----------|
| 0 | Stream Deck, Stream Deck Scissor Keys |
| 1 | Stream Deck Mini |
| 2 | Stream Deck XL |
| 3 | Stream Deck Mobile |
| 4 | Corsair GKeys |
| 5 | Stream Deck Pedal |
| 6 | Corsair Voyager |
| 7 | Stream Deck + |
| 8 | SCUF Controller |
| 9 | Stream Deck Neo |
| 10 | Stream Deck Studio |
| 11 | Virtual Stream Deck |
| 12 | Galleon 100 SD |
| 13 | Stream Deck + XL |

## Connecting

You can iterate through the list of available devices using `streamDeck.devices`. Each device exposes properties including `id`, `isConnected`, `name`, `size`, and `type`.

```typescript
import streamDeck from "@elgato/streamdeck";

streamDeck.devices.forEach((device) => {
	const { id, isConnected, name, size, type } = device;

	streamDeck.logger.info(name); // Stream Deck Neo, Stream Deck +
});
```

You can also listen for new device connections using the `onDeviceDidConnect` event:

```typescript
import streamDeck, { DeviceDidConnectEvent } from "@elgato/streamdeck";

streamDeck.devices.onDeviceDidConnect((ev: DeviceDidConnectEvent) => {
	const { id, isConnected, name, size, type } = ev.device;

	streamDeck.logger.info(name);
});
```

## Changing

> **Note:** Monitoring device changes is available from Stream Deck 7.0.

You can listen for device property changes using the `onDeviceDidChange` event:

```typescript
import streamDeck, { type DeviceDidChangeEvent } from "@elgato/streamdeck";

streamDeck.devices.onDeviceDidChange((ev: DeviceDidChangeEvent) => {
	const { id, isConnected, name, size, type } = ev.device;

	streamDeck.logger.info(name);
});
```

## Disconnecting

You can listen for device disconnections using the `onDeviceDidDisconnect` event:

```typescript
import streamDeck, { DeviceDidDisconnectEvent } from "@elgato/streamdeck";

streamDeck.devices.onDeviceDidDisconnect((ev: DeviceDidDisconnectEvent) => {
	const { id, isConnected, name, size, type } = ev.device;

	streamDeck.logger.info(name);
});
```

> **Note:** While you can use these events to optimize resource utilization, the keys/encoders can still be visible in the Stream Deck app while the hardware is disconnected.

## Hardware

### Stream Deck Neo

- 8 customizable LCD keys
- 2 capacitive touch buttons

### Stream Deck

- 15 customizable LCD keys

### Stream Deck Scissor Keys

- 15 customizable LCD keys (scissor-switch key mechanism)

### Stream Deck +

- 8 customizable LCD keys
- 4 dials with rotation and press
- Touch strip

### Stream Deck + XL

- Type ID: 13
- Extended variant of Stream Deck + with additional controls

### Stream Deck XL

- 32 customizable LCD keys

### Stream Deck Mini

- 6 customizable LCD keys

### Stream Deck Pedal

- 3 customizable pedals

### Stream Deck Studio

- Type ID: 10

### Stream Deck Mobile

- Mobile app-based virtual Stream Deck

### Corsair Galleon 100 SD

- 12 customizable LCD keys
- 2 dials
- Integrated LCD screen

### Corsair G-Keys

- Corsair keyboard G-key integration (Type ID: 4)

### Corsair Voyager

- Corsair Voyager laptop integration (Type ID: 6)

### SCUF Controller

- SCUF gaming controller integration (Type ID: 8)
