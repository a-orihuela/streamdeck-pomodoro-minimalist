---
mode: ask
---

Quiero añadir una nueva acción a mi plugin de Stream Deck.

Antes de proponer cualquier código, lee los siguientes archivos locales:
- `docs/sdk/guides/actions.md`
- `docs/sdk/guides/keys.md` (si el tipo es Key o ambos)
- `docs/sdk/guides/dials.md` (si el tipo es Dial/Encoder o ambos)
- `docs/sdk/guides/settings.md` (si necesita settings persistentes)
- `docs/sdk/guides/ui.md` (si tiene Property Inspector)
- `docs/sdk/references/manifest.md` (para el campo `Actions[]` del manifest)

Responde a estas preguntas antes de generar código:

1. ¿Cuál es el nombre de la acción? (ej. "Volume Control")
2. ¿Cuál es el UUID de la acción? (debe tener el prefijo del UUID del plugin, ej. `{plugin-uuid}.volume-control`)
3. ¿Qué tipo de controlador usa?
   - [ ] Key (botón físico)
   - [ ] Dial/Encoder (dial + touch strip del Stream Deck+)
   - [ ] Ambos
4. ¿Tiene Property Inspector (panel de configuración en la app)?
5. ¿Necesita settings persistentes (guardar estado entre sesiones)?
6. ¿Qué hace la acción cuando se activa?

Una vez respondidas, tu flujo debe ser:
1. Crear `src/actions/{nombre-kebab}.ts` con la clase de la acción
2. Registrar la acción en `src/plugin.ts`
3. Añadir la entrada en `*.sdPlugin/manifest.json` bajo `Actions[]`
4. Si tiene Property Inspector: crear `*.sdPlugin/ui/{nombre}.html`
5. Añadir los assets de icono en `*.sdPlugin/imgs/actions/{nombre}/`

No inventes campos del manifest — usa solo los documentados en `docs/sdk/references/manifest.md`.
