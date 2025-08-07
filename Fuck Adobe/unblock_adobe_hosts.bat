@echo off
title Reverting Adobe blocks from hosts file...
echo.

:: Requires admin
>nul 2>&1 "%SystemRoot%\system32\cacls.exe" "%SystemRoot%\system32\config\system"
if %errorlevel% NEQ 0 (
    echo This script must be run as administrator.
    pause
    exit /b
)

set "hostsFile=%SystemRoot%\System32\drivers\etc\hosts"
set "tempFile=%SystemRoot%\System32\drivers\etc\hosts_tmp"
setlocal enabledelayedexpansion

:: List of Adobe domains to remove
set removeCount=0

(
    for /f "usebackq tokens=* delims=" %%L in ("%hostsFile%") do (
        set "line=%%L"
        set "skipLine=false"

        for %%D in (
            adobe.com
            activate.adobe.com
            lm.licenses.adobe.com
            ims-prod06.adobelogin.com
            ims-na1.adobelogin.com
            na1r.services.adobe.com
            hlrcv.stage.adobe.com
            practivate.adobe.com
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
            echo !line! | findstr /C:"127.0.0.1 %%D" >nul && set "skipLine=true"
            echo !line! | findstr /C:"0.0.0.0 %%D" >nul && set "skipLine=true"
        )

        if /i "!skipLine!"=="false" (
            echo !line!
        ) else (
            echo Removed: !line!
            set /a removeCount+=1 >nul
        )
    )
) > "%tempFile%"

:: Replace original hosts file
copy /y "%tempFile%" "%hostsFile%" >nul
del "%tempFile%" >nul

echo.
echo %removeCount% Adobe block lines removed from hosts file.
pause