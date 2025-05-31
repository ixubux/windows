# Self-elevate if not running as admin
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell -Verb runAs -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`""
    exit
}

# Disable unnecessary services
$services = @(
    "AdobeUpdateService",
    "AppVClient",
    "DiagTrack",
    "DialogBlockingService",
    "MsKeyboardFilter",
    "NetTcpPortSharing",
    "RasAuto",
    "RemoteAccess",
    "RemoteRegistry",
    "RetailDemo",
    "SCardSvr",
    "ScDeviceEnum",
    "SCPolicySvc",
    "seclogon",
    "SgrmBroker",
    "shpamsvc",
    "Spooler",
    "TermService",
    "tzautoupdate",
    "UevAgentService",
    "WerSvc",
    "wisvc",
    "WpcMonSvc",
    "XblAuthManager",
    "XblGameSave",
    "XboxNetApiSvc"
)

foreach ($svc in $services) {
    Write-Host "Disabling $svc..." -ForegroundColor Cyan
    try {
        Stop-Service -Name $svc -Force -ErrorAction Stop
        Set-Service -Name $svc -StartupType Disabled -ErrorAction Stop
        Write-Host " $svc disabled." -ForegroundColor Green
    } catch {
        Write-Host " $svc could not be disabled or is missing." -ForegroundColor Yellow
    }
}

Write-Host "`n Done. You’re free from the fluff." -ForegroundColor Magenta
