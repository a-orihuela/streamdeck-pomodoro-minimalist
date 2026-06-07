---
mode: ask
---

Quiero crear iconos para Stream Deck.

Antes de proponer cualquier diseño o estructura, lee: `docs/icons.md`

Responde a estas preguntas antes de generar los iconos:

1. ¿Qué tipo de icono necesitas?
   - [ ] Icono de acción (key image) — aparece en el botón del Stream Deck
   - [ ] Icono de plugin (marketplace icon) — aparece en la lista de plugins
   - [ ] Icono de categoría (category icon) — agrupa acciones en la lista
2. ¿Estático o animado?
   - Estático: SVG, PNG o JPEG — 144×144 px
   - Animado: GIF o WEBP — 144×144 px, 10-20 fps, máx 5 seg, máx 1 MB
3. ¿Cuántos estados tiene el icono? (ej. activo/inactivo)
4. ¿Necesita variante @2x (alta resolución)?

Requisitos obligatorios de `docs/icons.md`:
- Tamaño exacto: **144×144 píxeles** (Stream Deck escala automáticamente)
- Nombre de archivo: máximo 80 caracteres
- Formato de ruta en manifest: sin extensión (ej. `"imgs/actions/counter/key"`)
- Las rutas en `manifest.json` deben ser relativas a la carpeta `.sdPlugin`

Rutas estándar de assets:
- Key image: `imgs/actions/{nombre-accion}/key.png` + `key@2x.png`
- Action list icon: `imgs/actions/{nombre-accion}/icon.png` + `icon@2x.png`
- Plugin marketplace icon: `imgs/plugin/marketplace.png` + `marketplace@2x.png`
- Category icon: `imgs/plugin/category-icon.png` + `category-icon@2x.png`
