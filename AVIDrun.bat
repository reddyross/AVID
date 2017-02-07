@ECHO off
@TITLE BMOCBot
CD /D %~dp0NadekoBot\src\NadekoBot
dotnet run --configuration Release
ECHO BMOC-Bot has been succesfully stopped, press any key to close this window.
TITLE BMOC - Stopped
CD /D %~dp0
PAUSE >nul 2>&1
del NadekoRunNormal.bat
