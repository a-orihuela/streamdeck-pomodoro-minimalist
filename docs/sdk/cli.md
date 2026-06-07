# Stream Deck CLI

Stream Deck CLI is a command-line interface tool for building, managing, and packaging Stream Deck plugins, and is the quickest way to get up-and-running when developing for Stream Deck.

**Alias:** Use `sd` as shorthand for `streamdeck` (e.g., `sd create`).

Source: [https://docs.elgato.com/streamdeck/cli/intro](https://docs.elgato.com/streamdeck/cli/intro)

---

## Introduction

### Prerequisites

- Node.js version 24 or higher
- Stream Deck version 7.1 or higher
- A Stream Deck device (or Stream Deck Mobile as a free alternative)

### Installing Node.js

Using a Node version manager is recommended.

**macOS / Windows (nvm):**
```
nvm install 24
nvm use 24
node -v
```

### Installation

```
npm install -g @elgato/cli@latest
```

Or with other package managers:
```
yarn global add @elgato/cli
pnpm add -g @elgato/cli
```

### PowerShell on Windows

Node.js CLIs include a local `.ps1` PowerShell script that requires an execution policy to run. Set the policy with:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Verification

```
streamdeck -v
```

### Command Overview

| Command | Description |
|---------|-------------|
| `create` | Plugin creation wizard |
| `link [path]` | Link plugin to Stream Deck |
| `restart\|r <uuid>` | Start or restart a plugin |
| `stop\|s <uuid>` | Stop a plugin |
| `dev [options]` | Enable or disable developer mode |
| `validate [options] [path]` | Validate a plugin |
| `pack\|bundle [options] [path]` | Create a `.streamDeckPlugin` file |
| `config` | Manage local CLI configuration |
| `list [options]` | List installed plugins |
| `unlink [options] <uuid>` | Unlink a plugin from Stream Deck |

---

## create

The `streamdeck create` command is a Stream Deck plugin creation wizard that scaffolds a new plugin through an interactive setup process.

### Synopsis

```
streamdeck create
```

### Description

This command guides developers through plugin creation by prompting for essential information:

- **Author** – The plugin developer's name
- **Plugin Name** – The plugin's title
- **Plugin UUID** – A unique identifier for the plugin
- **Description** – A brief explanation of plugin functionality

Upon completion, the newly created plugin is automatically installed in Stream Deck and is ready for development.

### Workflow Steps

The command performs the following operations in sequence:

1. Enables developer mode
2. Generates plugin scaffolding
3. Installs dependencies
4. Builds the plugin
5. Finalizes setup
6. Optionally opens the project in VS Code

### Example

```
streamdeck create
```

Sample interactive session:

```
Author: Elgato
Plugin Name: Counter
Plugin UUID: com.elgato.counter
Description: A simple counter that increments on each press
```

The plugin directory is created as a subdirectory in the current working location using the plugin name (e.g., `counter/`).

---

## config

The `streamdeck config` command manages local CLI configuration files that control command output, execution behavior, and interaction customization.

### Synopsis

```
streamdeck config set <key>=<value> [<key>=<value>...]
streamdeck config unset <key> [<key>...]
streamdeck config list
streamdeck config reset
```

### Sub-commands

#### set

Assigns the specified configuration key(s) to the provided value(s).

```
streamdeck config set packageManager=yarn
streamdeck config set reduceMotion=true
```

#### unset

Restores the specified configuration key(s) to their default values.

```
streamdeck config unset packageManager
```

#### list

Displays all currently defined configuration settings.

```
streamdeck config list
```

#### reset

Restores all configuration keys to factory defaults.

```
streamdeck config reset
```

### Configuration Options

#### `reduceMotion`

| Property | Value |
|----------|-------|
| Default | `false` |
| Type | Boolean |

Determines whether feedback provided should prefer reduced motion. When `true`, the busy indicator will be rendered as a static indicator.

#### `packageManager`

| Property | Value |
|----------|-------|
| Default | `npm` |
| Type | Enumerated: `bun`, `npm`, `pnpm`, `yarn` |

Specifies which package manager to use when creating new projects.

---

## dev

The `streamdeck dev` command controls developer mode for Stream Deck plugin development.

### Synopsis

```
streamdeck dev [-d|--disable]
```

### Description

Developer mode facilitates local Stream Deck plugin development and provides additional capabilities for building and debugging. When enabled, developers can:

- Attach debuggers (e.g., VS Code) to Node.js plugins
- Debug the property inspector locally at `http://localhost:23654/`

### Options

#### `--disable` / `-d`

| Property | Value |
|----------|-------|
| Default | `false` |
| Type | Boolean |

Disables developer mode when specified.

### Examples

**Enable developer mode:**
```
streamdeck dev
```

**Disable developer mode:**
```
streamdeck dev --disable
```

---

## link

The `streamdeck link` command installs a plugin to Stream Deck, making it accessible within the application.

### Synopsis

```
streamdeck link [path]
```

### Arguments

- **path** (optional) – Path to the `.sdPlugin` directory to link. Defaults to the current working directory.

### Description

This command links a specified directory to Stream Deck, effectively installing the plugin for development. If no path is provided, the current working directory is used as the target.

#### Directory Naming Requirements

The directory must follow a specific naming convention: it must be named after your plugin's UUID with the `.sdPlugin` suffix. For example, a plugin identified as `com.elgato.hello-world` requires a directory named `com.elgato.hello-world.sdPlugin/`.

### Examples

**Install from current location:**
```
streamdeck link
```

**Install from a specific directory:**
```
streamdeck link com.elgato.hello-world.sdPlugin
```

---

## unlink

The `streamdeck unlink` command removes a linked (developer) plugin from Stream Deck, effectively uninstalling it while preserving the plugin's source directory.

> Available since version 1.5.0.

### Synopsis

```
streamdeck unlink [options] <uuid>
```

### Arguments

- **uuid** – The identifier of the plugin to unlink.

### Options

#### `--delete` / `-d`

| Property | Value |
|----------|-------|
| Default | `false` |
| Type | Boolean |

Enables the removal of plugins that are not linked plugins (i.e., those installed regularly). When this flag is active and the target is a regularly installed plugin rather than a linked one, the plugin is deleted from the system.

### Example

```
streamdeck unlink com.elgato.hello-world
```

---

## list

The `streamdeck list` command displays a catalog of installed plugins along with their source locations.

> Available since version 1.5.0.

### Synopsis

```
streamdeck list [options]
```

**Alias:** `streamdeck -l`

### Options

#### `--all` / `-a`

| Property | Value |
|----------|-------|
| Default | `false` |
| Type | Boolean |

When `true`, all installed plugins are shown (not just linked/developer plugins).

### Examples

**Display linked plugins only:**
```
streamdeck list
```

or:
```
streamdeck -l
```

**Display all installed plugins:**
```
streamdeck list --all
```

---

## pack

The `streamdeck pack` command packages a Stream Deck plugin into a distributable `.streamDeckPlugin` installer file.

**Alias:** `bundle`

### Synopsis

```
streamdeck pack [options] [path]
```

### Arguments

- **path** (optional) – Path of the plugin directory to pack. Defaults to the current working directory.

### Description

This command creates a distributable installer that allows plugins to be shared. Plugins must pass validation before packaging.

**Default exclusions** (automatically excluded from the package):
- `.git`
- `/.env*`
- `*.log`
- `*.js.map`

Users can customize exclusions using a `.sdignore` file, which follows `.gitignore` specification syntax.

### Options

#### `--dry-run`

| Property | Value |
|----------|-------|
| Default | `false` |
| Type | Boolean |

Generates a packaging report without actually creating the `.streamDeckPlugin` file.

#### `--force` / `-f`

| Property | Value |
|----------|-------|
| Default | `false` |
| Type | Boolean |

Forces saving, overwriting the package file if it already exists.

#### `--output` / `-o`

| Property | Value |
|----------|-------|
| Default | Current working directory |
| Type | String (path) |

Specifies the path for the output directory where the `.streamDeckPlugin` file will be saved.

#### `--version`

| Property | Value |
|----------|-------|
| Default | `undefined` |
| Type | String (semver) |

Plugin version; the specified value will be written to the manifest before packaging.

#### `--force-update-check`

| Property | Value |
|----------|-------|
| Default | `false` |
| Type | Boolean |

Forces an immediate check for updated validation rules. Cannot be combined with `--no-update-check`.

#### `--no-update-check`

| Property | Value |
|----------|-------|
| Default | `false` |
| Type | Boolean |

Disables automatic updating of validation schemas. Recommended for CI/CD pipelines. Cannot be combined with `--force-update-check`.

### Examples

**Package plugin to a dist folder:**
```
streamdeck pack com.elgato.test.sdPlugin/ --output dist/
```

**Package with a version update:**
```
streamdeck pack --version "0.8.2.12"
```

**Generate a packaging report without creating the file:**
```
streamdeck pack --dry-run
```

---

## validate

The `streamdeck validate` command checks a Stream Deck plugin for compliance with validation rules.

### Synopsis

```
streamdeck validate [options] [path]
```

### Arguments

- **path** (optional) – Directory location of the plugin to validate. Defaults to the current working directory.

### Description

Validates the Stream Deck plugin in the current working directory, or `path` when specified, and outputs the validation results. The tool automatically checks for updated validation schemas once per day unless configured otherwise.

### Options

#### `--force-update-check`

| Property | Value |
|----------|-------|
| Default | `false` |
| Type | Boolean |

Forces an immediate check for the newest validation rules. Typically the update check occurs once per day automatically. Cannot be combined with `--no-update-check`.

#### `--no-update-check`

| Property | Value |
|----------|-------|
| Default | `false` |
| Type | Boolean |

Skips automatic validation schema updates. Particularly useful in continuous integration pipelines. Cannot be combined with `--force-update-check`.

### Examples

**Validate a specific plugin directory:**
```
streamdeck validate com.elgato.hello-world.sdPlugin
```

**Validate current directory with the latest schemas:**
```
streamdeck validate --force-update-check
```

---

## restart

The `streamdeck restart` command restarts a Stream Deck plugin.

**Alias:** `r`

### Synopsis

```
streamdeck restart <uuid>
```

### Arguments

- **uuid** – The UUID of the plugin to restart.

### Description

Instructs Stream Deck to restart (stop and then start) the plugin identified by its UUID. If the plugin is not already running, the system will launch it.

When a plugin restarts, all associated resources reload, including the manifest JSON file.

### Example

```
streamdeck restart com.elgato.hello-world
```

---

## stop

The `streamdeck stop` command halts a Stream Deck plugin's execution and unloads its resources.

**Alias:** `s`

### Synopsis

```
streamdeck stop <uuid>
```

### Arguments

- **uuid** – The UUID of the plugin to stop.

### Description

Instructs Stream Deck to stop the plugin identified by its UUID. When stopped, the plugin and all of its resources are unloaded from Stream Deck, allowing the plugin to be modified.

### Example

```
streamdeck stop com.elgato.hello-world
```
