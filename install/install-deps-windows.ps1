$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

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

function info {
    param($message)
    Write-Host "`r  [ " -NoNewline
    [Console]::ForegroundColor = 'Blue'
    Write-Host '..' -NoNewline
    [Console]::ResetColor()
    Write-Host " ] $message" 
}

if ($isAdmin -eq $false) {
  fail 'Debes tener permisos de administrador para continuar.' 
  return
}

# Environment variables

info "Configurando variables de entorno"

setx HOME "%USERPROFILE%"

setx XDG_CONFIG_HOME "%HOME%\.config"

setx YAZI_FILE_ONE "C:\Program Files\Git\usr\bin\file.exe"

setx LS_COLORS "di=36:ln=37:so=32:pi=33:ex=32:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

setx EDITOR "code"

Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe

# Aplicaciones no opcionales

# YASB
winget install --id AmN.yasb

success "Yasb instalado correctamente"

# Windows Terminal
winget install -e --id Microsoft.WindowsTerminal

success "Windows Terminal instalado correctamente"

# PowerShell
winget install --id Microsoft.PowerShell --source winget

success "PowerShell instalado correctamente"

# VSCode
winget

success "VSCode instalado correctamente"

# Oh my posh
winget install JanDeDobbeleer.OhMyPosh -s winget

success "Oh my posh instalado correctamente"

# Git
winget install -e --id Git.Git

success "Git instalado correctamente"

# Flow launcher
winget install "Flow Launcher"

success "Flow Launcher instalado correctamente"

# Spicetify
iwr -useb https://raw.githubusercontent.com/spicetify/cli/main/install.ps1 | iex
iwr -useb https://raw.githubusercontent.com/spicetify/marketplace/main/resources/install.ps1 | iex

success "Spicetify instalado correctamente"

# Scoop
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

scoop bucket add main

success "Scoop instalado correctamente"

# Eza
scoop install main/eza

success "Eza instalado correctamente"

# Yazi
scoop install yazi
scoop install ffmpeg 7zip jq poppler fd ripgrep fzf zoxide imagemagick

suceess "Yazi instalado correctamente"

# Neovim
scoop install main/neovim

suceess "Neovim instalado correctamente"


