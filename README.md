# streamdeck-dev-template

Plantilla para desarrollar plugins, profiles e icon packs de Stream Deck con GitHub Copilot.

El template incluye la **documentación oficial de Elgato completa** (extraída de docs.elgato.com) y scaffolds listos para los tres tipos de proyecto. El script `init` pregunta qué quieres crear, lo personaliza con tus datos y elimina todo lo que no necesitas.

## Uso

```powershell
# Windows
.\init.ps1
```

```bash
# macOS / Linux
chmod +x init.sh && ./init.sh
```

El wizard pregunta qué quieres crear (puedes elegir varios):

```
  ¿Qué quieres crear? (escribe los números separados por coma)
    1) Plugin
    2) Profile
    3) Icon Pack
```

Tras responder las preguntas para cada tipo seleccionado, el script:
1. Copia el scaffold correspondiente al root del proyecto
2. Reemplaza los placeholders con tus datos
3. Elimina los scaffolds no usados y el propio `init`
4. Ejecuta `npm install` si incluye un plugin

## Flujo de trabajo por tipo

### Plugin

```bash
npm run watch                          # compilar y recargar en vivo
streamdeck validate {uuid}.sdPlugin    # validar manifest
streamdeck pack                        # empaquetar para distribución
```

### Profile

Edita el archivo `.streamDeckProfile` con la app de Stream Deck (importa, edita, exporta).

### Icon Pack

Añade iconos (144×144 px) a `icons/` y usa [Icon Pack Man](https://iconpackman.elgato.com/) para generar el `.streamDeckIconPack`.

## Estructura del template (antes de init)

```
streamdeck-dev-template/
├── scaffold/
│   ├── plugin/                  ← plugin scaffold (TypeScript + manifest + assets)
│   ├── profile/                 ← profile scaffold (.streamDeckProfile)
│   └── icons/                   ← icon pack scaffold (manifest.json, icons.json, icons/)
├── docs/                        ← documentación local de Elgato
│   ├── sdk/                     ← introduction, guides, references, cli, style-guide
│   ├── profiles.md
│   └── icons.md
├── .github/
│   ├── copilot-instructions.md  ← contexto y reglas para Copilot
│   └── prompts/
│       ├── create-plugin.prompt.md
│       ├── create-profile.prompt.md
│       └── create-icons.prompt.md
├── init.ps1 / init.sh           ← wizard de configuración (se auto-elimina al ejecutar)
├── .gitignore
└── README.md
```

## Copilot: prompts disponibles

| Tarea | Prompt |
|---|---|
| Añadir una nueva acción al plugin | `.github/prompts/create-plugin.prompt.md` |
| Crear un profile | `.github/prompts/create-profile.prompt.md` |
| Crear iconos | `.github/prompts/create-icons.prompt.md` |

## Requisitos

- Node.js 24+ (solo para plugins)
- Stream Deck 7.1+ (solo para plugins)
- Stream Deck CLI: `npm install -g @elgato/cli@latest` (solo para plugins)
