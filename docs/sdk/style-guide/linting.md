# Linting

Source: https://docs.elgato.com/streamdeck/sdk/style-guide/linting/

## Quick Start

Install both linting tools:

```
npm install @elgato/eslint-config @elgato/prettier-config --save-dev
```

Update `package.json` with the lint script and Prettier config:

```json
{
  "scripts": {
    "lint": "eslint --max-warnings 0"
  },
  "prettier": "@elgato/prettier-config"
}
```

Create `eslint.config.js`:

```javascript
import { config } from "@elgato/eslint-config";
export default config.recommended;
```

Download the `.editorconfig` file from the Elgato ESLint config repository.

---

## ESLint Configuration

### Configuration Levels

Two configuration levels are available:

- `config.recommended` — standard enforcement
- `config.strict` — stricter type enforcement

### Base Extensions

- JSDoc recommended
- ESLint recommended
- TypeScript ESLint recommended

### Setup

```javascript
import { config } from "@elgato/eslint-config";
export default config.recommended;
```

### Key Rules

| Rule | Recommended | Strict | Notes |
|------|-------------|--------|-------|
| Indent: Tabs | Warn | Warn | — |
| JSDoc: Check tag names | Warn | Warn | Includes `csspart`, `cssproperty`, `jest-environment`, `slot` |
| JSDoc: No undefined types | Warn | Warn | — |
| JSDoc: Require JSDoc | Warn | Warn | — |
| JSDoc: Require Returns | Warn | Warn | Disabled for getters |
| TypeScript: Explicit function returns | Off | Warn | Excluded from JS/test files |
| TypeScript: Explicit member accessibility | Warn | Warn | No `public` on `constructor` |
| TypeScript: Member ordering | Warn | Warn | Grouped/alphabetical |
| TypeScript: Sort type constituents | Warn | Warn | — |

### Member Ordering

**Type order:** Fields → Constructors → Signatures → Properties → Methods

**Access order:** Public → Protected → Private

Each access level is further subdivided by: static → abstract → regular, then sorted alphabetically.

### Ignored Files (Default)

- `.github/`
- `bin/`
- `dist/`
- `node_modules/`

### Overriding Rules

```javascript
import { config } from "@elgato/eslint-config";
import { defineConfig } from "eslint/config";

export default defineConfig([
  {
    extends: [config.recommended],
    rules: {
      "no-unused-vars": "warn",
    },
  },
]);
```

---

## Prettier Configuration

### Installation

```
npm install @elgato/prettier-config --save-dev
```

### Setup in `package.json`

```json
{
  "prettier": "@elgato/prettier-config"
}
```

### CLI Usage

Check files for formatting issues:

```
prettier . --check
```

Format files in place:

```
prettier . --write
```

### Configuration Options

| Option | Value | Notes |
|--------|-------|-------|
| `endOfLine` | `lf` | — |
| `printWidth` | `120` | — |
| `singleQuote` | `false` | Prefer double quotes |
| `semi` | `true` | Prefer semicolons |
| `tabWidth` | `4` | 2 for `.yaml`/`.yml` files |
| `useTabs` | `true` | Except JSON, Markdown, and YAML |
| `trailingComma` | `all` | Except `.jsonc` |
| `multilineArraysWrapThreshold` | `-1` | Manual mode |
| `importOrder` | Third-party first | Via sort-imports plugin |
| `importOrderSeparation` | `true` | Via sort-imports plugin |
| `importOrderSortSpecifiers` | `true` | Via sort-imports plugin |
| `importOrderCaseInsensitive` | `true` | Via sort-imports plugin |
| `importOrderParserPlugins` | TypeScript | Via sort-imports plugin |

### Overriding Prettier Options

Create a `.prettierrc.js` file:

```javascript
module.exports = {
  ...require("@elgato/prettier-config"),
  tabWidth: 2,
  useTabs: false,
};
```

### VS Code Integration

Install the Prettier extension and enable `editor.formatOnSave` in your VS Code settings for automatic formatting on save.
