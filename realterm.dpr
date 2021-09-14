program realterm;

{$R *.dres}

uses
  sysutils,
  Forms,
  Graphics,
  PicProgN in 'PicProgN.pas',
  realterm1 in 'realterm1.pas' {Form1},
  ADSpcEmu in 'ADSpcEmu.pas',
  M545X in 'M545X.pas',
  RTAboutBox in 'RTAboutBox.pas' {AboutBox},
  EscapeString in 'EscapeString.pas',
  ModbusCRC in 'ModbusCRC.pas',
  Realterm_TLB in 'Realterm_TLB.pas',
  RealtermIntf in 'RealtermIntf.pas' {RealtermIntf: CoClass},
  SpyNagDialog in 'SpyNagDialog.pas' {SpyNagDlg},
  ScanPorts in 'ScanPorts.pas' {FormScanPorts},
  HexStringForm in 'HexStringForm.pas' {PagesDlg},
  CRC8 in 'CRC8.pas',
  HexEmulator in 'HexEmulator.pas',
  Checksums in 'Checksums.pas',
//  Sc in '..\..\units\TetaSerialCop 2.0\SOURCE\Sc.pas',
  I2Cx in 'I2Cx.pas',
  ComportFinder in 'ComportFinder.pas',
  ParameterHandler in 'ParameterHandler.pas',
  Parameter_INI_Dialog in 'Parameter_INI_Dialog.pas' {ParameterINIDlg},
  I2CMemFrame in 'I2CMemFrame.pas' {FrameI2CMem: TFrame},
  GlobalHotkeys in 'GlobalHotkeys.pas',
  Paramlst in 'comps\Paramlst.pas',
  rtUpdate1 in 'rtUpdate1.pas',
  CRC in 'CRC.pas',
  Helpers in 'Helpers.pas',
  AFVersionCaption in 'comps\AFVersionCaption\AFVersionCaption.pas',
  TimeStamps in 'TimeStamps.pas',
  ConsoleConnector in 'ConsoleConnector.pas',
  FilenameList in 'FilenameList.pas',
  BL233_EEProm in 'BL233_EEProm.pas' {BL233EEPromDlg},
  DeviceChangeNotifier in 'DeviceChangeNotifier.pas',
  CodeSignChecker1 in 'CodeSignChecker1.pas',
  PortIO in 'comps\dlportio\delphi\delphi.4\PortIO.pas',
  ADTrmEmu in 'comps\turbopower\ADTrmEmu.pas',
  Vcl.Controls in 'Vcl.Controls.pas',
  Vcl.ComCtrls in 'Vcl.ComCtrls.pas',
  adport in 'comps\turbopower\adport.pas',
  adwnPort in 'comps\turbopower\adwnPort.pas',
  NoSleep in 'NoSleep.pas',
  AwUser in 'comps\turbopower\AwUser.pas',
  InstallTourDlg1 in 'InstallTourDlg1.pas' {InstallTour};

{$R *.TLB}

{$R *.RES}

begin
  // Use delphi.mo for runtime library translations, if it is there
  //translateremoved AddDomainForResourceString('delphi');

  // This one is not needed, because 'Arial' should not be translated,
  // but is here as an example
  //translateremoved TP_GlobalIgnoreClass(TFont);
 // {$IFDEF DEBUG}ReportMemoryLeaksOnShutDown := True;{$ENDIF} //http://www.simonjstuart.com/2010/10/02/memory-leaks-delphi-please-clean-up-your-code/#DPR1
{$IFDEF DEBUG}
{$WARN SYMBOL_PLATFORM OFF}
 ReportMemoryLeaksOnShutDown := (DebugHook<> 0);
 {$WARN SYMBOL_PLATFORM ON}
 {$ENDIF}
  try
    Application.Initialize;  //regserver happens here
    except on E: exception do begin
        console.showmessage('The Realterm ActX/OLE Server must be registered once at install.'+CRLF
           +'Realterm must be run as Admin to do /regserver'+CRLF
           +CRLF
           +'Realterm is running as: '+IsUserAdminStr+CRLF
           +'Commandline is: '+CmdLine
           +CRLF
           +E.message);
        exit;
    end;
  end;
  Application.Title := 'Realterm: Serial Capture and Binary Terminal';
  Application.MainFormOnTaskbar := True;
  FormScanPorts:=TFormScanPorts.Create(Application);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TSpyNagDlg, SpyNagDlg);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TPagesDlg, PagesDlg);
  Application.CreateForm(TParameterINIDlg, ParameterINIDlg);
  Application.CreateForm(TBL233EEPromDlg, BL233EEPromDlg);
  //Application.CreateForm(TInstallTour, InstallTourDlg);
  Application.Run;
end.
