@echo off
echo.
echo Begining compilation of MD5Sum
echo.
goto setup

:setup
echo Setting up environment for build
echo.
set BIN32=C:\Qt\5.3\mingw482_32\bin
set ISS="C:\Program Files (x86)\Inno Setup 5"
set CURDIR=%~dp0
echo Environment setup complete
echo.
goto compile

:compile
echo Compiling version 32 bit...
%BIN32%\qmake %CURDIR%\src\MD5Sum.pro
make
echo.
echo Copying exe to destination..
copy /Y %CURDIR%\release\MD5Sum.exe %CURDIR%\md5_win32_bin\bin\MD5Sum.exe
echo.
echo.
goto build

:build
echo Creating installer..
echo.
%ISS%\iscc /qp /omd5_win32_bin\release md5_win32_bin\md5sum_setup.iss
echo.
echo Build complete!
echo.
goto clean

:clean
echo Cleaning up..
echo.
make clean
del /F Makefile
del /F Makefile.Debug
del /F Makefile.Release
del /F object_script.MD5Sum.Debug
del /F object_script.MD5Sum.Release
del /F md5_win32_bin\bin\MD5Sum.exe
rmdir /S /Q debug
rmdir /S /Q release
cls
echo.
echo Build 100% successfull!
echo Setup file can be found at:
echo %CURDIR%md5_win32_bin\release
echo.
pause