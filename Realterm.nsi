; Script generated by the HM NIS Edit Script Wizard.
; Script to build Realterm Installer.
; Script signs exe's and extracts version numbers. Needs batch files and sign tool to do this.

!define PRODUCT_NAME "Realterm"
!define SOURCEDIR "c:\l\DXE10\a\realterm"
!system " $\"%ProgramFiles%\BEL\GetVersionInfo\GetVersionInfo.exe$\" ${SOURCEDIR}\${PRODUCT_NAME}.exe VersionInfo.nsh $\"!define PRODUCT_VERSION $\" "
!include VersionInfo.nsh
!system " $\"%ProgramFiles%\BEL\GetVersionInfo\GetVersionInfo.exe$\" ${SOURCEDIR}\${PRODUCT_NAME}.exe ThisVersionNumber.txt "
; HM NIS Edit Wizard helper defines
!ifndef PRODUCT_VERSION  ;if passed on command line or found fron exe
  !define PRODUCT_VERSION "3.0.0.XXX"  ;now passed in from the build file
!endif
!define OUTFILE "${SOURCEDIR}\${PRODUCT_NAME}_${PRODUCT_VERSION}_setup.exe"

; ---- Now do signing --------
!system "sign.bat ${SOURCEDIR}\${PRODUCT_NAME}.exe"  ;sign exe itself (before putting in installer)
!include PostExec.nsh  ;to sign installer http://nsis.sourceforge.net/Run_Command_After_Compilation
${PostExec2} ${SOURCEDIR}\installer\sign.bat ${OUTFILE} ; sign the installer after it has been created (this launches and waits until installer is built)
;-------
!define PRODUCT_PUBLISHER "Broadcast Equipment"
!define PRODUCT_WEB_SITE "http://realterm.sourceforge.net"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\realterm.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
!define PRODUCT_STARTMENU_REGVAL "NSIS:StartMenuDir"

SetCompressor /SOLID lzma
SetCompressorDictSize 64
SetDatablockOptimize ON

; MUI 1.67 compatible ------
!include "MUI2.nsh"     ;was MUI.nsh
!include FontReg.nsh
!include "GetDotNetDir.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${SOURCEDIR}\scap_cap1.ico"
!define MUI_UNICON "${SOURCEDIR}\scap_cap1.ico"

; Welcome page
!define MUI_WELCOMEPAGE_TITLE "Welcome to ${PRODUCT_NAME} ${PRODUCT_VERSION} setup"
!define MUI_WELCOMEPAGE_TITLE_3LINES
!insertmacro MUI_PAGE_WELCOME
; Components page
;!define MUI_PAGE_HEADER_TEXT foo
;!define MUI_PAGE_HEADER_SUBTEXT bar
!insertmacro MUI_PAGE_COMPONENTS
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Start menu page
var ICONS_GROUP
!define MUI_STARTMENUPAGE_NODISABLE
!define MUI_STARTMENUPAGE_DEFAULTFOLDER "Realterm"
!define MUI_STARTMENUPAGE_REGISTRY_ROOT "${PRODUCT_UNINST_ROOT_KEY}"
!define MUI_STARTMENUPAGE_REGISTRY_KEY "${PRODUCT_UNINST_KEY}"
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "${PRODUCT_STARTMENU_REGVAL}"
!insertmacro MUI_PAGE_STARTMENU Application $ICONS_GROUP
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES

; Finish page
; force Realterm Install to run by remving checkbox option
!define MUI_PAGE_CUSTOMFUNCTION_SHOW FinishPage_Show
!define MUI_FINISHPAGE_RUN "$INSTDIR\realterm.exe"
!define MUI_FINISHPAGE_RUN_PARAMETERS "install"
!define MUI_FINISHPAGE_RUN_TEXT "See Full Install Tour"
;COM server now registered in SEC01 when exe is installed. So user can't fail to install it
;!define MUI_FINISHPAGE_RUN_FUNCTION RunRealtermFn
!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\Readme.txt"
;!define MUI_FINISHPAGE_SHOWREADME  ;using a fn to launch readme and changelog
;!define MUI_FINISHPAGE_SHOWREADME_FUNCTION ShowReadmeFn
!define MUI_FINISHPAGE_LINK "Realterm Website: Documentation and Help"
!define MUI_FINISHPAGE_LINK_LOCATION "http://realterm.sourceforge.net/"

