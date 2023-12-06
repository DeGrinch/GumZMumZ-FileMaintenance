@echo off

setlocal enabledelayedexpansion

:searchLoop

rem Deleting FolderSearchResults.txt to start fresh
del "%~dp0FolderSearchResults.txt" 2>nul

set /p FOLDERNAME=Enter the folder name to search (type EXIT to quit): 
echo Searching for folders named %FOLDERNAME% across all partitions...

echo Available partitions on the system:
wmic logicaldisk get deviceid, volumename, description

set "OUTPUT_FILE=%~dp0FolderSearchResults.txt"

echo Searching for folders named %FOLDERNAME% across all partitions...
for %%D in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    powershell -Command "Get-ChildItem -Path %%D:\ -Directory -Recurse | Where-Object { $_.Name -eq '%FOLDERNAME%' } | ForEach-Object { $_.FullName }" 2>$null >> "!OUTPUT_FILE!"
)

start Folder_Search_Results_Viewer.bat

set /p CONFIRM=Have you read the results? (Type YES to continue or EXIT to quit): 
if /i "%CONFIRM%"=="YES" (
    goto searchLoop
) else if /i "%CONFIRM%"=="EXIT" (
    echo Exiting...
    exit /b
) else (
    goto searchLoop
)
