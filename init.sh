#!/usr/bin/env bash
set -e

# ─── Helpers ──────────────────────────────────────────────────────────────────

cyan='\033[0;36m'; green='\033[0;32m'; yellow='\033[0;33m'; red='\033[0;31m'; reset='\033[0m'

header()  { echo -e "\n  ${cyan}$1${reset}\n"; }
success() { echo -e "  ${green}$1${reset}"; }
warn()    { echo -e "  ${yellow}$1${reset}"; }
err()     { echo -e "\n  ${red}ERROR: $1${reset}"; echo -e "  ${yellow}$2${reset}"; exit 1; }

read_required() {
    local val=""
    while [ -z "$val" ]; do
        read -rp "  $1: " val
        val="${val#"${val%%[![:space:]]*}"}"
        val="${val%"${val##*[![:space:]]}"}"
    done
    echo "$val"
}

safe_name() {
    echo "$1" | tr -cs '[:alnum:]_-' '-' | sed 's/^-*//;s/-*$//'
}

replace_in_files() {
    local dir="$1"; shift
    while [ $# -ge 2 ]; do
        local from="$1" to="$2"; shift 2
        find "$dir" -not -path "*/node_modules/*" \
            -type f \( -name "*.json" -o -name "*.ts" -o -name "*.html" \
                     -o -name "*.mjs" -o -name "*.js" -o -name "*.md" -o -name "*.svg" \) \
            | xargs sed -i "s|${from}|${to}|g"
    done
}

device_suffix() {
    case "$1" in
        0) echo "SD" ;; 1) echo "Mini" ;; 2) echo "XL" ;;
        5) echo "Pedal" ;; 7) echo "Plus" ;; 8) echo "Neo" ;;
        *) echo "SD" ;;
    esac
}

device_name() {
    case "$1" in
        0) echo "Stream Deck / MK.2 (15 keys)" ;;
        1) echo "Stream Deck Mini (6 keys)" ;;
        2) echo "Stream Deck XL (32 keys)" ;;
        5) echo "Stream Deck Pedal" ;;
        7) echo "Stream Deck + (8 keys + 4 dials)" ;;
        8) echo "Stream Deck Neo (8 keys)" ;;
        *) echo "Stream Deck" ;;
    esac
}

# ─── Verificar prerequisitos ─────────────────────────────────────────────────

command -v node >/dev/null 2>&1 || \
    err "'node' no está instalado." "Instala Node.js 24+ desde: https://nodejs.org"

command -v npm >/dev/null 2>&1 || \
    err "'npm' no está instalado." "Instala Node.js (incluye npm) desde: https://nodejs.org"

node_version=$(node -v | grep -oE '[0-9]+' | head -1)
if [ "$node_version" -lt 24 ]; then
    err "Node.js $node_version detectado. Se requiere versión 24 o superior." \
        "Actualiza con: nvm install 24 && nvm use 24"
fi

# ─── Banner ───────────────────────────────────────────────────────────────────

clear
echo -e "${cyan}  ╔══════════════════════════════════════╗${reset}"
echo -e "${cyan}  ║   Stream Deck — Setup Wizard         ║${reset}"
echo -e "${cyan}  ╚══════════════════════════════════════╝${reset}"
echo ""
echo "  ¿Qué quieres crear? (números separados por coma)"
echo "    1) Plugin"
echo "    2) Profile"
echo "    3) Icon Pack"
echo ""
read -rp "  Selección: " selection

do_plugin=false; do_profile=false; do_icons=false
IFS=',' read -ra parts <<< "$selection"
for p in "${parts[@]}"; do
    p="${p// /}"
    case "$p" in
        1) do_plugin=true ;;
        2) do_profile=true ;;
        3) do_icons=true ;;
    esac
done

$do_plugin || $do_profile || $do_icons || \
    err "Selección no válida." "Ejecuta el script de nuevo y elige 1, 2, 3 o combinación."

if $do_plugin; then
    command -v streamdeck >/dev/null 2>&1 || \
        err "'streamdeck' CLI no está instalado." \
            "Instala con: npm install -g @elgato/cli@latest"
fi

# ─── Recoger datos ────────────────────────────────────────────────────────────

if $do_plugin; then
    header "Plugin — datos necesarios"
    plugin_author=$(read_required "Autor (nombre o empresa)")
    plugin_name=$(read_required "Nombre del plugin (ej. Wave Link)")
    plugin_uuid=$(read_required "UUID (ej. com.empresa.miplugin)")
    plugin_desc=$(read_required "Descripción breve")
fi

