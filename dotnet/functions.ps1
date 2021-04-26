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

New-Alias -Name New-Sln -Value New-Solution