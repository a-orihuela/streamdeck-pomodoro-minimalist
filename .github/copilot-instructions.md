# Stream Deck + GitHub Copilot (plantilla base)

Este repositorio está preparado para usar GitHub Copilot como asistente principal para crear:

- Plugins (`.sdPlugin`) para Stream Deck
- Profiles de Stream Deck
- Iconos para acciones y perfiles

## Fuente de verdad (obligatoria)

La documentación oficial de Elgato ha sido extraída y guardada localmente en `docs/`. **Priorizar siempre los archivos locales** — contienen el contenido completo de cada página. Las URLs remotas son la referencia canónica si hay duda.

### SDK (plugins) — docs locales

#### Introduction
| Submenú | Archivo local | URL remota |
|---|---|---|
| getting-started | [docs/sdk/introduction/getting-started.md](../docs/sdk/introduction/getting-started.md) | https://docs.elgato.com/streamdeck/sdk/introduction/getting-started/ |
| plugin-environment | [docs/sdk/introduction/plugin-environment.md](../docs/sdk/introduction/plugin-environment.md) | https://docs.elgato.com/streamdeck/sdk/introduction/plugin-environment/ |
| your-first-changes | [docs/sdk/introduction/your-first-changes.md](../docs/sdk/introduction/your-first-changes.md) | https://docs.elgato.com/streamdeck/sdk/introduction/your-first-changes/ |
| distribution | [docs/sdk/introduction/distribution.md](../docs/sdk/introduction/distribution.md) | https://docs.elgato.com/streamdeck/sdk/introduction/distribution/ |

#### Guides
| Submenú | Archivo local | URL remota |
|---|---|---|
| actions | [docs/sdk/guides/actions.md](../docs/sdk/guides/actions.md) | https://docs.elgato.com/streamdeck/sdk/guides/actions/ |
| app-monitoring | [docs/sdk/guides/app-monitoring.md](../docs/sdk/guides/app-monitoring.md) | https://docs.elgato.com/streamdeck/sdk/guides/app-monitoring/ |
| deep-linking | [docs/sdk/guides/deep-linking.md](../docs/sdk/guides/deep-linking.md) | https://docs.elgato.com/streamdeck/sdk/guides/deep-linking/ |
| devices | [docs/sdk/guides/devices.md](../docs/sdk/guides/devices.md) | https://docs.elgato.com/streamdeck/sdk/guides/devices/ |
| dials | [docs/sdk/guides/dials.md](../docs/sdk/guides/dials.md) | https://docs.elgato.com/streamdeck/sdk/guides/dials/ |
| i18n | [docs/sdk/guides/i18n.md](../docs/sdk/guides/i18n.md) | https://docs.elgato.com/streamdeck/sdk/guides/i18n/ |
| keys | [docs/sdk/guides/keys.md](../docs/sdk/guides/keys.md) | https://docs.elgato.com/streamdeck/sdk/guides/keys/ |
| logging | [docs/sdk/guides/logging.md](../docs/sdk/guides/logging.md) | https://docs.elgato.com/streamdeck/sdk/guides/logging/ |
| profiles | [docs/sdk/guides/profiles.md](../docs/sdk/guides/profiles.md) | https://docs.elgato.com/streamdeck/sdk/guides/profiles/ |
| resources | [docs/sdk/guides/resources.md](../docs/sdk/guides/resources.md) | https://docs.elgato.com/streamdeck/sdk/guides/resources/ |
| settings | [docs/sdk/guides/settings.md](../docs/sdk/guides/settings.md) | https://docs.elgato.com/streamdeck/sdk/guides/settings/ |
| system | [docs/sdk/guides/system.md](../docs/sdk/guides/system.md) | https://docs.elgato.com/streamdeck/sdk/guides/system/ |
| ui | [docs/sdk/guides/ui.md](../docs/sdk/guides/ui.md) | https://docs.elgato.com/streamdeck/sdk/guides/ui/ |

#### References
| Submenú | Archivo local | URL remota |
|---|---|---|
| manifest | [docs/sdk/references/manifest.md](../docs/sdk/references/manifest.md) | https://docs.elgato.com/streamdeck/sdk/references/manifest/ |
| touch-strip-layout | [docs/sdk/references/touch-strip-layout.md](../docs/sdk/references/touch-strip-layout.md) | https://docs.elgato.com/streamdeck/sdk/references/touch-strip-layout/ |
| websocket/plugin | [docs/sdk/references/websocket-plugin.md](../docs/sdk/references/websocket-plugin.md) | https://docs.elgato.com/streamdeck/sdk/references/websocket/plugin/ |
| websocket/ui | [docs/sdk/references/websocket-ui.md](../docs/sdk/references/websocket-ui.md) | https://docs.elgato.com/streamdeck/sdk/references/websocket/ui/ |
| changelog | [docs/sdk/references/changelog.md](../docs/sdk/references/changelog.md) | https://docs.elgato.com/streamdeck/sdk/references/changelog/ |