!insertmacro MUI_PAGE_FINISH

Function FinishPage_Show
  ShowWindow $mui.FinishPage.Run ${SW_HIDE}  ;hide the run checkbox and label
FunctionEnd


!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"

; Reserve files
;!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS   ;mui1
;!insertmacro RESERVEFILE_INSTALLOPTIONS  ;mui2

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "${OUTFILE}"
InstallDir "$PROGRAMFILES\BEL\Realterm\"

InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show
InstType "Normal"
InstType "Full"

;------ Code to check and request admin level... http://stackoverflow.com/questions/8732019/how-do-you-request-administrator-permissions-using-nsis
RequestExecutionLevel admin ;Require admin rights on NT6+ (When UAC is turned on)
                                                                    ;
!include LogicLib.nsh

Function .onInit
UserInfo::GetAccountType
pop $0
${If} $0 != "admin" ;Require admin rights on NT4+
    MessageBox mb_iconstop "Administrator rights required!"
    SetErrorLevel 740 ;ERROR_ELEVATION_REQUIRED
    Quit
${EndIf}
FunctionEnd
;---------

Section "MainSection" SEC01
  SectionIn 1 2
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  File "${SOURCEDIR}\realterm.exe"
  File "${SOURCEDIR}\Readme.txt"
  File "${SOURCEDIR}\change_log.txt"
  File "${SOURCEDIR}\term_hex.FON"
  File "${SOURCEDIR}\Keymap_VT100_BS.txt"
  File "${SOURCEDIR}\installer\ThisVersionNumber.txt"
  ExecShell "" "$INSTDIR\realterm.exe" "/regserver" ;register the COM server

  SetOutPath "$APPDATA\Realterm"
  SetOverwrite off
  File "${SOURCEDIR}\macros\*.ini"
  SetOverwrite ifnewer
  File "${SOURCEDIR}\macros\Macros_and_INI_files.txt"

; Shortcuts
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
  CreateDirectory "$SMPROGRAMS\$ICONS_GROUP"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\Realterm.lnk" "$INSTDIR\realterm.exe"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\Realterm I2C.lnk" "$INSTDIR\realterm.exe" "tab=I2C flow=2"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\Realterm I2C via USB.lnk" "$INSTDIR\realterm.exe" "port=\VCP0 tab=I2C flow=2"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\Realterm HalfDuplex RTSCTS.lnk" "$INSTDIR\realterm.exe" "half=1 flow=2"
;  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\Realterm NO Port Scan.lnk" "$INSTDIR\realterm.exe" "scanports=0"
  CreateShortCut "$DESKTOP\Realterm.lnk" "$INSTDIR\realterm.exe"
  !insertmacro MUI_STARTMENU_WRITE_END
;install font directly into windows..
   StrCpy $FONT_DIR $FONTS
  !cd "${SOURCEDIR}\"
  !insertmacro InstallFONFont "term_hex.FON"  "Terminal_Hex 9"
   SendMessage ${HWND_BROADCAST} ${WM_FONTCHANGE} 0 0 /TIMEOUT=5000


SectionEnd


Section "Utilities" SEC03
  SectionIn 1 2
  SetOutPath "$INSTDIR\utils"
  SetOverwrite ifnewer
  File /r "${SOURCEDIR}\utils\*.*"

; Shortcuts
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
  !insertmacro MUI_STARTMENU_WRITE_END
SectionEnd

Section "Examples" SEC02
  SectionIn 1 2
  SetOutPath "$INSTDIR\examples"
  SetOverwrite ifnewer
  File /r "${SOURCEDIR}\examples\*.*"

; Shortcuts
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
  !insertmacro MUI_STARTMENU_WRITE_END
SectionEnd

