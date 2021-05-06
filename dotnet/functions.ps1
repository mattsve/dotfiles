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
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [string]$Path
    )

    try {
        $solutions = Get-ChildItem -Filter *.sln -Path $path
        if ($solutions.Count -ne 1) {                
            Throw "$($solutions.Count) solutions found"        
        }
        & ($solutions[0].FullName)
    }
    catch  {
        $PSCmdlet.WriteError($_)
    }
}

New-Alias -Name New-Sln -Value New-Solution -Force
New-Alias -Name Open-Sln -Value Open-Solution -Force