#### Style Guide
| Submenú | Archivo local | URL remota |
|---|---|---|
| linting | [docs/sdk/style-guide/linting.md](../docs/sdk/style-guide/linting.md) | https://docs.elgato.com/streamdeck/sdk/style-guide/linting/ |

#### CLI
| Archivo local | URL remota |
|---|---|
| [docs/sdk/cli.md](../docs/sdk/cli.md) | https://docs.elgato.com/streamdeck/sdk/cli/intro/ |

Contiene todos los comandos: `config`, `create`, `dev`, `link`, `unlink`, `list`, `pack`, `validate`, `restart`, `stop`.

#### Releases
| Submenú | Archivo local | URL remota |
|---|---|---|
| upgrading/v2 | [docs/sdk/upgrading-v2.md](../docs/sdk/upgrading-v2.md) | https://docs.elgato.com/streamdeck/sdk/releases/upgrading/v2/ |

### Profiles — docs locales

| Archivo local | URL remota |
|---|---|
| [docs/profiles.md](../docs/profiles.md) | https://docs.elgato.com/stream-deck/profiles/getting-started/ |

### Icons — docs locales

| Archivo local | URL remota |
|---|---|
| [docs/icons.md](../docs/icons.md) | https://docs.elgato.com/stream-deck/icons/getting-started/ |

Si hay conflicto entre ejemplos externos y la documentación de Elgato, prevalece Elgato.

## Estructura del proyecto tras ejecutar `init`

El script `init` genera **solo lo necesario** según lo que hayas elegido crear. Ejemplos:

**Solo plugin (`1`):**
```
{repo}/
├── {uuid}.sdPlugin/          ← Stream Deck carga esta carpeta
│   ├── imgs/                 ← iconos PNG
│   ├── ui/                   ← HTML del Property Inspector
│   └── manifest.json
├── src/
│   ├── actions/increment-counter.ts
│   └── plugin.ts
├── docs/
├── .github/
├── package.json              ← scripts: build, watch, lint
├── rollup.config.mjs
├── tsconfig.json
└── eslint.config.js
```

**Solo profile (`2`):**
```
{repo}/
├── profiles/
│   └── {nombre}.streamDeckProfile
├── docs/
└── .github/
```

**Solo icon pack (`3`):**
```
{repo}/
├── icons/                    ← tus archivos SVG/PNG/GIF/WEBP (144×144 px)
├── manifest.json             ← metadatos del pack
├── icons.json                ← nombre y tags de cada icono
├── icon.svg                  ← thumbnail del pack (56×56 px)
├── docs/
└── .github/
```

### Cómo añadir una nueva acción al plugin

1. Crear `src/actions/{nombre}.ts` — clase que extiende `SingletonAction`
2. Decorar con `@action({ UUID: "{plugin-uuid}.{nombre}" })`
3. Registrar en `src/plugin.ts`: `streamDeck.actions.registerAction(new MiAccion())`
4. Añadir entrada en `{uuid}.sdPlugin/manifest.json` bajo `Actions[]`
5. Añadir assets en `{uuid}.sdPlugin/imgs/actions/{nombre}/`

## Proceso obligatorio para tareas de Copilot

1. Identificar si la petición es de **plugin**, **profile** o **iconos** (puede ser mixta).
2. Leer primero el archivo local correspondiente de `docs/` antes de proponer código.
3. Enumerar en la respuesta inicial el archivo(s) de `docs/` que aplica antes de proponer cambios.
4. Para **Profiles** e **Icons**, leer `docs/profiles.md` y `docs/icons.md` completos.
5. Proponer estructura de archivos mínima y ejemplos listos para ejecutar.
6. Validar siempre manifest, rutas de assets, tamaños de iconos y empaquetado.

## Convenciones para esta plantilla

- Mantener cambios mínimos y enfocados.
- No inventar campos del `manifest.json`; usar solo lo documentado en [docs/sdk/references/manifest.md](../docs/sdk/references/manifest.md).
- En iconos, respetar tamaños y formato exigidos en [docs/icons.md](../docs/icons.md) — siempre 144×144 px.
- En profiles, documentar claramente contexto, páginas y acciones siguiendo [docs/profiles.md](../docs/profiles.md).
- Incluir pasos de build/test solo si existen en el repositorio.
- Los UUIDs de acción deben tener siempre el prefijo del UUID del plugin.
