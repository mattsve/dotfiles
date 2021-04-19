function IsWindows {
    return ($env:OS -eq "Windows_NT")
}

if (IsWindows) {
Import-Module PSColors
}

Import-Module posh-git
Import-Module oh-my-posh

Set-PoshPrompt -Theme "$home\.poshthemes\private.omp.json"

if (-not (Test-Path alias:ls)) {
    function ls {
        &(get-command -name ls -CommandType Application | select-object -index 0) --color $args
    }
}

function gciw {
    Get-ChildItem @args | Format-Wide
}

New-Alias -Name lsw -Value gciw

if (Test-Path "$home\.pwsh_extra.ps1") {
    . "$home\.pwsh_extra.ps1"
}