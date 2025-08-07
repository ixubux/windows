@echo off
title Blocking Adobe executables in Windows Firewall...
echo.

setlocal enabledelayedexpansion

:: List of Adobe executable paths
set count=0

:: Start loop
for %%A in (
"C:\Program Files\Common Files\Adobe\Adobe OS Extension\AdobeNotificationHelper.exe"
"C:\Program Files\Common Files\Adobe\Adobe OS Extension\AdobeNotificationClient.exe"
"C:\Program Files\Common Files\Adobe\Adobe Desktop Common\RemoteComponents\UPI\ExManCoreLib\AdobeExtensionsService.exe"
"C:\Program Files\Common Files\Adobe\Adobe Desktop Common\NGL\adobe_licensing_wf_helper.exe"
"C:\Program Files\Common Files\Adobe\Adobe Desktop Common\NGL\adobe_licensing_wf.exe"
"C:\Program Files\Adobe\Adobe Premiere Pro 2025\PlugIns\(AfterEffectsLib)\Effects\mochaAE\MochaAE.bundle\Contents\Win64\mochaui\bin\mocha4ae_adobe.exe"
"C:\Program Files\Adobe\Adobe Premiere Pro 2025\AdobeCrashReport.exe"
"C:\Program Files\Adobe\Adobe Premiere Pro 2025\Adobe Premiere Pro.exe"
"C:\Program Files\Adobe\Adobe Creative Cloud\Diagnostics\Adobe Creative Cloud Diagnostics.exe"
"C:\Program Files\Adobe\Adobe Creative Cloud\ACC\Adobe Crash Processor.exe"
"C:\Program Files\Adobe\Adobe Creative Cloud Experience\js\node_modules\adobe-cr\build\Release\Adobe Crash Processor.exe"
"C:\Program Files (x86)\Common Files\Adobe\OOBE\PDApp\IPC\customhook\AdobeIPCBrokerCustomHook.exe"
"C:\Program Files (x86)\Common Files\Adobe\OOBE\PDApp\IPC\AdobeIPCBroker.exe"
"C:\Program Files (x86)\Common Files\Adobe\AdobeNotificationManager\AdobeNotificationHelper.exe"
"C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\LCC\adobe_licensing_helper.exe"
"C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\IPCBox\customhook\AdobeIPCBrokerCustomHook.exe"
"C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\IPCBox\AdobeIPCBroker.exe"
"C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\HDBox\Adobe Update Helper.exe"
"C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\ElevationManager\AdobeUpdateService.exe"
"C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\ElevationManager\AdobeServiceInstaller.exe"
"C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\ElevationManager\Adobe Installer.exe"
"C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\DEBox\DE6\resources\libraries\Adobe_Helperx64.exe"
"C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\DEBox\DE6\resources\libraries\Adobe_Helperx32.exe"
"C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\ADS\Adobe Desktop Service.exe"
"C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\ADS\Adobe Crash Processor.exe"
"C:\Program Files (x86)\Adobe\Adobe Creative Cloud\Utils\AdobeGenuineValidator.exe"
"C:\adobeTemp\ETR75D9.tmp\1\universal\App\PlugIns\(AfterEffectsLib)\Effects\mochaAE\MochaAE.bundle\Contents\Win64\mochaui\bin\mocha4ae_adobe.exe"
"C:\adobeTemp\ETR75D9.tmp\1\universal\App\AdobeCrashReport.exe"
"C:\adobeTemp\ETR75D9.tmp\1\universal\App\Adobe Media Encoder.exe"
) do (
    set /a count+=1
    set "ruleName=Block_Adobe_!count!"
    
    echo Blocking: %%A
    netsh advfirewall firewall add rule name="!ruleName!_IN" dir=in action=block program="%%~A" enable=yes
    netsh advfirewall firewall add rule name="!ruleName!_OUT" dir=out action=block program="%%~A" enable=yes
)

echo.
echo Done. %count% Adobe processes blocked from network access.
pause
