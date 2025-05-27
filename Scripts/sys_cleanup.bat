@echo off

:: Temp files
del /s /f /q "%TEMP%\*.*" >nul 2>&1
del /s /f /q "%SystemRoot%\Temp\*.*" >nul 2>&1
del /s /f /q "%LocalAppData%\Temp\*.*" >nul 2>&1

:: Windows Update cache
net stop wuauserv >nul 2>&1
del /s /f /q "%SystemRoot%\SoftwareDistribution\Download\*.*" >nul 2>&1
net start wuauserv >nul 2>&1

:: Recycle Bin
rd /s /q %SystemDrive%\$Recycle.Bin >nul 2>&1

:: System cache
del /s /f /q "%SystemRoot%\Prefetch\*.*" >nul 2>&1
del /f /s /q "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
del /f /q "%LocalAppData%\IconCache.db" >nul 2>&1

:: Browser cache
del /s /f /q "%LocalAppData%\Google\Chrome\User Data\Default\Cache\*.*" >nul 2>&1
del /s /f /q "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache\*.*" >nul 2>&1

:: Recent files and logs
del /f /q "%AppData%\Microsoft\Windows\Recent\*.*" >nul 2>&1
del /s /f /q "%SystemRoot%\Logs\*.*" >nul 2>&1

echo System cache cleaned successfully.
pause