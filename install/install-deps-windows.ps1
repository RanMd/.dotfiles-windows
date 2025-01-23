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

if ($isAdmin -eq $false) {
  fail 'Debes tener permisos de administrador para continuar.' 
  return
}

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
