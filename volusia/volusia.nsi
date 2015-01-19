; example2.nsi
;
; This script is based on example1.nsi, but it remember the directory, 
; has uninstall support and (optionally) installs start menu shortcuts.
;
; It will install makensisw.exe into a directory that the user selects,
Function .onInit
  SetOutPath $TEMP
  File /oname=spltmp.bmp "..\flatbyte.bmp"

; optional
; File /oname=spltmp.wav "my_splashshit.wav"

  splash::show 1500 $TEMP\spltmp

  Pop $0 ; $0 has '1' if the user closed the splash screen early,
	 ; '0' if everything closed normal, and '-1' if some error occured.

  Delete $TEMP\spltmp.bmp
;  Delete $TEMP\spltmp.wav
FunctionEnd


;--------------------------------

;LoadLanguageFile "${NSISDIR}\Contrib\Language files\German.nlf"
;LangString Name ${LANG_GERMAN} "German"

; The name of the installer
Name "Volusia"

; The file to write
OutFile "Volusia.exe"

; The default installation directory
InstallDir $PROGRAMFILES\FlatByte\Volusia

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKLM "Software\FlatByte\Volusia" "Install_Dir"

;--------------------------------

; Pages

Page components
Page directory
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

;--------------------------------

; The stuff to install
Section "Programfiles (required)"
  SetShellVarContext all   
  SectionIn RO
  
  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  ; Put file there
  File ".\volusia.hta"
  File ".\*.htm"
  File ".\ponce2.png"
  File ".\help.png"
  File ".\sc.exe"
  File ".\robocopy.exe"
  File ".\arch.jpg"
  File ".\p*.gif"
  File ".\v*.ico"
  
  ; Write the installation path into the registry
  WriteRegStr HKLM SOFTWARE\FlatByte\Volusia "Install_Dir" "$INSTDIR"
  
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Volusia" "DisplayName" "Volusia NetInstall Servermanagement"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Volusia" "DisplayIcon" "$INSTDIR\volusia.ico"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Volusia" "DisplayVersion" "1.0"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Volusia" "Publisher" "FlatByte IT-Consulting"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Volusia" "URLInfoAbout" "www.flatbyte.com"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Volusia" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Volusia" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Volusia" "NoRepair" 1
  WriteUninstaller "uninstall.exe"
  
SectionEnd

; Optional section (can be disabled by the user)
Section "Start Menu Shortcuts"
  SetShellVarContext all 
  CreateDirectory "$SMPROGRAMS\FlatByte"
  ;CreateShortCut "$SMPROGRAMS\FlatByte\Volusia\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe" 0
  CreateShortCut "$SMPROGRAMS\FlatByte\Volusia.lnk" "$INSTDIR\volusia.hta" "" "$INSTDIR\volusia.ico" 0
  
SectionEnd

;--------------------------------

; Uninstaller

Section "Uninstall"
  SetShellVarContext all 
  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Volusia"
  DeleteRegKey HKLM "SOFTWARE\FlatByte\Volusia"
  DeleteRegKey HKCU "SOFTWARE\FlatByte\Volusia"

  ; Remove files and uninstaller
  Delete $INSTDIR\*.*

  ; Remove shortcuts, if any
  Delete "$SMPROGRAMS\FlatByte\Volusi*.*"

  ; Remove directories used
  ;RMDir "$SMPROGRAMS\FlatByte\Volusia"
  RMDir "$SMPROGRAMS\FlatByte"
  RMDir "$INSTDIR"

SectionEnd
