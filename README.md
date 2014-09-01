# MD5Sum
The readme file for MD5Sum and build instructions

## Table of Contents
* [Getting tools](#gettings-tools)
* [Libs You Need](#libs-you-need)
* [Contributors](#contributors)

## Getting Tools
To build, you need three different tools:

1. Qt - Compiler and IDE (For programming and graphical UI building)
2. GnuMake for Win32 (For compiling and generating exe)
3. Inno Setup (For building installer via iss install script)

Internet shortcuts are provided for all three tools, but not the tools themselves.  

GnuMake needs to be placed inside the base directory for the project, namely the one with build_win32.bat

It's simple, install Qt, install Inno Setup, and paste GnuMake along with its dependencies (two dlls) and run build_win32.bat

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

## Contributors
[Pazuzu156](https://github.com/pazuzu156)