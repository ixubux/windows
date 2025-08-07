@echo off
title Removing Adobe firewall block rules...
echo.

setlocal enabledelayedexpansion
set count=0

:: Loop through possible rule names
for /l %%i in (1,1,100) do (
    set "ruleIn=Block_Adobe_%%i_IN"
    set "ruleOut=Block_Adobe_%%i_OUT"

    netsh advfirewall firewall delete rule name="!ruleIn!" >nul 2>&1
    if !errorlevel! EQU 0 (
        echo Removed rule: !ruleIn!
        set /a count+=1
    )

    netsh advfirewall firewall delete rule name="!ruleOut!" >nul 2>&1
    if !errorlevel! EQU 0 (
        echo Removed rule: !ruleOut!
        set /a count+=1
    )
)

if %count% EQU 0 (
    echo No matching rules found.
) else (
    echo.
    echo %count% rules removed.
)
pause
