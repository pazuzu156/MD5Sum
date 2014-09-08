# MD5Sum
The readme file for MD5Sum and build instructions

## Table of Contents
* [Getting tools](#gettings-tools)
* [Libs You Need](#libs-you-need)
* [Compiler](#compiler)
* [Contributors](#contributors)

## Getting Tools

MD5Sum is built using MinGW32 compiler from Qt via QMAKE. Please be sure you have that package of Qt installed onto the system before attempting to compile MD5Sum.

To build, you need three different tools:

1. Qt - Compiler and IDE (For programming and graphical UI building)
2. GnuMake for Win32 (For compiling and generating exe)
3. Inno Setup (For building installer via iss install script)
4. MinGW (Contains g++ compiler for Qt project)

Internet shortcuts are provided for all four tools, but not the tools themselves.  

~~GnuMake needs to be placed inside the base directory for the project, namely the one with build_win32.bat~~

compiler.exe will use GnuMake if you've installed it onto your system. If it cannot be found via compiler.ini, then it will default to the current directory the compiler is run in.

It's simple, install Qt, install Inno Setup, and paste GnuMake along with its dependencies (two dlls) if it's not installed, and run compiler.exe

## Libs You Need
You will need several libraries that are included in Qt.  
Follow this structure:

```
md5_win32_bin\bin\platforms\qwindows32.dll
md5_win32_bin\bin\icudt52.dll
md5_win32_bin\bin\icuin52.dll
md5_win32_bin\bin\icuuc52.dll
md5_win32_bin\bin\libgcc_s_dw2-1.dll
md5_win32_bin\bin\libstdc++-6.dll
md5_win32_bin\bin\libwinpthread-1.dll
md5_win32_bin\bin\Qt5Core.dll
md5_win32_bin\bin\Qt5Gui.dll
md5_win32_bin\bin\Qt5Widgets.dll
```

This will allow the compiler to successfully build the installer  
However, build tool v3 copies these libs, so it isn't needed to copy yourself, the build tool will handle this. You will however still need to obtain the MfW libs and exe on your own.

## Compiler
As of build tool v3, codenamed "compiler", everything is done with just opening compiler.exe. You may need to configure compiler.ini, so look at ini.txt for instructions on how the ini configuration file works for the compiler.

Make sure both Qt and Inno Setup are installed on the system. If you installed them in a different directory, edit compiler.ini to reflect those locations.

## Contributors
[Pazuzu156](https://github.com/pazuzu156)
