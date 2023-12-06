@echo off
setlocal enabledelayedexpansion

REM Set the root directory path, this would be the main folder with any/all sub folders, images, videos inside of it. IE My D:\pictures\from-phone\downloaded this script will then sort each photo into a folder based on it's creation date
set "rootDir=C:\Path\To\Your-MAIN-images\Folder"

REM Loop through each image file in the root directory and its subfolders
for /r "%rootDir%" %%F in (*.jpg *.jpeg *.png *.gif *.bmp *.tif *.tiff) do (
    REM Extract Date Taken using PowerShell
    for /F "tokens=*" %%A in ('powershell "Import-Module BitsTransfer; $image = [System.Drawing.Image]::FromFile('%%F'); $image.PropertyItems | Where-Object {$_.Id -eq 36867} | ForEach-Object { [System.Text.Encoding]::ASCII.GetString($_.Value) }"') do (
        set "dateTaken=%%A"
        set "dateTaken=!dateTaken:~0,10!"  REM Extracting just the date part (YYYY:MM:DD)
        set "dateTaken=!dateTaken:-=!"
        set "dateTaken=!dateTaken:/=-!"
        if not exist "%rootDir%\!dateTaken!" mkdir "%rootDir%\!dateTaken!"
        move "%%F" "%rootDir%\!dateTaken!\"
    )
)

echo Sorting completed.
pause