Section "Aux Wrapper" SEC05
  SectionIn  2

  SetOutPath "$INSTDIR\wrapper"
  SetOverwrite ifnewer
  File "${SOURCEDIR}\RealtermWrapper\*.*"
  call RegisterWrapper
SectionEnd


Section "Source" SEC04
  SectionIn 2
  SetOutPath "$INSTDIR\source"
  SetOverwrite on
  File "${SOURCEDIR}\RTAboutBox.pas"
  File "${SOURCEDIR}\RTAboutBox.dfm"
  File "${SOURCEDIR}\RealtermIntf.pas"
  File "${SOURCEDIR}\Realterm_TLB.pas"
  File "${SOURCEDIR}\realterm.ridl"
  File "${SOURCEDIR}\realterm.tlb"
  File "${SOURCEDIR}\realterm.res"
  File "${SOURCEDIR}\realterm.dpr"
  File "${SOURCEDIR}\realterm.dproj"
  File "${SOURCEDIR}\realterm1.res"
  File "${SOURCEDIR}\realterm1.pas"
  File "${SOURCEDIR}\realterm1.dfm"
  File "${SOURCEDIR}\PicProgN.pas"
  File "${SOURCEDIR}\ModbusCRC.pas"
  File "${SOURCEDIR}\CRC.pas"
  File "${SOURCEDIR}\CRC8.pas"
  File "${SOURCEDIR}\M545X.pas"
  File "${SOURCEDIR}\EscapeString.pas"
  File "${SOURCEDIR}\ADSpcEmu.pas"
  File "${SOURCEDIR}\change_log.txt"
  File "${SOURCEDIR}\SpyNagDialog.pas"
  File "${SOURCEDIR}\SpyNagDialog.dfm"
  File "${SOURCEDIR}\ScanPorts.pas"
  File "${SOURCEDIR}\ScanPorts.dfm"
  File "${SOURCEDIR}\HexEmulator.pas"
  File "${SOURCEDIR}\HexStringForm.pas"
  File "${SOURCEDIR}\HexStringForm.dfm"
  File "${SOURCEDIR}\installer\Realterm.nsi"
  File "${SOURCEDIR}\Checksums.pas"
  File "${SOURCEDIR}\ComportFinder.pas"
  File "${SOURCEDIR}\I2CX.pas"
  File "${SOURCEDIR}\Baudot.pas"
  File "${SOURCEDIR}\I2CMemFrame.pas"
  File "${SOURCEDIR}\I2CMemFrame.dfm"
  File "${SOURCEDIR}\ParameterHandler.pas"
  File "${SOURCEDIR}\Parameter_INI_Dialog.pas"
  File "${SOURCEDIR}\Parameter_INI_Dialog.dfm"
  File "${SOURCEDIR}\GlobalHotkeys.pas"
  File "${SOURCEDIR}\Helpers.pas"
  File "${SOURCEDIR}\TimeStamps.pas"
  File "${SOURCEDIR}\FilenameList.pas"
  File "${SOURCEDIR}\BL233_EEProm.pas"
  File "${SOURCEDIR}\BL233_EEProm.dfm"
  File "${SOURCEDIR}\DeviceChangeNotifier.pas"
  File "${SOURCEDIR}\CodeSignChecker1.pas"
  File "${SOURCEDIR}\RTUpdate1.pas"
  File "${SOURCEDIR}\NoSleep.pas"
  File "${SOURCEDIR}\InstallTourDlg1.pas"
  File "${SOURCEDIR}\InstallTourDlg1.dfm"
  File "${SOURCEDIR}\ParameterMatch.pas"

  SetOutPath "$INSTDIR\source\comps\"
  File "${SOURCEDIR}\comps\commandline_parser_parsv1-2\Source\Paramlst.pas"
  ; File "${SOURCEDIR}\comps\AFVersionCaption\AFVersionCaption.pas"
  SetOutPath "$INSTDIR\source\iconss\"
  File "${SOURCEDIR}\icons\*.ico"
  SetOutPath "$INSTDIR\source\comps\turbopower\"
  File "${SOURCEDIR}\..\..\units\AsyncPro\source\ADTrmEmu.pas"
  File "${SOURCEDIR}\..\..\units\AsyncPro\source\AdMeter.pas"
  File "${SOURCEDIR}\..\..\units\AsyncPro\source\AwTPcl.pas"
  File "${SOURCEDIR}\..\..\units\AsyncPro\source\AwAbsPcl.pas"
  File "${SOURCEDIR}\..\..\units\AsyncPro\source\AdExcept.pas"
  File "${SOURCEDIR}\..\..\units\AsyncPro\source\AdPacket.pas"
  File "${SOURCEDIR}\..\..\units\AsyncPro\source\AwAscii.pas"
  File "${SOURCEDIR}\..\..\units\AsyncPro\source\OOMisc.pas"
  File "${SOURCEDIR}\..\..\units\AsyncPro\source\AdTrmVT1_BS.rc"
  File "${SOURCEDIR}\..\..\units\AsyncPro\source\AdTrmVT1_BS.bin"
  File "${SOURCEDIR}\..\..\units\AsyncPro\source\AdTrmVT1_BS.txt"
  File "${SOURCEDIR}\..\..\units\AsyncPro\source\LnsWin32.pas"
  File "${SOURCEDIR}\..\..\units\AsyncPro\source\awuser.pas"
  File "${SOURCEDIR}\..\..\units\AsyncPro\source\AdPort.pas"
  File "${SOURCEDIR}\..\..\units\AsyncPro\source\AdWnPort.pas"


  SetOutPath "$INSTDIR\source\icons\"
  File "${SOURCEDIR}\icons\*.ico"
