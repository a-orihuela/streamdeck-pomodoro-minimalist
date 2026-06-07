#!/usr/bin/env pwsh
$ErrorActionPreference = "Stop"

# --- Helpers ------------------------------------------------------------------

function Write-Header($text) {
    Write-Host ""
    Write-Host "  $text" -ForegroundColor Cyan
    Write-Host ""
}

function Read-Required($prompt) {
    do { $val = (Read-Host "  $prompt").Trim() } while ($val -eq "")
    return $val
}

function Update-FilePlaceholders($dir, $replacements) {
    $files = Get-ChildItem -Recurse -File $dir -Include *.json,*.ts,*.html,*.mjs,*.js,*.md,*.svg |
             Where-Object { $_.FullName -notmatch '\\node_modules\\' }
    foreach ($f in $files) {
        $content = Get-Content $f.FullName -Raw -Encoding UTF8
        $updated = $content
        foreach ($r in $replacements.GetEnumerator()) {
            $updated = $updated -replace [regex]::Escape($r.Key), $r.Value
        }
        if ($updated -ne $content) {
            Set-Content $f.FullName $updated -Encoding UTF8 -NoNewline
        }
    }
}

function Get-SafeName($name) {
    ($name -replace '[^\w\s-]', '' -replace '\s+', '-').Trim('-')
}

# DeviceType map
$deviceSuffix = @{ "0"="SD"; "1"="Mini"; "2"="XL"; "5"="Pedal"; "7"="Plus"; "8"="Neo" }
$deviceName   = @{
    "0" = "Stream Deck / MK.2 (15 keys)"
    "1" = "Stream Deck Mini (6 keys)"
    "2" = "Stream Deck XL (32 keys)"
    "5" = "Stream Deck Pedal"
    "7" = "Stream Deck + (8 keys + 4 dials)"
    "8" = "Stream Deck Neo (8 keys)"
}

# --- Verificar prerequisitos --------------------------------------------------

function Assert-Command($cmd, $friendlyName, $installUrl) {
    if (-not (Get-Command $cmd -ErrorAction SilentlyContinue)) {
        Write-Host ""
        Write-Host "  ERROR: '$cmd' no esta instalado o no esta en el PATH." -ForegroundColor Red
        Write-Host "  Instala $friendlyName desde: $installUrl" -ForegroundColor Yellow
        exit 1
    }
}

Assert-Command "node" "Node.js 24+" "https://nodejs.org"
Assert-Command "npm"  "npm (incluido con Node.js)" "https://nodejs.org"

$nodeVersion = [int]((node -v) -replace 'v(\d+)\..*', '$1')
if ($nodeVersion -lt 24) {
    Write-Host ""
    Write-Host "  ERROR: Node.js $nodeVersion detectado. Se requiere version 24 o superior." -ForegroundColor Red
    Write-Host "  Actualiza con: nvm install 24 && nvm use 24" -ForegroundColor Yellow
    exit 1
}

# --- Banner -------------------------------------------------------------------

Clear-Host
Write-Host "  ==========================================" -ForegroundColor Cyan
Write-Host "     Stream Deck - Setup Wizard             " -ForegroundColor Cyan
Write-Host "  ==========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Que quieres crear? (numeros separados por coma)"
Write-Host "    1) Plugin"
Write-Host "    2) Profile"
Write-Host "    3) Icon Pack"
Write-Host ""
$selection = (Read-Host "  Seleccion").Trim() -split '\s*,\s*'

$doPlugin  = $selection -contains "1"
$doProfile = $selection -contains "2"
$doIcons   = $selection -contains "3"

if (-not ($doPlugin -or $doProfile -or $doIcons)) {
    Write-Host "  Seleccion no valida. Ejecuta el script de nuevo." -ForegroundColor Red
    exit 1
}

if ($doPlugin) {
    Assert-Command "streamdeck" "Stream Deck CLI" "npm install -g @elgato/cli@latest"
}

# --- Recoger datos ------------------------------------------------------------

$pluginData  = @{}
$profileData = @{}
$iconsData   = @{}