if $do_profile; then
    header "Profile — datos necesarios"
    profile_name=$(read_required "Nombre del profile (ej. OBS Streaming)")
    echo ""
    echo "  ¿Para qué dispositivos? (DeviceType, números separados por coma)"
    echo "    0) Stream Deck / MK.1 / MK.2   (15 keys, 5×3)"
    echo "    1) Stream Deck Mini             (6 keys, 3×2)"
    echo "    2) Stream Deck XL               (32 keys, 8×4)"
    echo "    5) Stream Deck Pedal"
    echo "    7) Stream Deck +                (8 keys + 4 dials)"
    echo "    8) Stream Deck Neo              (8 keys + info widgets)"
    echo ""
    read -rp "  Dispositivos: " dev_input

    # Parse and validate device types
    profile_devices=()
    IFS=',' read -ra dev_parts <<< "$dev_input"
    for d in "${dev_parts[@]}"; do
        d="${d// /}"
        case "$d" in
            0|1|2|5|7|8) profile_devices+=("$d") ;;
        esac
    done

    if [ ${#profile_devices[@]} -eq 0 ]; then
        warn "Ningún dispositivo válido. Usando Stream Deck estándar (0)."
        profile_devices=("0")
    fi
fi

if $do_icons; then
    header "Icon Pack — datos necesarios"
    icons_name=$(read_required "Nombre del pack")
    icons_author=$(read_required "Autor")
    icons_desc=$(read_required "Descripción breve")
fi

# ─── Aplicar scaffolds seleccionados ─────────────────────────────────────────

header "Configurando proyecto..."

if $do_plugin; then
    warn "[Plugin] Copiando scaffold..."
    old_uuid="com.yourcompany.yourplugin"

    find scaffold/plugin -maxdepth 1 -mindepth 1 | xargs -I{} mv {} .

    replace_in_files . \
        "$old_uuid"          "$plugin_uuid" \
        "PLUGIN_AUTHOR"      "$plugin_author" \
        "PLUGIN_NAME"        "$plugin_name" \
        "PLUGIN_DESCRIPTION" "$plugin_desc"

    [ -d "${old_uuid}.sdPlugin" ] && mv "${old_uuid}.sdPlugin" "${plugin_uuid}.sdPlugin"

    warn "[Plugin] Instalando dependencias..."
    npm install --silent

    warn "[Plugin] Compilando..."
    npm run build --silent

    warn "[Plugin] Validando manifest..."
    streamdeck validate "${plugin_uuid}.sdPlugin"

    success "[Plugin] Listo."
fi

if $do_profile; then
    warn "[Profile] Copiando scaffold..."

    safe_pname=$(safe_name "$profile_name")

    # Destination depends on whether plugin is also being created
    if $do_plugin; then
        profiles_dir="${plugin_uuid}.sdPlugin/profiles"
    else
        profiles_dir="profiles"
    fi
    mkdir -p "$profiles_dir"

    # Copy README
    cp "scaffold/profile/profiles/README.md" "$profiles_dir/README.md"

    # Create one .streamDeckProfile per selected device
    for dt in "${profile_devices[@]}"; do
        suffix=$(device_suffix "$dt")
        dname=$(device_name "$dt")
        out_file="${profiles_dir}/${safe_pname}-${suffix}.streamDeckProfile"

        cat > "$out_file" << PROFILEEOF
{
    "DeviceModel": 0,
    "DeviceUUID": "",
    "Name": "${profile_name} — ${dname}",
    "Pages": {
        "items": { "0": { "items": {} } },
        "current": "0"
    },
    "Version": "1.0"
}
PROFILEEOF
    done

    # If bundled with plugin: add Profiles[] to manifest.json
    if $do_plugin; then
        manifest="${plugin_uuid}.sdPlugin/manifest.json"
        profiles_json="["
        first=true
        for dt in "${profile_devices[@]}"; do
            suffix=$(device_suffix "$dt")
            [ "$first" = true ] || profiles_json+=","
            first=false
            profiles_json+="
        {
            \"Name\": \"profiles/${safe_pname}-${suffix}\",
            \"DeviceType\": ${dt},
            \"AutoInstall\": true,
            \"Readonly\": false,
            \"DontAutoSwitchWhenInstalled\": false
        }"
        done
        profiles_json+="
    ]"

        # Insert Profiles[] before closing brace of manifest
        sed -i "s|}$|,\n    \"Profiles\": ${profiles_json}\n}|" "$manifest"
    fi

    # If profile-only: move remaining scaffold files
    if ! $do_plugin; then
        find scaffold/profile -maxdepth 1 -mindepth 1 \( ! -name "profiles" \) | \
            xargs -I{} mv {} .
    fi

    success "[Profile] Listo — ${#profile_devices[@]} perfil(es) creado(s)."
fi

if $do_icons; then
    warn "[Icons] Copiando scaffold..."
    find scaffold/icons -maxdepth 1 -mindepth 1 | xargs -I{} mv {} .

    replace_in_files . \
        "ICONPACK_NAME"        "$icons_name" \
        "ICONPACK_AUTHOR"      "$icons_author" \
        "ICONPACK_DESCRIPTION" "$icons_desc"

    success "[Icons] Listo."
fi

# ─── Limpiar scaffold no usado y el propio init ───────────────────────────────

rm -rf scaffold init.ps1 init.sh

# ─── Resumen ─────────────────────────────────────────────────────────────────

echo ""
success "✓ Proyecto inicializado."
echo ""

if $do_plugin; then
    echo -e "  Plugin '${plugin_name}' (${plugin_uuid})"
    echo "    npm run watch      -> compilar y recargar en vivo"
    echo "    npm run lint       -> verificar estilo de código"
    echo "    npm run validate   -> validar manifest"
    echo "    npm run pack       -> empaquetar para distribución"
    echo "    npm run sync       -> propagar cambios de project.config.json"
    echo ""
fi
if $do_profile; then
    device_labels=$(printf '%s, ' "${profile_devices[@]/#/$(device_suffix )}" 2>/dev/null || echo "${profile_devices[*]}")
    echo -e "  Profiles '${profile_name}'"
    if $do_plugin; then
        echo "    Ubicación: ${plugin_uuid}.sdPlugin/profiles/"
    else
        echo "    Ubicación: profiles/"
    fi
    echo "    Ver profiles/README.md para el flujo de trabajo"
    echo ""
fi
if $do_icons; then
    echo -e "  Icon Pack '${icons_name}' — añade iconos 144×144 px en icons/"
    echo "    Ver icons/README.md para specs y cómo empaquetar"
    echo ""
fi
