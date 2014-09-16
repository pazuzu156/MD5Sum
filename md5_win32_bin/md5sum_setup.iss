#define AppName "MD5Sum"
; #define MyAppVersion "1.0.1"
#define Publisher "Kaleb Klein"
#define AppURL "http://www.kalebklein.com"
#define AppEXE "MD5Sum.exe"

[Setup]
AppId={{59F5B31A-8CCF-4541-AB31-F200C18AC3FC}
AppName={#AppName}
AppVersion={#Version}
AppVerName={#AppName} {#Version}
AppPublisher={#Publisher}
AppPublisherURL={#AppURL}
AppSupportURL={#AppURL}
AppUpdatesURL={#AppURL}
DefaultDirName={pf}\{#AppName}
DefaultGroupName={#AppName}
LicenseFile=bin\license.txt
OutputBaseFilename=md5sum_setup
SetupIconFile=bin\gear.ico
WizardSmallImageFile=bin\gear.bmp
WizardImageFile=bin\gear_big.bmp
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Types]
Name: "full"; Description: "Default Installation"
Name: "source"; Description: "Include source code for {#AppName}"; Flags: iscustom

[Components]
Name: "app"; Description: "Default installation"; Types: full source; Flags: fixed
Name: "src"; Description: "Include Source Code"; Types: source

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1

[Files]
Source: "bin\MD5Sum.exe"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: app
Source: "bin\platforms\qwindows.dll"; DestDir: "{app}\platforms"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: app

; ================
; Source
; ================

; about dialog
Source: "..\src\aboutdialog.cpp"; DestDir: "{app}\src"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: src
Source: "..\src\aboutdialog.h"; DestDir: "{app}\src"; Flags: ignoreversion; Components: src
Source: "..\src\aboutdialog.ui"; DestDir: "{app}\src"; Flags: ignoreversion; Components: src

; checksum generator
Source: "..\src\checksumgenerator.cpp"; DestDir: "{app}\src"; Flags: ignoreversion; Components: src
Source: "..\src\checksumgenerator.h"; DestDir: "{app}\src"; Flags: ignoreversion; Components: src
Source: "..\src\checksumgenerator.ui"; DestDir: "{app}\src"; Flags: ignoreversion; Components: src

; main window
Source: "..\src\mainwindow.cpp"; DestDir: "{app}\src"; Flags: ignoreversion; Components: src
Source: "..\src\mainwindow.h"; DestDir: "{app}\src"; Flags: ignoreversion; Components: src
Source: "..\src\mainwindow.ui"; DestDir: "{app}\src"; Flags: ignoreversion; Components: src

; validation thread
Source: "..\src\validationthread.cpp"; DestDir: "{app}\src"; Flags: ignoreversion; Components: src
Source: "..\src\validationthread.h"; DestDir: "{app}\src"; Flags: ignoreversion; Components: src

; Extras
Source: "..\src\main.cpp"; DestDir: "{app}\src"; Flags: ignoreversion; Components: src
Source: "..\src\gear.png"; DestDir: "{app}\src"; Flags: ignoreversion; Components: src
Source: "..\src\gear.ico"; DestDir: "{app}\src"; Flags: ignoreversion; Components: src
Source: "..\src\gear_icon_resource.qrc"; DestDir: "{app}\src"; Flags: ignoreversion; Components: src
Source: "..\src\icon.rc"; DestDir: "{app}\src"; Flags: ignoreversion; Components: src
Source: "..\src\MD5Sum.pro"; DestDir: "{app}\src"; Flags: ignoreversion; Components: src

; Rest of stuff
Source: "bin\source.txt"; DestDir: "{app}"; Flags: ignoreversion; Components: src
Source: "bin\libgcc_s_dw2-1.dll"; DestDir: "{app}"; Flags: ignoreversion; Components: app
Source: "bin\libstdc++-6.dll"; DestDir: "{app}"; Flags: ignoreversion; Components: app
Source: "bin\libwinpthread-1.dll"; DestDir: "{app}"; Flags: ignoreversion; Components: app
Source: "bin\gear.ico"; DestDir: "{app}"; Flags: ignoreversion; Components: app
Source: "bin\icudt52.dll"; DestDir: "{app}"; Flags: ignoreversion; Components: app
Source: "bin\icuin52.dll"; DestDir: "{app}"; Flags: ignoreversion; Components: app
Source: "bin\icuuc52.dll"; DestDir: "{app}"; Flags: ignoreversion; Components: app
Source: "bin\license.txt"; DestDir: "{app}"; Flags: ignoreversion; Components: app
Source: "bin\MD5Sum.exe"; DestDir: "{app}"; Flags: ignoreversion; Components: app
Source: "bin\Qt5Core.dll"; DestDir: "{app}"; Flags: ignoreversion; Components: app
Source: "bin\Qt5Gui.dll"; DestDir: "{app}"; Flags: ignoreversion; Components: app
Source: "bin\Qt5Widgets.dll"; DestDir: "{app}"; Flags: ignoreversion; Components: app
Source: "bin\Qt5Network.dll"; DestDir: "{app}"; Flags: ignoreversion; Components: app

[Icons]
Name: "{group}\{#AppName}"; Filename: "{app}\{#AppEXE}"
Name: "{group}\{cm:ProgramOnTheWeb,{#AppName}}"; Filename: "{#AppURL}"
Name: "{group}\{cm:UninstallProgram,{#AppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#AppName}"; Filename: "{app}\{#AppEXE}"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#AppName}"; Filename: "{app}\{#AppEXE}"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\{#AppName}"; Description: "{cm:LaunchProgram,{#StringChange(AppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

