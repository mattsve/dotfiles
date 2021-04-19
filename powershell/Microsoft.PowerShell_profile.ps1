Import-Module posh-git
Import-Module oh-my-posh

Set-PoshPrompt -Theme "$home\.poshthemes\private.omp.json"

if (Test-Path "$home\.pwsh_extra.ps1") {
    . "$home\.pwsh_extra.ps1"
}