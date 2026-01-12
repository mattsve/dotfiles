function IsWindows {
    return ($env:OS -eq "Windows_NT")
}

oh-my-posh init pwsh --config "$home/.dotfiles/applications/oh-my-posh/configuration.omp.json" | Invoke-Expression

$env:POSH_GIT_ENABLED = $true

if (-not (Test-Path alias:ls)) {
    function ls {
        &(get-command -name ls -CommandType Application | select-object -index 0) --color $args
    }
}

function gciw {
    Get-ChildItem @args | Format-Wide
}

New-Alias -Name lsw -Value gciw -Force

$dotfilesFolder = (Get-Item $MyInvocation.MyCommand.Definition).Target | Split-Path | Split-Path
foreach ($f in (Get-ChildItem $dotfilesFolder -Filter *.ps1 -Recurse)) {
    if ($f.FullName -eq (Join-Path $dotfilesFolder "bootstrap.ps1")) { continue }
    if ((Split-Path $f.FullName) -eq (Join-Path $dotfilesFolder "windows")) { continue }
    if ((Split-Path $f.FullName) -eq (Join-Path $dotfilesFolder ".config")) { continue }
    if ((Split-Path $f.FullName) -eq (Join-Path $dotfilesFolder "scripts")) { continue }
    if ($f.FullName -eq (Join-Path $dotfilesFolder "powershell" "Microsoft.PowerShell_profile.ps1")) { continue }

    . "$f"
}

if (Get-Command "thefuck" -ErrorAction SilentlyContinue) {
    Invoke-Expression "$(thefuck --alias)"
    New-Alias -Name Correct-Me -Value fuck -Force
}

if (Test-Path "$home\.pwsh_extra.ps1") {
    . "$home\.pwsh_extra.ps1"
}

$PSStyle.FileInfo.Directory = $PSStyle.Foreground.Blue + $PSStyle.Bold