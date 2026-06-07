# Logging

Logging is a useful way to track the flow of functionality, and can assist with diagnosing bugs within your plugin.

The Stream Deck SDK provides logging support for both runtime consoles and file system output.

## Writing Logs

### Basic Usage

Logs are created using a `Logger` instance from the `streamDeck` import:

```typescript
import streamDeck from "@elgato/streamdeck";

streamDeck.logger.info("Hello world");

streamDeck.connect();
```

> **Tip:** Using `streamDeck.logger` ensures your plugin's logs are written to all available targets, for example the log file.

## Reading Logs

### Log Targets by Environment

Logs output to different targets based on source and environment:

| Source                    | Environment | Targets                                  |
|---------------------------|-------------|------------------------------------------|
| Plugin                    | Development | File, Console (Plugin)                   |
| Property Inspector (UI)   | Development | File, Console (Plugin), Console (UI)     |
| Plugin                    | Production  | File                                     |
| Property Inspector (UI)   | Production  | File, Console (UI)                       |

### Log Files

Plugin logs are stored in the `logs` directory within the plugin bundle:

```
com.elgato.hello-world.sdPlugin/logs/com.elgato.hello-world.0.log
```

**Log entry format:**

```
<iso_date> <log_level> [[scope]: ]<message>
```

**Example log entry:**

```
2024-05-05T12:35:13.000Z INFO  Hello world
```

**File Rotation:** Your plugin's 10 most recent log files are available, with `0` being the most recent. Log files never exceed 10 MiB.

New log files are created when:

- The plugin starts
- The current log file exceeds 10 MiB

> **Warning:** Uninstalling a plugin will also remove its associated log files.

### Console Output

During development, logs mirror to:

- Node.js terminal (plugin debugging)
- Browser console (property inspector debugging)

**Logger method to console method mapping:**

```typescript
import streamDeck from "@elgato/streamdeck";

// console.error(...)
streamDeck.logger.error("Failures or exceptions");

// console.warn(...)
streamDeck.logger.warn("Recoverable errors");

// console.log(...)
streamDeck.logger.info("Hello world");
streamDeck.logger.debug("Debugging information");
streamDeck.logger.trace("Detailed messages");

streamDeck.connect();
```

## Log Levels

The SDK provides five log level methods:

```typescript
import streamDeck from "@elgato/streamdeck";

streamDeck.logger.error("Failures or exceptions");
streamDeck.logger.warn("Recoverable errors");
streamDeck.logger.info("Hello world");
streamDeck.logger.debug("Debugging information");
streamDeck.logger.trace("Detailed messages");

streamDeck.connect();
```

### Log Level Reference

| Level       | Value             | Description                                                                                      |
|-------------|-------------------|--------------------------------------------------------------------------------------------------|
| Error       | `LogLevel.ERROR`  | Requires immediate attention; module failure, unexpected behavior, data loss/corruption          |
| Warning     | `LogLevel.WARN`   | Abnormal but recoverable state; value resort to fallback                                         |
| Information | `LogLevel.INFO`   | General information                                                                              |
| Debug       | `LogLevel.DEBUG`  | Debugging and development entries; variable values                                               |
| Trace       | `LogLevel.TRACE`  | Detailed execution flow; network traffic, IPC communication (may contain sensitive data)         |

### Setting the Log Level

Use `setLevel` to control which messages are emitted. Messages below the configured level produce no output.

```typescript
import streamDeck from "@elgato/streamdeck";

streamDeck.logger.setLevel("warn");

streamDeck.logger.error("Failures or exceptions");
streamDeck.logger.warn("Recoverable errors");
streamDeck.logger.info("Hello world");   // No output.
streamDeck.logger.debug("Debugging information"); // No output.
streamDeck.logger.trace("Detailed messages");     // No output.

streamDeck.connect();
```

**Default levels:**

| Environment | Default Level | Minimum Configurable Level |
|-------------|---------------|---------------------------|
| Development | `DEBUG`       | —                         |
| Production  | `INFO`        | `DEBUG`                   |

## Creating Loggers (Scopes)

Child loggers, called "scopes", identify the source of log messages as breadcrumbs in the output. Create a scoped logger with `createScope`:

```typescript
import streamDeck from "@elgato/streamdeck";

const scopedLogger = streamDeck.logger.createScope("Main");
scopedLogger.info("Hello world");

streamDeck.connect();
```

**Output:**

```
2024-05-05T12:35:13.000Z INFO  Main: Hello world
```

### Nested Scopes

Scopes can be nested by calling `createScope` on an existing scoped logger. The scope names are joined with `->` in the output:

```typescript
import streamDeck from "@elgato/streamdeck";

const scopedLogger = streamDeck.logger.createScope("Main");
scopedLogger.info("Hello world");

const nestedLogger = scopedLogger.createScope("Nested");
nestedLogger.info("Test");

streamDeck.connect();
```

**Output:**

```
2024-05-05T12:35:13.000Z INFO  Main: Hello world
2024-05-05T12:35:13.000Z INFO  Main->Nested: Test
```

## Stream Deck Application Logs

The Stream Deck application itself writes diagnostic logs to the following locations:

- **Windows:** `%appdata%\Elgato\StreamDeck\logs\`
- **macOS:** `~/Library/Logs/ElgatoStreamDeck/`

The most recent log file is named `StreamDeck0.log`.
