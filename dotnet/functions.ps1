function New-Solution {    
    param (        
        [string]$Name = 'All',
        [switch]$Recurse = $false
    )
    & dotnet new sln -n $Name --force
    if ($Recurse) {
        foreach ($csproj in (Get-ChildItem -Include *.csproj -Recurse)) {
            & dotnet sln All.sln add $csproj
        }
    }
}

function Open-Solution {
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [string]$Path
    )

    $solutions = Get-ChildItem -Filter *.sln -Path $path
    if ($solutions.Count -ne 1) {
        Write-Error "Zero or more than one solution found"
        return 1
    }

    & ($solutions[0].FullName)
}

New-Alias -Name New-Sln -Value New-Solution -Force
New-Alias -Name Open-Sln -Value Open-Solution -Force