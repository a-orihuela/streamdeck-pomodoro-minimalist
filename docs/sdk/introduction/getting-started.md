# Getting Started

> Source: https://docs.elgato.com/streamdeck/sdk/introduction/getting-started/

---

## Installation

### Prerequisites

Developing Stream Deck plugins requires the following:

- **Node.js** version 24 or higher
- **Stream Deck** version 7.1 or higher
- A **Stream Deck device**
- A text editor (**VS Code** recommended)
- Terminal access for CLI work

> **Note:** If you do not own a Stream Deck device, you can try [Stream Deck Mobile](https://www.elgato.com/stream-deck-mobile) for free.

---

### Install Node.js

Node.js installation is best managed with a version manager:

- **macOS:** [nvm](https://github.com/nvm-sh/nvm)
- **Windows:** [nvm-windows](https://github.com/coreybutler/nvm-windows)

After installing your version manager, run the following commands to install and switch to Node.js 24:

```bash
nvm install 24
nvm use 24
node -v
```

---

### Install the Stream Deck CLI

Install the Stream Deck CLI globally using your preferred package manager:

**npm:**

```bash
npm install -g @elgato/cli
```

**yarn:**

```bash
yarn global add @elgato/cli
```

**pnpm:**

```bash
pnpm add -g @elgato/cli
```

#### Windows PowerShell: Execution Policy

Windows PowerShell users may need to configure execution policies before running CLI commands:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

## Creating a Plugin

### Setup Wizard

After installing the CLI, run the following command to launch the interactive plugin creation wizard:

```bash
streamdeck create
```

The wizard scaffolds a basic plugin project and prompts you for information such as your plugin's UUID.

### Plugin UUID

Plugin UUIDs must follow **reverse-DNS format** (e.g., `com.obsproject.obs-studio`) and may only contain:

- Lowercase alphanumeric characters
- Hyphens (`-`)
- Periods (`.`)

> **Important:** Once a plugin has been published to the marketplace, its UUID **cannot be changed**.

---

## Project Structure

After the wizard completes, your plugin directory will have the following structure:

```
.
├── *.sdPlugin/
│   ├── bin/
│   ├── imgs/
│   ├── logs/
│   ├── ui/
│   │   └── increment-counter.html
│   └── manifest.json
├── src/
│   ├── actions/
│   │   └── increment-counter.ts
│   └── plugin.ts
├── package.json
├── rollup.config.mjs
└── tsconfig.json
```

### Key Directories and Files

| Path | Description |
|---|---|
| `.sdPlugin/` | The **compiled plugin folder** — this is what Stream Deck loads. Contains build artifacts, images, logs, UI files, and `manifest.json`. |
| `.sdPlugin/manifest.json` | Defines plugin metadata (name, UUID, actions, etc.). |
| `.sdPlugin/ui/` | HTML files used for Property Inspectors (user-facing configuration UI). |
| `src/` | TypeScript source files. |
| `src/actions/` | Individual action implementations (e.g., `increment-counter.ts`). |
| `src/plugin.ts` | Main plugin entry point. |
| `package.json` | npm package configuration including build scripts. |
| `rollup.config.mjs` | Rollup bundler configuration. |
| `tsconfig.json` | TypeScript compiler configuration. |

---

## Running Your Plugin

### npm Scripts

The setup wizard pre-configures the following npm scripts in `package.json`:

```json
{
  "scripts": {
    "build": "rollup -c",
    "watch": "rollup -c -w --watch.onEnd=\"streamdeck restart {{YOUR_PLUGIN_UUID}}\""
  }
}
```

### Development Watch Mode

To start developing, run:

```bash
npm run watch
```

This command:

1. Compiles your TypeScript source files.
2. Watches for changes to `src/` files and `manifest.json`.
3. Automatically recompiles and hot-reloads your plugin in Stream Deck when changes are detected.

Press `Ctrl + C` to stop watching.

> **Tip:** If your plugin does not appear in Stream Deck, this may be due to the app running with elevated privileges. This occurs after a fresh install or update of the Stream Deck app. Restarting the app should resolve the issue.

---

## What's Next?

After setting up your first plugin, explore the following topics:

- **Your First Changes** — Make your first modifications to the plugin.
- **Actions** — Learn about defining and handling actions.
- **Property Inspectors** — Add user-facing configuration UI for your actions.
- **CLI Commands** — Explore additional `streamdeck` CLI commands for managing and deploying plugins.
