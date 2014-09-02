@echo off

rem envars
rem Batch file that sets environment variables for the build tool
rem Set each location according to the locations for each of the
rem install locations for your system

rem QBIN (Qt mingw bin directory)
rem ISS (Inno Setup Home Directory)
rem CURDIR (The current directory) - No need changing this one.

echo Setting QBIN directory..
set QBIN=C:\Qt\5.3\mingw482_32\bin
echo Setting ISS directory..
set ISS="C:\Program Files (x86)\Inno Setup 5"
echo Setting CURDIR directory..
set CURDIR=%~dp0
echo Setting MBIN directory..
set MBIN=%CURDIR%\md5_win32_bin\bin
echo.
