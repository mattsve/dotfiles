function IsWindows {
    return ($env:OS -eq "Windows_NT")
}

Import-Module Get-ChildItemColor
Import-Module posh-git
Import-Module oh-my-posh

Set-PoshPrompt -Theme "$home\.poshthemes\private.omp.json"

if (-not (Test-Path alias:ls)) {
    function ls {
        &(get-command -name ls -CommandType Application | select-object -index 0) --color $args
    }
}

function gciw {
    Get-ChildItemColorFormatWide @args
}

New-Alias -Name lsw -Value gciw -Force

if (Test-Path "$home\.pwsh_extra.ps1") {
    . "$home\.pwsh_extra.ps1"
}