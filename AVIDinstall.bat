@ECHO OFF
TITLE AVID Client
SET root=%~dp0
CD /D %root%

CLS
ECHO 1.Download Latest Build From Avid
ECHO 2.Download Stable Build From Avid
ECHO 3.Run Avid (normally)
ECHO 4.Run Avid with Auto Restart (check if it is working properly before using this)
ECHO 5.To exit
ECHO 6.Install Nadeko's ffmpeg (for music)
ECHO.
ECHO Make sure you are running as Administrator
ECHO.
ECHO Don't try to install ffmpeg multiple times-- only if error with initial install
CHOICE /C 123456 /M "Enter your choice:"

:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 6 GOTO ffmpeg
IF ERRORLEVEL 5 GOTO exit
IF ERRORLEVEL 4 GOTO autorestart
IF ERRORLEVEL 3 GOTO runnormal
IF ERRORLEVEL 2 GOTO stable
IF ERRORLEVEL 1 GOTO latest

:latest
ECHO Make sure you are running it on Windows 8 or later.
timeout /t 10
ECHO Downloading Avid (Latest), please wait...
SET "FILENAME=%~dp0\Latest.bat"
bitsadmin.exe /transfer "Downloading Nadeko (Latest)" /priority high https://github.com/Kwoth/NadekoBot/raw/master/scripts/Latest.bat "%FILENAME%"
ECHO Avid Dev Build (latest) downloaded.
timeout /t 5
CALL Latest.bat
GOTO End

:stable
ECHO Make sure you are running it on Windows 8 or later.
timeout /t 10
ECHO Downloading Avid (Stable), please wait...
SET "FILENAME=%~dp0\Stable.bat"
bitsadmin.exe /transfer "Downloading Nadeko (Stable)" /priority high https://github.com/Kwoth/NadekoBot/raw/master/scripts/Stable.bat "%FILENAME%"
ECHO Avid Stable build downloaded.
timeout /t 5
CALL Stable.bat
GOTO End

:runnormal
ECHO Downloading AVID Run, please wait...
SET "FILENAME=%~dp0\NadekoRunNormal.bat"
bitsadmin.exe /transfer "Downloading AVID Run (normal)" /priority high https://raw.githubusercontent.com/reddyross/AVID/master/AVIDrun.bat "%FILENAME%"
ECHO.
ECHO Running BMOC Normally, "if" you are running this to check BMOC, use ".die" command on discord to stop BMOC.
timeout /t 10
CALL NadekoRunNormal.bat
GOTO End

:autorestart
ECHO Downloading Avid Auto Run, please wait...
SET "FILENAME=%~dp0\NadekoAutoRun.bat"
bitsadmin.exe /transfer "Downloading Nadeko Auto-Run" /priority high https://github.com/Kwoth/NadekoBot/raw/master/scripts/NadekoAutoRun.bat "%FILENAME%"
ECHO.
ECHO Running Nadeko with Auto Restart, you will have to close the session to stop the auto restart.
timeout /t 15
CALL NadekoAutoRun.bat
GOTO End

:exit
exit

:ffmpeg
TITLE NadekoBot FFMPEG Installer! 
ECHO Welcome to NadekoBot FFMPEG Installer! 
ECHO.
ECHO Installing ffmpeg in "%SystemDrive%\ffmpeg\"...
ECHO.
ECHO Make sure you are running this as Administrator! 
ECHO If not, then please restart "AVIDinstall.bat" as Administrator.
ECHO.
ECHO DO NOT USE "Windows PowerShell" for ffmpeg Installation!
ECHO.
timeout /t 30
ECHO.
ECHO Please wait...
mkdir %SystemDrive%\ffmpeg\
SET "FILENAME=%SystemDrive%\ffmpeg\ffmpeg.zip"
bitsadmin.exe /transfer "Downloading ffmpeg" /priority high https://ffmpeg.zeranoe.com/builds/win64/static/ffmpeg-20170111-e71b811-win64-static.zip "%FILENAME%"
IF EXIST "%SystemDrive%\ffmpeg\ffmpeg.zip" powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('%SystemDrive%\ffmpeg\ffmpeg.zip"', '%SystemDrive%\ffmpeg\'); }"
ECHO Backing up PATH registry to "%SystemDrive%\ffmpeg"
reg export "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "%SystemDrive%\ffmpeg\path_registry_backup.reg"
timeout /t 5
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /f /v "path" /t REG_SZ /d "%path%;%SystemDrive%\ffmpeg\ffmpeg-20170111-e71b811-win64-static\bin"
ECHO ffmpeg path has been set!
ECHO.
ECHO ffmpeg Installation complete!
GOTO End

:End
pause
CALL AVIDinstall.bat
