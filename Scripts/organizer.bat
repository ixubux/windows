@echo off
:: Zen File Sorter v2 (fixed)
:: Creates folders only if files exist inside.

set "DOWNLOADS=%USERPROFILE%\Downloads"
set "DOCS=%DOWNLOADS%\Documents"
set "IMAGES=%DOWNLOADS%\Pictures"
set "VIDEOS=%DOWNLOADS%\Videos"
set "AUDIO=%DOWNLOADS%\Audio"
set "ARCHIVES=%DOWNLOADS%\Archives"
set "SCRIPTS=%DOWNLOADS%\Scripts"
set "APPS=%DOWNLOADS%\Apps"
set "ISO=%DOWNLOADS%\ISO"
set "OTHERS=%DOWNLOADS%\Others"

cd /d "%DOWNLOADS%"

:: === FUNCTION: Create folder if files exist and move files ===
:: Usage: call :move_if_exist "filepattern" "targetfolder"
goto :main

:move_if_exist
setlocal
set "patterns=%~1"
set "folder=%~2"
set "moved=0"

for %%P in (%patterns%) do (
    dir /b "%%P" >nul 2>&1
    if not errorlevel 1 (
        if !moved! EQU 0 (
            if not exist "%folder%" mkdir "%folder%"
            set moved=1
        )
        move "%%P" "%folder%" >nul
    )
)

endlocal & goto :eof

:main
:: Enable delayed expansion for variables in function
setlocal enabledelayedexpansion

:: Documents
call :move_if_exist "*.pdf *.doc* *.txt *.xls* *.ppt*" "%DOCS%"

:: Images
call :move_if_exist "*.jpg *.jpeg *.png *.gif *.bmp *.webp" "%IMAGES%"

:: Videos
call :move_if_exist "*.mp4 *.mkv *.avi *.mov *.webm" "%VIDEOS%"

:: Audio
call :move_if_exist "*.mp3 *.wav *.flac *.aac *.ogg *.m4a *.wma" "%AUDIO%"

:: Archives
call :move_if_exist "*.zip *.rar *.7z *.tar *.gz *.xz" "%ARCHIVES%"

:: Scripts
call :move_if_exist "*.bat *.ps1 *.sh *.js *.py" "%SCRIPTS%"

:: Apps
call :move_if_exist "*.exe *.msi *.dmg *.pkg *.deb *.rpm *.msi" "%APPS%"

:: ISO Files
call :move_if_exist "*.iso" "%ISO%"

:: Move leftover files with unknown extensions to Others
for %%F in (*) do (
    if /i not "%%~nxF"=="%~nx0" (
        set "ext=%%~xF"
        set "isKnown=0"
        
        :: Check against known extensions (case-insensitive)
        for %%E in (.pdf .doc .docx .txt .xls .xlsx .ppt .pptx .jpg .jpeg .png .gif .bmp .webp .mp4 .mkv .avi .mov .webm .mp3 .wav .flac .aac .ogg .m4a .wma .zip .rar .7z .tar .gz .xz .iso .bat .ps1 .sh .js .py .exe .msi .dmg .pkg .deb .rpm .dll) do (
            if /i "!ext!"=="%%E" set "isKnown=1"
        )
        
        :: If extension is not known, move to Others
        if !isKnown! EQU 0 (
            if not exist "%OTHERS%" mkdir "%OTHERS%"
            move "%%F" "%OTHERS%" >nul
        )
    )
)

endlocal

echo Downloads sorted with calm clarity...
timeout /t 2 >nul
