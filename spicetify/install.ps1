$spotifyPath = "$env:APPDATA\Spotify\Spotify.exe"

function fail {
    param($message)
    Write-Host "`r`e[2K  [ " -NoNewline
    [Console]::ForegroundColor = 'Red'
    Write-Host 'FAIL' -NoNewline
    [Console]::ResetColor()
    Write-Host " ] $message"
    Write-Host ""
    exit
}

function success {
    param($message)
    Write-Host "`r`e[2K  [ " -NoNewline
    [Console]::ForegroundColor = 'Green'
    Write-Host 'OK' -NoNewline
    [Console]::ResetColor()
    Write-Host " ] $message"
}


if (-not (Test-Path -Path $spotifyPath)) {
  fail 'Debes instalar Spotify primero.'
  return  
}

# Install Spicetify CLI
iwr -useb https://raw.githubusercontent.com/spicetify/cli/main/install.ps1 | iex

# Themes
git clone --depth=1 https://github.com/spicetify/spicetify-themes.git

if (-not (Test-Path -Path "./spicetify-themes")) {
    fail 'Hubo un problema al clonar el repositorio de temas.'
}

cd spicetify-themes
cp * "$(spicetify -c | Split-Path)\Themes\" -Recurse
cd ..

# Hide windows controls
$extensionPath = (Resolve-Path "$env:APPDATA\spicetify\Extensions\noControls.js").Path 
curl -o $extensionPath https://raw.githubusercontent.com/ohitstom/spicetify-extensions/refs/heads/main/noControls/noControls.js

success 'Todo se ha instalado correctamente, no te olvides de ejecutar "spicetify apply" para aplicar los cambios'
