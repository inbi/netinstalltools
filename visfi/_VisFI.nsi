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
Name "Visual FastInst"

; The file to write
OutFile "VisFI.exe"

; The default installation directory
InstallDir $PROGRAMFILES\FlatByte\VisFI

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKLM "Software\FlatByte\VisFI" "Install_Dir"

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
  File ".\VisFI.hta"
  
  ; Write the installation path into the registry
  WriteRegStr HKLM SOFTWARE\FlatByte\VisFI "Install_Dir" "$INSTDIR"
  
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\VisFI" "DisplayName" "Visual FastInst"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\VisFI" "DisplayIcon" "$WINDIR\system32\accwiz.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\VisFI" "DisplayVersion" "1.1"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\VisFI" "Publisher" "FlatByte IT-Consulting"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\VisFI" "URLInfoAbout" "www.flatbyte.com"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\VisFI" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\VisFI" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\VisFI" "NoRepair" 1
  WriteUninstaller "uninstall.exe"
  
SectionEnd

; Optional section (can be disabled by the user)
Section "Start Menu Shortcuts"
  SetShellVarContext all
  CreateDirectory "$SMPROGRAMS\FlatByte"
  ;CreateShortCut "$SMPROGRAMS\FlatByte\Visual FastInst\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe" 0
  CreateShortCut "$SMPROGRAMS\FlatByte\Visual FastInst.lnk" "$INSTDIR\VisFI.hta" "" "$WINDIR\system32\accwiz.exe" 0
  
SectionEnd

;--------------------------------

; Uninstaller

Section "Uninstall"
  SetShellVarContext all  
  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\VisFI"
  DeleteRegKey HKLM "SOFTWARE\FlatByte\VisFI"
  DeleteRegKey HKCU "SOFTWARE\FlatByte\VisFI"

  ; Remove files and uninstaller
  Delete $INSTDIR\VisFI.hta
  Delete $INSTDIR\uninstall.exe

  ; Remove shortcuts, if any
  Delete "$SMPROGRAMS\FlatByte\Visual Fast*.*"

  ; Remove directories used
  RMDir "$SMPROGRAMS\FlatByte\Visual FastInst"
  RMDir "$SMPROGRAMS\FlatByte"
  RMDir "$INSTDIR"

SectionEnd