if ($doPlugin) {
    Write-Header "Plugin - datos necesarios"
    $pluginData.Author      = Read-Required "Autor (nombre o empresa)"
    $pluginData.Name        = Read-Required "Nombre del plugin (ej. Wave Link)"
    $pluginData.UUID        = Read-Required "UUID (ej. com.empresa.miplugin)"
    $pluginData.Description = Read-Required "Descripcion breve"
}

if ($doProfile) {
    Write-Header "Profile - datos necesarios"
    $profileData.Name = Read-Required "Nombre del profile (ej. OBS Streaming)"
    Write-Host ""
    Write-Host "  Para que dispositivos? (DeviceType, numeros separados por coma)"
    Write-Host "    0) Stream Deck / MK.1 / MK.2   (15 keys, 5x3)"
    Write-Host "    1) Stream Deck Mini             (6 keys, 3x2)"
    Write-Host "    2) Stream Deck XL               (32 keys, 8x4)"
    Write-Host "    5) Stream Deck Pedal"
    Write-Host "    7) Stream Deck +                (8 keys + 4 dials)"
    Write-Host "    8) Stream Deck Neo              (8 keys + info widgets)"
    Write-Host ""
    $devInput = (Read-Host "  Dispositivos").Trim() -split '\s*,\s*'
    $profileData.DeviceTypes = $devInput | Where-Object { $deviceSuffix.ContainsKey($_) }
    if ($profileData.DeviceTypes.Count -eq 0) {
        Write-Host "  Ningun dispositivo valido. Usando Stream Deck estandar (0)." -ForegroundColor Yellow
        $profileData.DeviceTypes = @("0")
    }
}

if ($doIcons) {
    Write-Header "Icon Pack - datos necesarios"
    $iconsData.Name        = Read-Required "Nombre del pack"
    $iconsData.Author      = Read-Required "Autor"
    $iconsData.Description = Read-Required "Descripcion breve"
}

# --- Aplicar scaffolds --------------------------------------------------------

Write-Header "Configurando proyecto..."

if ($doPlugin) {
    Write-Host "  [Plugin] Copiando scaffold..." -ForegroundColor Yellow

    $oldUUID = "com.yourcompany.yourplugin"
    $newUUID = $pluginData.UUID

    Get-ChildItem "scaffold\plugin" -Force | ForEach-Object {
        Move-Item $_.FullName . -Force
    }

    Update-FilePlaceholders . @{
        $oldUUID             = $newUUID
        "PLUGIN_AUTHOR"      = $pluginData.Author
        "PLUGIN_NAME"        = $pluginData.Name
        "PLUGIN_DESCRIPTION" = $pluginData.Description
    }

    if (Test-Path "${oldUUID}.sdPlugin") {
        Rename-Item "${oldUUID}.sdPlugin" "${newUUID}.sdPlugin"
    }

    Write-Host "  [Plugin] Instalando dependencias..." -ForegroundColor Yellow
    npm install --silent

    Write-Host "  [Plugin] Compilando..." -ForegroundColor Yellow
    npm run build --silent

    Write-Host "  [Plugin] Validando manifest..." -ForegroundColor Yellow
    streamdeck validate "${newUUID}.sdPlugin"

    Write-Host "  [Plugin] OK." -ForegroundColor Green
}