; Shortcuts
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
  !insertmacro MUI_STARTMENU_WRITE_END
SectionEnd

Section "DLPortIO" SEC06
  SectionIn 2
  SetOutPath "$INSTDIR\dlportio"
  SetOverwrite on

  File "${SOURCEDIR}\comps\dlportio\DriverLINX\drivers\Install_dlportio.exe"
  File "${SOURCEDIR}\comps\dlportio\DriverLINX\drivers\dlportio.dll"
  File "${SOURCEDIR}\comps\dlportio\DriverLINX\drivers\dlportio.sys"
  File "${SOURCEDIR}\comps\dlportio\DLPortIO.pdf"
; Shortcuts
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
  !insertmacro MUI_STARTMENU_WRITE_END
SectionEnd

Section -AdditionalIcons
  SetOutPath $INSTDIR
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\Readme.lnk" "$INSTDIR\Readme.txt"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\Change Log.lnk" "$INSTDIR\change_log.txt"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\Uninstall.lnk" "$INSTDIR\uninst.exe"
  !insertmacro MUI_STARTMENU_WRITE_END
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\realterm.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\realterm.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"


SectionEnd

; Section descriptions
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC01} "Executeables"
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC03}  "Utilities for batch file support and I2C eeprom programming"
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC02} "Script files demonstrating controlling Realterm from a variety of languages"

;  !insertmacro MUI_DESCRIPTION_TEXT ${SEC05} "Installs Term_Hex fonts, which have chars for every byte. Also useful in editors for diplaying control codes"
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC05} "[REMOVED] Auxillary COM wrapper to support callbacks to Internet Explorer."
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC04} "Compiling requires Delphi Berlin 10.1, and will also require additional components that are not included here."
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC06} "Only required for BEL Dual PIC Programmer support"
!insertmacro MUI_FUNCTION_DESCRIPTION_END


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  !insertmacro MUI_STARTMENU_GETFOLDER "Application" $ICONS_GROUP
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"

  Delete "$INSTDIR\Install.exe"
