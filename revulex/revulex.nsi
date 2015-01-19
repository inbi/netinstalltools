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
Name "Revulex"

; The file to write
OutFile "Revulex.exe"

; The default installation directory
InstallDir $PROGRAMFILES\FlatByte\Revulex

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKLM "Software\FlatByte\Revulex" "Install_Dir"

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
  File ".\Revulex.hta"
  File ".\NidImport.hta"
  File ".\faq.html"
  File ".\revulex.asp"
  File ".\*.txt"
  File ".\ta*.png"
  File ".\s*.png"
  File ".\bg.jpg"
  
  ; Write the installation path into the registry
  WriteRegStr HKLM SOFTWARE\FlatByte\Revulex "Install_Dir" "$INSTDIR"
  
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Revulex" "DisplayName" "Revulex (for NetInstall)"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Revulex" "DisplayIcon" "$WINDIR\system32\rtcshare.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Revulex" "DisplayVersion" "1.0"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Revulex" "Publisher" "FlatByte IT-Consulting"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Revulex" "URLInfoAbout" "www.flatbyte.com"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Revulex" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Revulex" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Revulex" "NoRepair" 1
  WriteUninstaller "uninstall.exe"
  
SectionEnd

; Optional section (can be disabled by the user)
Section "Start Menu Shortcuts"
  SetShellVarContext all
  CreateDirectory "$SMPROGRAMS\FlatByte\Revulex"
  CreateShortCut "$SMPROGRAMS\FlatByte\Revulex\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe" 0
  CreateShortCut "$SMPROGRAMS\FlatByte\Revulex\Revulex.lnk" "$INSTDIR\Revulex.hta" "" "$WINDIR\system32\rtcshare.exe" 0
  CreateShortCut "$SMPROGRAMS\FlatByte\Revulex\NID Importer.lnk" "$INSTDIR\NidImport.hta" "" "$WINDIR\system32\rsnotify.exe" 0
  CreateShortCut "$SMPROGRAMS\FlatByte\Revulex\FAQ.lnk" "$INSTDIR\faq.html" "" "" 0
  CreateShortCut "$SMPROGRAMS\FlatByte\Revulex\SQL Tables.lnk" "$INSTDIR\sql_tables.txt" "" "" 0
  CreateShortCut "$SMPROGRAMS\FlatByte\Revulex\SQL Views.lnk" "$INSTDIR\sql_views.txt" "" "" 0
  CreateShortCut "$SMPROGRAMS\FlatByte\Revulex\Tabellenbeziehungen.lnk" "$INSTDIR\sql_table_relationship.png" "" "" 0
  CreateShortCut "$SMPROGRAMS\FlatByte\Revulex\GNU Lizenz.lnk" "http://www.gnu.org/licenses/gpl.html" "" "" 0

  
SectionEnd

;--------------------------------

; Uninstaller

Section "Uninstall"
  SetShellVarContext all  
  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Revulex"
  DeleteRegKey HKLM "SOFTWARE\FlatByte\Revulex"

  ; Remove files and uninstaller
  Delete $INSTDIR\revulex.hta
  Delete $INSTDIR\uninstall.exe
  Delete $INSTDIR\revulex.asp        
  Delete $INSTDIR\nidimport.hta  
  Delete $INSTDIR\*.txt
  Delete $INSTDIR\faq.html  
  Delete $INSTDIR\*.png
  Delete $INSTDIR\*.log
  Delete $INSTDIR\*.jpg


  ; Remove shortcuts, if any
  Delete "$SMPROGRAMS\FlatByte\Revulex\*.*"

  ; Remove directories used
  RMDir "$SMPROGRAMS\FlatByte\Revulex"
  RMDir "$SMPROGRAMS\FlatByte"
  RMDir "$INSTDIR"

SectionEnd
