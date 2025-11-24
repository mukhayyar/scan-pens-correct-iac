@echo off
setlocal enabledelayedexpansion

:: Configuration for PENS Captive Portal
set "BASE_HOST=iac"
set "DOMAIN=.pens.ac.id"
set "PORT=8003"
set "PATH_QUERY=/index.php?zone=eepiswlan"
set "TEMP_FILE=temp_status_code.txt"

:: Range to scan (e.g., iac1 to iac30)
set START=1
set END=30

echo Scanning for active captive portals (https)...
echo This may take a moment.

for /L %%i in (%START%,1,%END%) do (
    set "CURRENT_NUM=%%i"
    set "URL=https://!BASE_HOST!%%i!DOMAIN!:!PORT!!PATH_QUERY!"
    
    :: Reset status variable
    set "STATUS=000"

    :: Run curl directly and save output to a temp file
    :: -k: Allow insecure SSL
    :: -s: Silent
    :: -o nul: Discard the HTML body
    :: -w: Write only the HTTP code
    :: --connect-timeout 1: Wait 1 second max
    cmd /c curl -k -s -o nul -w "%%{http_code}" --connect-timeout 1 "!URL!" > "!TEMP_FILE!"
    
    :: Read the status from the file
    if exist "!TEMP_FILE!" (
        set /p STATUS=<"!TEMP_FILE!"
    )

    :: Check the status
    if "!STATUS!" NEQ "000" (
        echo.
        echo [+] FOUND ACTIVE PORTAL: iac%%i [HTTP !STATUS!]
        echo     !URL!
        :: stop
        goto :EOF
    ) else (
        :: Print a dot for progress (without new line)
        <nul set /p=.
    )
)

:: Clean up
if exist "!TEMP_FILE!" del "!TEMP_FILE!"

echo.
echo Scan complete.
pause