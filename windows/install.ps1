$ErrorActionPreference = "Stop"

# Check if running as administrator
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "This script requires administrative rights" -ForegroundColor Red
    exit 1
}

# Check if Chocolatey is not installed
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Installing chocolatey"
    winget install --id chocolatey.chocolatey --source winget
    write-Host "Please restart this script with chocolatey in path"
    exit 1
}

Write-Host "Install applications via chocolatey"
choco install -y "$PSScriptRoot/packages.config"

& "$PSScriptRoot/../.config/install.ps1"