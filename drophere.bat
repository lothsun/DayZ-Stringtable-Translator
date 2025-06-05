@echo off
setlocal

REM Check if a file was passed in via drag-and-drop
if "%~1"=="" (
    echo Please drag and drop a CSV file onto this batch file.
    pause
    exit /b
)

REM Call the PowerShell script with the provided CSV path
powershell -NoProfile -ExecutionPolicy Bypass -File "Translate-CSV.ps1" "%~1"

pause
