# Disabled Services Lister
# Lists Windows services with StartType=Disabled

# Self-elevate to admin
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell -Verb runAs -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`""
    exit
}

# Clear and show header
Clear-Host
Write-Host "DISABLED SERVICES - $env:COMPUTERNAME" -ForegroundColor Cyan
Write-Host "Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor Gray
Write-Host ""

try {
    # Get disabled services
    $services = Get-Service | Where-Object { $_.StartType -eq 'Disabled' } |
                Select-Object Name, DisplayName, Status |
                Sort-Object Name
    
    # Display results
    if ($services.Count -gt 0) {
        $services | Format-Table -AutoSize
        Write-Host "Total: $($services.Count) disabled services" -ForegroundColor Green
    } else {
        Write-Host "No disabled services found" -ForegroundColor Yellow
    }
}
catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}

# Pause before exit
Write-Host ""
Write-Host "Press any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")