@echo off
title Blocking Adobe tracking & licensing servers via hosts file...
echo.

:: Requires admin
>nul 2>&1 "%SystemRoot%\system32\cacls.exe" "%SystemRoot%\system32\config\system"
if %errorlevel% NEQ 0 (
    echo This script must be run as administrator.
    pause
    exit /b
)

set "hostsFile=%SystemRoot%\System32\drivers\etc\hosts"
setlocal enabledelayedexpansion

:: Domains to block
set blockList=0

for %%D in (
adobe.com
activate.adobe.com
lm.licenses.adobe.com
ims-prod06.adobelogin.com
ims-na1.adobelogin.com
na1r.services.adobe.com
hlrcv.stage.adobe.com
practivate.adobe.com
na1r.services.adobe.com
na2m-pr.licenses.adobe.com
oobesaas.adobe.com
assetserver.adobe.com
wip.adobe.com
geo2.adobe.com
adobeid-na1.services.adobe.com
telemetry.adobe.com
adobedtm.com
metrics.adobe.com
typekit.net
use.typekit.net
prod.adobegenuine.com
prod.adobegenuine.com.edgesuite.net
genuine.adobe.com
www.adobeereg.com
ereg.adobe.com
na1m.adobelogin.com
) do (
    findstr /C:"127.0.0.1 %%D" "%hostsFile%" >nul
    if errorlevel 1 (
        echo 127.0.0.1 %%D>>"%hostsFile%"
        echo 0.0.0.0 %%D>>"%hostsFile%"
        echo Blocked: %%D
        set /a blockList+=1
    ) else (
        echo Already blocked: %%D
    )
)

echo.
echo %blockList% Adobe tracking domains added to hosts file.
pause