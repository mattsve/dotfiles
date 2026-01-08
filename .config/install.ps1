$ErrorActionPreference = "Stop"

function Link([string]$link, [string]$target) {
    $file = Get-Item $link -ErrorAction SilentlyContinue
    if ($file) {
        if ($file.LinkType -ne "SymbolicLink") {
            Write-Error "'$($file.FullName)' exists and is not a symbolic link"
        } elseif ($file.Target -ne $target) {
            Write-Error "'$($file.FullName)' is a symbolic link pointing to '$($file.Target)' and not '$($target)'"            
        } else {
            Write-Verbose "$($file.FullName) already linked"
        }
    } else {
        $directory = Split-Path $link
        if (-not (Test-Path $directory)) {
            Write-Verbose "Creating dirctory $($directory)"
            New-Item -ItemType Directory -Path $directory
        }
        Write-Verbose "Creating $link -> $target"
        New-Item -Path $link -ItemType SymbolicLink -Value $target -ErrorAction Continue
    }
}

# Check if running as administrator
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "This script requires administrative rights" -ForegroundColor Red
    exit 1
}

write-Host "Installing .config"
foreach ($dir in Get-ChildItem  -Directory -Path "$PSScriptRoot") {
    Write-Host "  - $($dir.Name)"
    Link "$home/.config/$($dir.Name)" "$($dir.FullName)"
}