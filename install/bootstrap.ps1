$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$DOTFILES = (Resolve-Path "$scriptDir/..").Path

$overwrite_all = $false
$backup_all = $false
$skip_all = $false

function info {
    param($message)
    Write-Host "`r  [ " -NoNewline
    [Console]::ForegroundColor = 'Blue'
    Write-Host '..' -NoNewline
    [Console]::ResetColor()
    Write-Host " ] $message" 
}

function user {
    param($message)
    Write-Host "`r  [ " -NoNewline
    [Console]::ForegroundColor = 'Yellow'
    Write-Host '??' -NoNewline
    [Console]::ResetColor()
    Write-Host " ] $message"
}

function success {
    param($message)
    Write-Host "`r`e[2K  [ " -NoNewline
    [Console]::ForegroundColor = 'Green'
    Write-Host 'OK' -NoNewline
    [Console]::ResetColor()
    Write-Host " ] $message"
}

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

function link-file {
    param(
        [string]$src,
        [string]$dst
    )

    $overwrite = $false
    $backup = $false
    $skip = $false
    $action = ''

    if (Test-Path $dst) {
        if ($overwrite_all -eq $false -and $backup_all -eq $false -and $skip_all -eq $false) {
            $currentSrc = (Get-Item $dst).Target

            if ($currentSrc -eq $src) {
                $skip = $true
            }
            else {
                user "El archivo ya existe: $dst ($(Split-Path $src -Leaf)), ¿Qué quieres hacer? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
                $action = [Console]::ReadKey($true).KeyChar

                switch ($action) {
                    'o' { $overwrite = $true }
                    'O' { $overwrite_all = $true }
                    'b' { $backup = $true }
                    'B' { $backup_all = $true }
                    's' { $skip = $true }
                    'S' { $skip_all = $true }
                    default { }
                }
            }
        }

        $overwrite = if ($overwrite) { $true } elseif ($overwrite_all) { $true } else { $false }
        $backup = if ($backup) { $true } elseif ($backup_all) { $true } else { $false }
        $skip = if ($skip) { $true } elseif ($skip_all) { $true } else { $false }

        if ($overwrite) {
            Remove-Item -Path $dst -Force -Recurse
            success "removido $dst"
        }

        if ($backup) {
            Rename-Item -Path $dst -NewName "${dst}.backup"
            success "se movio $dst a ${dst}.backup"
        }

        if ($skip) {
            success "omitido $src"
        }
    }

    if ($skip -eq $false) {
        New-Item -ItemType SymbolicLink -Path $dst -Target $src
        success "Enlazado $src a $dst"
    }
}

function install-dotfiles {
    info 'Instalando dotfiles'

    Get-ChildItem -Path $DOTFILES -Recurse -Depth 2 -Filter 'links.prop' | ForEach-Object {
        Get-Content $_ | ForEach-Object {
            $line = $_
            $srcAux, $dstAux = $line.Split('=') | ForEach-Object { $_.Trim() }

            #Creacion variables
            $app = $dstAux.Split('/')[0]
            $appExpand = Invoke-Expression ($app) 

            $dstExpanded = (Resolve-Path $dstAux.Replace($app, $appExpand)).Path       
            $srcExpanded = (Resolve-Path $srcAux.Replace('$DOTFILES', $DOTFILES)).Path 
            $dir = Split-Path $dstExpanded -Parent -Resolve

            if (-not (Test-Path $dir)) {
                New-Item -ItemType Directory -Path $dir | Out-Null
            }

            link-file $srcExpanded $dstExpanded
        }
    }
}

install-dotfiles
echo ''
echo ''
success 'Todo se instalo correctamente'