;  Delete "$INSTDIR\DLPORTIO.sys"
;  Delete "$INSTDIR\DLPORTIO.dll"
  Delete "$INSTDIR\Readme.txt"
  Delete "$INSTDIR\change_log.txt"
  Delete "$INSTDIR\realterm.exe"
  Delete "$INSTDIR\hexcsv2dec.exe"
  Delete "$INSTDIR\term_hex.FON"

  Delete "$INSTDIR\source\SpyNagDialog.dfm"
  Delete "$INSTDIR\source\SpyNagDialog.pas"
  Delete "$INSTDIR\source\change_log.txt"
  Delete "$INSTDIR\source\ADSpcEmu.pas"
  Delete "$INSTDIR\source\EscapeString.pas"
  Delete "$INSTDIR\source\M545X.pas"
  Delete "$INSTDIR\source\ModbusCRC.pas"
  Delete "$INSTDIR\source\CRC8.pas"
  Delete "$INSTDIR\source\PicProgN.pas"
  Delete "$INSTDIR\source\realterm1.dfm"
  Delete "$INSTDIR\source\realterm1.pas"
  Delete "$INSTDIR\source\realterm1.res"
  Delete "$INSTDIR\source\realterm.dpr"
  Delete "$INSTDIR\source\realterm.res"
  Delete "$INSTDIR\source\realterm.tlb"
  Delete "$INSTDIR\source\Realterm_TLB.pas"
  Delete "$INSTDIR\source\RealtermIntf.pas"
  Delete "$INSTDIR\source\RTAboutBox.dfm"
  Delete "$INSTDIR\source\RTAboutBox.pas"
  Delete "$INSTDIR\source\Realterm.nsi"
  Delete "$INSTDIR\source\ScanPorts.pas"
  Delete "$INSTDIR\source\ScanPorts.dfm"
  Delete "$INSTDIR\source\HexEmulator.pas"
  Delete "$INSTDIR\source\Checksums.pas"
  Delete "$INSTDIR\source\ComportFinder.pas"
  Delete "$INSTDIR\source\I2CX.pas"
  Delete "$INSTDIR\source\I2CMemFrame.pas"
  Delete "$INSTDIR\source\I2CMemFrame.dfm"

  Delete "$INSTDIR\dlportio\Install_dlportio.exe"
  Delete "$INSTDIR\dlportio\DLPortIO.pdf"


  Delete "$SMPROGRAMS\$ICONS_GROUP\Uninstall.lnk"
  Delete "$SMPROGRAMS\$ICONS_GROUP\Website.lnk"
  Delete "$DESKTOP\Realterm.lnk"
  Delete "$SMPROGRAMS\$ICONS_GROUP\*.lnk"

  RMDir /r "$SMPROGRAMS\$ICONS_GROUP"
  RMDir "$INSTDIR\dlportio"
  RMDir "$INSTDIR\source"
;leave utils and examples, as user might be editing these....
  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
SectionEnd
;-------------------------------

Function RegisterWrapper
        ; get directory of .NET framework installation
        Push "v2.0"
        Call GetDotNetDir
        Pop $R0 ; .net framework v2.0 installation directory
        StrCmpS "" $R0 err_dot_net_not_found

        ; Perform our install
        ; e.g. use the .Net path in $R0 to call RegAsm.exe
        ;SetOutPath "$INSTDIR\wrapper"
        ;File "RealtermWrapper.dll"
        ExecWait '"$R0\RegAsm.exe" "$INSTDIR\wrapper\RealtermWrapper.dll" /codebase'

        Return

err_dot_net_not_found:
        MessageBox MB_OK "Failed to register RealtermWrapper,$\r$\n \
                   .Net framework not found   $\r$\n"
FunctionEnd
;----------
;Function ShowReadmeFn
;  ;ExecShell "" "$INSTDIR\change_log.txt"  ; install option
;  ExecShell "" "$INSTDIR\Readme.txt"
;FunctionEnd

;--------------
;Function RunRealtermFn
;  MessageBox MB_OK "Register COM Servers $\r$\n \
;                   SMPROGRAMS: $SMPROGRAMS  $\r$\n \
;                   Start Menu Folder: $STARTMENU_FOLDER $\r$\n \
;                   InstallDirectory: $INSTDIR "
;  ExecShell "" "$INSTDIR\realterm.exe" "/regserver"
;  ExecShell "" "$INSTDIR\realterm.exe" "install"
;FunctionEnd
;------------------
