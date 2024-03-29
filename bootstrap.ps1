param([switch]$elevated)

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

function ModuleInstall([string]$module) {
    if ( -not (Get-Module -ListAvailable -Name $module)) {
        Install-Module $module @args
    } 
}

function IsWindows {
    return ($env:OS -eq "Windows_NT")
}

function Install-Font([string]$font) {
    if (IsWindows) {
        & .\scripts\Add-Font.ps1 -path $font
    }
}

function Install-OhMyPosh() {
    if (IsWindows) {
        & winget install JanDeDobbeleer.OhMyPosh -s winget
    } else {
        $architecture = uname -m
        if ($architecture -eq "x86_64") {
            $architecture = "amd64"
        } elseif ($architecture -eq "aarch64") {
            $architecture = "arm64"
        } else {
            Write-Error "Cannot install OhMyPosh"
        }
        
        New-Item -ItemType Directory -Force -Path $home/bin
        Invoke-WebRequest -Uri "https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-$architecture" -OutFile "$home/bin/oh-my-posh"
        & chmod +x "$home/bin/oh-my-posh"
    }
}

function IsElevated {
    if (IsWindows) {
        return ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')
    }
    else {
        return $true # no need to run elevated in unix
    }
}

if ($(IsElevated) -eq $false) {
    if ($elevated) {
        Write-Error "Must run as root"
        exit 1
    }
    else {
        Start-Process -Wait -Verb RunAs (Get-Process -Id $PID).Path -ArgumentList ("-noprofile -noexit -file ""$($myinvocation.MyCommand.Definition)"" -elevated")
        exit 0
    }
}

Write-Host "Installing modules"
Set-PSRepository PSGallery -InstallationPolicy Trusted
ModuleInstall "posh-git" -Scope CurrentUser

Write-Host "Installing OhMyPosh"
Install-OhMyPosh

Write-Host "Installing fonts"
Install-Font (Get-Item "fonts").FullName

Write-Host "Linking files"
Link $home/.poshthemes (Get-Item "poshthemes").FullName
Link $Global:profile (Get-Item "powershell/Microsoft.PowerShell_profile.ps1").FullName