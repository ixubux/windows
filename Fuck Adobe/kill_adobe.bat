@echo off
title Killing all Adobe-related processes...
echo.

:: Optional: elevate to admin
>nul 2>&1 "%SystemRoot%\system32\cacls.exe" "%SystemRoot%\system32\config\system"
if %errorlevel% NEQ 0 (
    echo This script must be run as administrator.
    pause
    exit /b
)

setlocal enabledelayedexpansion
set count=0

:: List of known Adobe processes (lowercase recommended for search matching)
for %%P in (
adobe_licensing_wf_helper.exe
adobe_licensing_wf.exe
adobe_licensing_helper.exe
adobeipcbroker.exe
adobeipcbrokercustomhook.exe
adobeupdatemanager.exe
adobeupdateservice.exe
adobegenuinevalidator.exe
adobegenuinesoftwareintegrityservice.exe
adobedotcom.exe
adobedesktopservice.exe
adobeservicesinstaller.exe
adobecrashreport.exe
adobecrashprocessor.exe
adobeextensionservice.exe
adobegcclient.exe
adobe_notification_helper.exe
adobenotificationclient.exe
adobeupdatehelper.exe
adobeinstaller.exe
acrotray.exe
creativecloud.exe
creativecloudhelper.exe
coreSync.exe
node.exe
armsvc.exe
adobe premiere pro.exe
adobe media encoder.exe
mocha4ae_adobe.exe
) do (
    tasklist /fi "imagename eq %%P" | find /i "%%P" >nul
    if not errorlevel 1 (
        echo Killing: %%P
        taskkill /f /im "%%P" >nul 2>&1
        set /a count+=1
    )
)

echo.
echo %count% Adobe-related processes attempted to kill.
pause