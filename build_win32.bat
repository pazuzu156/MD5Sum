@echo off

rem build_win32 v2
rem Build tool for compiling source and win32 installer
rem Requires envars.bat to get it's environment variables.

rem Use envars.bat to set the locations for the required tools
rem for your system setup.

echo.
echo Begining compilation of MD5Sum
echo.
goto setup

:setup
echo Setting up environment for build
echo.
call envars.bat
echo Environment setup complete
echo.
goto compile

:compile
echo Compiling version 32 bit...
%QBIN%\qmake %CURDIR%\src\MD5Sum.pro
make
echo.
echo Copying exe to destination..
copy /Y %CURDIR%\release\MD5Sum.exe %MBIN%\MD5Sum.exe
echo.
goto getlibs

:getlibs
echo Obtaining Qt libraries...
echo.
rem Really, only need to copy once, because we're not deleting them
rem However, I don't feel like creating any if statements,
rem so we'll just let it copy anyhow..
copy /Y %QBIN%\icudt52.dll %MBIN%\icudt52.dll
copy /Y %QBIN%\icuin52.dll %MBIN%\icuin52.dll
copy /Y %QBIN%\icuuc52.dll %MBIN%\icuuc52.dll
copy /Y %QBIN%\libgcc_s_dw2-1.dll %MBIN%\libgcc_s_dw2-1.dll
copy /Y "%QBIN%\libstdc++-6.dll" "%MBIN%\libstdc++-6.dll"
copy /Y %QBIN%\libwinpthread-1.dll %MBIN%\libwinpthread-1.dll
copy /Y %QBIN%\Qt5Core.dll %MBIN%\Qt5Core.dll
copy /Y %QBIN%\Qt5Gui.dll %MBIN%\Qt5Gui.dll
copy /Y %QBIN%\Qt5Widgets.dll %MBIN%\Qt5Widgets.dll
copy /Y %QBIN%\..\plugins\platforms\qwindows.dll %MBIN%\platforms\qwindows.dll
echo.
echo Libraries obtained.
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
