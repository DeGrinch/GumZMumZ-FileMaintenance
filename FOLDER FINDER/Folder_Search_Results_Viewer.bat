@echo off
setlocal enabledelayedexpansion

rem Copying FolderSearchResults.txt to FolderSearchResultsAnalyzer.txt
copy "%~dp0FolderSearchResults.txt" "%~dp0FolderSearchResultsAnalyzer.txt" /Y > nul

:mainLoop
cls
echo Folder Search Results:
echo ----------------------

set "LINE_NUM=0"

rem Displaying the content of FolderSearchResultsAnalyzer.txt
for /f "delims=" %%A in ('type "%~dp0FolderSearchResultsAnalyzer.txt"') do (
    set /a LINE_NUM+=1
    echo !LINE_NUM!. %%A
    set "RESULTS[!LINE_NUM!]=%%A"
)

echo ----------------------
echo.

set /p CHOICE=Enter the number for more information (or type EXIT to quit): 

if /i "%CHOICE%"=="EXIT" (
    exit /b
)

if not defined RESULTS[%CHOICE%] (
    echo Invalid selection.
    pause
    goto mainLoop
)

cls
echo Additional Information for: !RESULTS[%CHOICE%]!
echo ---------------------------------------------

powershell -Command "Get-ChildItem '!RESULTS[%CHOICE%]!' | Format-Table Name, @{Label='Size';Expression={$_.Length}}, CreationTime -AutoSize"

pause
goto mainLoop
