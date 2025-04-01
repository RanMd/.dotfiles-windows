# Inicialización de Oh My Posh con el tema "pure"
oh-my-posh init pwsh --config 'C:\Users\Yo\.config\ohmyposh\zen.toml' | Invoke-Expression

# Configuración de PSReadLine
Set-PSReadLineOption -PredictionViewStyle InlineView -MaximumHistoryCount 2048
Set-PSReadLineKeyHandler -Key "Ctrl+ " `
                         -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::ForwardChar($key, $arg)
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadLineKeyHandler -Key "Ctrl+b" `
                         -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::ForwardChar($key, $arg)
}

# Mise activation
# (When using scoop, mise is automatically activated)

# Inicialización de Zoxide para gestión avanzada de directorios
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# Creación de alias personalizados

function eza_alias {
    eza --color=always --icons=always --no-user --time-style='+%d/%m/%Y' $args
}

Set-Alias ls eza_alias

function lsa { ls -al }
function lsl { ls -l }

Function BackupFile {
    param(
        [string]$Path
    )
    $BackupPath = "$($Path).bak"
    Copy-Item -Path $Path -Destination $BackupPath
}

Set-Alias bak BackupFile

function Copy-FolderContent {
    param (
        [string]$Source
    )
    $Destination = "C:\Program Files (x86)\Steam\steamapps\common\RimWorld\Mods"
    Copy-Item -Path $Source -Destination $Destination -Recurse -Force
}

Set-Alias cf Copy-FolderContent

# Atajos de teclado para búsqueda en el historial
Set-PSReadLineKeyHandler -Chord "Ctrl+n" -Function HistorySearchForward
Set-PSReadLineKeyHandler -Chord "Ctrl+p" -Function HistorySearchBackward
