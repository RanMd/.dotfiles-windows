$spotifyPath = "$env:USERPROFILE\AppData\Roaming\Spotify\Spotify.exe"

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

if (-not (Test-Path -Path $spotifyPath)) {
  fail 'Debes instalar Spotify primero.'
  return  
}

iwr -useb https://raw.githubusercontent.com/spicetify/cli/main/install.ps1 | iex
git clone --depth=1 https://github.com/spicetify/spicetify-themes.git
cd spicetify-themes
cp * "$(spicetify -c | Split-Path)\Themes\" -Recurse
