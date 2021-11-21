# Modules
#

# https://github.com/starship/starship
Invoke-Expression (&starship init powershell)

# https://github.com/dahlbyk/posh-git
Import-Module posh-git

# https://github.com/vors/ZLocation
Import-Module ZLocation

# https://github.com/71/Focus-Window
# Import-Module Focus-Window -DisableNameChecking


# Aliases
#

New-Alias g git
New-Alias w Focus-Window
New-Alias e explorer


# Functions
#

function go {
    $p = $env:PATH
    $env:PATH = "$env:SCOOP\apps\gcc\current\bin;$(Split-Path (Get-Command go.exe).Source -Parent)"
    try { go.exe $args }
    finally { $env:PATH = $p }
}

function gh-clone {
    param (
        [String]
        $RepositoryURL
    )

    if ($RepositoryURL -notmatch '^(https://github.com/|git@github.com:|)([^/]+)/(.+?)(\.git)?$') {
        throw 'Please insert a GitHub URL.'
    }

    if ($Matches[1] -eq '') {
        if ($Matches[2] -eq '71') {
            $RepositoryURL = "git@github.com:71/$($Matches[3]).git"
        } else {
            $RepositoryURL = "https://github.com/$($Matches[2])/$($Matches[3]).git"
        }
    }

    git.exe clone $RepositoryURL C:\Code\github.com\$($Matches[2])\$($Matches[3])
}

function install-needed {
    cargo.exe install bat starship
}


# Configuration
#

# Git

$GitPromptSettings.EnableFileStatus = $false

# Readline

Set-PSReadLineOption -HistoryNoDuplicates
