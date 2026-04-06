$ErrorActionPreference = 'Stop'

Write-Host "Stopping AnyDesk..."

$service = Get-Service -Name 'AnyDesk' -ErrorAction SilentlyContinue
if ($service) {
    if ($service.Status -ne 'Stopped') {
        Stop-Service -Name 'AnyDesk' -Force -ErrorAction SilentlyContinue
    }
}

Get-Process -Name 'AnyDesk' -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue

$paths = @(
    "$env:ProgramData\AnyDesk",
    "$env:AppData\AnyDesk"
)

foreach ($path in $paths) {
    if (Test-Path $path) {
        Write-Host "Removing $path"
        Remove-Item -Path $path -Recurse -Force -ErrorAction SilentlyContinue
    }
    else {
        Write-Host "Not found: $path"
    }
}

Write-Host "Done."