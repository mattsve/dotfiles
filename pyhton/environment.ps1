$env:PYTHONIOENCODING='utf-8'
if (Get-Command "python3" -ErrorAction SilentlyContinue) {
    $scriptLocation = python3 -c "import os, sysconfig; print(sysconfig.get_path('scripts', f'{os.name}_user'))"
    $env:Path += ";$scriptLocation"
    
    if (-Not (Get-Command "thefuck" -ErrorAction SilentlyContinue)) {
        & pip install thefuck
    }
}