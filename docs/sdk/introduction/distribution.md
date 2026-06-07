# Distribution

Stream Deck plugins are packaged as `.streamDeckPlugin` files through the Stream Deck CLI. These packages contain all necessary components for Marketplace distribution or direct user delivery.

The publication workflow follows these stages:

**Create → Pack → Upload to Maker Console → Review → Publish to Marketplace**

> Plugins are DRM protected after they have been uploaded to Maker Console.

---

## DRM Protection

Digital Rights Management offers several advantages:

- **File Encryption** — prevents unauthorized execution without consent
- **Integrity Checking** — protects users from tampered files with built-in verification
- **New SDK Features** — unlocks additional Stream Deck SDK capabilities

Stream Deck CLI 1.6+ enables DRM by default. Check your version with:

```
streamdeck -v
```

Update to the latest CLI via:

```
npm install -g @elgato/cli@latest
```

### Compatibility & Readiness Prerequisites

**Node.js SDK Requirements:**
- Must use `@elgato/streamdeck` v2 or higher

**File Integrity:**
- Generate required files at runtime
- Do not modify distributed files after packaging

**Manifest:**
- Store non-sensitive information in separate JSON files or embed in codebase
- Cannot access manifest JSON at runtime

DRM protection applies across all Stream Deck SDK libraries (C#, C++, Go, etc.).

### Enabling DRM

1. Update `@elgato/streamdeck` to v2+ (Node.js only)
2. Modify the manifest:
   - Set `UUID` to your plugin identifier (e.g., `com.elgato.wave-link`)
   - Update `SDKVersion` to `3`
   - Update `Software.MinimumVersion` to `"6.9"` or higher

### Testing DRM-Protected Versions

You can access a pre-publication DRM-protected version of your plugin before it goes live:

1. Log into [Maker Console](https://maker.elgato.com)
2. Upload plugin without "Publish after review" selected
3. Navigate to your product page and open the **Versions** tab
4. Select the new version
5. Download the DRM-protected version

---

## Packaging

Use the Stream Deck CLI `pack` command to create `.streamDeckPlugin` installer files:

```
streamdeck pack com.elgato.hello-world.sdPlugin
```

The `pack` command:

1. Validates the plugin and supporting files
2. Bundles the `*.sdPlugin` directory contents
3. Outputs a `.streamDeckPlugin` installer file

### Excluding Files

Create `.sdignore` files using the `.gitignore` specification to exclude files during packaging.

---

## Publishing

### Marketplace Publication Steps

1. Review the [plugin guidelines](https://docs.elgato.com/guidelines/stream-deck/plugins) for compliance
2. Create an eye-catching app icon
3. Develop gallery items showcasing your plugin's functionality
4. Submit via [Maker Console](https://maker.elgato.com)

> Returning makers unable to locate existing plugins should contact maker relations at [maker@elgato.com](mailto:maker@elgato.com).

---

*Source: https://docs.elgato.com/streamdeck/sdk/introduction/distribution/*
