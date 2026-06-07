# Profiles

Profile para **PROFILE_DEVICE** — distribuido como `.streamDeckProfile`.

> Documentación completa: `docs/profiles.md`

## Flujo de trabajo recomendado

Los profiles no se editan directamente en el JSON — se trabajan desde la app de Stream Deck y se versionan aquí.

```
1. Importar   → doble clic en el .streamDeckProfile (lo instala en Stream Deck)
2. Editar     → abre Stream Deck app → ajusta teclas, acciones y páginas visualmente
3. Exportar   → clic derecho en el profile → Exportar → sobreescribe el .streamDeckProfile de esta carpeta
4. Versionar  → git add profiles/ && git commit
```

## Especificaciones de dispositivos

| Dispositivo | Keys | Dials | Notas |
|---|---|---|---|
| Stream Deck Mini | 6 (2×3) | — | |
| Stream Deck Neo | 8 (4×2) | — | + 2 widgets de información |
| Stream Deck | 15 (5×3) | — | |
| Stream Deck + | 8 (4×2) | 4 | + touch strip |
| Stream Deck XL | 32 (8×4) | — | |

## Notas importantes

- Los profiles **NO escalan** entre dispositivos — crea uno por dispositivo objetivo.
- Los plugins externos que uses **no se incluyen** en el profile; el usuario debe instalarlos por separado.
- Para distribuir: publica el `.streamDeckProfile` en el Elgato Marketplace.