if ($doProfile) {
    Write-Host "  [Profile] Copiando scaffold..." -ForegroundColor Yellow

    if ($doPlugin) {
        $profilesDir = "$($pluginData.UUID).sdPlugin\profiles"
    } else {
        $profilesDir = "profiles"
    }
    New-Item -ItemType Directory -Path $profilesDir -Force | Out-Null

    Copy-Item "scaffold\profile\profiles\README.md" "$profilesDir\README.md" -Force

    $safeName = Get-SafeName $profileData.Name

    foreach ($dt in $profileData.DeviceTypes) {
        $suffix  = $deviceSuffix[$dt]
        $dName   = $deviceName[$dt]
        $outFile = "$profilesDir\${safeName}-${suffix}.streamDeckProfile"
        $pName   = "$($profileData.Name) - $dName"

        # Write profile JSON using a here-string (avoids PS 5.1 pipeline issue)
        $profileJson = @"
{
    "DeviceModel": 0,
    "DeviceUUID": "",
    "Name": "$pName",
    "Pages": {
        "items": { "0": { "items": {} } },
        "current": "0"
    },
    "Version": "1.0"
}
"@
        Set-Content $outFile $profileJson -Encoding UTF8
    }

    if ($doPlugin) {
        $manifestPath = "$($pluginData.UUID).sdPlugin\manifest.json"
        $manifest = Get-Content $manifestPath -Raw | ConvertFrom-Json

        $profileEntries = @()
        foreach ($dt in $profileData.DeviceTypes) {
            $suffix = $deviceSuffix[$dt]
            $entry = New-Object PSObject -Property @{
                Name                        = "profiles/${safeName}-${suffix}"
                DeviceType                  = [int]$dt
                AutoInstall                 = $true
                Readonly                    = $false
                DontAutoSwitchWhenInstalled = $false
            }
            $profileEntries += $entry
        }
        $manifest | Add-Member -NotePropertyName "Profiles" -NotePropertyValue $profileEntries -Force
        $manifest | ConvertTo-Json -Depth 10 | Set-Content $manifestPath -Encoding UTF8
    }

    if (-not $doPlugin) {
        Get-ChildItem "scaffold\profile" -Force | Where-Object { $_.Name -ne "profiles" } |
            ForEach-Object { Move-Item $_.FullName . -Force }
    }

    Write-Host "  [Profile] OK - $($profileData.DeviceTypes.Count) perfil(es) creado(s)." -ForegroundColor Green
}

if ($doIcons) {
    Write-Host "  [Icons] Copiando scaffold..." -ForegroundColor Yellow

    Get-ChildItem "scaffold\icons" -Force | ForEach-Object {
        Move-Item $_.FullName . -Force
    }

    Update-FilePlaceholders . @{
        "ICONPACK_NAME"        = $iconsData.Name
        "ICONPACK_AUTHOR"      = $iconsData.Author
        "ICONPACK_DESCRIPTION" = $iconsData.Description
    }

    Write-Host "  [Icons] OK." -ForegroundColor Green
}

# --- Limpiar ------------------------------------------------------------------

Remove-Item "scaffold" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "init.ps1" -Force -ErrorAction SilentlyContinue
Remove-Item "init.sh"  -Force -ErrorAction SilentlyContinue

# --- Resumen ------------------------------------------------------------------

Write-Host ""
Write-Host "  Proyecto inicializado." -ForegroundColor Green
Write-Host ""

if ($doPlugin) {
    $uuid = $pluginData.UUID
    Write-Host "  Plugin: $($pluginData.Name) ($uuid)" -ForegroundColor White
    Write-Host "    npm run watch      -> compilar y recargar en vivo"
    Write-Host "    npm run lint       -> verificar estilo de codigo"
    Write-Host "    npm run validate   -> validar manifest"
    Write-Host "    npm run pack       -> empaquetar para distribucion"
    Write-Host "    npm run sync       -> propagar cambios de project.config.json"
    Write-Host ""
}
if ($doProfile) {
    $deviceList = ($profileData.DeviceTypes | ForEach-Object { $deviceSuffix[$_] }) -join ", "
    Write-Host "  Profiles: $($profileData.Name) (dispositivos: $deviceList)" -ForegroundColor White
    if ($doPlugin) {
        Write-Host "    Ubicacion: $($pluginData.UUID).sdPlugin/profiles/"
    } else {
        Write-Host "    Ubicacion: profiles/"
    }
    Write-Host "    Ver profiles/README.md para el flujo de trabajo"
    Write-Host ""
}
if ($doIcons) {
    Write-Host "  Icon Pack: $($iconsData.Name) - aniade iconos 144x144 px en icons/" -ForegroundColor White
    Write-Host "    Ver icons/README.md para specs y como empaquetar"
    Write-Host ""
}
