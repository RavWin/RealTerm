unit Realterm1;
{$J+} //D7
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, AdPort, AdWnPort, AdProtcl, {AdTerm,} AdSocket, ExtCtrls, Spin,
  AdStatLt,AdWUtil, {AdIniDB,} adExcept, Paramlst, ComCtrls, ToolWin, Buttons,
  checklst, Menus, PicProgN, PortIO, {verslab,} AFVersionCaption,
  ADTrmEmu, OoMisc, Mask, AdSpcEmu, AdPStat, StBase, StWmDCpy, StFirst,
  {TVicCommUnit,} StExpr, StVInfo, AppEvnts, AdPacket, I2CMemFrame,FilenameList,
  Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Vcl.Tabs,
  Vcl.DockTabSet, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, Vcl.AppAnalytics,rtUpdate1;

type
    TIconStyle=(iconAuto,iconIdle,iconClosed,iconOpen,iconCap,iconMatch,iconSend,iconWSDisconnect);
    // Constants for enum EnumPutStringAs
type
  TSendAs = (sasLiteral, sasASCII, sasNumbers, sasHex); // Must be same as TLB declare of EnumPutStringAs = TOleEnum;
type
  TForm1 = class(TForm)
    Port1: TApdWinsockPort;
    AdEmulator_VT100: TAdVT100Emulator;
    Timer1: TTimer;
    AdEmulator_Hex: TAdTTYEmulator;
    ApdSLController1: TApdSLController;
    EchoPort: TApdWinsockPort;
    Parameter1: TParameter;
    SaveDialog1: TSaveDialog;
    StatusBar1: TStatusBar;
    PageControl1: TPageControl;
    TabSheetPort: TTabSheet;
    GroupBox2: TGroupBox;
    StopBitsGroup: TRadioGroup;
    ParityGroup: TRadioGroup;
    DataBitsGroup: TRadioGroup;
    SoftwareFlowGroup: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    ReceiveFlowBox: TCheckBox;
    TransmitFlowBox: TCheckBox;
    XonCharEdit: TEdit;
    XoffCharEdit: TEdit;
    HardwareFlowGroup: TRadioGroup;
    BitBtnSetPort: TBitBtn;
    Pins: TTabSheet;
    TabSheetSend: TTabSheet;
    Label13: TLabel;
    GroupBoxStatus: TGroupBox;
    ApdStatusLightConnected: TApdStatusLight;
    LabelConnected: TLabel;
    ApdStatusLightRxd: TApdStatusLight;
    Label6: TLabel;
    ApdStatusLightTXD: TApdStatusLight;
    LabelApdStatusTXD: TLabel;
    ApdStatusLightCTS: TApdStatusLight;
    Label8: TLabel;
    ApdStatusLightDCD: TApdStatusLight;
    Label10: TLabel;
    ApdStatusLightDSR: TApdStatusLight;
    Label11: TLabel;
    ApdStatusLightBREAK: TApdStatusLight;
    Label12: TLabel;
    ApdStatusERROR: TApdStatusLight;
    LabelApdStatusError: TLabel;
    MemoPinNumbers: TMemo;
    ApdProtocol1: TApdProtocol;
    TabSheetCapture: TTabSheet;
    GroupBoxCapture: TGroupBox;
    Label1: TLabel;
    ButtonCaptureOverwrite: TButton;
    ButtonCaptureAppend: TButton;
    ButtonCaptureStop: TButton;
    CheckBoxDirectCapture: TCheckBox;
    ComboBoxSaveFName: TComboBox;
    ButtonSaveFName: TButton;
    RadioGroupCaptureSizeUnits: TRadioGroup;
    OpenDialog1: TOpenDialog;
    PanelBaud1: TPanel;
    ComboBoxBaud: TComboBox;
    Panel2: TPanel;
    ComboBoxComPort: TComboBox;
    TabSheetEcho: TTabSheet;
    GroupBoxEchoPort: TGroupBox;
    EchoStopBitsGroup: TRadioGroup;
    EchoParityGroup: TRadioGroup;
    EchoDataBitsGroup: TRadioGroup;
    EchoSoftwareFlowGroup: TGroupBox;
    Label20: TLabel;
    Label21: TLabel;
    EchoReceiveFlowBox: TCheckBox;
    EchoTransmitFlowBox: TCheckBox;
    EchoXonCharEdit: TEdit;
    EchoXoffCharEdit: TEdit;
    EchoHardwareFlowGroup: TRadioGroup;
    BitBtnSetEchoPort: TBitBtn;
    Panel3: TPanel;
    ComboBoxEchoBaud: TComboBox;
    CheckBoxEchoOn: TCheckBox;
    ApdStatusLightRI: TApdStatusLight;
    Label22: TLabel;
    FontDialog1: TFontDialog;
    GroupBox7: TGroupBox;
    ButtonSetRTS: TButton;
    ApdStatusLightRTS: TApdStatusLight;
    ButtonClrRTS: TButton;
    GroupBox4: TGroupBox;
    ButtonSetDTR: TButton;
    ApdStatusLightDTR: TApdStatusLight;
    ButtonClearDTR: TButton;
    GroupBox8: TGroupBox;
    ButtonSetBreak: TButton;
    ButtonClearBreak: TButton;
    Button500msBreak: TButton;
    GroupBoxDiagnosticFiles: TGroupBox;
    Label24: TLabel;
    ComboBoxTraceFName: TComboBox;
    ButtonTraceFName: TButton;
    CheckBoxTrace: TCheckBox;
    CheckBoxLog: TCheckBox;
    ProgressBarCapture: TProgressBar;
    ComboBoxCaptureSize: TComboBox;
    MenuItemTitle: TMenuItem;
    MenuItemPort: TMenuItem;
    MenuItemShow: TMenuItem;
    MenuItemClose: TMenuItem;
    MenuItemCapture: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    SpeedButtonPort1Open: TSpeedButton;
    MenuItemBaud: TMenuItem;
    Panel4: TPanel;
    ComboBoxEchoPort: TComboBox;
    Label19: TLabel;
    ApdSLControllerEcho: TApdSLController;
    LabelEchoConnected: TLabel;
    ApdStatusLightEchoConnected: TApdStatusLight;
    ApdStatusLightEchoTXD: TApdStatusLight;
    Label25: TLabel;
    ApdStatusLightEchoRXD: TApdStatusLight;
    Label26: TLabel;
    N3: TMenuItem;
    MenuItemEcho: TMenuItem;
    TabSheetI2C: TTabSheet;
    HideControls1: TMenuItem;
    CheckBoxEchoPortMonitoring: TCheckBox;
    PanelFloatingButtons: TPanel;
    ButtonFreeze: TButton;
    ButtonClear: TButton;
    RadioGroupBusNum: TRadioGroup;
    ButtonIStart: TButton;
    ButtonIStop: TButton;
    ButtonIRead: TButton;
    SpinEditIBytes2Read: TSpinEdit;
    Label3: TLabel;
    ButtonIGetStatus: TButton;
    ButtonIQueryPins: TButton;
    ButtonNewLine: TButton;
    GroupBoxSendString: TGroupBox;
    ComboBoxSend1: TComboBox;
    ButtonSendNumbers1: TButton;
    ButtonSendAscii1: TButton;
    ButtonSendAscii2: TButton;
    ComboBoxSend2: TComboBox;
    SpinEditNumTimesToSend: TSpinEdit;
    CheckBoxStripSpaces: TCheckBox;
    ButtonSendNumbers2: TButton;
    Label17: TLabel;
    ButtonSMBusAlert: TButton;
    ButtonI2CGCAReset: TButton;
    TabsheetMISC: TTabSheet;
    MenuItemSend: TMenuItem;
    MenuItemSendStringAscii1: TMenuItem;
    EditSendNumeric: TEdit;
    ButtonSend0: TButton;
    ButtonSend3: TButton;
    GroupBoxGPIB: TGroupBox;
    ButtonGPIBCtrlC: TButton;
    ButtonGPIBSetup: TButton;
    ButtonGPIBRST: TButton;
    ButtonGPIBIDN: TButton;
    ButtonGPIBERR: TButton;
    ButtonGPIBTST: TButton;
    GroupBoxPP: TGroupBox;
    SpeedButtonPower: TSpeedButton;
    ApdStatusLightRB7: TApdStatusLight;
    Label23: TLabel;
    ButtonReset1: TButton;
    ButtonReset2: TButton;
    ButtonResetBoth: TButton;
    SpinEditLPT: TSpinEdit;
    ButtonOpenLPT: TButton;
    SpeedButtonSpy1: TSpeedButton;
    CheckBoxLiteralStrings: TCheckBox;
    GroupBoxIAddress: TGroupBox;
    SpinEditISubAddress: TSpinEdit;
    Label31: TLabel;
    GroupBoxSignalWsConnect: TGroupBox;
    CheckBoxSignalWsWithDTR: TCheckBox;
    CheckBoxSignalWsWithRTS: TCheckBox;
    GroupBoxNL: TGroupBox;
    CheckBoxNLBefore: TCheckBox;
    CheckBoxNLAfter: TCheckBox;
    N4: TMenuItem;
    MenuItemCopyTerminal: TMenuItem;
    MenuItemPasteTerminal: TMenuItem;
    GroupBoxIWrite: TGroupBox;
    ButtonIWrite: TButton;
    EditIData2Write: TEdit;
    StExpressionEditIW: TStExpressionEdit;
    ButtonIWByte: TButton;
    ButtonIWWordBE: TButton;
    ButtonIWWordLE: TButton;
    ButtonIWAscii: TButton;
    CheckBoxIWCompactAscii: TCheckBox;
    ButtonIWClear: TButton;
    ButtonIWrite00: TButton;
    ButtonIWriteFF: TButton;
    ButtonIWBit: TButton;
    ButtonIWNotBit: TButton;
    ButtonIWBitClear: TButton;
    SpeedButtonIWBit7: TSpeedButton;
    SpeedButtonIWBit6: TSpeedButton;
    SpeedButtonIWBit5: TSpeedButton;
    SpeedButtonIWBit4: TSpeedButton;
    SpeedButtonIWBit3: TSpeedButton;
    SpeedButtonIWBit2: TSpeedButton;
    SpeedButtonIWBit1: TSpeedButton;
    SpeedButtonIWBit0: TSpeedButton;
    RadioGroupWsTelnet: TRadioGroup;
    TimerSendFile: TTimer;
    CheckBoxClearTerminalOnPortChange: TCheckBox;
    Help1: TMenuItem;
    TabSheetI2CMisc: TTabSheet;
    GroupBox3: TGroupBox;
    ButtonI2CSend2M5451D4: TButton;
    EditI2CDigits: TEdit;
    ButtonM5451Clear: TButton;
    GroupBox6: TGroupBox;
    ButtonIRead1WireID: TButton;
    GroupBoxSensirion: TGroupBox;
    ButtonSHTReadTemp: TButton;
    ButtonSHTReadHumidity: TButton;
    ButtonSHTClear: TButton;
    CheckBoxSHTCRC: TCheckBox;
    ButtonSHTReadStatus: TButton;
    ButtonSHTSoftReset: TButton;
    CheckboxSHTWrHideAck: TCheckBox;
    ButtonSHTWriteStatus: TButton;
    EditSHTStatus: TEdit;
    CheckBoxTraceHex: TCheckBox;
    CheckBoxLogHex: TCheckBox;
    ButtonIWriteThenRead: TButton;
    SpinEditIBytes2Read2: TSpinEdit;
    Label5: TLabel;
    LabeledEditIWriteB4Data: TLabeledEdit;
    TabSheetI2C2: TTabSheet;
    GroupBoxBL301: TGroupBox;
    ButtonBL301WriteAscii2LCD: TButton;
    ButtonBL301InitLCD: TButton;
    ButtonBL301SetContrast: TButton;
    ButtonBL301SetLeds: TButton;
    ButtonBL301ReadSwitches: TButton;
    SpinEditBL301Contrast: TSpinEdit;
    SpeedButtonBL301Leds7: TSpeedButton;
    SpeedButtonBL301Leds6: TSpeedButton;
    SpeedButtonBL301Leds5: TSpeedButton;
    SpeedButtonBL301Leds4: TSpeedButton;
    SpeedButtonBL301Leds3: TSpeedButton;
    SpeedButtonBL301Leds2: TSpeedButton;
    SpeedButtonBL301Leds1: TSpeedButton;
    SpeedButtonBL301Leds0: TSpeedButton;
    ComboBoxIWAscii: TComboBox;
    CheckBoxIWAsciiLiteral: TCheckBox;
    ComboBoxBL301Ascii: TComboBox;
    SpeedButtonBL301ClearLedButtons: TSpeedButton;
    CheckBoxBL301AsciiLiteral: TCheckBox;
    GroupBoxaSC7511: TGroupBox;
    ButtonASC7511Status: TButton;
    ButtonASC7511Config: TButton;
    ButtonASC7511Rate: TButton;
    ButtonASC7511Local: TButton;
    ButtonASC7511Remote: TButton;
    Label9: TLabel;
    Label27: TLabel;
    GroupBoxSPI: TGroupBox;
    ButtonSpiCSInit: TButton;
    ButtonSpiCS00: TButton;
    ButtonSpiCS01: TButton;
    ButtonSpiCS11: TButton;
    ButtonSpiCS10: TButton;
    ApdStatusLightEchoCTS: TApdStatusLight;
    ApdStatusLightEchoDSR: TApdStatusLight;
    Label28: TLabel;
    Label32: TLabel;
    ApdStatusLightEchoDCD: TApdStatusLight;
    Label33: TLabel;
    ApdStatusLightEchoBreak: TApdStatusLight;
    Label34: TLabel;
    ButtonIRead1WireDS1820: TButton;
    GroupBoxSendFile: TGroupBox;
    LabelRepeats: TLabel;
    LabelProtocolError: TLabel;
    ProgressBarSendFile: TProgressBar;
    ComboBoxSendFName: TComboBox;
    ButtonSendFName: TButton;
    ButtonSendFile: TButton;
    BitBtnAbortSendFile: TBitBtn;
    SpinEditAsciiCharDelay: TSpinEdit;
    SpinEditAsciiLineDelay: TSpinEdit;
    SpinEditFileSendDelay: TSpinEdit;
    SpinEditFileSendRepeats: TSpinEdit;
    PanelSpecialCapture: TPanel;
    CheckBoxCaptureAsHex: TCheckBox;
    RadioGroupTimeStamp: TRadioGroup;
    GroupBoxPCA9544: TGroupBox;
    RadioGroupPCA9544BusNum: TRadioGroup;
    ButtonPCA9544Status: TButton;
    Label35: TLabel;
    ButtonWriteINIFile: TButton;
    ComboBoxIAddress: TComboBox;
    ButtonChangeTraceFName: TButton;
    ButtonClearTraceLog: TButton;
    ButtonDumpTraceLog: TButton;
    GroupBoxBlueSMiRF: TGroupBox;
    ButtonBSEnterAT: TButton;
    ButtonBSExitAT: TButton;
    ButtonBSFastMode: TButton;
    ComboBoxBSBaud: TComboBox;
    ButtonBSBaud: TButton;
    ButtonBSRSSI: TButton;
    ButtonBSPark: TButton;
    ButtonSendLF: TButton;
    GroupBoxMAX127: TGroupBox;
    RadioGroupMax127Range: TRadioGroup;
    ButtonMax127Read: TButton;
    TimerCallback: TTimer;
    RadioGroupTimeStampDelimiter: TRadioGroup;
    ApdDataPacket1: TApdDataPacket;
    TabSheetEvents: TTabSheet;
    RadioGroupSendEvent: TRadioGroup;
    LabelLastEvent: TLabel;
    GroupBoxDataTrigger: TGroupBox;
    ApdStatusLightDataTrigger: TApdStatusLight;
    ButtonEditDataTrigger1: TButton;
    CheckBoxDataTrigger1: TCheckBox;
    ButtonBSQueryBaud: TButton;
    ComboBoxBaudMult: TComboBox;
    ButtonBL301MAscii: TButton;
    SpinEditBL301MNumDisplay: TSpinEdit;
    ComboBoxBL301MString: TComboBox;
    ButtonBL301MInit: TButton;
    RadioGroupEchoWsTelnet: TRadioGroup;
    ComboBoxCRC: TComboBox;
    GroupBoxPCA9545: TGroupBox;
    ButtonPCA9545Status: TButton;
    GroupBox9: TGroupBox;
    CheckBox9545_Bus0: TCheckBox;
    CheckBox9545_Bus1: TCheckBox;
    CheckBox9545_Bus2: TCheckBox;
    CheckBox9545_Bus3: TCheckBox;
    C1: TMenuItem;
    SendBreak1: TMenuItem;
    ButtonI2CTestM5451: TButton;
    CheckBoxI2CM5451_Color: TCheckBox;
    ButtonPopupMenu: TButton;
    GroupBoxAddCannedString: TGroupBox;
    EditCannedStringTitle: TEdit;
    EditCannedStringContents: TEdit;
    ButtonAddCannedString: TButton;
    GroupBoxBitBash: TGroupBox;
    ButtonBL233_BitBashIdle: TButton;
    SpeedButtonP7: TSpeedButton;
    SpeedButtonP6: TSpeedButton;
    SpeedButtonP5: TSpeedButton;
    SpeedButtonP4: TSpeedButton;
    SpeedButtonP3: TSpeedButton;
    SpeedButtonP2: TSpeedButton;
    SpeedButtonP1: TSpeedButton;
    SpeedButtonP0: TSpeedButton;
    Label39: TLabel;
    ButtonBL233ReadPins: TButton;
    EditCannedStringShortcut: TEdit;
    GroupBoxColors: TGroupBox;
    EditColors: TEdit;
    ButtonScanBus: TButton;
    PopupMenuI2CControlRegister: TPopupMenu;
    MenuItemCR7: TMenuItem;
    MenuItemCR6: TMenuItem;
    MenuItemCR5: TMenuItem;
    MenuItemCR4: TMenuItem;
    MenuItemCR3: TMenuItem;
    MenuItemCR2: TMenuItem;
    MenuItemCR1: TMenuItem;
    MenuItemCR0: TMenuItem;
    GroupBoxI2CControlRegister: TGroupBox;
    CheckBoxMenuItemCR7: TCheckBox;
    CheckBoxMenuItemCR1: TCheckBox;
    ButtonI2CCRMore: TButton;
    abc1: TMenuItem;
    MenuItemCRDefault: TMenuItem;
    Function1: TMenuItem;
    N5: TMenuItem;
    TabSheetI2CMem: TTabSheet;
    SpinEditMax127Channel: TSpinEdit;
    Label44: TLabel;
    ButtonShowEventsTab: TButton;
    StatusBarFormattedData: TStatusBar;
    SpeedButtonShowFormattedData: TSpeedButton;
    PopupMenuHexCSVFormat: TPopupMenu;
    Clear1: TMenuItem;
    uUnsignedBigendian1: TMenuItem;
    sSignedBigendian1: TMenuItem;
    fFloatBigendian1: TMenuItem;
    gFloatlittleendian1: TMenuItem;
    dBCDLiteralDecimal1: TMenuItem;
    bBinary1: TMenuItem;
    aASCII1: TMenuItem;
    vUnsignedLittleendian1: TMenuItem;
    tSignedLittleEndian1: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    HexCSVFormatCharacters1: TMenuItem;
    LabeledEditDataTriggerLastString1: TLabeledEdit;
    FrameI2CMem1: TFrameI2CMem;
    Button1WireCheckPresence: TButton;
    CheckBox1WireUseRomID: TCheckBox;
    ComboBox1WireRomID: TComboBox;
    Button1WireDS2450ReadADC: TButton;
    Button1WireReadDS2423Count: TButton;
    ApdDataPacketFormatted: TApdDataPacket;
    ButtonShowLastError: TButton;
    N1001: TMenuItem;
    N1501: TMenuItem;
    N2001: TMenuItem;
    GroupBox5: TGroupBox;
    SpinEditScale: TSpinEdit;
    BitBtnChangeScale: TBitBtn;
    Label30: TLabel;
    CheckBoxEnableTimerEvents: TCheckBox;
    N9: TMenuItem;
    MenuItemFullScreen: TMenuItem;
    Auto1: TMenuItem;
    CheckBoxClearTerminalOnPortOpen: TCheckBox;
    MenuItemSendStringAscii2: TMenuItem;
    MenuItemSendStringNum1: TMenuItem;
    N10: TMenuItem;
    MenuItemSendStringNum2: TMenuItem;
    N11: TMenuItem;
    MenuItemAddHotkey: TMenuItem;
    N12: TMenuItem;
    MenuItemGlobalHotkeys1: TMenuItem;
    MenuItemClearTerminal: TMenuItem;
    MenuItemNewLine: TMenuItem;
    MenuItemSendCRLF: TMenuItem;
    MenuItemStayOnTop: TMenuItem;
    MenuItemMiniTerminal: TMenuItem;
    Window1: TMenuItem;
    TabSheetDisplay: TTabSheet;
    Label2: TLabel;
    Label36: TLabel;
    RadioGroupDisplayType: TRadioGroup;
    GroupBoxFrames: TGroupBox;
    Label4: TLabel;
    SpinEditFrameSize: TSpinEdit;
    CheckBoxSingleFrame: TCheckBox;
    ButtonGulp1: TButton;
    CheckBoxInvertData: TCheckBox;
    CheckBoxHalfDuplex: TCheckBox;
    GroupBoxBinarySync: TGroupBox;
    Label16: TLabel;
    Label18: TLabel;
    Label7: TLabel;
    LabelSyncCount: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    ComboBoxSyncString: TComboBox;
    RadioGroupSyncIs: TRadioGroup;
    BitBtnChangeBinarySync: TBitBtn;
    ComboBoxSyncXOR: TComboBox;
    ComboBoxSyncAND: TComboBox;
    CheckBoxLeadingSync: TCheckBox;
    SpinEditSyncShowLength: TSpinEdit;
    CheckBoxHighlightSync: TCheckBox;
    ButtonFont: TButton;
    CheckBoxBigEndian: TCheckBox;
    CheckBoxNewLine: TCheckBox;
    CheckBoxClearTerminalOnDisplayChange: TCheckBox;
    CheckboxScrollback: TCheckBox;
    SpinEditScrollbackRows: TSpinEdit;
    SpinEditTerminalCols: TSpinEdit;
    CheckBoxDisplayTimeStamp: TCheckBox;
    GroupBoxHexCSV: TGroupBox;
    Label29: TLabel;
    SpeedButtonEditDataPacketFormatted: TSpeedButton;
    ComboBoxHexCSVFormat: TComboBox;
    RadioGroupHexCSVTerminalShows: TRadioGroup;
    ButtonHexCSVFormat: TButton;
    RadioGroupHexCSVStatusShows: TRadioGroup;
    CheckBoxMaskMSB: TCheckBox;
    CheckBoxCRLF: TCheckBox;
    MenuItemSendFile: TMenuItem;
    MenuItemOpenPort: TMenuItem;
    TrayIcon1: TTrayIcon;
    ButtonPlay1: TButton;
    ButtonPlay2: TButton;
    N13: TMenuItem;
    MenuItemScrollUp: TMenuItem;
    MenuItemScrollDown: TMenuItem;
    CheckBoxLazyPaint: TCheckBox;
    MenuItemShow2: TMenuItem;
    N14: TMenuItem;
    ButtonSendHex1: TButton;
    ButtonSendHex2: TButton;
    GroupBoxBLE: TGroupBox;
    ComboBoxBLE1Baud: TComboBox;
    ButtonBLE1SetBaud: TButton;
    ButtonBLE1RSSI: TButton;
    ButtonBLE1QuerySettings: TButton;
    ComboBoxBLE1StdCommands: TComboBox;
    TimerSendStringQueue: TTimer;
    ButtonBLE1Clear: TButton;
    ComboBoxBLE1ConnectCommands: TComboBox;
    CheckBoxCaptureFormatted: TCheckBox;
    RadioGroupCaptureAutoFileName: TRadioGroup;
    CheckBoxCaptureDisplay: TCheckBox;
    CheckBoxCaptureRestart: TCheckBox;
    CheckBoxCapturePostProcess: TCheckBox;
    ButtonPostProcessFName: TButton;
    ComboBoxCapturePostFName: TComboBox;
    OpenDialog2: TOpenDialog;
    CheckBoxCRCHex: TCheckBox;
    CheckBoxCR1: TCheckBox;
    CheckBoxLF1: TCheckBox;
    CheckBoxCR2: TCheckBox;
    CheckBoxLF2: TCheckBox;
    Label42: TLabel;
    CheckBoxCRC: TCheckBox;
    RadioButtonUnsigned: TRadioButton;
    CheckBoxBackspaceDo: TCheckBox;
    RadioButtonTimeStampDummy: TRadioButton;
    ComboBoxTimeStampFormat: TComboBox;
    CheckBoxHexSpace: TCheckBox;
    ComboBoxDisplayTimeStampFormat: TComboBox;
    MenuItemSendString1: TMenuItem;
    ExtendedfControl21: TMenuItem;
    MenuItemCR27: TMenuItem;
    MenuItemCR26: TMenuItem;
    MenuItemCR21: TMenuItem;
    MenuItemCR20: TMenuItem;
    MenuItemCR2Default: TMenuItem;
    ButtonBL233EEPromDlg: TButton;
    N17: TMenuItem;
    I21: TMenuItem;
    MenuItemBitTiming00: TMenuItem;
    MenuItemBitTiming08: TMenuItem;
    MenuItemBitTiming10: TMenuItem;
    MenuItemBitTiming20: TMenuItem;
    N18: TMenuItem;
    ApdDataPacketI2C: TApdDataPacket;
    MenuItemCR25: TMenuItem;
    MenuItemCR24: TMenuItem;
    MenuItemCR23: TMenuItem;
    MenuItemCR22: TMenuItem;
    LinkLabel2: TLinkLabel;
    LinkLabel3: TLinkLabel;
    LinkLabel4: TLinkLabel;
    ComboBoxHexCSVFormatChars: TComboBox;
    Edit1: TEdit;
    SpeedButtonCancelSend: TSpeedButton;
    CheckBoxPadLeft: TCheckBox;
    Label37: TLabel;
    CheckBoxRxdIdle: TCheckBox;
    SpinEditTerminalRows: TSpinEdit;
    SpinEditRxdIdle: TSpinEdit;
    CheckBoxPortAutoOpen: TCheckBox;
    SpinEditPortAutoClose: TSpinEdit;
    CheckBoxPortAutoClose: TCheckBox;
    FileOpenDialog1: TFileOpenDialog;
    Label38: TLabel;
    TimerSlowChanges: TTimer;
    ButtonShowAbout: TButton;
    MenuItemOnlineManual: TMenuItem;
    MenuItemNews: TMenuItem;
    MenuItemAbout: TMenuItem;
    N15: TMenuItem;
    MenuItemContextHelp: TMenuItem;
    MenuItemAllHelp: TMenuItem;
    PopupMenu1: TPopupMenu;
    MenuItemLastErrorMessage: TMenuItem;
    N16: TMenuItem;
    SpinEditScalePPI: TSpinEdit;
    ButtonFontSize1: TButton;
    ButtonFontSize2: TButton;
    N1251: TMenuItem;
    AppAnalytics1: TAppAnalytics;
    CheckBoxNoSleep: TCheckBox;
    D1: TMenuItem;
    AdTerminal1: TAdTerminal;
    RadioGroupMiscFeatures: TRadioGroup;
    GroupBoxPhone: TGroupBox;
    ButtonPhone1: TButton;
    ButtonPhone2: TButton;
    ComboBoxPhoneStdCommands: TComboBox;
    LinkLabelPhoneATCommandRef: TLinkLabel;
    LinkLabelPhoneUnlocking: TLinkLabel;
    CheckBoxPhoneAddEqualsQ: TCheckBox;
    LinkLabel1: TLinkLabel;
    InstallTour1: TMenuItem;
    ButtonPhoneAT: TButton;
    ComboBoxUSBHistory: TComboBox;
    ComboBoxUSBData: TComboBox;
    LabelUSBShow: TLabel;
    PanelUSBShow: TPanel;
    ButtonEditCapture: TButton;
    CheckBoxPostShowCMD: TCheckBox;
    N19: TMenuItem;
    MenuItemMacro1: TMenuItem;
    MenuItemMacro2: TMenuItem;
    MenuItemEditMacrosINIFile: TMenuItem;
    CheckBoxCaptureEOL: TCheckBox;
    ComboBoxCaptureEOLChar: TComboBox;
    CheckBoxMonitorNewLineOnDirectionChange: TCheckBox;
    RadioButtonSigned: TRadioButton;

    procedure ButtonCaptureOverwriteClick(Sender: TObject);
    procedure ButtonCaptureAppendClick(Sender: TObject);

    procedure ButtonCaptureStopClick(Sender: TObject);
    {procedure AdEmulator_PlainProcessCharOld(CP: TObject; C: Char;
      var Command: TEmuCommand);}
    procedure Timer1Timer(Sender: TObject);
    procedure RadioGroupDisplayTypeClick(Sender: TObject);
    //handler for the click event, also handles get/set of the complex cmdline value in one place
    function RadioGroupDisplayTypeSet(GetValue:boolean=false; DisplayTypeValue:integer=999):integer;
    {procedure AdEmulator_HexProcessCharOld(CP: TObject; C: Char;
      var Command: TEmuCommand);}
    procedure SpinEditFrameSizeChange(Sender: TObject);
    procedure ButtonFreezeClick(Sender: TObject);
    procedure SetPortClick(Sender: TObject);
    procedure Port1WsConnect(Sender: TObject);
    procedure Port1WsDisconnect(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Port1WsAccept(Sender: TObject; Addr: TInAddr;
      var Accept: Boolean);
    procedure CheckBoxSingleFrameClick(Sender: TObject);
    procedure ButtonGulp1Click(Sender: TObject);
    procedure ComboBoxCaptureSizeChange(Sender: TObject);
    procedure ParameterParamMatch(Sender: TObject; CaseMatch: Boolean;
      Param, Reference: String);
    procedure FormCreate(Sender: TObject);
    procedure BitBtnSetPortClick(Sender: TObject);
    procedure CheckBoxInvertDataClick(Sender: TObject);
    procedure ButtonSetRTSClick(Sender: TObject);
    procedure ButtonClrRTSClick(Sender: TObject);
    procedure ButtonSetDTRClick(Sender: TObject);
    procedure ButtonClearDTRClick(Sender: TObject);
    procedure Button500msBreakClick(Sender: TObject);
    procedure ButtonSendAscii1Click(Sender: TObject);
    procedure ButtonSendAscii2Click(Sender: TObject);
    procedure CheckBoxHalfDuplexClick(Sender: TObject);
    procedure ButtonSetBreakClick(Sender: TObject);
    procedure ButtonClearBreakClick(Sender: TObject);
    procedure ButtonSendFileClick(Sender: TObject);
    procedure BitBtnAbortSendFileClick(Sender: TObject);
    procedure SpinEditLPTChange(Sender: TObject);
    procedure BitBtnChangeBinarySyncClick(Sender: TObject);
    procedure ButtonSendNumbers1Click(Sender: TObject);
    procedure ButtonSendNumbers2Click(Sender: TObject);
    procedure ButtonSaveFNameClick(Sender: TObject);
    procedure ButtonSendFNameClick(Sender: TObject);
//    procedure Button16Click(Sender: TObject);
//    procedure Button17Click(Sender: TObject);
    procedure SpeedButtonPowerClick(Sender: TObject);
    procedure ButtonResetBothClick(Sender: TObject);
    procedure ButtonReset1Click(Sender: TObject);
    procedure ButtonReset2Click(Sender: TObject);
    procedure PortTriggerAvail(CP: TObject; Count: Word);
    procedure EchoPortWsAccept(Sender: TObject; Addr: TInAddr;
      var Accept: Boolean);
    procedure BitBtnSetEchoPortClick(Sender: TObject);
    procedure CheckBoxEchoOnClick(Sender: TObject);
    procedure ButtonFontClick(Sender: TObject);
    procedure CheckBoxBigEndianClick(Sender: TObject);
    procedure CheckBoxTraceClick(Sender: TObject);
    procedure CheckBoxLogClick(Sender: TObject);
    procedure ComboBoxTraceFNameChange(Sender: TObject);
    procedure ButtonTraceFNameClick(Sender: TObject);
    procedure ButtonOpenLPTClick(Sender: TObject);
    procedure MenuItemShowClick(Sender: TObject);
    procedure MenuItemCloseClick(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
    procedure MenuItemCaptureClick(Sender: TObject);
    procedure MenuItemPortClick(Sender: TObject);
    procedure SpeedButtonPort1OpenClick(Sender: TObject);
    procedure Hide1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure EchoPortWsDisconnect(Sender: TObject);
    procedure EchoPortWsConnect(Sender: TObject);
    procedure EchoPortTrigger(CP: TObject; Msg, TriggerHandle, Data: Word);
    procedure Port1TriggerCaptureWrite(CP: TObject; Msg, TriggerHandle, Data: Word);
    procedure Port1TriggerEchoOut(CP: TObject; Msg, TriggerHandle, Data: Word);
    procedure MenuItemEchoClick(Sender: TObject);
    procedure ApdProtocol1ProtocolFinish(CP: TObject; ErrorCode: Integer);
    procedure ApdProtocol1ProtocolStatus(CP: TObject; Options: Word);
    procedure HideControls1Click(Sender: TObject);
    procedure SpinEditAsciiCharDelayChange(Sender: TObject);
    procedure SpinEditAsciiLineDelayChange(Sender: TObject);
    procedure AdEmulator_VT100ProcessChar(Sender: TObject; Character: ansiChar;
      var ReplaceWith: AnsiString; Commands: TAdEmuCommandList;
      CharSource: TAdCharSource);
    //procedure AdEmulator_HexProcessChar(Sender: TObject; C: Char;
    //  var ReplaceWith: String; Commands: TAdEmuCommandList;
    //  CharSource: TAdCharSource);
    procedure AdEmulator_ShowAllProcessChar(Sender: TObject;
      C: AnsiChar; var ReplaceWith: AnsiString; Commands: TAdEmuCommandList;
      CharSource: TAdCharSource);
    procedure CheckBoxEchoPortMonitoringClick(Sender: TObject);
    procedure ButtonClearClick(Sender: TObject);
    procedure SpinEditTerminalRowsChange(Sender: TObject);
    procedure AdTerminal1Click(Sender: TObject);
    procedure RadioGroupBusNumClick(Sender: TObject);
    procedure ButtonIStartClick(Sender: TObject);
    procedure ButtonIStopClick(Sender: TObject);
    procedure ButtonIReadClick(Sender: TObject);
    procedure ButtonIRead1WireIDClick(Sender: TObject);
    procedure ButtonIGetStatusClick(Sender: TObject);
    procedure ButtonIWriteClick(Sender: TObject);
    procedure ButtonIQueryPinsClick(Sender: TObject);
    procedure ButtonNewLineClick(Sender: TObject);
    procedure CheckBoxNewLineClick(Sender: TObject);
    procedure SpinEditFileSendRepeatsChange(Sender: TObject);
    procedure StWMDataCopy1DataReceived(Sender: TObject;
//D3     CopyData: TCopyDataStruct);
      CopyData: tagCopyDataStruct);
    procedure TrayIcon1RightClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
//    procedure ButtonKReadAllClick(Sender: TObject);
    procedure FontDialog1Apply(Sender: TObject; Wnd: HWND);
//D3   procedure FontDialog1Apply(Sender: TObject; Wnd: Integer);
    procedure ApdProtocol1ProtocolError(CP: TObject; ErrorCode: Integer);
    procedure ButtonSMBusAlertClick(Sender: TObject);
    procedure ButtonI2CGCAResetClick(Sender: TObject);
    procedure ButtonI2CSend2M5451D4Click(Sender: TObject);
    procedure ButtonGPIBCtrlCClick(Sender: TObject);
    procedure ButtonGPIBSetupClick(Sender: TObject);
    procedure ButtonGPIBRSTClick(Sender: TObject);
    procedure ButtonGPIBIDNClick(Sender: TObject);
    procedure ButtonGPIBERRClick(Sender: TObject);
    procedure ButtonSend0Click(Sender: TObject);
    procedure ButtonSend3Click(Sender: TObject);
    procedure EditSendNumericChange(Sender: TObject);
    procedure MenuItemSendStringClick(Sender: TObject);
    procedure ButtonGPIBTSTClick(Sender: TObject);
    procedure SpeedButtonSpy1Click(Sender: TObject);
{    procedure VicCommSpy1Received(ComNumber: Byte; sValue: String);
    procedure VicCommSpy1Sent(ComNumber: Byte; sValue: String);
}    procedure TerminalNewLine;
    procedure MenuItemCopyTerminalClick(Sender: TObject);
    procedure MenuItemPasteTerminalClick(Sender: TObject);
    procedure IWrite(S:ansistring);
    procedure IRead(BytesToRead:byte);
    procedure ButtonIWrite00Click(Sender: TObject);
    procedure ButtonIWriteFFClick(Sender: TObject);
    procedure ButtonM5451ClearClick(Sender: TObject);
    procedure ButtonIWAsciiClick(Sender: TObject);
    procedure ButtonIWClearClick(Sender: TObject);
    procedure ButtonIWByteClick(Sender: TObject);
    procedure ButtonIWWordBEClick(Sender: TObject);
    procedure ButtonIWWordLEClick(Sender: TObject);
    procedure ButtonIWBitClearClick(Sender: TObject);
    procedure ButtonIWBitClick(Sender: TObject);
    procedure ButtonIWNotBitClick(Sender: TObject);
    procedure RadioGroupWsTelnetClick(Sender: TObject);
    procedure ComboBoxComPortDblClick(Sender: TObject);
    procedure TimerCallbackTimer(Sender: TObject);
    procedure TimerSendFileTimer(Sender: TObject);
    procedure CommSpy1Received(CommIndex: Byte; Data: ansiString;
      Info: Cardinal);
    procedure CommSpy1Sent(CommIndex: Byte; Data: ansiString;
      Info: Cardinal);
    procedure CheckboxScrollbackClick(Sender: TObject);
    procedure LabelHTMLClick(Sender: TObject);
    procedure AllHelpClick(Sender: TObject);
    procedure ButtonSHTReadTempClick(Sender: TObject);
    procedure ButtonSHTClearClick(Sender: TObject);
    procedure ButtonSHTReadHumidityClick(Sender: TObject);
    procedure ButtonSHTReadStatusClick(Sender: TObject);
    procedure ButtonSHTSoftResetClick(Sender: TObject);
    procedure ButtonSHTWriteStatusClick(Sender: TObject);
    procedure CheckBoxTraceHexClick(Sender: TObject);
    procedure CheckBoxLogHexClick(Sender: TObject);
    procedure ButtonIWriteThenReadClick(Sender: TObject);
    procedure ButtonBL301WriteAscii2LCDClick(Sender: TObject);
    procedure ButtonBL301InitLCDClick(Sender: TObject);
    procedure SpeedButtonBL301ClearLedButtonsClick(Sender: TObject);
    procedure ButtonBL301SetContrastClick(Sender: TObject);
    procedure ButtonBL301SetLedsClick(Sender: TObject);
    procedure ButtonBL301ReadSwitchesClick(Sender: TObject);
    procedure ButtonASC7511StatusClick(Sender: TObject);
    procedure ButtonASC7511ConfigClick(Sender: TObject);
    procedure ButtonASC7511RateClick(Sender: TObject);
    procedure ButtonASC7511LocalClick(Sender: TObject);
    procedure ButtonASC7511RemoteClick(Sender: TObject);
    procedure Port1TriggerAvail(CP: TObject; Count: Word);
    procedure ButtonSpiCSInitClick(Sender: TObject);
    procedure ButtonSpiCS00Click(Sender: TObject);
    procedure ButtonSpiCS01Click(Sender: TObject);
    procedure ButtonSpiCS10Click(Sender: TObject);
    procedure ButtonSpiCS11Click(Sender: TObject);
    procedure ButtonIRead1WireDS1820Click(Sender: TObject);
    procedure SpinEditScrollbackRowsChange(Sender: TObject);
    procedure RadioGroupPCA9544BusNumClick(Sender: TObject);
    procedure ButtonPCA9544StatusClick(Sender: TObject);
    procedure TabSheetI2CShow(Sender: TObject);
    procedure ButtonChangeTraceFNameClick(Sender: TObject);
    procedure ButtonClearTraceLogClick(Sender: TObject);
    procedure ButtonDumpTraceLogClick(Sender: TObject);
    //procedure ButtonUser1Click(Sender: TObject);
    {function FormHelp(Command: Word; Data: Integer;
      var CallHelp: Boolean): Boolean;}
    procedure ButtonBSEnterATClick(Sender: TObject);
    procedure ButtonBSExitATClick(Sender: TObject);
    procedure ButtonBSFastModeClick(Sender: TObject);
    procedure ButtonBSBaudClick(Sender: TObject);
    procedure ButtonBSRSSIClick(Sender: TObject);
    procedure ButtonBSParkClick(Sender: TObject);
    procedure ButtonSendLFClick(Sender: TObject);
    procedure ButtonMax127ReadClick(Sender: TObject);
    procedure RadioGroupSendEventClick(Sender: TObject);
    procedure SpinEditTerminalColsChange(Sender: TObject);
    procedure CheckBoxDirectCaptureClick(Sender: TObject);
    procedure ButtonEditDataTrigger1Click(Sender: TObject);
    procedure CheckBoxDataTrigger1Click(Sender: TObject);
    procedure ApdDataPacket1Packet(Sender: TObject; Data: Pointer;
      Size: Integer);
    procedure StatusBar1DblClick(Sender: TObject);
    procedure ButtonBL233_BitBashIdleClick(Sender: TObject);
    procedure ApdDataPacket1Timeout(Sender: TObject);
    procedure ButtonBSQueryBaudClick(Sender: TObject);
    procedure LabelApdStatusErrorDblClick(Sender: TObject);
    procedure LabelApdStatusTXDDblClick(Sender: TObject);
    procedure PanelBaud1DblClick(Sender: TObject);
    procedure ButtonBL301MAsciiClick(Sender: TObject);
    procedure ButtonBL301MInitClick(Sender: TObject);
    procedure RadioGroupEchoWsTelnetClick(Sender: TObject);
    procedure CheckBoxCRCClick(Sender: TObject);
    procedure ButtonPCA9545StatusClick(Sender: TObject);
    procedure CheckBox9545_BusXClick(Sender: TObject);
    procedure SendBreak1Click(Sender: TObject);
    procedure C1Click(Sender: TObject);
    procedure ButtonI2CTestM5451Click(Sender: TObject);
    procedure CheckBoxI2CM5451_ColorClick(Sender: TObject);
    procedure ButtonTerminalEnableClick(Sender: TObject);
    procedure ButtonTerminalActiveClick(Sender: TObject);
    procedure ButtonPopupMenuClick(Sender: TObject);
    procedure ButtonAddCannedStringClick(Sender: TObject);
    procedure SpeedButtonP0Click(Sender: TObject);
    procedure ButtonBL233ReadPinsClick(Sender: TObject);
    procedure LabelSyncCountClick(Sender: TObject);
    procedure EditColorsChange(Sender: TObject);
    procedure ButtonScanBusClick(Sender: TObject);
    procedure ButtonI2CCRMoreClick(Sender: TObject);
    procedure CheckBoxMenuItemCR7Click(Sender: TObject);
    procedure CheckBoxMenuItemCR1Click(Sender: TObject);
    procedure PopupMenuI2CControlRegisterChange(Sender: TObject;
      Source: TMenuItem; Rebuild: Boolean);
    procedure MenuItemCRClick(Sender: TObject);
    procedure MenuItemCRDefaultClick(Sender: TObject);
    procedure ButtonShowEventsTabClick(Sender: TObject);
    procedure SpeedButtonShowFormattedDataClick(Sender: TObject);
    procedure ButtonHexCSVFormatClick(Sender: TObject);
    procedure ComboBoxHexCSVFormatDblClick(Sender: TObject);
    procedure HexCSVFormatChars1Click(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure RadioGroupHexCSVTerminalShowsClick(Sender: TObject);
    procedure RadioGroupHexCSVStatusShowsClick(Sender: TObject);
    procedure CheckBoxMaskMSBClick(Sender: TObject);
    function FormHelp(Command: Word; Data: NativeInt;
      var CallHelp: Boolean): Boolean;
    procedure ParameterRemoteParamMatch(Sender: TObject; CaseMatch: Boolean;
      Param, Reference: string);
    procedure ButtonWriteINIFileClick(Sender: TObject);
    procedure EchoReceiveFlowBoxClick(Sender: TObject);
    procedure CheckBox1WireUseRomIDClick(Sender: TObject);
    procedure Button1WireCheckPresenceClick(Sender: TObject);
    procedure Button1WireDS2450ReadADCClick(Sender: TObject);
    procedure SpeedButtonEditDataPacketFormattedClick(Sender: TObject);
    procedure ApdDataPacketFormattedStringPacket(Sender: TObject;
      Data: AnsiString);
    procedure ButtonShowLastErrorClick(Sender: TObject);
    procedure BitBtnChangeScaleClick(Sender: TObject);

    procedure FormScale(Percent:integer);
    procedure SetWinState(WinState:integer);
    function  GetWinState:integer;
    procedure CheckBoxEnableTimerEventsClick(Sender: TObject);
    procedure MenuItemFullScreenClick(Sender: TObject);
    procedure MenuItemScaleClick(Sender: TObject);
    procedure SpinEditScaleDblClick(Sender: TObject); //set screen scale to % of design size
    procedure SetClearTerminalCheckBoxes(Value:integer);
    function  GetClearTerminalCheckBoxes:integer;
    procedure MenuItemGlobalHotkeys1Click(Sender: TObject);
    procedure MenuItemSendCRLFClick(Sender: TObject);
    procedure MenuItemStayOnTopClick(Sender: TObject);
    procedure MenuItemMiniTerminalClick(Sender: TObject);
    procedure CheckBoxCRLFClick(Sender: TObject);
    procedure SpinEditTerminalColsDblClick(Sender: TObject);
    procedure Port1WsError(Sender: TObject; ErrCode: Integer);
    procedure MenuItemSendFileClick(Sender: TObject);
    procedure MenuItemOpenPortClick(Sender: TObject);
    procedure ButtonPlay1Click(Sender: TObject);
    procedure ButtonPlay2Click(Sender: TObject);
    procedure MenuItemScrollUpClick(Sender: TObject);
    procedure MenuItemScrollDownClick(Sender: TObject);
    procedure SpinEditTerminalRowsDblClick(Sender: TObject);
    procedure CheckBoxLazyPaintClick(Sender: TObject);
    procedure ButtonSendHex1Click(Sender: TObject);
    procedure ButtonSendHex2Click(Sender: TObject);
    procedure ComboBoxBLE1StdCommandsDblClick(Sender: TObject);
    procedure ButtonBLE1SetBaudClick(Sender: TObject);
    procedure ButtonBLE1RSSIClick(Sender: TObject);
    procedure ButtonBLE1QuerySettingsClick(Sender: TObject);
    procedure TimerSendStringQueueTimer(Sender: TObject);
    procedure ComboBoxBLE1StdCommandsSelect(Sender: TObject);
    procedure ButtonBLE1ClearClick(Sender: TObject);
    procedure ComboBoxBLE1ConnectCommandsDblClick(Sender: TObject);
    procedure ComboBoxComPortSelect(Sender: TObject);
    procedure CheckBoxCaptureDisplayClick(Sender: TObject);
    procedure ButtonPostProcessFNameClick(Sender: TObject);
//    procedure ComboboxRightJustify(Sender: TObject);
    procedure StatusBar1DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure ComboBoxCRCChange(Sender: TObject);
    procedure FrameI2CMem1ButtonI2CMemBrowseReadFilesClick(Sender: TObject);
    procedure RadioGroupTimeStampContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure ComboBoxTimeStampFormatExit(Sender: TObject);
    procedure RadioGroupTimeStampClick(Sender: TObject);
    procedure RadioGroupCaptureAutoFileNameClick(Sender: TObject);
    procedure RadioButtonTimeStampDummyDblClick(Sender: TObject);
    procedure RadioButtonUnsignedClick(Sender: TObject);
    procedure RadioButtonSignedClick(Sender: TObject);
    procedure CheckBoxHexSpaceClick(Sender: TObject);
    procedure ComboBoxTimeStampFormatChange(Sender: TObject);
    procedure CheckBoxDisplayTimeStampContextPopup(Sender: TObject;
      MousePos: TPoint; var Handled: Boolean);
    procedure CheckBoxDisplayTimeStampClick(Sender: TObject);
    procedure ComboBoxSendFNameExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure MenuItemCR2Click(Sender: TObject);
    procedure MenuItemCR2DefaultClick(Sender: TObject);
    procedure ButtonBL233EEPromDlgClick(Sender: TObject);
    procedure MenuItemBitTimingClick(Sender: TObject);
    procedure ComboBoxExitCheckPath(Sender: TObject);
    procedure ComboBoxExitCheckFileExists(Sender: TObject);
    procedure FrameI2CMem1ButtonI2CMemBrowseWriteFilesClick(Sender: TObject);
    procedure ApdDataPacketI2CStringPacket(Sender: TObject; Data: AnsiString);
    procedure ApdDataPacketI2CPacket(Sender: TObject; Data: Pointer;
      Size: Integer);
    procedure LinkLabelHTMLClick(Sender: TObject; const Link: string;
      LinkType: TSysLinkType);
    procedure ComboBoxHexCSVFormatCharsCloseUp(Sender: TObject);
    procedure ComboBoxHexCSVFormatCharsDropDown(Sender: TObject);
    procedure ComboBoxHexCSVFormatCharsSelect(Sender: TObject);
    procedure HexCSVFormatTest(Sender: TObject);
    procedure CheckBoxPadLeftClick(Sender: TObject);
    procedure SpinEditRxdIdleChange(Sender: TObject);
    procedure SpinEditRxdIdleExit(Sender: TObject);
    procedure SpinEditPortAutoCloseChange(Sender: TObject);
    procedure CheckBoxPortAutoOpenClick(Sender: TObject);
    procedure CheckBoxPortAutoCloseClick(Sender: TObject);
    procedure SpinEditNumTimesToSendDblClick(Sender: TObject);
    procedure Port1ErrorEvent(CP: TObject; ErrCode: Integer);
    procedure TimerSlowChangesTimer(Sender: TObject);
    procedure ButtonShowAboutClick(Sender: TObject);
    procedure MenuItemAboutClick(Sender: TObject);
    procedure MenuItemOnlineManualClick(Sender: TObject);
    procedure MenuItemNewsClick(Sender: TObject);
    procedure MenuItemLastErrorMessageClick(Sender: TObject);
    procedure ButtonFontSizeClick(Sender: TObject);
    procedure CheckBoxNoSleepClick(Sender: TObject);
    procedure DonateLabelHTMLClick(Sender: TObject; const Link: string;
      LinkType: TSysLinkType);
    procedure MenuItemDonateClick(Sender: TObject);
    procedure CheckBoxRxdIdleContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure PageControl1Change(Sender: TObject);
    procedure RadioGroupMiscFeaturesClick(Sender: TObject);
    procedure ButtonPhoneExitATModeClick(Sender: TObject);
    procedure ButtonPhoneSendCaptionClick(Sender: TObject);
    procedure ComboBoxPhoneStdCommandsDblClick(Sender: TObject);
    procedure ComboBoxPhoneStdCommandsSelect(Sender: TObject);
    procedure InstallTour1Click(Sender: TObject);
    procedure ComboBoxUSBHistorySelect(Sender: TObject);
    procedure LabelUSBShowClick(Sender: TObject);
    procedure CheckBoxCapturePPInterLockClick(Sender: TObject);
    procedure CheckBoxPostShowCMDClick(Sender: TObject);
    procedure ButtonEditCaptureClick(Sender: TObject);
    procedure ComboBoxCapturePostFNameClick(Sender: TObject);
    procedure ComboBoxCapturePostFNameCloseUp(Sender: TObject);
    procedure ComboBoxCapturePostFNameDblClick(Sender: TObject);
    procedure MenuItemMacro1Click(Sender: TObject);
    procedure MenuItemMacro2Click(Sender: TObject);
    procedure ComboBoxCaptureEOLCharExit(Sender: TObject);
    procedure ComboBoxCaptureEOLCharChange(Sender: TObject);
    procedure CheckBoxCaptureEOLContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure ComboBoxCaptureEOLCharSelect(Sender: TObject);
    procedure SpeedButtonCancelSendDblClick(Sender: TObject);
    procedure ComboBoxComPortDropDown(Sender: TObject);


  private
    { Private declarations }
    CaptureStopTime:TDateTime;
    CaptureAutoQuit:boolean; //quit program when capture is done
    CaptureAutostart         :TAdCaptureMode; //triggers immediate capture after startup
    CaptureFileName:string; //saved so can be used by post-process.
    CaptureEOLChar:AnsiChar; //used for end-on-line and #lines
    SendStringAutostart:boolean;    //sends  string1 immediately after start
    SendStringAutostartAs: TSendAs; //what to send it as

    SendFileAutostart:boolean;
    SendFileAutoQuit:boolean; //quit program when sendfile is done
    CaptureIdleAutoQuitCount:cardinal; //used for quitting capture after sendfile, when port goes idle

    PortErrorQuit:boolean;   //quit program if commandline port opening fails
    PortWsErrorReopen:boolean; //flag so port retries after WsError
    SpyModeAutoStart:Boolean; //automatically starts SPY mode.

    LastCharCount:integer;//Cardinal;
    fCharCount:integer;
    fLineCount:integer;
    fEchoPortConnected:boolean; //as telnet ports can be open, but not connected to anything
    fMonitorLastCharPort:integer; //1=main port, -1=echo port, 0 at start. Used to do newline on direction change
    Color4Keyboard: TColor;
    Color4Port: TColor;
    Color4WriteChar: TColor;
    Color4SpyTx : TColor;
    Color4SpyRx : TColor;
    Color4Background : TColor;

    SendFileRepeatCounter:cardinal;

    PendingStuff:boolean; //if this is set, then others are checked
    PendingInvisible:boolean;
    PendingHelp:boolean;
    PendingInstall:boolean;
    PendingMessage:string;
    PendingWidth,PendingHeight:integer;

    Port1Changed:boolean;
    EchoPortChanged:boolean;
    AdShowAllEmulator : TAdTTYEmulator;
    CannedStrings: TStringlist;
//    DataTriggerCount:integer;
    IsCurrentDataTrigger:boolean;
    DataTriggerLightTimer:integer;
    FirstAvailablePort:word; //0 for none/not searched
    FDesignHeight: Integer;
    FDesignWidth: Integer;
    FPrevWidth: Integer;
    FPrevHeight: Integer;
    FScale:Integer; //form scale in %
    FResizeColumnsFromWidth:boolean;
    FIsWMSizeMove:boolean; //set/cleared by windows message when user is dragging window. Used to block endless resize calcs in form resize

 //   DeviceNotifier : TDeviceNotifier;
//    LastDataTriggerCount:integer;
//    SuppressPortScan:boolean;
//    PortScanLastPort:integer;
//    PortScanLastPortOnStartup:integer;
    procedure CaptureButtonsEnable(Enabled:boolean);
    procedure ShowSerialStatus(ForceShow:boolean;SendInfo:string='');
    procedure TrayIconLoadIcons;
    function OptimiseTerminalWidth(N:integer;IsNarrow:boolean=false):integer;
    procedure SetDisplayWidth(IsNarrow:boolean=false);
    procedure HideControls(Hide:boolean; NumRows:integer{;IsNarrow:boolean=false});
//    procedure Port1Trigger(CP: TObject; Msg, TriggerHandle, Data: Word);
    procedure SetCharCount(CC: integer); //keeps last<=current
    procedure IncCharCount(Increment:integer); //always safely wraps to 0
    procedure SendStringN(S:ansistring; N:integer=1;NLBefore:boolean=false;NLAfter:boolean=false);
    procedure SendTabSendString(S:ansistring{;AppendCR:boolean=false;AppendLF:boolean=false}); //sends string, controlled by SendTab global controls: CRC, Repeats etc
    procedure SendTabSendString1(SendAs:TSendAs); //Send STRING1
    procedure SendASCIIString(S:ansistring;AppendCR,AppendLF,StripSpaces:boolean); //sends a string, appending CRLF as chosen, a number of times
//    procedure SendTabSendASCIIString(S:ansistring;AppendCR,AppendLF,StripSpaces:boolean);
    procedure PositionFloatingButtons;
//    procedure Send2KCDXO(Add,Command,Data:string);
    procedure SetHalfDuplex(State:boolean); //wrapper for setting terminal HD
    procedure PopulateComNumbers(LastComport:integer; ShowForm:boolean; ForceSearch:boolean=false); //shell chooses between two methods depending on Window version
    procedure PopulateComNumbersFromRegistry;//(LastComport:integer; ShowForm:boolean);
    procedure PopulateComNumbersBySearch(LastComport:integer; ShowForm:boolean);
    procedure USBPortChange(Sender: TObject; Added:boolean; const DeviceStr: String); // of Object;
    procedure Port1PutChar(C:ansichar);
    procedure Port1PutString(S:ansistring);
    procedure SendCannedString(Index:integer); //index is 0 based
    procedure AddCannedString(AsText, AsChars :{ansi}string); //adds a canned string to the list if new
    procedure SetPortAndBaudCaptions; //writes menu and statusbar strings.
    procedure SetComPortClick(Sender: TObject); //changes the comport
    procedure SpyModeOpen(Open:boolean); //programatically enter start mode.
    procedure SignalWsConnectedThroughRTSDTR(Connected:boolean; OtherPort:TApdWinsockPort);
    function  IWBitValue:byte;
    procedure IWriteThenRead(WriteData:ansistring;BytesToRead:byte);
    procedure ItemIndexToHWFlowOptions(ItemIndex:integer;Port:TApdWinsockPort);
    procedure SHT(S:ansistring);
    function BL301LEDBitValue: byte;
    procedure SpiCSButtonClick(Sender:TObject; CommandStr:ansistring);
    procedure SetDataTriggerLight(IsTrigger:Boolean=true);
    function ICRBitValue:byte;
    function ICR2BitValue:byte;
    procedure ICRCommand(N:integer);
    procedure SpyOpen(State:boolean);
    function SpyDriversInstalled:boolean; //detect an install of the driver, using the Realterm driver installer.
    procedure ShowHideStatusBarFormattedData;
    procedure InvertAndMaskChars(Character: ansichar; var ReplaceWith:AnsiString);
    procedure PortErrorMessage(Msg:string);
    procedure WMHotKey(var Msg: TWMHotKey); message WM_HOTKEY; //global hotkey handler
    procedure WMEnterSizeMove(var Message: TMessage); message WM_ENTERSIZEMOVE;
    procedure WMExitSizeMove(var Message: TMessage); message WM_EXITSIZEMOVE;
    procedure WMDropFiles(var Msg: TWMDropFiles);  message WM_DROPFILES; //drag and drop file handler
    procedure WMSysCommand(var Msg: TWMSysCommand) ; message WM_SYSCOMMAND;
//    procedure WMDeviceChange(var Msg: TMessage); message WM_DEVICECHANGE; //detect USB changes
    //Hint is either statusbar simple or panel 0, so do selection here
    function  GetStatusBarHint:string;
    procedure SetStatusBarHint(S:string); overload;
    procedure SetStatusBarHint(S: string; IsError: boolean); overload;
    procedure FrameControl(C: Tcontrol; CL: Tcolor=clRed);
    //function  DirectoryExistsOrMakeIt(FName:string; MissingStr: string = 'Directory does not exist'):boolean; //true if DirExists when done
    property StatusBarHint : string read GetStatusBarHint write SetStatusBarHint; //Hint is either statusbar simple or panel 0
    procedure StatusBarHintTimeStampNow(ShowCaptureTimeStamp:boolean=true); //show a sample timestamp

    procedure SetStatusPanelWidth;
    procedure DonationLinkLabelChange;
    //procedure ClearStayOnTop(Sender: TObject);
    procedure ShowForm(F: TForm; Modal: Boolean=false);
    procedure SysMenuAddRemoveExtraItems(Add:boolean=true);
    //procedure ShowSysMenu;
    procedure ShowSysMenu(Show:boolean=true);
    procedure HTMLClick(Link: string);
    procedure ShowUpdateAvailable(Updater:TrtUpdate);
    procedure ShowPopupMenu(Handle: HMENU; Show: boolean=true);
    procedure ShowHint(var HintStr: String; var CanShow: Boolean;
      var HintInfo: THintInfo);
    function CapturePPMustMoveFile: boolean;
    procedure SetWSConnectLightOffColor(Port: TApdWinsockPort;
      A: TApdStatusLight);
    procedure SetEchoMonitoring;
    procedure IncLineCount(Increment: integer);
    procedure CapturePostProcess; //launch post process
  protected
    procedure ChangeRowsCols(NewRows,NewCols:integer; SetFormWidth:boolean=false); //row change without cursor changing
    procedure SetRowsColsFromFormSize(WhenGreaterBy:integer=0;SetCols:boolean=false;
                        ForceRows:boolean=false;ForceCols:boolean=false);
    procedure SetFormSizeFromRowsCols(SetWidthFromCols:boolean=false; MinWidthFromPanel:boolean=false);
    function PageControlAndBarsHeight:integer;
    procedure PortOpenTry(Port:TApdWinsockPort;Open:boolean=true);
    procedure SendFileStartSend(Reset:boolean=false);


  public
    CaptureMode:TAdCaptureMode;
    IsCapturing:boolean;
    IsSendingFile:boolean;
    CaptureSize:integer;
    CaptureLines:integer;
    LastCaptureCharWasEOL:boolean; //used for timed stop 
    CaptureTime:integer; //seconds
    CaptureTimeLeft:integer; //seconds
    CaptureCountForCallback:integer;
    CPS:integer;//cardinal;
    QuitNow:boolean; //makes timer routine close the program
    LastErrorMessage:string; //so you can get at it from the ActX when it doesn't show dialogs
    SendFileList:TFilenameList;
    Macro1:TStrings;
    Macro2:TStrings;

    property CharCount : integer read fCharCount write SetCharCount;
    property LineCount : integer read fLineCount;
    procedure StartCapture(CaptureMode: TAdCaptureMode; Restart:boolean=false);
    procedure StopCapture(Msg:string; CanRestart:boolean=false);
    function SelectTabSheet(TabCaption:string):boolean;
    //procedure Set_ComPort(Com:TApdWinsockPort; const Value: WideString);
    procedure DisplayHint(Sender: TObject);
    procedure SetTerminalCharColor(Sender:TObject;CharSource:TADCharSource;InvertColor:boolean=false);
    procedure SetColors(ColorString:ansistring);
    procedure ExecuteParameterString(S:string);
    procedure Port1Open(OpenPort:boolean);
    //function  ConvertString(S:ansistring; SendAs:TSendAs=sasLiteral; CRCType:integer=0; AppendCR:boolean=false; AppendLF:boolean=false; StripSpaces:boolean=false):ansistring;
    procedure SendString(S:ansistring; SendAs:TSendAs=sasLiteral; CRCType:integer=0; AppendCR:boolean=false; AppendLF:boolean=false; StripSpaces:boolean=false);
    //procedure SendString(S:ansistring); //sends a string
    procedure SendStringSlow(S:ansistring; milliseconds:cardinal);
    procedure SetCaption(S:string);
    procedure Donate(From:string='MN');
    procedure UpdateTrayIcon(IconStyle:TIconStyle=iconAuto; ForceAnimate:boolean=false);
    procedure AllHelp(JustLinks:boolean=false);

    { Public declarations }
  end;

var
  Form1: TForm1;
const
  StatusBarPanelHints=0;
  StatusBarPanelCharCount=1;
  StatusBarPanelCPS=2;
  StatusBarPanelEnd=3;
  PortScanLastPort:integer=MaxComHandles;
  PortScanLastPortOnStartup:integer=MaxComHandles;

//procedure SetGroupItemByString(Value:String; RadioGroup:TRadioGroup);
//procedure ComboBoxPutStringAtTop(CB:TComboBox; MaxLength:integer);
//procedure ComboBoxPushString(CB:TComboBox; S:string; Maxlength:Integer=100);

implementation

uses RealtermIntf,{Ststrs,}Ststrl,StUtils,math,ComServ, adSelCom, Registry,
     M545X, EscapeString, ModbusCRC{, gnugettextD5},SpyNagDialog, ShellApi,
  RTAboutBox, {D6OnHelpFix,} DateUtils, ScanPorts, AdPackEd, StrUtils, CRC8, HexEmulator,
  Checksums, I2Cx, ComportFinder, ParameterHandler,Parameter_INI_Dialog,GlobalHotKeys,
  system.TypInfo,System.UITypes,System.Types, CRC, Helpers, TimeStamps, ConsoleConnector, BL233_EEProm,
  CodeSignChecker1,DeviceChangeNotifier,NoSleep,InstallTourDlg1,IOUtils;

{$R *.DFM}
const CRLF=chr(13)+chr(10); CR=#13;

var F: file;
    Block : array[0..1023] of AnsiChar;
    TimerHandle : word;
    CurrentEmulator : TAdTerminalEmulator;
//    KAdjustingF0:boolean; //set while F0 is being adjusted

    SaveOnTrigger:TTriggerEvent; //save port trigger handler during direct capture
    NoNagAboutSpy:boolean;
    PlainCapture:boolean;
    TimeStampDelimiter:ansichar;

var HexEmulator : THexEmulator;
var WProc:pointer;

function AppWndProcWMCopyData(Handle: hWnd; Msg, wParam, lParam: Cardinal): LongInt; stdcall; forward;
procedure SetI2CAddress(NewAddress:word; ChipName:string); forward;
function GetI2CAddress(IncludeSubAddress:boolean):word;  forward;


//const Capturing:boolean=false;
//interlocks the capture buttons

//procedure SetSpinEditValue(Spin:TSpinEdit; Value:integer);
//var OnChangeEvent: TNotifyEvent;
//begin
//  OnChangeEvent:=Spin.OnChange;
//  Spin.OnChange:=nil;
//  Spin.Value:=Value;
//  Spin.OnChange:=OnChangeEvent;
//end;
//procedure SetGroupItemByString(Value:String; RadioGroup:TRadioGroup);
//  var i:integer;
//      ThisItem:string;
//begin
//  Value:=uppercase(Value);
//  for i:=0 to RadioGroup.ControlCount-1 do begin
//    ThisItem:= uppercase(RadioGroup.Items[i]);
//    if Value[1]= ThisItem[1]
//      then begin
//        RadioGroup.ItemIndex:=i; // set when match found
//        exit;
//      end;
//  end;
//  //no match
//  //no error handler, just ignore
//end;
procedure TForm1.SetTerminalCharColor(Sender:TObject;CharSource:TADCharSource;InvertColor:boolean=false);
//var temp:integer;
begin
  with sender as TAdTerminalEmulator do begin
  //Buffer.BackColor:=Color4Background; //added to try and make ansi emulator have right background
  case CharSource of
    csUnknown: ;
    csKeyboard: Buffer.ForeColor:= Color4Keyboard;
    csPort: begin
              if not CheckBoxCaptureDisplay.Checked then IncCharCount(1); //incs first in captur handler
              Buffer.ForeColor    := Color4Port;
            end;
    csWriteChar: Buffer.ForeColor:=Color4WriteChar;
    //else
  end; //case
  //doing invert here resulted in loss of chars when strings sent fast - using ecReverese command now on ProcessChars
//  if InvertColor then begin
//    Temp:=Buffer.ForeColor;
//    Buffer.ForeColor:=Color4Background;
//    Buffer.BackColor := Temp;
//  end;
  end; //with
end;
function TForm1.GetStatusBarHint:string;
begin
  if StatusBar1.SimplePanel
    then result:=StatusBar1.SimpleText
    else result:=StatusBar1.panels[0].Text;
end;

procedure TForm1.SetStatusBarHint(S:string; IsError:boolean); //Hint is either statusbar simple or panel0
begin
  if StatusBar1.SimplePanel
    then StatusBar1.SimpleText := S
    else StatusBar1.panels[0].Text:= S;
  if IsError
    then begin
      StatusBar1.Color:=clRed;
      //FrameControl(StatusBar1);
      Application.HintPause:=2500;
    end
    else begin
      StatusBar1.Color:=clBtnFace;
      //FrameControl(StatusBar1,-1);
      Application.HintPause:=750;
    end;
//  StatusBar1.SimpleText := S;
//  StatusBar1.panels[0].Text:= S;
end;

procedure TForm1.SetStatusBarHint(S:string); //Hint is either statusbar simple or panel0
begin
  SetStatusBarHint(S,false);
//  if StatusBar1.SimplePanel
//    then StatusBar1.SimpleText := S
//    else StatusBar1.panels[0].Text:= S;
end;

procedure TForm1.DisplayHint(Sender: TObject);
begin
  StatusBarHint:=GetLongHint(Application.Hint);
  //sender is never the control for the hint
end;
//http://docs.embarcadero.com/products/rad_studio/delphiAndcpp2009/HelpUpdate2/EN/html/delphivclwin32/Forms_TApplication_OnShowHint.html
procedure TForm1.ShowHint(var HintStr: String; var CanShow: Boolean; var HintInfo: THintInfo);
begin
  //replace \r with CR
  HintStr:= ExpandEscapeCRString(HintStr);
  StatusBarHint:=ExpandEscapeCRString(GetLongHint(Application.Hint));

//  if HintInfo.HintControl = SpeedButton3 then
//  begin
//    with HintInfo do
//    begin
//      HintColor := clAqua;{ Changes only for this hint }
//      HintMaxWidth := 120;{Hint text word wraps if width is greater than 120 }
//      Inc(HintPos.X, SpeedButton3.Width); { Move hint to right edge }
//    end;
//  end;
end;
procedure TForm1.Port1PutString(S:ansistring);
begin
  SendString(S);
end;

procedure TForm1.Port1PutChar(C:ansichar);
begin
  Port1.PutChar(C);
  if CheckBoxHalfDuplex.checked then AdTerminal1.WriteString(C);
end;

//try to find a page with the matching caption (case independent)
function TForm1.SelectTabSheet(TabCaption:string):boolean; //true if Caption is found
 var I:integer; ThisCaption:string; TabNum:integer;
begin
  result:=false;
  TabNum:=StrtoIntDef(TabCaption,-1); //if given a number, then it is not -1
  dec(TabNum); //make tabnums 1 based
  TabCaption:=uppercase(TabCaption);
  for I:=0 to PageControl1.PageCount-1 do begin
    ThisCaption:=uppercase(PageControl1.Pages[I].Caption);
    ThisCaption:=stringreplace(ThisCaption,'&','',[rfReplaceAll]);
    if (ThisCaption = TabCaption) or (I=TabNum)  then begin
      PageControl1.ActivePage:=PageControl1.Pages[I];
      PageControl1.Pages[I].visible:=true; //in case page was hidden
      PageControl1.Pages[I].TabVisible:=true; //in case page was hidden
      result:=true;
    end;
  end;
end; //select tab

const MAXLENGTHOFMENUCAPTION=20;

procedure TForm1.MenuItemAboutClick(Sender: TObject);
begin
  ShowForm(AboutBox,true);
end;

procedure TForm1.AddCannedString(AsText, AsChars :string{ansistring}); //adds a canned string to the list if new
  var index:integer;

  procedure RenumberMenuItems;
  begin
    //for i:=
  end;
  procedure InsertMenuItem(index:integer); //index is 0 based
    var base :integer;
        mi:TMenuItem;
  begin
    base:=MenuItemSend.Indexof(MenuItemSendString1); //get base index of string menu items
    //if base+index >= MenuItemSend.Count then exit; //check exists

    mi:=TMenuItem.Create(Self);
    if length(AsText)>MAXLENGTHOFMENUCAPTION
      then  mi.Caption:=copy(AsText,1,MAXLENGTHOFMENUCAPTION-3)+'...'
      else mi.Caption:=AsText;
    mi.OnClick:=MenuItemSendStringClick;
//    inttostr(index+1)
    mi.Shortcut:=Shortcut(Word(1), [ssCtrl]);
    mi.Tag:=index;

//    MenuItemSend.Insert([base+index],mi);
    mi.destroy;
  end;

begin
    if length(AsChars)=0 then exit; //don't want to try and add...
    index:=CannedStrings.IndexOf(AsChars);
    if index>=0 //if exists then move to top of list, otherwise add
      then begin
        CannedStrings.Delete(index);
        CannedStrings.Insert(0,AsChars);
//        SetMenuItem(0);
        end
      else begin //doesn't exist
        if CannedStrings.Count >= 9 //max length of list
          then CannedStrings.Delete(CannedStrings.Count - 1); //delete last item in list
        CannedStrings.Insert(0,AsChars);
//        SetMenuItem(0);
      end;
end;
procedure TForm1.CaptureButtonsEnable( Enabled : boolean);
  var CL:TColor;
begin
    ButtonCaptureOverwrite.enabled:=enabled;
    ButtonCaptureAppend.enabled:=enabled;
    ButtonCaptureStop.enabled:=not enabled;
//    Capturing:= not Enabled;
    RadioGroupCaptureSizeUnits.enabled:=Enabled;
    ComboBoxCaptureSize.enabled:=Enabled;
    CheckboxDirectCapture.enabled:=Enabled;

    if Enabled
      then CL:=clBtnFace
      else CL:=clRed;
    GroupBoxCapture.color:=CL;
    PanelSpecialCapture.Enabled:=Enabled;
    PanelSpecialCapture.color:=CL;

end;

//TForm1.CaptureButtonsState(Enabled:boolean)
const NO_SLEEP_TRAYICON_STRING = ' SLEEP BLOCKED'; //appended when NoSleep
procedure TForm1.StartCapture(CaptureMode: TAdCaptureMode; Restart:boolean=false);
  const SavedTrayIcon1Hint:string='';

  procedure CaptureFileErrorMessage(E:exception);
  begin
    console.showmessage('Unable to Open/Create capture file'+CRLF+'  '+CaptureFileName+CRLF+ E.message);
  end;
begin //startcapture
  if ((self.CaptureMode<>CaptureMode) or Restart) then begin //don't call it if you are already there

  if (CaptureMode=cmOff)  //close
    then begin
      StopCapture('');
    end
    else  begin
      //open the capture file
      SelectTabSheet('Capture'); //select tab when called from interface
      if not Port1.Open then begin
          console.showmessage('Port must be open to capture!');
          SelectTabSheet('Port');
          exit;
      end;
      CharCount:=0; //also clears LineCount
      if ( CaptureTime>0)
        then CaptureStopTime:=now+(CaptureTime/(3600*24))
        else CaptureStopTime:=0;
      if ( CaptureTime>0) or (CaptureSize>0 ) or (CaptureLines>0) then begin
        ProgressBarCapture.Position:=0;
        ProgressBarCapture.visible:=true;
      end;
      if Restart then begin
         CloseFile(F);
         CapturePostProcess;
      end;
      //CaptureFileName:= ComboBoxSaveFname.text;
      CaptureFileName:= ExpandEnvVars(ComboBoxSaveFname.text);

      if (RadioGroupCaptureAutoFileName.ItemIndex<>0) and (CaptureMode<>cmAppend)
        then CaptureFileName:=MakeAutoFileName(CaptureFileName, RadioGroupCaptureAutoFileName.ItemIndex); //add time to name if needed...
        ComboBoxSaveFName.hint:='Actual Filename: '+ ExtractFileName(CaptureFileName)+'\r'
          +CaptureFileName;
      //ComboBoxSaveFName.longhint:='Actual Filename: '+CaptureFileName;
      if not DirectoryExistsOrMakeIt(CaptureFileName,'Directory must exist to capture')
        then begin
          SelectTabsheet('Capture');
          exit;
        end;

      if Restart then begin
         //CloseFile(F);
         //CapturePostProcess;
         try
           AssignFile(F,CaptureFileName);
           rewrite(F,1);
         except
           on E: exception do begin
             CaptureFileErrorMessage(E);
             closefile(F);
             exit;
           end;
         end;
         StatusBarHint:='Restart Capture: '+ ExtractFileName(CaptureFileName);
         exit;
      end;

      PlainCapture:= not (CheckboxCaptureAsHex.checked or (RadioGroupTimeStamp.ItemIndex>0) );
      case RadioGroupTimeStampDelimiter.ItemIndex of
        0: TimeStampDelimiter:=',';
        1: TimeStampDelimiter:=' ';
        2: TimeStampDelimiter:=ansichar(RadioGroupTimeStampDelimiter.Items[2][1]); //should only be a single char
      end; //case

      Form1.ComboBoxSaveFname.PutStringAtTop(10);
      if CheckboxCapturePostProcess.Checked then Form1.ComboBoxCapturePostFname.PutStringAtTop(10);

      CurrentEmulator:=AdTerminal1.Emulator; //save emulator for later...
      if not CheckBoxDirectCapture.checked
        then begin    //use terminal capture function...
          try
            AdTerminal1.Emulator:=AdEmulator_VT100;
            Port1.FlushInBuffer;
            //AdTerminal1.CaptureFile:=comboboxstring(Form1.ComboBoxSaveFname);
            AdTerminal1.CaptureFile:=CaptureFileName; //Form1.ComboBoxSaveFname.text;
            AdTerminal1.Capture:=CaptureMode;
            //AdTerminal1.visible:=not CheckBoxHideTerminal.checked; //hide it...
            //CaptureButtonsEnable(false);
            IsCapturing:=true;
            Form1.CaptureMode:=CaptureMode;
          except
            on E:exception do begin
              CaptureFileErrorMessage(E);
              //CaptureButtonsEnable(true);
              AdTerminal1.Emulator:=CurrentEmulator;
              end;
            //console.showmessage('Unable to open capture file');
          end;
        end
        else begin  //if direct capture
          AdTerminal1.Active:=CheckBoxCaptureDisplay.Checked; //false;
          try
            //AssignFile(F,comboboxstring(Form1.ComboBoxSaveFname));
            AssignFile(F,CaptureFileName); //Form1.ComboBoxSaveFname.text);
            if (CaptureMode=cmAppend)
              then begin
                  //showmessage('Append in direct Not available yet')//append(F,1)
                  //append is a text file only function, and has probs w/ ^Z's
                  reset(F,1);
                  Seek(F, FileSize(F));
                  end
              else rewrite(F,1);
            Port1.FlushInBuffer;
            SaveOnTrigger:=Port1.OnTrigger;
            Port1.OnTrigger:=Port1TriggerCaptureWrite;
            TimerHandle:=Port1.AddTimerTrigger;
            Port1.SetTimerTrigger(TimerHandle, 2, True);  //110ms interrupt
            //CaptureButtonsEnable(false);
            IsCapturing:=true;
            Form1.CaptureMode:=CaptureMode;
          except
            on E: exception do begin
            CaptureFileErrorMessage(E);
            //console.showmessage('Unable to Open/Create capture file'+CRLF+'  '+CaptureFileName+CRLF+ E.ToString+ E.message);
            //CaptureButtonsEnable(true);
            Port1.RemoveAllTriggers;
            AdTerminal1.Active:=true;
            try
              CloseFile(F);
            except
            end;
            end;
          end; //try
        end;
        //Form1.GroupBoxCapture.color:=clRed;
        //PanelSpecialCapture.Enabled:=false; //prevent mode changes during capture
        //PanelSpecialCapture.color:=clRed;
        if (CaptureIdleAutoQuitCount<>0) //has not been explicitly set on commandline etc
          then StatusBarHint:='Waiting until Idle or Capture Secs to stop'
      end;
    end; //if needs to be done
    CaptureButtonsEnable(not IsCapturing);
    if IsCapturing//MenuItemCapture.Checked
      then begin
        BlockSleep(CheckboxNoSleep.Checked);
        SavedTrayIcon1Hint:=TrayIcon1.Hint;
        MenuItemCapture.Caption:='Stop &Capture';
        TrayIcon1.Hint:= TrayIcon1.Hint+ ':Capturing';
        if CheckboxNoSleep.Checked
          then TrayIcon1.Hint:= TrayIcon1.Hint+ NO_SLEEP_TRAYICON_STRING;

        if CaptureAutoQuit
          then begin
            MenuItemClose.Caption:='&Close (AutoQuit when capture ends)';
            TrayIcon1.Hint:= TrayIcon1.Hint+ ':AutoQuit';
          end;
      end
      else begin
        MenuItemCapture.Caption:='Start &Capture';
        TrayIcon1.Hint:=SavedTrayIcon1Hint;
      end;
  end; //StartCapture
procedure TForm1.RadioGroupCaptureAutoFileNameClick(Sender: TObject);
begin
  CheckBoxCapturePPInterLockClick(nil);
  if RadioGroupCaptureAutoFileName.ItemIndex<>3 then MakeAutoFileName(''); //reset sequential count
  StatusBarHint:=MakeAutoFileName('<filename>.<ext>',RadioGroupCaptureAutoFileName.ItemIndex,false);
end;
const PP_MOVE_NAME_EXTRA_BIT='-moved';
procedure TForm1.CheckBoxCapturePPInterLockClick(Sender: TObject);
begin
  if CapturePPMustMoveFile
  then RadioGroupCaptureAutoFileName.Items[0]:=PP_MOVE_NAME_EXTRA_BIT
  else RadioGroupCaptureAutoFileName.Items[0]:='Off';
  //if CheckBoxCapturePostProcess.Checked then begin
  CheckBoxPostShowCMD.Visible:=CheckBoxCapturePostProcess.Checked;
  //end;
end;
function TForm1.CapturePPMustMoveFile:boolean;
//deal with race condition: move file before next capture starts
begin
  result:=CheckboxCaptureRestart.Checked and CheckboxCapturePostProcess.Checked
    and (RadioGroupCaptureAutoFileName.ItemIndex=0);
end;
procedure TForm1.CapturePostProcess;
    procedure RenamePPFile(var F:string);
    begin
      F:=ExtractFilePath(F)+TPath.GetFileNameWithoutExtension(F)+PP_MOVE_NAME_EXTRA_BIT+TPath.GetExtension(F)
    end;
var cline,PPFileName:string; WinState:integer; KeepCMDOpen:boolean;
begin
  KeepCMDOpen:=CheckBoxPostShowCMD.checked or (CheckBoxPostShowCMD.State=cbGrayed);
  if Form1.Visible then begin
    if (Form1.WindowState=wsMinimized)
      then WinState:=SW_SHOWMINIMIZED
      else WinState:=SW_SHOWMINIMIZED;//SW_SHOWNORMAL;
  end
  else WinState:=SW_HIDE;
  if KeepCMDOpen then Winstate:=SW_SHOWNORMAL;
  PPFileName:=CaptureFileName;   //default: use capfilename for PP
  if CapturePPMustMoveFile then begin
    RenamePPFile(PPFileName);
    MoveFile(PChar(CaptureFileName), PChar(PPFileName)); //rename the file
  end;
  PPFileName:=ExpandEnvVars(PPFileName);
//  cline:= '/C '+QuoteFileName(ComboboxCapturePostFName.text)+' '+CaptureFileName ;
  if KeepCMDOpen then Cline:='/K ' else cline:='/C ';
  
  cline:= cline+QuoteFileName(ExpandEnvVars(ComboboxCapturePostFName.text))+' '+PPFileName ;
  if CheckBoxPostShowCMD.State=cbGrayed then
    if not InputQuery('Realterm Capture Post-Process Debugging',
     'Char Count='+inttostr(CharCount)+CR
     +'cmd will stay open'+CR+CR
     +'Execute this Commandline?'+CR
     ,
    cline) then exit; //don't PP
  LastErrorMessage:='PostProcess '+inttostr(CharCount)+'chars; CommandLine='+CRLF+'cmd.exe'+' '+cline;
  if CheckboxCapturePostProcess.Checked then begin
      ShellExecute(0, nil, 'cmd.exe', pwidechar(cline), nil, WinState);
  end;
end;
procedure TForm1.StopCapture(Msg:string; CanRestart:boolean=false);
begin
  if CheckBoxDirectCapture.checked
    then begin
      if (CheckBoxCaptureRestart.checked and CanRestart) then begin //only automatic stops, and direct capture will restart
        StartCapture(cmOn,true);
        exit;
      end;
      Port1.RemoveTrigger(TimerHandle);
      CloseFile(F);
      CapturePostProcess;
      Port1.OnTrigger:=SaveOnTrigger; //restore to the way it was
      end;
  if AdTerminal1.Emulator<>CurrentEmulator
    then AdTerminal1.Emulator:=CurrentEmulator;
  AdTerminal1.Capture:=cmOff;
  AdTerminal1.ClearAll; //was ClearBuffer;
  AdTerminal1.Visible:=true;
  AdTerminal1.Active:=true;
  Form1.CaptureMode:=cmOff;
  CaptureButtonsEnable(true);
  //Form1.GroupBoxCapture.color:=clBtnFace;
  MenuItemCapture.Caption:='Start &Capture';
  IsCapturing:=false;
  //PanelSpecialCapture.Enabled:=true;
  //PanelSpecialCapture.color:=clBtnFace;
  if (length(Msg)>0) then StatusBarHint:=Msg;
  //TRealtermIntf(ComServer).SendEventOnCaptureStop;
  if (ComServer.StartMode=smAutomation) then begin
      RTI.SendEventOnCaptureStop;
      end;
  BlockSleep(false);
  //Formclose is moved into timer to remove an error thrown with "capquit"
  //if CaptureAutoQuit then Form1.close; //end application
end; //StopCapture
procedure TForm1.ButtonCaptureOverwriteClick(Sender: TObject);
begin
  StartCapture(cmOn);
end;

procedure TForm1.ButtonCaptureAppendClick(Sender: TObject);
begin
  StartCapture(cmAppend);
end;
//function IntToStr(Value: Integer): ansistring; overload;
//function IntToStr(Value: Integer): ansistring; overload;
//begin
//  ansistring(IntToStr(Value));
//end;

procedure TForm1.Port1TriggerCaptureWrite(CP: TObject; Msg, TriggerHandle, Data: Word);
//original routine to do direct capture
var NumCharsToRead : cardinal;
const TimeStampNextChar:boolean=false;

procedure FormatAndWriteBlock;
var i:integer; C:ansichar; //TD,TS:tdatetime;
    S:ansistring;
begin
  if CharCount=0 then TimeStampNextChar:=true; //always put timestamp at the start of the file
  for i:=0 to NumCharsToRead-1 do begin
    C:=Block[i];
   if  RadioGroupTimeStamp.ItemIndex>0 then begin //if desire timestamp
     if ((C=ansichar(10)) or (C=ansichar(13)))
       then begin
         TimeStampNextChar:=true;
       end
       else begin
         if TimeStampNextChar then begin  //emit timestamp
              S:=TimeStampStr(RadioGroupTimeStamp.ItemIndex, now, ComboboxTimeStampFormat.Text) + TimeStampDelimiter;
              Blockwrite(F,S[1],length(S));
            TimeStampNextChar:=false; //clear for next time....
         end;
       end;
   end;//has timestamp
   if CheckBoxCaptureAsHex.Checked
      then begin
        S:=inttohex(integer(C),2);
        Blockwrite(F,S[1],2);
      end
      else begin
        Blockwrite(F,C,1);
      end;

  end; //for each char in block....
end; //formatandwriteblock
var BeforeCharCount:integer; BlockPtr:integer;
begin
  //check for data and write to a file...
  while ( Port1.InBuffUsed > 0 ) do begin
      NumCharsToRead:=Port1.InBuffUsed;
        if (NumCharsToRead > sizeof(Block))
            then NumCharsToRead:= sizeof(Block);
        try
//          Port1.GetBlock(Block, NumCharsToRead);

          if not (CheckBoxCaptureEOL.Checked or (CaptureLines>0)) then begin
            Port1.GetBlock(Block, NumCharsToRead);
          end else begin
            Port1.PeekBlock(Block, NumCharsToRead);
            BlockPtr := 0;
            //look for EOL
            repeat //for all chars or until enough lines
              LastCaptureCharWasEOL:= (Block[BlockPtr]=CaptureEOLChar);
              inc(BlockPtr);
              if LastCaptureCharWasEOL then begin
                inc(fLineCount);
                if (CaptureLines>0) and (fLineCount>=CaptureLines) then break; //done Lines or timeout
                if CheckBoxCaptureEOL.Checked and (CaptureSize>0) and ( CharCount+BlockPtr>=CaptureSize ) then break; //done
              end;
            until (BlockPtr>=NumCharsToRead);
            NumcharsToRead:=BlockPtr;  //sp
            Port1.GetBlock(Block, BlockPtr);
          end;

          if PlainCapture
            then BlockWrite(F,Block,NumCharsToRead)
            else FormatAndWriteBlock;//BlockWrite(F,Block,NumCharsToRead);//FormatAndWriteBlock
          BeforeCharCount:=CharCount;
          IncCharCount(NumCharsToRead); //as displayfn is also counting
          if ((CaptureSize>0) and ( CharCount>=CaptureSize )
               and (not CheckBoxCaptureEOL.Checked or LastCaptureCharWasEOL) )
            or ((CaptureLines<>0) and (fLineCount>=CaptureLines))
            then begin
              StopCapture('Capture stopped: Size Reached',true);
            end;
          if (CaptureCountForCallback>0) and     //?want to callback at all?
             ( CharCount>=CaptureCountForCallback) and  //have reached the count?
             ( CaptureCountForCallback > BeforeCharCount ) //but only do 1st time
             then begin
            //StopCapture;
               RTI.SendEventOnCaptureCount; //for direct capture....
            end;

        except
          {
          on E : EAPDException do
            if (E is EBadHandle) then begin
              ...fatal memory overwrite or programming error
              halt;
            end else if E is EBufferIsEmpty then begin
              ...protocol error, 128 bytes expected
              raise;

            end; }
        end; //except
  end; //while
//  if ((CaptureStopTime>0) and (now>=CaptureStopTime))
//    then begin
//    StopCapture;
//  end;
  //ShowSerialStatus;
end;

procedure TForm1.Port1TriggerEchoOut(CP: TObject; Msg, TriggerHandle, Data: Word);
var NumCharsToRead : word;
    Block : array[0..1023] of AnsiChar;
begin
 if CheckBoxEchoPortMonitoring.Checked and ( Port1.InBuffUsed > 0 ) then begin
    if CheckBoxMonitorNewLineOnDirectionChange.checked
       and (fMonitorLastCharPort=-1) then //lastchar from echo port
                  TerminalNewLine;
    fMonitorLastCharPort:=1;
 end;
  //check for data and write to echo port if it is on...
  while CheckBoxEchoOn.Checked
       and ( Port1.InBuffUsed > 0 )
       and EchoPort.Open
       and (EchoPort.OutBuffFree>=sizeof(Block))
       and ((EchoPort.DeviceLayer<>dlWinsock) or FEchoPortConnected) //when telnet,only if there is somewhere for the chars to go.
      do begin
        NumCharsToRead:=Port1.InBuffUsed;
        if (NumCharsToRead > sizeof(Block))
            then NumCharsToRead:= sizeof(Block);
        try
          Port1.GetBlock(Block, NumCharsToRead);
          EchoPort.PutBlock(Block,NumCharsToRead);
        except
          raise;
          {
          on E : EAPDException do
            if (E is EBadHandle) then begin
              ...fatal memory overwrite or programming error
              halt;
            end else if E is EBufferIsEmpty then begin
              ...protocol error, 128 bytes expected
              raise;

            end; }
        end; //except
  end; //while
end;


//gets chars from the echo port and sends them to PORT1 if it is open
procedure TForm1.EchoPortTrigger(CP: TObject; Msg, TriggerHandle,
  Data: Word);
var NumCharsToRead : word;
    Block : array[0..1023] of ansiChar;
  procedure PutBlockInTerminal;
  var i:word;
  begin
    for i:=0 to (NumCharsToRead-1) do begin
      assert({(i>=0) and }(i<=1023));
      AdTerminal1.WriteChar(Block[i]);
    end;
  end;

begin
  //check for data and write to a file...
  if (Port1.open and (CheckBoxEchoOn.Checked or CheckBoxEchoPortMonitoring.Checked) ) //echo to port1
    then begin //there is somewhere to put them...
      while ( EchoPort.InBuffUsed > 0 ) and (Port1.OutBuffFree> sizeof(Block)) do begin
            NumCharsToRead:=EchoPort.InBuffUsed;
            if (NumCharsToRead > sizeof(Block))
                then NumCharsToRead:= sizeof(Block);
 //           try
              EchoPort.GetBlock(Block, NumCharsToRead);
              if CheckBoxEchoOn.Checked then
                  Port1.PutBlock(Block,NumCharsToRead);
              if CheckBoxEchoPortMonitoring.Checked then begin
                if CheckBoxMonitorNewLineOnDirectionChange.checked
                    and (fMonitorLastCharPort=1) then //lastchar from main port
                  TerminalNewLine;
                PutBlockInTerminal;
                fMonitorLastCharPort:=-1;
              end;
 //           except
 //                 raise;
              {
              on E : EAPDException do
                if (E is EBadHandle) then begin
                  ...fatal memory overwrite or programming error
                  halt;
                end else if E is EBufferIsEmpty then begin
                  ...protocol error, 128 bytes expected
                  raise;

                end; }
//            end; //except
      end; //while
      end
    else begin
      while ( EchoPort.InBuffUsed > 0 ) do begin
        NumCharsToRead:=EchoPort.InBuffUsed;
        if (NumCharsToRead > sizeof(Block))
              then NumCharsToRead:= sizeof(Block);
        EchoPort.GetBlock(Block, NumCharsToRead); //default is to leave the port open and just empty the buffer
        if CheckBoxEchoPortMonitoring.Checked then PutBlockInTerminal;
      end; //while
    end; //if

end; //proc


procedure TForm1.ButtonCaptureStopClick(Sender: TObject);
begin
  CaptureAutoQuit:=false; //don't autoquit when stop button pressed
  StopCapture('Capture stopped manually');
end;

procedure TForm1.SetCharCount(CC: integer);
begin
  fCharCount:=CC;
  if CC=0      //ensure that lastcharcount is always <= Charcount
    then begin
      LastCharCount:=0;
      fLineCount:=0;
      StatusBar1.Panels[StatusBarPanelCharCount].Text:='Chars:0';
    end;
end; //TForm1.SetCharCount
procedure TForm1.IncCharCount(Increment:integer); //always safely wraps to 0
begin
  try
    fCharCount:=fCharCount+Increment;
  except
    fCharCount:=0;
  end;
end; //TForm1.IncCharCount
procedure TForm1.IncLineCount(Increment:integer); //always safely wraps to 0
begin
  try
    fLineCount:=fLineCount+Increment;
  except
    fLineCount:=0;
  end;
end; //TForm1.IncCharCount


procedure TForm1.TrayIconLoadIcons;
var
    Icon:TIcon;
    StyleName,IconName, MissingName:string;
    iStyle,J:integer;
begin
  if (TrayIcon1.Icons<>nil)
    then TrayIcon1.Icons.Clear;
   MissingName:='';
   Icon:=TIcon.Create;
   TrayIcon1.Icons := TImageList.Create(Self);
   Icon.Handle := LoadIcon( HInstance ,pchar('iconIdle') );
   TrayIcon1.Icon.Assign(Icon);
  //iconAuto does not have actual icon files - it tells routines to Autoselect one
  for iStyle := ord(iconAuto)+1 to ord(high(TIconStyle)) do begin
    StyleName:=GetEnumName(TypeInfo(TIconStyle),iStyle);
    for J := 0 to 3 do begin    //for each style there are 4 sequential animation icons
      IconName:=StyleName+inttostr(J+1);
      Icon.Handle := LoadIcon( HInstance ,pchar(IconName) ); //try to get Animated icon
      if (Icon.Handle=0)
        then Icon.Handle := LoadIcon( HInstance ,pchar(StyleName) ); //otherwise get static one (ie 4 times)
      if (Icon.Handle=0)
        then begin
          MissingName:=StyleName; //this will just show one error message even if many missing
          Icon.Handle := LoadIcon( HInstance ,pchar('iconIdle') ); //if it is completely missing try to bog over it...
        end;
      TrayIcon1.Icons.AddIcon(Icon);
    end; //for
  end;//for
  if MissingName<>'' then console.showmessage('Error: Missing ICON while loading'+MissingName);
  Icon.Free;
end;//proc

procedure TForm1.UpdateTrayIcon(IconStyle:TIconStyle=iconAuto; ForceAnimate:boolean=false);

//sets to the icon NAME, if Iconname is '', animates the icon
var
  //AppIcon : TIcon;
  //ChangeIcon : boolean;
  IconNum:integer;
  const AnimateSequence :integer =1;
  const LastIconNum : integer =-1; //trigger update on first run through
begin
  //ChangeIcon:=false;
  //Decide what icon to use...
  if (IconStyle=iconAuto)
    then begin //autoselect the style...Priority list as below
      if IsCurrentDataTrigger
        then IconStyle:=iconMatch
        else if IsCapturing
            then IconStyle:=iconCap
            else if IsSendingFile
                  then IconStyle:=iconSend
                  else if not AdTerminal1.ComPort.Open
                          then begin
                              AnimateSequence := 1;
                              IconStyle:=iconClosed; //iconIdle
                          end
                          else if (AdTerminal1.ComPort.DeviceLayer=dlWinsock)
                                    and not ApdStatusLightConnected.Lit //and port open
                                  then IconStyle:=iconWSDisconnect
                                  else IconStyle:=iconOpen;
      //bump animate if chars coming in...
    end;// iconAuto
    if (CPS>=1) or ForceAnimate
      then begin
        //ChangeIcon:=true;
        AnimateSequence := AnimateSequence + 1;
        if AnimateSequence > 4 then begin
          AnimateSequence := 1;
        end;
    end;

  IconNum:=(ord(IconStyle)-1)*4 + AnimateSequence-1; //address the desired icon
  if (IconNum <> LastIconNum) then begin
      //if ChangeIcon then begin
      TrayIcon1.IconIndex:=IconNum; //select the icon  (out of range index is OK)
        if Visible or (LastIconNum<0) then begin
          TrayIcon1.Icons.GetIcon(IconNum,Application.Icon);
          TrayIcon1.Icons.GetIcon(IconNum,Form1.Icon);
        end;
      LastIconNum:=IconNum;
 //     TrayIcon1.Icons.GetIcon(ord(iconClosed),ImageStatusIcon.Picture.Graphic. );
    end;
end; //updatetrayicon
procedure TForm1.ShowSerialStatus(ForceShow:boolean;SendInfo:string='');
  var CPSSendFile:integer;//cardinal;
  //const LastCharCount:cardinal = 0;
  LineErrorStr:string;
  const LineErrorLightTimer :cardinal =0; LastCharCountSendFile:integer{cardinal}=0;
  const SendInfoStr:string='';
    function CalcCPS(const CharCount: integer{Cardinal};
                 var CPS, LastCharCount: integer{Cardinal}): Boolean;
    var dCC:integer{cardinal};
    begin
      // CC:=CharCount;
      if (LastCharCount <> CharCount) or ForceShow then
      begin
        result := true;
        dCC:=(CharCount - LastCharCount);
        if (dCC>=1)
          then CPS := dCC * 1000 div Timer1.Interval
          else CPS:=0;
//        try // trap numeric overflow problems
//          CPS := max(0,(CharCount - LastCharCount)) * 1000 div Timer1.Interval;
//        except
//          CPS := 0;
//        end;
      end
      else
      begin // last=this ie no data
        CPS := 0;
        result := false;
      end;
      LastCharCount := CharCount;
    end; // fn

    function CPSString(CPS: integer): string;
    begin
      if (CPS < 10000) then
        result := 'CPS:' + inttostr(CPS)
      else
        result := 'CPS:' + inttostr(CPS div 1000) + 'k';
    end; // fn
var ActualBytesTransferred, ActualBytesRemaining:integer;
const FileLength:integer=0;
begin
  if CalcCPS(CharCount,CPS,LastCharCount) then
     StatusBar1.Panels[StatusBarPanelCharCount].Text:='Chars:'+IntToStr(CharCount);
  StatusBar1.Panels[StatusBarPanelCPS].Text:=CPSString(CPS);

  if IsSendingFile then begin
    if length(SendInfo)>0 then SendInfoStr:=SendInfo; //save info for this file
    if TimerSendFile.Enabled
      then LabelProtocolError.Caption:='Pause '+inttostr(SpinEditFileSendDelay.Value)+'ms #'+inttostr(SendFileRepeatCounter)
      else
    //trying to make BytesRemaing accurate, but issues seem fundamental....
    if ApdProtocol1.BytesRemaining>FileLength then FileLength:=ApdProtocol1.BytesRemaining;

    //bytes transferred is what has been sent to buffer, not out the port
    ActualBytesTransferred:=ApdProtocol1.BytesTransferred;// - ApdProtocol1.ComPort.OutBuffUsed;
    ActualBytesRemaining:=FileLength - ActualBytesTransferred;//+ApdProtocol1.ComPort.OutBuffUsed;
    //ApdProtocol1.By
    ProgressBarSendFile.Position:=ActualBytesTransferred;//ApdProtocol1.BytesTransferred;
    CalcCPS(ActualBytesTransferred,CPSSendFile,LastCharCountSendFile);
    if TimerSendFile.Enabled
      then LabelProtocolError.Caption:='Sent '+SendInfoStr+'   ' +'Pause '+inttostr(SpinEditFileSendDelay.Value)+'ms #'+inttostr(SendFileRepeatCounter)
      else LabelProtocolError.Caption:=inttostr(ApdProtocol1.BytesTransferred)+'  '+inttostr(ApdProtocol1.ComPort.OutBuffUsed)+'  '
    +'Send '+SendInfoStr+'   ' +inttostr(ActualBytesRemaining) +'  '+ CPSString(CPSSendFile);
  end
  else FileLength:=0;

  //if (Port1.DeviceLayer<>dlWinsock) then
    ApdStatusLightRTS.Lit:=Port1.RTS;
    ApdStatusLightDTR.Lit:=Port1.DTR;
    case ( Port1.LineError ) of
      leNoError     : LineErrorStr:='';//'No line error';
      leBuffer      : LineErrorStr:='Buffer overrun in COMM.DRV';
      leOverrun     : LineErrorStr:='UART receiver overrun';
      leParity      : LineErrorStr:='UART receiver parity error';
      leFraming     : LineErrorStr:='UART receiver framing error';
      leCTSTO       : LineErrorStr:='Transmit timeout waiting for CTS';
      leDSRTO       : LineErrorStr:='Transmit timeout waiting for DSR';
      leDCDTO       : LineErrorStr:='Transmit timeout waiting for RLSD';
      leTxFull      : LineErrorStr:='Transmit queue is full';
      leBreak       : LineErrorStr:='Break condition received';
    else

    end;
  if LineErrorStr<>'' then begin  //this will only set the lineerror, not clear them...
    ApdStatusERROR.hint:=LineErrorStr;
    LabelAPdStatusError.hint:=LineErrorStr;
    //StatusBarHint:=LineErrorStr;
    SetStatusBarHint(LineErrorStr,true);
    LineErrorLightTimer:=5; //set how long it shows for 1 sec
  end else begin  //don't clear the linerror string, user doubleclicks to clear it
    if LineErrorLightTimer>0 then begin
      dec(LineErrorLightTimer);
      if LineErrorLightTimer<=0 then ApdStatusError.Lit:=false;
    end;
  end;

  if DataTriggerLightTimer>0
      then begin
        dec(DataTriggerLightTimer);
        ApdStatusLightDataTrigger.Lit:=true;
      end
      else begin
        IsCurrentDataTrigger:=false;
        ApdStatusLightDataTrigger.Lit:=false;
      end;
  if HexEmulator.IsSyncCountChanged then begin
    LabelSyncCount.Caption:=inttostr(HexEmulator.SyncCount);
    if HexEmulator.SyncCount>0 then SetDataTriggerLight;
  end;
  if not AdTerminal1.ComPort.Open and SpeedButtonPort1Open.Down
    then begin
      SpeedButtonPort1Open.Down:=false;
      SpeedButtonPort1OpenClick(nil)
    end;
  if AdTerminal1.ComPort.Open
    then GroupBoxStatus.caption:='Status'
    else GroupBoxStatus.caption:='Status:Closed';
    SetWSConnectLightOffColor(Port1,ApdStatusLightConnected);
  UpdateTrayIcon;
end; //TForm1.ShowSerialStatus
procedure TForm1.LabelApdStatusErrorDblClick(Sender: TObject);
begin
    ApdStatusError.Lit:=false;
    ApdStatusERROR.hint:='';
    LabelAPdStatusError.hint:='';
    StatusBarHint:='';
end;
procedure TForm1.InvertAndMaskChars(Character: ansichar; var ReplaceWith:AnsiString);
begin
  if CheckboxInvertData.Checked
    then begin
        Character:=ansichar(not(byte(Character)));
        ReplaceWith:=Character;
        end;
  if CheckboxMaskMSB.Checked
    then begin
        Character:=ansichar(127 and byte(Character));
        ReplaceWith:=Character;
    end;
end; //fn
//base emulator that just passes chars thru...
procedure TForm1.AdEmulator_VT100ProcessChar(Sender: TObject;
  Character: AnsiChar; var ReplaceWith: ansiString; Commands: TAdEmuCommandList;
  CharSource: TAdCharSource);
begin
  InvertAndMaskChars(Character,ReplaceWith);
  //SetTerminalCharColor(Sender,CharSource);   //sjb removed so VT100 colors work
end;

procedure TForm1.AdEmulator_ShowAllProcessChar(Sender: TObject;
  C: AnsiChar; var ReplaceWith: AnsiString; Commands: TAdEmuCommandList;
  CharSource: TAdCharSource);
  const TimeStampNextChar:boolean=false;
  const CR=char(13); LF=char(10);
  const TimeStampDelimiter='|';
begin
  //Command.Cmd:= eChar;
  InvertAndMaskChars(C,ReplaceWith);
  if CheckBoxRxdIdle.checked then begin
    if RxIdle then begin
      TimeStampNextChar:=true;
      Commands.AddCommand(ecCR);
      Commands.AddCommand(ecLF);
    end;
  end;

  if CheckBoxDisplayTimeStamp.Checked then begin //we are adding timestamps
      if (C=CR) or (C=LF)
        then TimeStampNextChar:=true
        else
          if TimeStampNextChar then begin
            ReplaceWith:=TimeStampStr(-1,Now,ComboBoxDisplayTimeStampFormat.text)+TimeStampDelimiter+ReplaceWith; //NowStr
            TimeStampNextChar:=false;
            Commands.AddCommand(ecReverseOnly);
            //with sender as TAdTerminalEmulator do begin
           //   SetTerminalCharColor(Sender,CharSource,true); //REVERSE VIDEO Timestamp
            exit;  //<-------------
            //end;
          end;
  end;
  Commands.AddCommand(ecRemoveReverse);
  //with sender as TAdTerminalEmulator do begin
    //SetTerminalCharColor(Sender,CharSource);
  if CharSource = csPort then IncCharCount(1);
  //end;
end;


procedure TForm1.DonationLinkLabelChange;
const ChangeCounter:integer=0; HintCounter:integer=0;
const S:string='';
begin
  if ChangeCounter=3  //set ratio of Realterm to Donate
    then begin
//      LinkLabelNews.Visible:=false;
      ChangeCounter:=0;
    end
    else begin
//      LinkLabelNews.Visible:=true;
      inc(ChangeCounter);
    end;

//  LinkLabelDonate.Visible:=not LinkLabelNews.Visible;
//  if LinkLabelDonate.Visible then begin
//
//    HintCounter:=round(random * 13 +0.5); //randdomly select a message 1-N
//    case HintCounter of
//      0,1: if (RTUpdate.RunTime>1/3) and (rtupdate.RunCount>10)
//        then S:='Getting plenty of help from Realterm?   '+RTUpdate.RunInfoStr;
//
//      2:S:='You can show Realterm is valuable to you with a donation';
//      3:S:='Is Realterm helping Your Company make profits?';
//      4:S:='I started developing Realterm in 1987 - 30 years ago.\rYour support keeps me enthusiastic';
//      5:S:='Your donations pay for Code Signing certificates \rmaking Realterm safer and easier to install and use';
//      6:S:='Your donation lets me update Delphi and keep developing Realterm';
//      7:S:='How is Realterm helping you feed your family? \rYup programmers families eat too - someone tell the boss';
//      8:S:='When I started Realterm I had hair. Donate and help keep yours';
//      9:S:='Realterm cannot help with erectile dysfunction. Sorry. \rContributing will make you feel better';
//      10:S:='The world is built by its Contributors';
//      11:S:='As you Sow so shall you Reap. \rBe a Contributor';
//      12:S:='Donors keep Realterm alive, without You, Realterm will die';
//      else S:='Does Realterm save Your boss time and money? \rGet them to contribute now!'
//
//      end;
//    S:=ExpandEscapeString(S);
//    LinkLabelDonate.Hint:=S;
//    StatusBarHint:=S;
//  end;
end;
procedure TForm1.TimerSlowChangesTimer(Sender: TObject);
begin
  DonationLinkLabelChange;
  rtUpdate.LaunchUpdateCheck; //this only actually does something once...
end;
const NEWS_AND_UPDATE_CAPTION = 'News && Updates';
procedure TForm1.ShowUpdateAvailable(Updater:TrtUpdate);
  var MH,MI:TMenuItem;
  const LastMIStr:string='';
begin
  if Updater.UpdateAvailable then begin
//      LinkLabelNews.Caption:= stringreplace(LinkLabelNews.Caption, 'News</a>', 'Update</a>',
//                          [rfReplaceAll, rfIgnoreCase]);
      //'<a href="https://sourceforge.net/p/realterm/news/">News</a>';
//      LinkLabelNews.Hint:='Update Available '+Updater.UpdateVersion;
//      LinkLabelNews.Color:=clRed;
  end
  else begin
//      LinkLabelNews.Caption:= stringreplace(LinkLabelNews.Caption,'Update</a>','News</a>',
//                          [rfReplaceAll, rfIgnoreCase]);
//      LinkLabelNews.Hint:='Check here for updates '+Updater.UpdateVersion;
//      LinkLabelNews.Color:=clBtnFace;
  end;
  //PopupMenu1.Items.Find('News && Updates').Caption:='Update Available';
  try
    MH:=PopupMenu1.Items.Find('Help'); //'News & Updates');
    MI:=MH.Find(NEWS_AND_UPDATE_CAPTION);
    if MI=nil then MI:=MH.Find(LastMIStr);
    if MI<>nil then begin
      if Updater.UpdateAvailable
        then LastMIStr:='Update Available '+Updater.UpdateVersion
        else LastMIStr:=NEWS_AND_UPDATE_CAPTION;
      MI.Caption:=LastMIStr;
      MI.Default:=Updater.UpdateAvailable; //bolds it
      MI.Checked:=Updater.UpdateAvailable;
    end;
  except //if couldn't find item
  end;
end;

procedure TForm1.InstallTour1Click(Sender: TObject);
begin
  Application.CreateForm(TInstallTour, InstallTourDlg);
  InstallTourDlg.Show;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var CaptureTimeRemaining:double; // in days
    CharsLeft:integer;
const PortIdleCapQuitCountDown :integer =0; //counts down when CPS is 0 for capture autoquit
      PortIdleCloseCountDown :integer =0;
const PortWasOpen:boolean=false;
begin
    //Formclose is moved here to remove an error thrown with "capquit" when it was in stopcapture
  //sendfile when capturing autoquit also moved here, so it capture hang on can work
  if QuitNow or
      (CaptureAutoQuit and not IsCapturing and not IsSendingFile)
    then begin
      Form1.close;
      exit;
  end;

  if PortWsErrorReopen then begin  //we have had a winsock error
    //The effect of PortWasOpen, is that it will take two passes to close then open the port, and status, buttones etc will visibly change
    if  PortWasOpen then begin  //close the port
       Port1.Open:=false; //must close the port to clear the error
       SpeedButtonPort1Open.Down:=Port1.Open;
       ApdStatusError.Lit:=true; //restore, since closing port clears it....
    end else begin   //port was closed last loop through, so re-open it...
      if (Port1.DeviceLayer=dlWinsock) then   //only autoreopen winsock ports
        Port1.Open:=CheckboxPortAutoOpen.checked
        else begin //comport
          if CheckboxPortAutoOpen.checked
               and (ComportList.NewComName=Port1.ComName) then begin
             Port1.Open:=true; //re-open the same port;
             ComportList.NewComName:=''; //clear it one it has happened...
          end;
        end;
      if Port1.Open  then
        PortWsErrorReopen:=false;
    end;
    SpeedButtonPort1Open.Down:=Port1.Open;
  end;
//  if not PortWasOpen and PortWsErrorReopen then begin
//    Port1.Open:=true;
//    PortWsErrorReopen:=false;
//  end;
  if not PortWasOpen and Port1.Open then begin //port has auto-opened
      AdTerminal1.enabled:=true;
      ApdSLController1.monitoring:=true;
      ShowSerialStatus(true);
      SpeedButtonPort1Open.Down:=Port1.Open;
      SetPortAndBaudCaptions;
      //PortIdleCloseCountDown:=SpinEditPortAutoClose.Value; //so it doesn't immediately autoclose...
  end else begin
      ShowSerialStatus(false); // xxx
  end;
  if Port1.Open and checkboxPortAutoClose.Checked and (SpinEditPortAutoClose.Value>0) then begin //might need to autoclose...
    if ApdStatusLightRxD.Lit or ApdStatusLightTXD.Lit
        or not PortWasOpen  //just opened
      then PortIdleCloseCountDown:=SpinEditPortAutoClose.Value
      else begin
        dec(PortIdleCloseCountDown, SpinEditPortAutoClose.Increment);
        if PortIdleCloseCountDown<=0
           then Port1Open(false); //autoclose
      end;
  end;
  PortWasOpen:=Port1.Open;

  if PendingStuff then begin
    //if anything here blocks, then timer will tick again while this is blocked.
    PendingStuff:=false; //so clear flag first
    if length(PendingMessage)>0 then begin
      console.showmessage(ExpandEscapeCRString(PendingMessage));
      //PendingMessage=''; //since this is a timer event it seems to refire, before PendingStuff can be cleared
    end;

    if PendingInvisible then begin //held over from parsing of commandline
      //Form1.Visible:=false;
      MenuItemShow.checked:=true; //will leave restore button in correct state
      MenuItemShowClick(nil);
      PendingInvisible:=false;
    end;
    if PendingInstall then begin
      PendingInstall:=false;  //clear first as tour is non-blocking and this will be re-called
      PendingHelp:=false;     //true;
      AnalyticsReportInstall; //ifdef in routine
      InstallTour1Click(nil); //non blocking...
    end; //if
    if PendingHelp then begin
      AllHelp;
      PendingHelp:=false;
    end;

  end; //pendingstuff
//  if PicProg.Open
//    then begin
//      ApdStatusLightRB7.Lit:=PicProg.RB7;
//    end;

  if IsCapturing then begin //
    if (CaptureTime>0) and not IsSendingFile  //block until file send is completed
      then begin
        CaptureTimeRemaining:=CaptureStopTime-now;
        if ( CaptureTimeRemaining>0 ) then begin //still going
          end
          else begin //time to stop
            if CheckBoxCaptureEOL.checked and not LastCaptureCharWasEOL then begin //wait for EOL or 5 secs
              CaptureLines:=1; //now it will stop at first line..
              if (CaptureTimeRemaining<(-5/(3600*24)) ) then //stop anyway
                  StopCapture('Capture Stopped at Time+5 without EOL',true);
            end else //normal timed stop
              StopCapture('Capture Stopped at Time',true);
        end;
    //show progress bar
        CaptureTimeLeft:=floor(CaptureTimeRemaining*24*3600); //in secs
        ProgressBarCapture.position:=CaptureTime-CaptureTimeLeft;
      end;//if captime
    if ( CaptureSize>0 ) then begin
        ProgressBarCapture.position:=CharCount;
        CharsLeft:=CaptureSize-CharCount;
        if CPS>0 then  //try to deal with mystery div by 0 in capture
          CaptureTimeLeft:=(CharsLeft div CPS); //an approximation
    end; //if capsize
    if ( CaptureLines>0 ) then begin
        ProgressBarCapture.position:=LineCount;
//        CharsLeft:=CaptureSize-CharCount;
//        if CPS>0 then  //try to deal with mystery div by 0 in capture
//          CaptureTimeLeft:=(CharsLeft div CPS); //an approximation
    end; //if caplines

    if (CaptureIdleAutoQuitCount>0) then begin//we want to autoquit when the port has been idle for a few ticks
      if (CPS>0) or (PortIdleCapQuitCountDown=0) then //Not Idle or start
        PortIdleCapQuitCountDown:=CaptureIdleAutoQuitCount
      else begin//port is idle this tick
        PortIdleCapQuitCountDown:=PortIdleCapQuitCountDown-1;
        if (PortIdleCapQuitCountDown=0) then StopCapture('Capture stopped on Idle');
      end; //CPS=0
    end;//if autoquitidle


  end; //if capturing

end;
procedure TForm1.SetDataTriggerLight(IsTrigger:Boolean); //this is also being used by binary sync events....
begin
  if IsTrigger
    then ApdStatusLightDataTrigger.LitColor:=clYellow
    else ApdStatusLightDataTrigger.LitColor:=clRed;
  DataTriggerLightTimer:=5; //light stays on for N ticks of the main timer
  IsCurrentDataTrigger:=true;
end;

procedure TForm1.SetDisplayWidth(IsNarrow:boolean=false);
  var N:integer;
begin
  N:= SpinEditFrameSize.Value;
  if CheckBoxSingleFrame.Checked
    then begin
      N:= -N; //
    end;
  if (AdTerminal1.Emulator = AdEmulator_Hex) and (HexEmulator.NumChars>1)
     then begin
       N:=N * HexEmulator.NumChars;
     end;
  N:=OptimiseTerminalWidth(N,IsNarrow);
  //AdTerminal1.Columns:=N;
  ChangeRowsCols(0,N,true);
  if not IsNarrow
    then SpinEditTerminalCols.Value:=AdTerminal1.Columns;

//    then AdTerminal1.DisplayColumns:=N;
  //if AdTerminal1.DisplayColumns<10 then AdTerminal1.DisplayColumns:=10;
end; //SetDisplayWidth

procedure TForm1.MenuItemOnlineManualClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open',
  'http://realterm.sourceforge.net',nil,nil, SW_SHOWNORMAL);
end;

function TForm1.OptimiseTerminalWidth(N:integer;IsNarrow:boolean=false):integer;
  var NewWidth:byte;
procedure OptimiseNarrow;
begin
  N:=abs(N);
  case ( abs(N) ) of
    1,2,3,4,6,8,12: NewWidth:=24;
    5,10,15 : NewWidth:=30;
    7,14,28: NewWidth:=28;
    9,18,36: NewWidth:=36;
    11:NewWidth:=33;
    16:NewWidth:=32;
    17,34:NewWidth:=34;
    19,38:NewWidth:=38;
    else begin
      NewWidth:=N;
    end;
  end;//case
  end;
procedure OptimiseWide;
begin
  case ( N ) of
    1,2,4,5,8,10,16,20,40,80: NewWidth:=80;
    3,6,9,12,18,24,36,72 : NewWidth:=72;
    7,14,21,28,42,84: NewWidth:=84;
    11:NewWidth:=77;
    13,26,39:NewWidth:=78;
    22,33:NewWidth:=66;
    17,34:NewWidth:=68;
    19,38:NewWidth:=76;
    32,64: NewWidth:=64;
    15,30: NewWidth:=60;
    else begin
      NewWidth:=N; //default if we can't squeeze 2 or more cols in
      if {(-80<=N) and }(N<=-1)  then begin //force single frame
          NewWidth:=byte(abs(N));
        end
      else begin
        //if N > 84            //max width is84  (no point really)
          //then NewWidth:=80;
        if N*3 <=84
          then begin
            NewWidth:=N*3;
            N:=1000;
          end;
        if N*2 <=84
          then begin
            NewWidth:=N*2;
            //N:=1000;
          end;

      end; //else
    end;
  end; //case
  end;
begin  //fn
  if IsNarrow
    then OptimiseNarrow
    else OptimiseWide;
  assert((NewWidth<255) and (NewWidth>0));
  result:=NewWidth;
end; //TForm1.OptimiseTerminalWidth(N:byte)

procedure TForm1.RadioButtonSignedClick(Sender: TObject);
begin
  RadioButtonUnsigned.SetChecked(false);
  RadioGroupDisplayTypeSet;
end;
procedure TForm1.RadioButtonUnsignedClick(Sender: TObject);
begin
  RadioButtonSigned.SetChecked(false);
  RadioGroupDisplayTypeSet;
end;

procedure TForm1.CheckBoxHexSpaceClick(Sender: TObject);
begin
  RadioGroupDisplayTypeSet;
end;
procedure TForm1.RadioGroupDisplayTypeClick(Sender: TObject);
begin
  RadioGroupDisplayTypeSet;
end;

//Value=999 = process click
function TForm1.RadioGroupDisplayTypeSet(GetValue:boolean=false; DisplayTypeValue:integer=999):integer;

  type TDisplayAsType= set of 0..20;
  function IsVisible(VisibleFor : TDisplayAsType):boolean;
  begin
    IsVisible:= RadioGroupDisplayType.ItemIndex in VisibleFor;
  end;
  function IsDisplayIntType:boolean;
  begin
    result:=IsVisible([7,8,9]);
  end;
  function IsDisplayIntOrFloatType:boolean;
  begin
    result:=IsVisible([7,8,9,10]);
  end;
  function IsDisplayHexSpaceType:boolean;
  begin
    result:=IsVisible([3]);
  end;
  //functions to handle the integer value from/to commandline.
  function GetDisplayTypeValue:integer;
  begin
    result:=RadioGroupDisplayType.ItemIndex;
    if IsDisplayIntType and not RadioButtonUnSigned.Checked  then result:= -result; //ints
    if IsDisplayHexSpaceType and CheckBoxHexSpace.Checked then result:= -result; //hex space
  end;

  procedure SetDisplayTypeValue(V:integer);
  begin
    if (abs(V)>=RadioGroupDisplayType.Items.Count) then V:=0;
    RadioGroupDisplayType.ItemIndex := abs(V); //immediately calls OnChanged
    CheckBoxHexSpace.Checked := not IsDisplayHexSpaceType or (not (V<0) and IsDisplayHexSpaceType); //default is checked
    RadioButtonUnSigned.SetChecked (not IsDisplayIntType or (IsDisplayIntType and not (V<0)));
    RadioButtonSigned.SetChecked(not RadioButtonUnsigned.Checked);
  end;

var Signed:boolean;
begin  //function
  result:=GetDisplayTypeValue;
  if GetValue then exit; //done

  if (DisplayTypeValue<>999) then begin
        SetDisplayTypeValue(DisplayTypeValue);
        exit; //should trigger a click by setting
  end;
  //otherwise set from click
  AdTerminal1.Emulator:= AdEmulator_Hex; // most use this emulator...
  AdEmulator_Hex.OnProcessChar:=HexEmulator.ProcessChar;
  GroupboxBinarySync.Visible:=true;
  GroupboxHexCSV.Visible:=false;
  RadioGroupHexCSVStatusShows.ItemIndex:=0; //hides statusbar
  ApdDataPacketFormatted.Enabled:=false;
//  StatusBarFormattedData.Visible:=false;
  HexEmulator.NumChars:=1; //used to setup terminal even when emulator not used
  CheckBoxDisplayTimeStamp.Enabled:=true;
  CheckBoxRxdIdle.Enabled:=true;

  CheckBoxCRLF.Enabled:=true;
  Signed:= RadioButtonSigned.Checked;
  //set the formatting setup
  HexEmulator.PadLeft:=CheckboxPadLeft.Checked;
  case ( RadioGroupDisplayType.ItemIndex ) of
    0: begin                                             //ascii
         AdTerminal1.Emulator:=AdShowAllEmulator;
         GroupboxBinarySync.Visible:=false;
         //CheckBoxDisplayTimeStamp.Enabled:=false;
       end;
    1: begin                                            //ansi / vt100
           AdTerminal1.Emulator:= AdEmulator_VT100;
           AdEmulator_VT100.NewLineMode:=CheckBoxNewLine.checked;
           AdTerminal1.Emulator.Buffer.ForeColor:=Color4Port; //default - ANSI color commands and attibutes will overwrite it
           AdTerminal1.Emulator.Buffer.BackColor:=Color4Background; //added to try and make ansi emulator have right background
           GroupboxBinarySync.Visible:=false;
           CheckBoxDisplayTimeStamp.Enabled:=false;
           CheckBoxRxdIdle.Enabled:=false;
           CheckBoxCRLF.Enabled:=false;
       end;
    2: HexEmulator.Init(true,false,false,false,false,NoStr,2); //ascii plain
    3: if CheckboxHexSpace.Checked
          then HexEmulator.Init(false,true,true ,false,false,HexStr,3) //hex optional space
          else HexEmulator.Init(false,true,false,false,false,HexStr,2); //hex no space
    4: HexEmulator.Init( true,true,true ,false,false,HexStr,4); //hex + ascii

    5: HexEmulator.Init(false,true,true ,false,false,BinaryStr,9);  //binary string
    6: HexEmulator.Init(false,true,true ,false,false,NibbleStr,10); //nibble
    7: if Signed  //8
          then HexEmulator.Init(false,true,false ,false,false,Int8Str,5)   //changed has trailing space to false...
          else HexEmulator.Init(false,true,false ,false,false,UInt8Str,4);
    8: if Signed  //16
          then HexEmulator.Init(false,true,false ,false,false,Int16Str,1)
          else HexEmulator.Init(false,true,false ,false,false,Uint16Str,0);
    9: if Signed    //32
          then HexEmulator.Init(false,true,false ,false,false,Int32Str,1)
          else HexEmulator.Init(false,true,false ,false,false,Uint32Str,1);
   10: HexEmulator.Init(false,true,true ,false,false,Float4Str,10);
   11,12: begin  //HexCSV
         AdTerminal1.Emulator:=AdShowAllEmulator;
         GroupboxBinarySync.Visible:=false;
         //ugly little hack as I have parked it off to one side at design time
         GroupBoxHexCSV.Top:=GroupboxBinarySync.Top ;
         GroupBoxHexCSV.Left:=GroupboxBinarySync.Left ;
         GroupBoxHexCSV.Width:=GroupboxBinarySync.Width ;
         GroupboxHexCSV.Visible:=true;
         if ApdDataPacketFormatted.EndString='' then ApdDataPacketFormatted.EndString:=^J;
         ApdDataPacketFormatted.Enabled:=true;
         RadioGroupHexCSVStatusShows.ItemIndex:=1;
       //  ShowHideStatusBarFormattedData;
       end;
    else begin
      RadioGroupDisplayType.ItemIndex:=0;
      console.showmessage('emulator '+inttostr(RadioGroupDisplayType.ItemIndex)+ ' not implemented yet')
    end;
  end; //case
  // show/hide auxiliary controls specific to various formatting options
  RadioButtonSigned.Visible:= IsDisplayIntType;
  RadioButtonUnSigned.Visible:=RadioButtonSigned.Visible;
  CheckBoxPadLeft.Visible:= IsVisible([7,8,9,10]);
  CheckBoxBigEndian.Enabled:= IsVisible([8,9,10]);  //multi-byte numeric type
  CheckBoxHexSpace.Enabled:= IsDisplayHexSpaceType;

  HexEmulator.InvertData:=CheckBoxInvertData.Checked;
  HexEmulator.MaskMSB:=CheckBoxMaskMSB.Checked;
  HexEmulator.BigEndian:=CheckBoxBigEndian.Checked;
  BitBtnChangeBinarySyncClick(nil); //set the hex emulators binary sync
  //OptimiseTerminalWidth(SpinEditFrameSize.Value * HexEmulator.NumChars);
  ShowHideStatusBarFormattedData;
  SetDisplayWidth;
  AdTerminal1.Emulator.Buffer.UseNewLineMode:=CheckBoxNewLine.checked;
  if CheckBoxClearTerminalOnDisplayChange.Checked
    then begin
      //AdTerminal1.ClearAll;
      ButtonClearClick(nil);
    end;
end;
procedure TForm1.SpinEditFrameSizeChange(Sender: TObject);
begin
  SetDisplayWidth;
end;

procedure TForm1.ButtonFreezeClick(Sender: TObject);
//This routine is unchanged from the early days. Behaviour of terminal must have changed, so a new method of freezing the terminal window is needed
begin
  //Scrollback doesn't freeze like it used to in old versions
  //Enabled doesn't seem to do anything, it still gathers chars
  //Active stops it, but loses chars rx'd during inactive period

//  AdTerminal1.Active:= not AdTerminal1.Active;
//  if not AdTerminal1.Active
//    then ButtonFreeze.Caption:='Resume'
//    else ButtonFreeze.Caption:='Freeze';
  AdTerminal1.FreezeScrollBack:= not AdTerminal1.FreezeScrollBack;
  if not AdTerminal1.FreezeScrollBack
    then ButtonFreeze.Caption:='Resume'
    else ButtonFreeze.Caption:='Freeze';

{  AdTerminal1.Scrollback:= not AdTerminal1.Scrollback;
  if AdTerminal1.Scrollback
    then ButtonFreeze.Caption:='Resume'
    else ButtonFreeze.Caption:='Freeze';}
end;
//function ComNumberStr(S:string):string;
//  var num,code:integer; numstr:string;
//begin
//  numstr:=StringReplace(S,'\\.\COM','',[]);
//  val(NumStr ,Num,Code);
//  if code=0
//    then result:=NumStr  //is numeric comport
//    else result:=S;      //is something else...
//end;
function Get_ComPortString(Com:TApdWinsockPort; Raw:boolean=false): string;
begin
  //with Com do begin
    if Com.DeviceLayer=dlWinsock
      then begin
        if (Com.wsMode = wsServer)
           then result:='server'
           else result:=Com.WsAddress;
        if Com.WsPort<>''
          then result:=result+':'+Com.WsPort;
      end
      else begin
        //result:=inttostr(Com.ComNumber);
        result:=Com.ComName;
        if not Raw then result:=ComNumberStr(result);

      end;
  //end;
end;
function IsSame_Comport(S:string; Com:TApdWinsockPort):boolean;
var CN:string;
begin
  Get_ComPortString(Com,true);
  result:= (S = CN) and  (S=ComNumberStr(CN));
end;

procedure Set_ComPort(Com:TApdWinsockPort; Value: WideString);
      procedure Set_Winsock(Com:TApdWinsockPort; const Value:string);
        var ColonPos:integer; Address:string;
      begin
          ColonPos:=AnsiPos(':',Value);
          if (ColonPos=0)
            then begin
              Address:=Value ;
              Com.WsPort:='telnet';
              end
            else begin
              Address:=copy(Value,1,ColonPos-1);
              Com.WsPort:=copy(Value,ColonPos+1, length(Value)-ColonPos);
            end;
          if LowerCase(Address)='server'
            then begin
              Com.WsMode:=wsServer;
              end
            else begin
              Com.WsMode:=wsClient;
              Com.wsAddress:=Address;
            end;
          Com.DeviceLayer:=dlWinSock;
          Com.ComNumber:=0;
      end; //fn
    procedure TrimToFirstSpace(var Value: WideString) ;
    var Pos:integer;
    begin
      Pos:=AnsiPos(' ',Value);
      if Pos > 1
        then begin
          Value:=copy(Value,1,Pos-1);
        //implicit else no space so leave alone.
        end;
    end;//fn

  var Num, code :integer;
      SaveOpen:boolean;

begin
  // Parse comport string to determine what type it is
  // eg a simple number: must be a physical comport#
  // a string starting with backslash (eg \VCP0) must be a registry entry
  // a string with dots or non numeric chars: must be telnet
  // if a : exists, pre: is wsaddress, post:is wsport
  //if Value<>get_ComPort(Com)
  if not IsSame_Comport(Value,Com)
    then begin
      SaveOpen:=Com.Open;
      if Com.Open then Com.Open:=false;
      //fComportString=Value;
      Com.open:=false;
      if Value[1]='\'
        then begin
          if Value[2]='\' then begin
            //must be an explicit ComName
             TrimToFirstSpace(Value);
             Com.ComName:=Value;
             Com.DeviceLayer:=DLWin32;
          end
          else begin
            //must be a key name from registry (begins with single \)
            //val(GetCommNumberByKey(Value),Num,Code);
            val(ComportList.GetComportByKey(Value),Num,Code);
            if code=0 then begin  //must be a number
              //Num:=strtoint(Value);
              Com.ComNumber:=Num;
              Com.DeviceLayer:=DLWin32;
              end
             else begin //didn't find a matching key
            end;
          end; // \keyname
        end
        else begin //either a com number or a winsock port
          TrimToFirstSpace(Value);  //so allows strings in form "1 = /serial3"
          val(Value ,Num,Code);
          if code=0 then begin  //is a number
            Com.ComNumber:=Num;
            Com.DeviceLayer:=DLWin32;
          end
          else begin //not a plain number so try to open as winsock
            Set_Winsock(Com,Value);
          end; //was winsock....
        end;
      Form1.PortOpenTry(Com,SaveOpen);  //have error messages and handling
      //Com.Open:=SaveOpen;
      if Form1.CheckBoxClearTerminalOnPortChange.Checked
        then begin
          Form1.ButtonClearClick(nil);
        end;
      end;
end;

//function GetPhysicalComNumber(const Value: WideString):integer;
//  var ComNumber, code:integer;
//begin
//  // Parse comport string to find numbered comport
//  // eg a simple number: must be a physical comport#
//  result:=-1; //invalid
//  val(Value,ComNumber,Code);
//  if code=0
//    then begin //is a numeric port
//      result:=ComNumber;
//    end;
//end;

procedure TForm1.SetPortClick(Sender: TObject);
begin
  //Port1.close;
  BitBtnSetPortClick(Sender);
end;


procedure TForm1.Port1WsConnect(Sender: TObject);
begin
  AdTerminal1.enabled:=true;
  ApdStatusLightConnected.lit:=true;
  LabelConnected.Caption:='Connected';
  SignalWsConnectedThroughRTSDTR(true,EchoPort);
end;

//procedure TForm1.PortErrorClose
//begin
//
//end

procedure TForm1.Port1WsDisconnect(Sender: TObject);
//called when port closes (even if serial), or when server loses connection
//const AlreadyTryingToClosePort:boolean=false;
begin
//  if AlreadyTryingToClosePort then exit; //kludge as closing port calls this
  AdTerminal1.enabled:=false;
  ApdStatusLightConnected.lit:=false;
  SignalWsConnectedThroughRTSDTR(false,EchoPort);
  //ApdStatusLightConnected2.lit:=false;
  LabelConnected.Caption:='Disconnect';
  if (Port1.wsMode=wsClient) // server stays waiting so only slient needs to do this
     and (Port1.DeviceLayer=dlWinsock) and not Port1.Open //not if a server
    then begin
//      AlreadyTryingToClosePort:=true;
//      Port1.Open:=false; //force the port to close, since they don't reconnect anyway
      //SpeedButtonPort1Open.Down:=false;
      //PortWsErrorReopen:= CheckboxPortAutoOpen.checked; //Port is not closed yet, so can't reopen here
      PortWsErrorReopen:= true;
    end;
//  AlreadyTryingToClosePort:=false;
end;

procedure TForm1.Port1WsError(Sender: TObject; ErrCode: Integer);
  var ErrStr:string;
begin
  if (Port1.DeviceLayer=dlWinsock)
    then begin
      ErrStr:='Winsock-';
    end else begin
      case ErrCode of
        ecDeviceRead: ErrStr:='USB Unplugged? : '; //supplement the nessage
      end;
    end;

//  case ErrCode of
//    wsaEConnRefused: ErrStr:='Connection Refused';
//    wsaHost_Not_Found: ErrStr:='Host Not Found';
//    wsaENotSock: ErrStr:='Not a Socket';
//    wsaENetReset: ErrStr:='Net Reset';
//    wsaEConnAborted: ErrStr:='Connection Aborted';
//    wsaEConnReset: ErrStr:='Connection  Reset';
//
//    else ErrStr:=' Error';
//  end;
  ErrStr:=ErrStr + AproLoadStr(Abs(ErrCode)) +'  err#'+inttostr(ErrCode);
  ApdStatusError.Lit:=true;
  ApdStatusERROR.hint:=ErrStr;
  LabelAPdStatusError.hint:=ErrStr;
  SetStatusBarHint(ErrStr,true);
  LastErrorMessage:=ErrStr;
  PortWsErrorReopen:=true;
//  if true //(Port1.wsMode=wsClient) // server and client close on error
//     and (Port1.DeviceLayer=dlWinsock)
//    then PortWsErrorReopen:= CheckboxPortAutoOpen.checked; //Port is not closed yet, so can't reopen here
//  SpeedButtonPort1Open.Down:=false; //close it
  //Port1.Open:=false;
  //LineErrorLightTimer:=5; //set how long it shows for 1 sec
end;

procedure TForm1.Port1ErrorEvent(CP: TObject; ErrCode: Integer);
  //var ErrStr:string;
begin
  Port1WsError(CP, ErrCode);
//  case ErrCode of
//    ecDeviceRead: ErrStr:='USB Unplugged: '+AproLoadStr(Abs(ErrCode));
//    else ErrStr:=MessageNumberToString(ErrCode);
//  end;
//  ErrStr:='Port - '+ErrStr+'  err#'+inttostr(ErrCode);
  //function ErrorMsg(const ErrorCode : SmallInt) : string;
  //{$IFDEF UseResourceStrings}
  //function MessageNumberToString(MessageNumber : SmallInt) : ShortString;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  if CommSpy1.IsNoneCommHooked
//    then CommSpy1.Opened:=false
//    else begin
//      if MessageDlg('You must close the comport (ie the application you are spying on) before you will be able to exit Realterm',
//                mtWarning,[mbCancel,mbIgnore],0) = mrCancel
//                then begin
//                  Action:=caNone;
//                  exit;
//                end;
//    end;
  if ApdProtocol1.InProgress then begin //stop send before capture
      BitBtnAbortSendFileClick(nil);
  end;
  if CaptureMode<>cmoff then begin
    StopCapture('');
  end;
  Port1.open:=false;
//  if CommSpy1.IsNoneCommHooked
//    then CommSpy1.Opened:=false
//    else ShowMessage('You must close the comport (ie the application you are spying on) before you will be able to exit Realterm');

  //CommSpy1.Opened:=false;
  //SpeedButtonPort1Open.Down:=Port1.Open;
  EchoPort.open:=false;
  Timer1.enabled:=false;
//  LabelConnected.Caption:='Disconnect';
  UpdateTrayIcon(iconIdle); //restore the icon to normal
  TrayIcon1.Visible:=false; //try to make it disappear immediately
  GlobalHotKeys1.UnRegisterAll(Handle);
  CannedStrings.Free;
  rtUpdate.UpdateRunTimeCount;
{$IFNDEF DEBUG}
  if Comserver.StartMode = smStandAlone then rtUpdate.ReportRunInfo;
{$ENDIF}
end; //form close

procedure TForm1.Port1WsAccept(Sender: TObject; Addr: TInAddr;
  var Accept: Boolean);
begin
  Accept:=true;
  AdTerminal1.enabled:=true;  //sjb re-enabled this line to let server send chars after reconnect. No idea why it was commented otu
  ApdStatusLightConnected.lit:=true;
  //ApdStatusLightConnected2.lit:=true;
  LabelConnected.Caption:='Accepted';
  SignalWsConnectedThroughRTSDTR(true,EchoPort);
end;

procedure TForm1.CheckBoxSingleFrameClick(Sender: TObject);
begin
  SetDisplayWidth;
end;

procedure TForm1.ButtonGulp1Click(Sender: TObject);
begin
  HexEmulator.GulpCount:=1; //using count might allow for gulp>1
end;

//procedure TForm1.ComboboxRightJustify(Sender: TObject);
//begin
//  TCombobox(Sender).RightJustify;//SelStart:=length(TCombobox(Sender).text);
//end;

procedure CBBigSize(CB:TComboBox;Big:boolean;Toggle:Boolean=false);
const SLeft:integer=0; SWidth:integer=0; SBig:boolean=false;
begin
  if Toggle then Big:=not SBig;

  if Big then begin
    SLeft:=CB.Left; SWidth:=CB.Width; SBig:=true;
    CB.Width:= CB.Left+CB.Width-10;
    CB.Left:=10;

    end
    else if SLeft>0 then begin
      SBig:=False;
      CB.Width:=SWidth;
      CB.Left:=SLeft;
  end;
end;

procedure TForm1.ComboBoxCaptureEOLCharChange(Sender: TObject);
begin
  CaptureEOLChar:=ExpandEscapeEOLString(ComboBoxCaptureEOLChar.text);
  CheckBoxCaptureEOL.Caption:='+'+ComboBoxCaptureEOLChar.text;
end;

procedure TForm1.ComboBoxCaptureEOLCharExit(Sender: TObject);
begin
  TCombobox(Sender).PutStringAtTop;
  TCombobox(Sender).Visible:=false;
end;

procedure TForm1.ComboBoxCaptureEOLCharSelect(Sender: TObject);
begin
  ComboBoxCaptureEOLCharChange(sender);
  ComboBoxCaptureEOLChar.Visible:=false;
end;

procedure TForm1.ComboBoxCapturePostFNameClick(Sender: TObject);
begin
  //CBBigSize(ComboBoxCapturePostFName,true);
end;
procedure TForm1.ComboBoxCapturePostFNameCloseUp(Sender: TObject);
begin
  CBBigSize(ComboBoxCapturePostFName,false);
end;

procedure TForm1.ComboBoxCapturePostFNameDblClick(Sender: TObject);
begin
  CBBigSize(ComboBoxCapturePostFName,false,true);
end;

procedure TForm1.ComboBoxCaptureSizeChange(Sender: TObject);
var CS:integer;
begin
    if ComboboxCaptureSize.text='' then exit; //empty is ok-ish
    CS:=strtointdef(ComboboxCaptureSize.text,-1);
    if CS<0 then begin
      ComboboxCaptureSize.Color:=clred;
      exit;
    end;

  if (IsCapturing) then  //is it too late to change?
    case RadioGroupCaptureSizeUnits.itemindex of
      0: if (CS<=CharCount) and (CS<>0) then begin //bytes
             ComboboxCaptureSize.color:=clRed; //show problem
          exit;
      end;
      1: ;
      2: if (CS<=LineCount) and (CS<>0) then begin//bytes
            ComboboxCaptureSize.color:=clRed; //show problem
            exit;
      end;
    end; //case
 // else begin //otherwise there is no problem so show changes
    ComboboxCaptureSize.Color:=clBtnface;
    CaptureIdleAutoQuitCount:=0; //default
    case RadioGroupCaptureSizeUnits.itemindex of
      0: begin //bytes
        CaptureTime:=0;
        CaptureSize:=CS;
        CaptureLines:=0;
      end;
      1: begin //seconds
        if (CS<0) then begin //-ve means quit on idle or timeout (usually when sending too)
            CS:=abs(CS);
            CaptureIdleAutoQuitCount:=min(10,max(2,CS)); //so min 2 or max of 10
        end;
        CaptureTime:=CS;
        CaptureSize:=0;
        CaptureLines:=0;
      end;
      2: begin
        CaptureTime:=0;
        CaptureSize:=0;
        CaptureLines:=CS;      
      end;
    end;
    ComboboxCaptureSize.color:=clWindow; //show problem
    if ( CS<>0 ) then begin
      ProgressBarCapture.min:=0;
      ProgressBarCapture.max:=CS;
    end;
  //end;

end;


procedure TForm1.ParameterRemoteParamMatch(Sender: TObject; CaseMatch: Boolean;
  Param, Reference: string);
begin
  ParameterParamMatch(Sender, CaseMatch, Param, Reference);
end ;

procedure SetPending(var AVar:boolean; const B:boolean=true); //used to set pending flags and ensure PendingStuff is also set
begin
  AVar:=B;
  if B then Form1.PendingStuff:=true;
end; //setpending

procedure ChangeMessageFilter(H:THandle=0); //used to open up UIPI for wmcopydata - A security hole, so avoid using
var ChangeWindowMessageFilter: function (msg : Cardinal; dwFlag : Word) : BOOL; stdcall;
    ChangeWindowMessageFilterEx: function (H:THandle; msg : Cardinal; dwFlag : Word) : BOOL; stdcall;
begin
  //warning might fail on <=XP
  if (H=0) then begin
      @ChangeWindowMessageFilter := GetProcAddress(LoadLibrary('user32.dll'), 'ChangeWindowMessageFilter');
      ChangeWindowMessageFilter(WM_COPYDATA, 1);
    end else begin
      @ChangeWindowMessageFilterEx := GetProcAddress(LoadLibrary('user32.dll'), 'ChangeWindowMessageFilterEx');
      ChangeWindowMessageFilterEx(H,WM_COPYDATA, 1);
  end;
end;
procedure TForm1.ParameterParamMatch(Sender: TObject; CaseMatch: Boolean; Param,
  Reference: String);
    var value:integer;
      IsRemoteCommand:boolean;
      UpperRef:string;
  procedure DataBitsFormatErrorMessage;
  begin
    messageDlg('Command Line Parameter Error: DATA= option is 3 chars eg "7N1" #Bits,Parity,Stop. Values are 8-5,[N,O,E,M,S],1-2',
                mtWarning,[mbOK],0);
  end;

  function BooleanOrText(Reference:String; var Text:TComboBox): boolean; //detects no refernce, 1or0 or a filename
  begin
    result:=true;  //defaults to true with nothing or filename
    if length(Reference)=0 then result:=true;
    if (length(reference)=1) and (reference[1]='1')
       then result:=true
       else begin
         if (length(reference)=1) and (reference[1]='0')
           then Result:=false
           else Text.Text:=Reference; //allows 1 chars filenames except 0 and 1
       end;
     if length(reference)>=2 then Text.Text:=Reference;
  end;
  function CaptureModeOrText(Reference:String; var Text:TComboBox): TAdCaptureMode; //detects no refernce, capturemode or a filename
    procedure SetText;
      begin
        Text.Text:=Reference;
        result:=cmOn;
      end;
  begin
    //defaults to true with nothing or filename
    case length(Reference) of
      0: result:=cmOn;
      1: case reference[1] of
           '0': begin result:=cmOff; CheckboxCaptureRestart.Checked:=false; end;
           '1': begin result:=cmOn;  CheckboxCaptureRestart.Checked:=false; end;
           '2': begin result:=cmAppend;  CheckboxCaptureRestart.Checked:=false; end;
           '3': begin
                  result:=cmOn;
                  CheckboxCaptureRestart.Checked:=true;
                end;

           else SetText ;
         end//case
       else SetText;
    end; //case
  end;
  procedure SetFlow(Reference:ansistring;Group:TRadioGroup;Port:TApdWinsockPort;
             ReceiveFlowBox,TransmitFlowBox:TCheckbox; var PortChanged:boolean);
  // Used by the commandline parser to us N in FLOW=N and set flow
  // 0-3 = HW flow set; +8=RX-XON, +4=TX XON
    var value:integer;
  begin
    case Reference[1] of
      'X','x': begin  //enable software flow control
        ReceiveFlowBox.Checked:=true;
        TransmitFlowBox.Checked:=true;
        exit;
      end;
      'R','r':  //RTSCTS
         value:=2;
      'D','d': //DTRDSR
         value:=1;
      else value:=strtoint(Reference);
    end;
//
//    if (Reference[1]='X') or (Reference[1]='x')
//      then begin  //enable software flow control
//        ReceiveFlowBox.Checked:=true;
//        TransmitFlowBox.Checked:=true;
//      end else begin
//
//     value:=strtoint(Reference);
     if value>=8 then begin
        value:=value-8;
        ReceiveFlowBox.Checked:=true;
     end else
        ReceiveFlowBox.Checked:=false;
     if value>=4 then begin
        value:=value-4;
        TransmitFlowBox.Checked:=true;
     end else
        TransmitFlowBox.Checked:=false;
     if (Value>=Group.Items.Count) or (value<0)
       then Value:=0;
     Group.ItemIndex:=value;
     ItemIndexToHWFlowOptions(Group.ItemIndex,Port);
     PortChanged:=true;
//     end; //if
  end; //fn
begin
//{$Include ParameterMatch.pas}
end;

//procedure TForm1.ParameterParamMatch(Sender: TObject; CaseMatch: Boolean;
//  Param, Reference: String);
//  var value:integer;
//      IsRemoteCommand:boolean;
//      UpperRef:string;
//  procedure DataBitsFormatErrorMessage;
//  begin
//    messageDlg('Command Line Parameter Error: DATA= option is 3 chars eg "7N1" #Bits,Parity,Stop. Values are 8-5,[N,O,E,M,S],1-2',
//                mtWarning,[mbOK],0);
//  end;
//
//  function BooleanOrText(Reference:String; var Text:TComboBox): boolean; //detects no refernce, 1or0 or a filename
//  begin
//    result:=true;  //defaults to true with nothing or filename
//    if length(Reference)=0 then result:=true;
//    if (length(reference)=1) and (reference[1]='1')
//       then result:=true
//       else begin
//         if (length(reference)=1) and (reference[1]='0')
//           then Result:=false
//           else Text.Text:=Reference; //allows 1 chars filenames except 0 and 1
//       end;
//     if length(reference)>=2 then Text.Text:=Reference;
//  end;
//  function CaptureModeOrText(Reference:String; var Text:TComboBox): TAdCaptureMode; //detects no refernce, capturemode or a filename
//    procedure SetText;
//      begin
//        Text.Text:=Reference;
//        result:=cmOn;
//      end;
//  begin
//    //defaults to true with nothing or filename
//    case length(Reference) of
//      0: result:=cmOn;
//      1: case reference[1] of
//           '0': begin result:=cmOff; CheckboxCaptureRestart.Checked:=false; end;
//           '1': begin result:=cmOn;  CheckboxCaptureRestart.Checked:=false; end;
//           '2': begin result:=cmAppend;  CheckboxCaptureRestart.Checked:=false; end;
//           '3': begin
//                  result:=cmOn;
//                  CheckboxCaptureRestart.Checked:=true;
//                end;
//
//           else SetText ;
//         end//case
//       else SetText;
//    end; //case
//  end;
//  procedure SetFlow(Reference:ansistring;Group:TRadioGroup;Port:TApdWinsockPort;
//             ReceiveFlowBox,TransmitFlowBox:TCheckbox; var PortChanged:boolean);
//  // Used by the commandline parser to us N in FLOW=N and set flow
//  // 0-3 = HW flow set; +8=RX-XON, +4=TX XON
//    var value:integer;
//  begin
//    case Reference[1] of
//      'X','x': begin  //enable software flow control
//        ReceiveFlowBox.Checked:=true;
//        TransmitFlowBox.Checked:=true;
//        exit;
//      end;
//      'R','r':  //RTSCTS
//         value:=2;
//      'D','d': //DTRDSR
//         value:=1;
//      else value:=strtoint(Reference);
//    end;
////
////    if (Reference[1]='X') or (Reference[1]='x')
////      then begin  //enable software flow control
////        ReceiveFlowBox.Checked:=true;
////        TransmitFlowBox.Checked:=true;
////      end else begin
////
////     value:=strtoint(Reference);
//     if value>=8 then begin
//        value:=value-8;
//        ReceiveFlowBox.Checked:=true;
//     end else
//        ReceiveFlowBox.Checked:=false;
//     if value>=4 then begin
//        value:=value-4;
//        TransmitFlowBox.Checked:=true;
//     end else
//        TransmitFlowBox.Checked:=false;
//     if (Value>=Group.Items.Count) or (value<0)
//       then Value:=0;
//     Group.ItemIndex:=value;
//     ItemIndexToHWFlowOptions(Group.ItemIndex,Port);
//     PortChanged:=true;
////     end; //if
//  end; //fn
////  procedure MakeAPPDATADirs;
////  var D1,D2:string;
////  begin
////    D1:=ExpandEnvVars('%APPDATA%');
////    D2:=ExpandEnvVars('%LOCALAPPDATA%');
////    if not (DirectoryExists(D1) and DirectoryExists(D2)) and
////       (mrYes = messagedlg('Create APPDATA and LOCALAPPDATA Directories for Realterm?'+#13+#13+
////                          D1+#13+D2, mtConfirmation, [mbYes,mbNo], 0) )
////        then begin
////          if not DirectoryExists(D1) and not CreateDir(D1) then showmessge('Unable to Create'+#13+#13+ D1);
////          if not DirectoryExists(D2) and not CreateDir(D2) then showmessge('Unable to Create'+#13+#13+ D2);
////    end;
////
////  end;
//begin
//{baud=9600 port=server:telnet capcount=9876 capfile=c:\temp\smap.xxx framesize=7 display=3 bigend=1 visible=0 RTS=0 DTR=1 flow=2}
//   Reference:=AnsiDequotedStr(Reference,'"'); // remove quotes that have come through the first instance message passing
//   if QuitNow then exit; //don't process any more when going to quit
//   param:=uppercase(param);
//   //IsRemoteCommand:=(Sender=ParameterRemote);
//   IsRemoteCommand:=not Parameter1.useProgramParams;
//   if (param='INIFILE') then begin
//     Parameter1.AddParamFileDuringExecute(Reference);
//   end;
//   if (param='BAUD') or (param='BD') then begin
//     ComboBoxBaud.text:=Reference;
//     Port1Changed:=true;
//   end;
//   if (param='PORT') or (param='PT') then begin
//     ComboBoxComPort.text:=Reference;
//     Port1Changed:=true;
//   end;
//   if (param='PORTQUIT') or (param='PQ') then begin
//     ComboBoxComPort.text:=Reference;
//     Port1Changed:=true;
//     PortErrorQuit:=true; //signal to form1.create, that it should quit if port error
//   end;
//   if (param='CAPFILE') or (param='CF') then begin
//     ComboBoxSaveFname.SetFilenameCheckPathExists(Reference);
//   end;
//   if (param='FRAMESIZE') or (param='FS') then begin
//     SpinEditFrameSize.value:= strtoint(Reference);
//   end;
//   if (param='CAPCOUNT' ) or (param='CC') then begin
//     ComboBoxCaptureSize.text:=Reference;
//     RadioGroupCaptureSizeUnits.ItemIndex:=0;  //bytes
//     ComboBoxCaptureSizeChange(nil);
//   end;
//   if (param='CAPSECS' ) or (param='CS') then begin
//     ComboBoxCaptureSize.text:=Reference;
//     RadioGroupCaptureSizeUnits.ItemIndex:=1; //secs
//     ComboBoxCaptureSizeChange(nil);
//   end;
//   if (param='CAPAUTONAME') then begin
//     value:=strtoint(Reference);
//     if (Value>=RadioGroupCaptureAutoFileName.Items.Count) or (value<0)
//       then Value:=0;
//     RadioGroupCaptureAutoFileName.ItemIndex:=Value;
//
//   end;
//   if (param='CAPHEX' ) or (param='CX') then begin
//     CheckBoxCaptureAsHex.Checked:=not (Reference='0');
//   end;
//   if (param='TIMESTAMP' ) or (param='TS') then begin
//     if length(Reference)>1  //not a simple number 0-9
//     then begin   //must be a format string
//        ComboboxTimestampFormat.text:=Reference;
//        Value:=RadioGroupTimeStamp.Items.Count-1; //last one
//     end else begin
//          value:=strtoint(Reference);
//     end;
//     if (Value>=RadioGroupTimeStamp.Items.Count) or (value<0)
//       then Value:=0;
//     RadioGroupTimeStamp.ItemIndex:=Value; //secs
//   end;
//   if (param='CAPPROCESS') then begin
//     if (length(reference)=1) and (reference[1]='0')
//      then CheckboxCapturePostProcess.checked:=false
//      else begin
//        CheckboxCapturePostProcess.checked:=true;
//        if (length(Reference)>0)
//          then ComboboxCapturePostFName.PushString(reference,100);
//          //then ComboBoxPushString(ComboboxCapturePostFName,reference,100);
//      end;
//   end;
//
//   if (Param='TSDELIMITER')  then begin
//     case Reference[1] of
//       ',': value:=0;
//       ' ': value:=1;
//       else begin  //third button is variable
//         value:=2;
//         RadioGroupTimeStampDelimiter.Items[2]:=Reference[1]; //Ensure only a single char. This will be used for delimiter later
//         end;
//     end; //case
//     RadioGroupTimeStampDelimiter.ItemIndex:=Value;
//   end;
//
//   if (param='CAPTURE') or (param='CP') then begin
//     if IsRemoteCommand
//      then begin
//        StartCapture(CaptureModeOrText(reference,ComboBoxSaveFname));
//      end
//      else begin
//        CaptureAutoStart:=CaptureModeOrText(reference,ComboBoxSaveFname);
//        //CaptureAutostart:=cmOn;
//      end;
//   end;
//   if (param='CAPQUIT') or (param='CQ') then begin
//     CaptureAutostart:=cmOn;
//     CaptureAutoQuit:=true;
//     if length(reference)>0 then ComboBoxSaveFname.SetFilenameCheckPathExists(Reference);
//   end;
//   if (Param='CAPDIRECT') or (param='CD') then begin
//     CheckboxDirectCapture.Checked:=not (Reference='0');
//   end;
//   if (param='DISPLAY'  ) or (param='DS') then begin
//     value:=strtointdef(Reference,0);
//     RadioGroupDisplayTypeSet(false,value);
//     //Form1.RadioGroupDisplayType.ItemIndex:=value;
//   end;
//   if (param='VISIBLE') or (param='VS')then begin
//   //not totally sure why visible can't be changed here.....
//     if IsRemoteCommand
//       then Form1.visible:= (Reference='0')
//       else SetPending(PendingInvisible,(Reference='0'));
//   end;
//   if (param='WINDOWSTATE') or (param='WS') then begin
//     UpperRef:=upperCase(reference);
//     if (UpperRef='MIN') then reference:='1';
//     if (UpperRef='NORM') then reference:='0';
//     if (UpperRef='MAX') then reference:='2';
//     if (UpperRef='FULL') then reference:='3';
//     Form1.SetWinState(strtointdef(reference,0));
//  //   if IsRemoteCommand
//    //   then Form1.SetWindowState(strtoint(reference))
//      // else Form1.fWindowState:=strtoint(reference); ////form is created after this is parsed. WindowState etc can't be changed here...
//   end;
//   if (param='BIGEND'  ) or (param='BN') then begin
//     CheckBoxBigEndian.checked:=(Reference='1');
//     CheckBoxBigEndianClick(nil);
//   end;
//   if (param='FLOW'  ) or (param='FW') then begin
//     SetFlow(Reference,Form1.HardwareFlowGroup,Port1,ReceiveFlowBox,TransmitFlowBox,Port1Changed);
//   end;
//   if (param='EFLOW'  ) or (param='EFW') then begin
//       SetFlow(Reference,Form1.EchoHardwareFlowGroup,EchoPort,EchoReceiveFlowBox,EchoTransmitFlowBox, EchoPortChanged);
//   end;
//
//   if (param='RTS')  then begin
//     Port1.RTS:=(Reference='1');
//   end;
//   if (param='DTR')  then begin
//     Port1.DTR:=(Reference='1');
//   end;
//   if (param='CLOSED') then begin
//     if IsRemoteCommand
//       then Port1.Open:= not (reference='1')
//       else Port1.AutoOpen:= not (reference='1');
//   end;
//   if (param='OPEN') then begin
//     if IsRemoteCommand
//       then Port1.Open:= not (reference='0')
//       else begin
//         Port1.AutoOpen:= not (reference='0');
//         CheckboxPortAutoOpen.Checked:=Port1.AutoOpen;
//       end;
//   end;
//   if (param='SPY') then begin
//     if IsRemoteCommand
//       then begin
//         SpyModeOpen(not (reference='0'));
//       end
//       else SpyModeAutoStart:= not (reference='0');
//   end;
//   if (param='TAB') then begin
//     if not SelectTabSheet(Reference) then begin //select the tabsheet by name
//       console.showmessage('Unknown tabsheet name "' + Reference +'"');
//     end;
//   end;
//   if (param='EBAUD') then begin
//     ComboBoxEchoBaud.text:=Reference;
//     EchoPortChanged:=true;
//   end;
//
//   if (param='ECHO') then begin
//     if (length(Reference)<>0) then ComboBoxEchoPort.text:=Reference;
//     BitBtnSetEchoPortClick(nil);
//     CheckBoxEchoOn.checked:=true;
//     CheckBoxEchoOnClick(nil); //and open the port
//     EchoPortChanged:=true;
//   end;
//   if (param='HALF') then begin
//     if length(Reference)=0
//       then CheckboxHalfDuplex.checked:=true
//       else CheckboxHalfDuplex.checked:= (Reference='1');
//   end;
//   if (param='LFNL') then begin
//     if length(Reference)=0
//       then CheckboxNewLine.checked:=true
//       else CheckboxNewLine.checked:= (Reference='1');
//   end;
//   if (param='CRLF') then begin
//     if length(Reference)=0
//       then CheckboxCRLF.checked:=true
//       else CheckboxCRLF.checked:= (Reference='1');
//   end;
//
//
//   if (param='CAPTION') then begin
//     Form1.SetCaption(Reference);
////     Caption:=Reference;
////     MenuItemTitle.Caption:=Reference;
////     TrayIcon1.Hint:=MenuItemTitle.Caption+'  ,'+StatusBar1.Panels[StatusBarPanelEnd].text;
////     Application.Title:=Reference; //shown on start bar when minimised
//   end;
//   if (param='HIDECONTROLS') then begin
//     HideControls1.Checked:= (Reference<>'0');  //default to hide
//     HideControls1Click(nil);
//   end;
//   //CONTROLS depreciated - to be phased out
//   if (param='CONTROLS') then begin
//     HideControls1.Checked:= (Reference='0');  //default to show
//     HideControls1Click(nil);
//   end;
//   if (param='MONITOR') then begin
//     CheckBoxEchoPortMonitoring.checked:=(Reference='1') or (Reference='');
//     CheckBoxEchoPortMonitoringClick(nil);
//   end;
//   if (param='DATA') then begin //sets data format
//     case Reference[1] of
//       '8': Port1.DataBits:=8;
//       '7': Port1.DataBits:=7;
//       '6': Port1.DataBits:=6;
//       '5': Port1.DataBits:=5;
//       else
//         DataBitsFormatErrorMessage;
//     end; //case
//     case uppercase(Reference)[2] of
//       'N': Port1.Parity:=pNone;
//       'O': Port1.Parity:=pOdd;
//       'E': Port1.Parity:=pEven;
//       'M': Port1.Parity:=pMark;
//       'S': Port1.Parity:=pSpace;
//       else
//         DataBitsFormatErrorMessage;
//     end; //case
//     case Reference[3] of
//       '1': Port1.StopBits:=1;
//       '2': Port1.StopBits:=2;
//       else
//         DataBitsFormatErrorMessage;
//     end; //case
//     Port1Changed:=true;
//   end; //DATA
//   if (param='EDATA') then begin //sets data format
//     case Reference[1] of
//       '8': EchoPort.DataBits:=8;
//       '7': EchoPort.DataBits:=7;
//       '6': EchoPort.DataBits:=6;
//       '5': EchoPort.DataBits:=5;
//       else
//         DataBitsFormatErrorMessage;
//     end; //case
//     case uppercase(Reference)[2] of
//       'N': EchoPort.Parity:=pNone;
//       'O': EchoPort.Parity:=pOdd;
//       'E': EchoPort.Parity:=pEven;
//       'M': EchoPort.Parity:=pMark;
//       'S': EchoPort.Parity:=pSpace;
//       else
//         DataBitsFormatErrorMessage;
//     end; //case
//     case Reference[3] of
//       '1': EchoPort.StopBits:=1;
//       '2': EchoPort.StopBits:=2;
//       else
//         DataBitsFormatErrorMessage;
//     end; //case
//    EchoPortChanged:=true;
//   end; //edata
//   if (param='WINSOCK') then begin
//     value:=strtoint(Reference);
//     if (value<0) then Value:=0;
//     Form1.RadioGroupWsTelnet.ItemIndex:=Value;
//   end;
//   if (param='EWINSOCK') then begin
//     value:=strtoint(Reference);
//     if (value<0) then Value:=0;
//     Form1.RadioGroupEchoWsTelnet.ItemIndex:=Value;
//   end;
//   if (param='CHARDLY') then begin //set char delay
//     value:=strtoint(Reference);
//     //if (value<0) then Value:=0;
//     Form1.SpinEditAsciiCharDelay.Value:=Value;
//   end;
//   if (param='LINEDLY') then begin //set char delay
//     value:=strtoint(Reference);
//     if (value<0) then Value:=0;
//     Form1.SpinEditAsciiLineDelay.Value:=Value;
//   end;
//   if (param='ROWS') then begin
//     value:=strtoint(Reference);
//     if (value<=0) then Value:=16;
//     Form1.SpinEditTerminalRows.Value:= Value;
//   end; //ROWS
//   if (param='COLS') then begin
//     value:=strtoint(Reference);
//     if (value<=0) then Value:=16;
//     Form1.SpinEditTerminalCols.Value:= Value;
//   end; //COLS
//
//   if (param='SENDFILE') or (param='SF') then begin
//     if IsRemoteCommand
//      then begin
//        if BooleanOrText(reference,ComboBoxSendFname)
//          then ButtonSendFileClick(nil)
//          else BitBtnAbortSendFileClick(nil);
//      end
//      else begin //from commandline
//        //ComboboxSendFname.text:=Reference;
//        SendFileList.SetFilenames(Reference,ComboboxSendFname);
//        SendFileAutostart:=true;
//      end;
//   end;
//
//   if (param='SENDFNAME') then begin
//        //ComboboxSendFname.text:=Reference;
//        SendFileList.SetFilenames(Reference,ComboboxSendFname);
//    end;
//   if (param='SENDQUIT')  or (param='SQ') then begin
//     if length(Reference)>0 then SendFileList.SetFilenames(Reference,ComboboxSendFname);//ComboboxSendFname.text:=Reference;
//     SendFileAutostart:=true;
//     SendFileAutoQuit:=true;
//   end;
//   if (param='SENDDLY') then begin
//     value:=strtoint(Reference);
//     Form1.SpinEditFileSendDelay.Value:= Value;
//     //Form1.SpinEditFileSendRepeats.Value:=0; //default to endless
//   end; //SENDDLY
//   if (param='SENDREP') then begin
//     value:=strtoint(Reference);
//     Form1.SpinEditFileSendRepeats.Value:= Value;
//   end; //SENDREP
//   if (param='FIRST') then begin
//     if IsFirstInstance then begin //receiving instance
//        if (reference='0') and (WProc<>nil)
//          then WProc := Pointer(SetWindowLong(Application.Handle, gwl_WndProc,Integer(WProc)));
//       if ((reference='1') or (reference='2')) and (WProc=nil)
//          then WProc := Pointer(SetWindowLong(Application.Handle, gwl_WndProc,Integer( @AppWndProcWMCopyData)));
//       if (reference='2')
//          then ChangeMessageFilter; //open up UIPI filter, only when user explicitly authorises it
//     end else begin //sending instance
//       ActivateFirstCommandline(WM_COPYDATA);
//       if (GetLastError<>0)
//        then begin //failed SendMessage
//          ExitCode:=GetLastError; //should be 5=excUIPIBlockedMessage
//          console.ShowMessage('Sending Message to first instance FAILED: '+CRLF+
//                      'ErrorCode='+inttostr(GetLastError)+CRLF+
//                      'Error: '+SysErrorMessage(GetLastError)+CRLF+CRLF+
//                      'Error 5 is an UIPI access problem. Try starting the first instance with'+CRLF+
//                      'realterm.exe first=2 [other params]');
//        end;
//          QuitNow:=true;
//          exit;
//     end;
//   end;
//   if (param='QUIT') or (param='EXIT') then begin
//     //Application.Terminate;
////     showmessage('Closing');
////     Form1.Close;
//     QuitNow:=true;
//     exit;
//   end;
//   if (param='STRING1') or (param='S1')  then begin
//     ComboboxSend1.PushString(reference,100);
//   end;
//   if (param='STRING2') or (param='S2')  then begin
//     ComboboxSend2.PushString(reference,100);
//   end;
//   //sendstr will change to actually sending the string, not loading the combobox
//   if (param='SENDSTR') or (param='SS')  then begin
//     ComboboxSend1.PushString(reference,100);
//     if ( IsRemoteCommand ) then begin
//       //ButtonSendAscii1Click(nil);
//       SendTabSendString1(sasAscii);
//     end
//     else begin
//       SendStringAutostart:=true;
//       SendStringAutostartAs:=sasAscii;
//       //OLD command line parameters it will push into BOTH comboboxes
//       //ComboboxSend2.PushString(reference,100);
//     end;
//   end;
//
//   if (param='SENDNUM') then begin
//     ComboboxSend1.PushString(reference,100);
//     if ( IsRemoteCommand ) then begin
//       //ButtonSendNumbers1Click(nil);
//       SendTabSendString1(sasNumbers);
//     end
//     else begin
//       SendStringAutostart:=true;
//       SendStringAutostartAs:=sasNumbers;
////OLD command line parameters it will push into BOTH comboboxes
////       ComboboxSend2.PushString(reference,100);
//     end;
//   end;
//   if (param='SENDHEX') then begin
//     ComboboxSend1.PushString(reference,100);
//     if ( IsRemoteCommand ) then begin
//       //ButtonSendHex1Click(nil);
//       SendTabSendString1(sasHex);
//     end
//     else begin
//       SendStringAutostart:=true;
//       SendStringAutostartAs:=sasHex;
//     end;
//   end;
//   if (param='SENDLIT') then begin
//     ComboboxSend1.PushString(reference,100);
//     if ( IsRemoteCommand ) then begin
//       //CheckboxLiteralStrings.Checked:=true;
//       //ButtonSendHex1Click(nil);
//       SendTabSendString1(sasLiteral);
//     end
//     else begin
//       SendStringAutostart:=true;
//       SendStringAutostartAs:=sasLiteral;
//     end;
//   end;
//
//   if (param='CR') then begin
//     CheckBoxCR1.checked:=not (reference='0');
//   end;
//   if (param='LF') then begin
//     CheckBoxLF1.checked:=not (reference='0');
//   end;
//   if (param='SCANPORTS') then begin
//     //SuppressPortScan:= (reference='0');
//     PortScanLastPortOnStartup:=strtoint(reference);
//     PortScanLastPort:=max(PortScanLastPort,PortScanLastPortOnStartup);
//   end;
//   if (param='HELP') then begin
//      SetPending(PendingHelp);
//   end;
//   if (param='I2CADD') then begin
//     ComboBoxIAddress.Text:=reference;
//   end;
//   if (param='SCROLLBACK') then begin
//     if (length(Reference)<>0) then begin
//        value:=strtoint(Reference);
//        if value<>0 then
//          Form1.SpinEditScrollbackRows.Value:= abs(Value);
//        CheckboxScrollback.checked:= value>0; //Reference<>'0';
//     end;
//
//   end; //SCROLL
//   if (param='COLORS') then begin
//     //SetColors(Reference);
//     EditColors.Text:=Reference;
//   end;//COLORS
//   if (param='INSTALL') then begin //used after installer has been run
//     SetPending(PendingInstall); //can set help if it wants
//     PortScanLastPortOnStartup:=4;
//
//     if (length(Reference)<>0) then
//        try
//          strtoint(Reference[1]); //errors if first char is not a digit
//            rtUpdate.InstallParamVersion:=(Reference);
//          except
//            PendingMessage:=Reference;
//          end;
//   end;
//   if (param='MSGBOX') then begin //brings up a message box
//     SetPending(PendingStuff);
//      if (length(Reference)<>0)
//        then PendingMessage:=Reference
//        else PendingMessage:='Usage: MSGBOX="you must give a string for me to show here"';
//   end;
//
//
//   if (param='HEXCSV') then begin
//     ComboBoxHexCSVFormat.PushString(reference,100);
//   end;
//   if (param='SCALE') then begin
//     value:=strtointdef(Reference,0); //nothing,0 or auto will return 0 ->autoscale
//     Form1.SpinEditScale.Value:= Value;
//     FormScale(Value);
//   end; //SENDREP
//   if (param='CLEAR') then begin
//     if (Reference='') and (IsRemoteCommand) then Form1.Clear1Click(nil); //clear
//     SetClearTerminalCheckboxes(StrtoIntDef(Reference,3));
//   end;
//   if (param='FONTNAME') then begin
//      AdTerminal1.Font.Name:=(reference);
//      SetFormSizeFromRowsCols(true,true);
//   end;
//   if (param='FONTSIZE') then begin
//      AdTerminal1.Font.Size:=StrtoIntDef(reference,12);
//      SetFormSizeFromRowsCols(true,true);
//   end;
//   if (param='BSYNCIS') then begin
//      RadioGroupSyncIs.ItemIndex:=StrtoIntDef(reference,0);
//   end;
//   if (param='BSYNCDAT') then begin
//      ComboBoxSyncString.PushString(reference);
//   end;
//
//   if (param='BSYNCAND') then begin
//      ComboBoxSyncAND.PushString(reference);
//   end;
//   if (param='BSYNCXOR') then begin
//      ComboBoxSyncXOR.PushString(reference);
//   end;
//   if (param='BSYNCHI') then begin
//      CheckBoxHighlightSync.checked:=(Reference='1') or (Reference='');
//   end;
//   if (param='BSYNCLEAD') then begin
//      CheckBoxLeadingSync.checked:=(Reference='1') or (Reference='');
//   end;
//   if (param='BSYNCSHOWCOUNT') then begin
//      SpinEditSyncShowLength.value:=StrtoIntDef(reference,-1);
//   end;
//   if ((param='KEYMAPVT') or (param='KEYMAP'))
//              and fileexists(Reference) //check for a valid file...
//   then begin
//        if (param='KEYMAPVT') then begin
//          AdEmulator_VT100.KeyboardMapping.LoadFromFile(Reference);
//        end;
//        if (param='KEYMAP') then begin
//          AdEmulator_Hex.KeyboardMapping.LoadFromFile(Reference);
//          AdShowAllEmulator.KeyboardMapping.LoadFromFile(Reference);
//        end;
//   end;
//   if (param='CRC') then begin
//     value:=StrtoIntDef(reference,1);
//     CRCType2UI(value);
////     CheckBoxCRC.checked:= (value<>0);
////     if (value<>0) then begin  //this allows Combobox and Hex to remain unchanged when CRC=0, so all controls can be set.
////        ComboBoxCRC.ItemIndex:=abs(value)-1;
////        CheckBoxCRCHex.checked:= (value<0);
////     end;
//   end;
//   if (param='EXITCODE') then begin
//       ExitCode:=StrtoIntDef(reference,1); //
//       //not using console for this message...
//       ShowMessage('Force EXITCODE for debugging batch files...'+CRLF+
//                      'ExitCode='+inttostr(ExitCode)+CRLF+CRLF+
//                      'CommandLine is:'+CRLF+Form1.Parameter1.ParamString.Text);
//       //Application.Terminate;
//       QuitNow:=true;
//       exit;
//   end;
//   if (param='CONSOLE') then begin
//     //StrtoIntDef(reference,1);
//     case StrtoIntDef(reference,1) of
//       0: Console.Detach;
//       //1 is else
//       2: begin
//            Console.Attach(true,true,true);
//            Console.writeln('Realterm Attached to Console. GUI Error and Message popups suppressed');
//          end;
//       else begin // 1 or anything else..
//            Console.Attach(true,true,false);
//            Console.writeln('Realterm Attached to Console');
//            end;
//     end;
//     //Console.Attach(true,true);
//     //Console.writeln('Realterm Attached to Console');
//   end;
//   if (param='RXIDLE') then begin
//     value:=StrtoIntDef(reference,1);
//     case value of
//       0: CheckBoxRxdIdle.Checked:=false;
//       1: CheckBoxRxdIdle.Checked:=true;
//       else begin
//         CheckBoxRxdIdle.Checked:= (value>0);
//         SpinEditRxdIdle.value:=abs(value);
//       end;
//     end; //case
//   end;
//   if (param='NOSLEEP') then begin
//     CheckboxNoSleep.checked:=not (reference='0');
//   end;
//      if (param='WINX') then begin
//     value:=strtointdef(Reference,Form1.Left); //nothing,0 or auto will return 0 ->autoscale
//     Form1.Left:= Value;
//   end; //
//   if (param='WINY') then begin
//     value:=strtointdef(Reference,Form1.Top); //nothing,0 or auto will return 0 ->autoscale
//     Form1.Top:= Value;
//   end; //
//   if (param='WINW') then begin
//     value:=strtointdef(Reference,Form1.Width); //nothing,0 or auto will return 0 ->autoscale
//     PendingWidth:=value;
//     Form1.Width:= Value;
//   end; //
//   if (param='WINH') then begin
//     value:=strtointdef(Reference,Form1.Height); //nothing,0 or auto will return 0 ->autoscale
//     PendingHeight:=value;
//     Form1.Height:= Value;
//     //FormScale(Value);
//   end; //
//
//end;


procedure TForm1.SetCaption(S:string);
begin
  Caption:=S;
  MenuItemTitle.Caption:=S;
  TrayIcon1.Hint:=S+'  ,'+StatusBar1.Panels[StatusBarPanelEnd].text;
  Application.Title:=S;
end;
procedure TForm1.SetClearTerminalCheckBoxes(Value:integer);
begin
  CheckBoxClearTerminalOnDisplayChange.Checked:= (Value and 1)<>0;
  CheckBoxClearTerminalOnPortChange.Checked:= (Value and 2)<>0;
  CheckBoxClearTerminalOnPortOpen.Checked:= (Value and 4)<>0;
end;
function  TForm1.GetClearTerminalCheckBoxes:integer;
begin
  result:= 1* ord(CheckBoxClearTerminalOnDisplayChange.Checked)
          +2* ord(CheckBoxClearTerminalOnPortChange.Checked)
          +4* ord(CheckBoxClearTerminalOnPortOpen.Checked);
end;
//populates the comboboxes with com numbers found on this system. Pushes down existing strings
procedure TForm1.PopulateComNumbers(LastComport:integer; ShowForm:boolean; ForceSearch:boolean=false);
//Windoes98 doesn't have the registry entries for ports
begin
  if ForceSearch or (Win32Platform=VER_PLATFORM_WIN32_WINDOWS)	or (Win32Platform=VER_PLATFORM_WIN32s)
    then PopulateComNumbersBySearch(LastComport,ShowForm) //<=Win98 (probably WinME)
    else PopulateComNumbersFromRegistry; //>=WinNT
end ;
procedure TForm1.ComboBoxUSBHistorySelect(Sender: TObject);
  var DevString,DevType,DriverName,FriendlyName,ClassName, Service, Mfg:string; CB:TCombobox;
begin
  CB:=Sender as TCombobox;
  DevString:=CB.Items[CB.ItemIndex];
  DeviceNotifier.GetUsbInfo(DevString,ComboBoxUSBData.Items);
  ComboBoxUSBData.ItemIndex:=0;
end;
procedure TForm1.USBPortChange(Sender: TObject; Added:boolean; const DeviceStr: String); // of Object;
  var S,FN,PN:string;  U:TStrings;

begin
  if Added
    then S:='USB Plugged : '
    else S:='USB Removed : ';
  PopulateComNumbersFromRegistry;

  ComboBoxUSBHistory.PushString(DeviceStr);

  U:=ComboBoxUSBData.Items;
  DeviceNotifier.GetUsbInfo(DeviceStr,U,FN,PN);
  ComboBoxUSBData.ItemIndex:=0;
  LabelUSBShow.color:=BoolColor(Added);
  PanelUSBShow.color:=BoolColor(Added);

  StatusBarHint:=S+ComportList.ChangedPortStr+' '+PN+'  '+FN;
end;

procedure PanelButton(Down:boolean);
  var P:TPanel;
begin
  P:=Form1.PanelUSBShow;
  if Down then begin
    P.BevelOuter:=bvLowered;
    end else begin
    P.BevelOuter:=bvRaised;
  end;

end;
procedure TForm1.LabelUSBShowClick(Sender: TObject);
begin
  ComboBoxUSBData.Visible:=not ComboBoxUSBData.Visible;
  ComboBoxUSBHistory.Visible:=ComboBoxUSBData.Visible;
  PanelButton(ComboBoxUSBData.Visible);
end;

procedure TForm1.PopulateComNumbersFromRegistry;
begin
    ComportList.Update;
    FirstAvailablePort:=ComportList.FirstAvailablePort;
    ComboBoxComport.AddListAtTop(ComportList);
    ComboBoxEchoPort.AddListAtTop(ComportList);
end;//fn

//If LastComport<=0, then will search first 4 ports for the firstavailablecomport
procedure TForm1.PopulateComNumbersBySearch(LastComport:integer; ShowForm:boolean);
var
  I, InsertPoint : Integer;
  S : string;
  OnlyFindFirstPort:boolean;
begin
  //AddComList(ComboBoxComport);
  FirstAvailablePort:=0;
  OnlyFindFirstPort:=LastComport<=0;
  if OnlyFindFirstPort then LastComport:=4;
  //if LastComport<=0  then exit; //handle case of scanports=0
  if ShowForm then self.ShowForm(FormScanPorts, false);//FormScanPorts.Show;
  FormScanPorts.StartScanning(LastComPort);
  S:='';
  InsertPoint:=0;
  for I := 1 to LastComport do begin   //MaxComHandles is constant
    FormScanPorts.Scanning(I,LastComport);
    if FormScanPorts.AbortScanning then break;
    if IsPortAvailable(I) then begin
      S := inttostr(I);
      if ComboBoxComport.Items.IndexOf(S)=-1  //not already in combobox
        then begin
          ComboBoxComport.Items.Insert(InsertPoint,S);
          ComboBoxEchoPort.Items.Insert(InsertPoint,S);
          inc(InsertPoint);
        end;
      if FirstAvailablePort=0
          then begin
            FirstAvailablePort:=I;
            if OnlyFindFirstPort then break;
          end;

    end;
  end; //for
  FormScanPorts.EndScanning;
end;

function ParityStartStopAsString(Port:TApdWinsockport):ansistring;
  var P:ansichar;
begin
  case Port.Parity of
    pNone: P:='N';
    pEven: P:='E';
    pOdd : P:='O';
    pMark: P:='M';
    pSpace:P:='S';
    else P:='?';
  end; //case
  result:=inttostr(Port.Databits) + P +inttostr(Port.Stopbits);
end;
function HandshakingAsString(Port:TApdWinsockport) :ansistring ;

begin
  result:=Form1.HardwareFlowGroup.Items[Form1.HardwareFlowGroup.ItemIndex];

  case Port.SWFlowOptions of
   swfNone: ; //already has a string from HWFlow above
   swfBoth, swfReceive, swfTransmit:
     if (Form1.HardwareFlowGroup.ItemIndex=0)
       then result:='XonXoff'
       else result:=result+ '+XonXoff';
   else result:=result+'?';
  end; //case
end; //HandshakingAsString

procedure TForm1.SetStatusPanelWidth;
var PortW,CPSW,CCW:integer; //width of strings
  procedure ScaleW(var W:integer);
  begin
    W:=W * SpinEditScale.Value div 100;
  end;
begin
  PortW:= StatusBar1.Canvas.TextWidth(StatusBar1.Panels[StatusBarPanelEnd].text);
  CPSW:= StatusBar1.Canvas.TextWidth('CPS:000k');
  CCW:= StatusBar1.Canvas.TextWidth('Chars:0000000');
  ScaleW(PortW);
  ScaleW(CPSW);
  ScaleW(CCW);
  StatusBar1.Panels[StatusBarPanelCPS].Width:=CPSW+StatusBar1.BorderWidth*2;
  StatusBar1.Panels[StatusBarPanelCharCount].Width:=CCW+StatusBar1.BorderWidth*2;
  StatusBar1.Panels[0].Width:= StatusBar1.Width
                              - StatusBar1.Height *3 div 2 //extra spave for the bevel drag symbol *2 because using tacentred alignment
                              //- StatusBar1.Height //extra spave for the bevel drag symbol *2 because using left alignment
                              - StatusBar1.Panels[1].Width
                              - StatusBar1.Panels[2].Width
                              - PortW - 10;

end;

procedure TForm1.SetPortAndBaudCaptions;
var BaudStr:string;
begin
  BaudStr:='';
  MenuItemPort.Caption:='Port: Closed';
  MenuItemBaud.Caption:='Baud: ----';
  if Port1.open
    then begin
      MenuItemPort.Caption:='Port: '+ComboBoxComPort.text;
      if Port1.DeviceLayer<>dlWinsock
        then begin
          BaudStr:=ComboBoxBaud.text + ' ' +ParityStartStopAsString(Port1) +' '+HandshakingAsString(Port1);
          MenuItemBaud.caption:='Baud: '+BaudStr;
          end
        else MenuItemBaud.caption:='Baud: ----';
    end
    else begin //port is closed
      if SpeedButtonSpy1.Down
        then begin
          MenuItemPort.Caption:='Port: '+ComboBoxComPort.text;
          MenuItemBaud.Caption:=' Spying';
          BaudStr:='Spying';
          end;
    end;
  StatusBar1.Panels[StatusBarPanelEnd].text:= MenuItemPort.caption+'  '+BaudStr;
  //set width to fit data....
  SetStatusPanelWidth;

  //StatusBar1.Panels[StatusBarPanelEnd].width:=StatusBar1.Canvas.TextWidth(StatusBar1.Panels[StatusBarPanelEnd].text)+20;
  TrayIcon1.Hint:=MenuItemTitle.Caption+'  ,'+StatusBar1.Panels[StatusBarPanelEnd].text;
end; //SetPortAndBaudCaptions

type TExitCode=(excNormal=0,excNoSuchPort=1,excPortBusy=2,excFileError=3,excUIPIBlockedMessage=5,excSendFileTimeout=6);
//procedure SetExitCode(V:TExitCode);
//begin
//  ExitCode:=integer(V);
//end;

procedure TForm1.FormCreate(Sender: TObject);
  var Port1AutoOpen, PortRetry:boolean;
  var TempCols:integer;
  function PortMessageOrQuit(ErrorExitCode:TExitCode; E:Exception ; Msg:string):boolean;
  begin
    //Port1.open:=false;
    if not (E=nil) then  //there is an error
      Msg:=Msg+char(13)+E.Message;
      LastErrorMessage:=Msg;
      Console.writeln(Msg);
    if PortErrorQuit
      then begin    //if PortQuit then close down
        //Console.writeln(Msg);
        ExitCode:=integer(ErrorExitCode);
        result:=false;
        //self.WindowState:=wsMinimized; //and stop the form flashing up
        Application.Terminate;  //put the terminate message into the q
        exit;
        end
      else begin   //otherwise show error dialog
        result:=(mrRetry=MessageDlg(Msg, mtError, [mbOK,mbRetry], 0));
      end;
  end;
  Procedure SetDesignSize;
  var A:TRect;
  begin
    //clip to screen size for small netbook screens
    //don't set the form yet, as later row->routine does it.
    A:=Screen.WorkAreaRect;
    FDesignHeight := min(Height,A.Height);
    FDesignWidth := min(Width,A.Width);
    FPrevWidth := Width;
    FPrevHeight := Height;
    //Now try to workout the scaling
    Form1.ClientWidth :=Form1.ClientWidth;
    fScale:=PageControl1.Width;
    PageControl1.Align:=alNone; //forces Pagecontrol to take client width
    fScale:=100 * PageControl1.Width div fScale;
    FDesignWidth := max(PageControl1.Width,FDesignWidth); //trying to deal with scaled width
    //SpinEditScale.value:=fScale;
    //PendingSize:=TRect.Create(Self.BoundsRect); //get current size/pos so WinX,Y,W,H params can modify
  end;
  function FontSizeStr(PixelHeight:integer):string;
  var Pt:integer;
  begin
    Pt:=PixelHeight * 72 div Screen.PixelsPerInch;  //or AdTerminal1.Font.pixelsPerInch?
    result:=inttostr(Pt);
  end;
  procedure SetFontButtonCaptions; //Deal with
  begin
    ButtonFontSize1.Caption:=FontSizeStr(12);
    ButtonFontSize2.Caption:=FontSizeStr(24);
  end;
  procedure ExecuteParameters;
    var fnDefault:string;
  begin
    Parameter1.SwitchWatch:=Parameter1.ParamWatch;
    Parameter1.ParamFile:=expandenvvars(
        DEFAULT_MACRO_PATH+ALWAYS_STARTMACRO_NAME+MACRO_EXT);
    Parameter1.useParamFile:=fileexists(Parameter1.ParamFile);
    fnDefault:=expandenvvars(
        DEFAULT_MACRO_PATH+DEFAULT_STARTMACRO_NAME+MACRO_EXT);
    if (ParamCount=0) and FileExists(fnDefault) then
        Parameter1.AddParamFileDuringExecute(fnDefault);
    Parameter1.ExecuteProgramParams;
  end;
begin //form.create
  SendFileList:= TFilenameList.create;
  Macro1:=TStringList.Create;
  Macro2:=TStringList.Create;
  fScale:=100; //default scaling
//  SetDesignSize;
  Scaled:=true;
  CaptureEOLChar:=#10;
  //ChangeScale(100,fScale,false);
  //TP_GlobalIgnoreClassProperty(TAdTerminal);
  //TranslateComponent(self); //translation should come first
  AdShowAllEmulator := TAdShowAllEmulator.create(Form1);
  AdShowAllEmulator.OnProcessChar:=AdEmulator_ShowAllProcessChar; //affected by params
  {$IFDEF DEBUG} ButtonPlay1.Visible:=true; ButtonPlay2.Visible:=true; {$ENDIF}
  ExecuteParameters;
//if fScale<>100 then FormScale(fScale); //can't resize before now.
//self.WindowState:=wsMaximized;
  //Having Port1.AutoOpen causes extra trap errors during IsComAvailable and causes terminal rx problem

  Port1AutoOpen:=Port1.AutoOpen; //So now save the value to another var
  Port1.AutoOpen:=false;  //and clear the port var that seems to be causing the problems

  if QuitNow then begin
    //Port1.AutoOpen:=false; //needed to prevent a ecPortOpen warning when sending to FIRST instance from command line
    self.WindowState:=wsMinimized; //and stop the form flashing up
    Application.Terminate;  //put the terminate message into the q
    exit;
  end;
  //to support scaling screen

  //WProc := Pointer(SetWindowLong(Application.Handle, gwl_WndProc,Integer( @AppWndProcWMCopyData)));
  //http://www.festra.com/eng/tip-hints.htm
  //Application.ShowHint := True;
  Application.OnShowHint := ShowHint; //
  //Application.OnHint := DisplayHint; //puts tooltips into status bar
  Application.HintHidePause:=3500; //default is 2500ms. lengthen by request
  Application.HintShortCuts:=true;
  ComboboxComport.Hint:='Dbl-click to scan ports.'+'Physical Port#  or name \VCP0  or portname \\.\COMA'+#13+
                        'ip_address:port or server:port (port can be service name eg "telnet") eg 192.168.0.102:23 or server:telnet or server:9876';
  ComboboxEchoPort.Hint:=ComboboxComport.Hint;
  NoNagAboutSpy:=SpyDriversInstalled;

  SetColors(EditColors.Text);
  fEchoPortConnected:=false;
  ParameterINIDlg.MacroButtonDo(0,false,true);//load default macros
  CannedStrings:=TStringlist.create;
  with GlobalHotKeys1 do begin
    AddMenuHotkey(MenuItemSendStringAscii1);
    AddMenuHotkey(MenuItemSendStringAscii2);
    AddMenuHotkey(MenuItemSendStringNum1);
    AddMenuHotkey(MenuItemSendStringNum2);
    AddMenuHotKey(MenuItemMacro1);
    AddMenuHotKey(MenuItemMacro2);
  end;
  TrayIconLoadIcons;
  AddDblClickToRadioGroup(RadioGroupTimeStamp,RadioButtonTimeStampDummy);
  DragAcceptFiles(Self.Handle, True);
  SysMenuAddRemoveExtraItems;
  SetFontButtonCaptions;
  //AddHintToRadioGroupButton(RadioGroupDisplayType, 'Displays all 256 chars with special font', 0);
//  AdShowAllEmulator := TAdShowAllEmulator.create(Form1);
//  AdShowAllEmulator.OnProcessChar:=AdEmulator_ShowAllProcessChar;

  //SetSpinEditValue(SpinEditTerminalRows,101);
  //SetSpinEditValue(SpinEditTerminalCols,255);
//  Form1.Width:=1800;
//  Form1.Height:=1800;
  AdTerminal1.Columns:=SpinEditTerminalCols.value;
  SpinEditTerminalRowsChange(nil);  //set to design values in Spinedits, not terminals, also Resize form
  SpinEditRxdIdleChange(nil);      //set to design value
  //SpinEditTerminalColsChange(nil);

  //AdTerminal1.Clear; //needed following removal of row clear from TadTrmEmu-Loaded
  //AdShowAllEmulator.ControlCharShowStyles :=(ssShowControlChars,ssShowCRLF,ssAlwaysLFatCR,{ssNoCRLFActions,}ssShowBackspace{, ssNoTabAction});

  //Problem with COLS commandline is overridden by setting display type.
  TempCols:=SpinEditTerminalCols.Value;  //keep
  RadioGroupDisplayTypeClick(nil); //set emulator
  if (TempCols>0) then SpinEditTerminalCols.Value:=TempCols; //restore
  //size should be set by now
  if PendingWidth>0 then Width:=PendingWidth;
  if PendingHeight>0 then Height:=PendingHeight;

  //AdTerminal1.Emulator := AdShowAllEmulator;
  if length(ComboboxComPort.text)=0 then ComboboxComPort.text:=Get_ComPortString(Port1);
  if length(ComboboxBaud.text)=0 then ComboboxBaud.text:= inttostr(Port1.baud);

  ParityGroup.ItemIndex   := Ord(Port1.Parity);
  DataBitsGroup.ItemIndex := 8 - Port1.Databits;
  StopBitsGroup.ItemIndex := Port1.Stopbits - 1;


  if (hwfUseRTS in Port1.HWFlowOptions) or (hwfRequireCTS in Port1.HWFlowOptions) then
    HardwareFlowGroup.ItemIndex := 2
  else if (hwfUseDTR in Port1.HWFlowOptions) or (hwfRequireDSR in Port1.HWFlowOptions) then
    HardwareFlowGroup.ItemIndex := 1
  else  if Port1.RS485Mode then
    HardwareFlowGroup.ItemIndex:=3
  else
    begin
      HardwareFlowGroup.ItemIndex := 0;
      StatusBarHint:='Warning: No handshaking';
    end;

  case Port1.SWFlowOptions of
    swfReceive : ReceiveFlowBox.Checked  := True;
    swfTransmit: TransmitFlowBox.Checked := True;
    swfBoth    :
      begin
        ReceiveFlowBox.Checked  := True;
        TransmitFlowBox.Checked := True;
      end;
  end;

  XonCharEdit.Text  := IntToStr(Ord(Port1.XonChar));
  XoffCharEdit.Text := IntToStr(ord(Port1.XoffChar));
  //if PicProg.Open
  //  then begin
    //  GroupBoxPP.Enabled:=false;
 //     GroupBoxPP.Hint:='Unable to open DLPORTIO Driver';
 //   end


 //MenuItemTitle.Caption:=Caption;
 //MenuItemBaud.caption:='Baud: '+ComboBoxBaud.text;

 //StatusBar1.Panels[6].text:=
 //now over-ride with any commandline values
 //Parameter1.execute_line(ParamStr);
 //now set any changed values...
 SpinEditAsciiCharDelayChange(nil); //also sets blocksize
 BitBtnSetPortClick(nil);
 BitBtnSetEchoPortClick(nil);


 // Now try to scan for ports and set the default port
 // Don't scan unless smStandAlone
 // Don't scan if PORT set on commandline, unless scanports is set on commandline
  if  (Comserver.StartMode=smStandAlone) and
     ((Port1.ComNumber=0) or (PortScanLastPortOnStartup<>MaxComHandles))
       then begin
    PopulateComNumbers(PortScanLastPortOnStartup,false); //finds FirstAvailablePort too
  end; //if
  if (Port1.ComNumber=0) and not PortErrorQuit then begin  //means that commandline didn't set it
    if (FirstAvailablePort>0)  //so we did find one
      then Port1.ComNumber:=FirstAvailablePort
      else begin
        Port1.ComNumber:=1;  //what else can I do?
        Port1AutoOpen:=false; //but don't autoopen
      end;
  end;
  DeviceNotifier:=TDeviceNotifier.CreateComportNotifier;
  DeviceNotifier.OnDeviceArrivalRemoval:=self.USBPortChange;
 //now open the port
 if Comserver.StartMode=smAutomation then begin
   Port1AutoOpen:=false;
   CheckBoxPortAutoOpen.Checked:=false;
 end;
 if Comserver.StartMode=smStandAlone then begin  //don't slow down automation launches. prob pointless as takes 50ms...
   if IsCodeSigned('','Broadcast Equipment Ltd')
     then begin
//       StatusBarHint:='Realterm has a Valid Digital Signature';
//       LinkLabelBadSignature.Visible:=false;
       end
     else begin
//       {$IFNDEF DEBUG}LinkLabelBadSignature.Visible:=true; {$ENDIF} //it would always show during debugging as it's never signed...
//       StatusBarHint:='Realterm has a BAD Digital Signature or cannot be checked'
     end;
 end;
 if Comserver.StartMode=smStandAlone then begin //only open the port immediately in standalone mode
//    if false then begin
    if SpyModeAutostart
      then SpyModeOpen(true)
      else
        repeat
        PortRetry:=false;
        try
          if PortErrorQuit and (Port1.DeviceLayer=dlWin32) and (Port1.ComNumber=0) then
              PortRetry:=PortMessageOrQuit(excNoSuchPort,nil,'BadID, Probably PORT does not exist')
          else
            Port1.open:=Port1AutoOpen;
          //Port1.AutoOpen:=false;
//          if IsPortAvailable(Port1.ComNumber)
//            then Port1.open:=Port1AutoOpen
//            else begin
//              MessageDlg('Port not available. Probably PORT does not exist', mtInformation, [mbOK], 0);
//              Port1AutoOpen:=false;
//            end;
        except
          on E: EAlreadyOpen do begin
        //E.Message:= 'Port is already open. You must change Port'+char(13)+E.Message;
        //raise;
        PortRetry:=PortMessageOrQuit(excPortBusy,E,'Port is already open. You must change Port or close other application');

        //PortRetry:=(mrRetry=MessageDlg('Port is already open. You must change Port or close other application'+char(13)+E.Message, mtInformation, [mbOK,mbRetry], 0));
        Port1.open:=false;
        Port1.AutoOpen:=false;
        end;
      on E: eBadId do begin
        //PortRetry:=(mrRetry=MessageDlg('BadID, Probably PORT does not exist'+char(13)+E.Message, mtInformation, [mbOK,mbRetry], 0));
        PortRetry:=PortMessageOrQuit(excNoSuchPort,E,'BadID, Probably PORT does not exist');
        Port1.open:=false;
        //ShowMessage('BadID, Probably PORT does not exist'+char(13)+E.Message);
        end;
      on E: eBaudRate do begin
        PortRetry:=PortMessageOrQuit(excNoSuchPort,E, 'BaudRate Error, Probably an impossible baudrate');
        //MessageDlg('BaudRate Error, Probably an impossible baudrate'+char(13)+E.Message, mtInformation, [mbOK], 0);
        Port1.open:=false;
        end;
      on E: EOpenComm do begin
        PortRetry:=PortMessageOrQuit(excNoSuchPort,E, 'Error Opening Comm, ');
        //MessageDlg('Error Opening Comm, '+char(13)+E.Message, mtInformation, [mbOK], 0);
        Port1.open:=false;
        end;
      on E:Exception do begin
       PortRetry:=PortMessageOrQuit(excNoSuchPort,E, 'Other Error opening comm, ');
       Port1.open:=false;
      end;
//      ecByteSize
//      ecDefault
//      ecHardware
//      ecMemory
//      ecCommNotOpen
//      ecNoHandles
//      ecNoTimers
//      ecNoPortSelected
    end; //try open
    until not PortRetry;
    //showmessage('bingo');
    Form1.SpeedButtonPort1Open.down:=Port1.Open;
    if (Comserver.StartMode=smAutomation) then begin
      TabsheetEvents.TabVisible:= true;
      RadioGroupSendEvent.Enabled:=true; //only useful in automation state
    end else begin
      TabsheetEvents.TabVisible:= false;
      RadioGroupSendEvent.Enabled:=false;
    end;
  end;
  //----- Moved from on activate
  //Re-display these values incase the port changed them (eg baud rate) when opening
  ComboBoxComPort.text:=Get_ComPortString(Port1); //init from port component
  ComboBoxBaud.text:=inttostr(Port1.baud);
  SetPortAndBaudCaptions;
  ApdSLController1.monitoring:=true;
  ApdSLControllerEcho.monitoring:=true;
  if Port1.open and (CaptureAutostart<>cmoff ) then begin
    StartCapture(CaptureAutoStart);
  end;
  if Port1.open and SendStringAutostart then begin
    SendTabSendString1(SendStringAutostartAs);
  end;
  if Port1.open and SendFileAutostart then begin
    ButtonSendFileClick(nil); //start sending file
  end;
  if Caption=''
    then begin
      //Default capton is set in AFVersion Caption now
      case Comserver.StartMode of
//     smAutomation: AFVersionCaption1.InfoPrefix:='Realterm: Automation Server';
//     smStandalone: AFVersionCaption1.InfoPrefix:='RealTerm: Serial Capture Program';
         smAutomation: Form1.Caption:='Realterm: Automation Server';
         smStandalone: Form1.Caption:='RealTerm: Serial Capture Program';
       else  ;
      end; //case
      Form1.Caption:=Form1.Caption+' '+rtUpdate.CurrentVersion
      //AFVersionCaption1.InfoPrefix:=AFVersionCaption1.InfoPrefix+' Automation Server';
      //AFVersionCaption1.execute;
    end;
  if Comserver.StartMode = smStandalone then
    rtUpdate.SetupForUpdate(ShowUpdateAvailable, AppAnalytics1);

    //rtUpdate.SetupForUpdate(AFVersionCaption1.Info, ShowUpdateAvailable, AppAnalytics1);
  Port1Changed:=false;  //might have been set by cmdline, and only active for "first" mode
  EchoPortChanged:=false;
  Timer1.Enabled:=true;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin

  DragAcceptFiles(Self.Handle, False);
  SendFileList.Destroy;
  Macro2.Free;
  Macro1.Free;
  DeviceNotifier.Free;
end;

//FormCreate


function TForm1.FormHelp(Command: Word; Data: NativeInt;
  var CallHelp: Boolean): Boolean;
begin
  CallHelp:=false;
  AllHelp;
  //showmessage(form1.HelpFile);
  result:=true; //look no further
end;


procedure TForm1.ItemIndexToHWFlowOptions(ItemIndex:integer;Port:TApdWinsockPort);
begin
    Port.RS485Mode :=false;
    case ItemIndex of
      0: Port.HWFlowOptions := [];
      1: Port.HWFlowOptions := [hwfUseDTR, hwfRequireDSR];
      2: Port.HWFlowOptions := [hwfUseRTS, hwfRequireCTS];
      3: begin
           Port.HWFlowOptions := [];
           Port.RS485Mode :=true;
         end;
    end;
end;
function Baud2Int(S,SMult:string):integer;
var  L,m{,mult}:integer;
begin
  L:=length(S);
  case S[L] of
    'M','m': begin
               m:=1000000;
               dec(L);
              end;
    'K','k': begin
               m:=1000;
               dec(L);
              end;
    else m:=1;
    end; //case
    S:=LeftStr(S,L); //remove the multiplier
  result:=strtoint(S)*m div strtoint(SMult);
end;
procedure TForm1.SetComPortClick(Sender: TObject);
  var
    E    : Integer;
    Temp : Byte;
    SerialControlsColor, SerialTextColor, WinsockTextColor: TColor;

  begin
    //change the port itself
    Set_Comport(Port1,ComboBoxComPort.GetStringPutAtTop);

    Port1.Parity   := TParity(ParityGroup.ItemIndex);
    Port1.Databits := 8 - DataBitsGroup.ItemIndex;
    Port1.Stopbits := StopBitsGroup.ItemIndex + 1;

    if (Port1.DataBits=5)
      then RadioGroupDisplayType.Items[0]:='Baudot'
      else RadioGroupDisplayType.Items[0]:='&All Chars';

    ItemIndexToHWFlowOptions(HardwareFlowGroup.ItemIndex, Port1);

    if TransmitFlowBox.Checked and ReceiveFlowBox.Checked then
      Port1.SWFlowOptions := swfBoth
    else if not TransmitFlowBox.Checked and not ReceiveFlowBox.Checked then
      Port1.SWFlowOptions := swfNone
    else if TransmitFlowBox.Checked then
      Port1.SWFlowOptions := swfTransmit
    else if ReceiveFlowBox.Checked then
      Port1.SWFlowOptions := swfReceive;

    Val(XonCharEdit.Text, Temp, E);
    if (E = 0) then
      Port1.XonChar := ansiChar(Temp);
    Val(XoffCharEdit.Text, Temp, E);
    if (E = 0) then
      Port1.XoffChar := ansiChar(Temp);
    try
    Port1.baud:=Baud2Int(ComboBoxBaud.GetStringPutAtTop,ComboboxBaudMult.GetStringPutAtTop); //strtoint(ComboBoxBaud.text);
    //Port1.baud:=Baud2Int(ComboBoxBaud.text,ComboboxBaudMult.text); //strtoint(ComboBoxBaud.text);
    except
      on E:EInOutError do MessageDlg('"'+E.Message+'"'+char(10)+char(10)+'Probably the requested baud rate is not possible on this adaptor',mtError,[mbOK],0);
    end;
    ComboBoxBaud.text:=inttostr(Port1.Baud);
    ComboBoxComPort.text:=Get_ComPortString(Port1);
  //  MenuItemPort.Caption := 'Port: '+ComboBoxComPort.text;
  //  MenuItemBaud.caption:='Baud: '+ComboBoxBaud.text;
    SetPortAndBaudCaptions;
    //do we need to disable the terminal until the telnet connects????
    //if ( ApdPort1.DeviceLayer=dlWinsock ) then begin
    if Port1.DeviceLayer=dlWinsock //grey if not a real port
      then begin
        SerialControlsColor:=clInactiveBorder;
        SerialTextColor:=clGrayText;
        WinsockTextColor:=clWindowText;
        end
      else begin
        SerialControlsColor:=clWindow;
        SerialTextColor:=clWindowText;
        WinsockTextColor:=clGrayText;
      end;
    //end;
    ComboBoxBaud.color:=SerialControlsColor;
    PanelBaud1.font.color:=SerialTextColor;
    ParityGroup.font.color:=SerialTextColor;
    DataBitsGroup.font.color:=SerialTextColor;
    StopBitsGroup.font.color:=SerialTextColor;
    HardwareFlowGroup.font.color:=SerialTextColor;
    RadioGroupWsTelnet.font.color:=WinsockTextColor;
    RadioGroupEchoWsTelnet.font.color:=WinsockTextColor;
    SoftwareFlowGroup.font.Color:=SerialTextColor;

    if Port1.Open then begin
      AdTerminal1.enabled:=true;
      ApdSLController1.monitoring:=true;
    end;
    Port1Changed:=false;
end; //SetPortClick

procedure TForm1.BitBtnSetPortClick(Sender: TObject);
begin
  if SpeedButtonSpy1.Down
    then SpeedButtonPort1OpenClick(nil) //this will change the Spy port
    else SetComPortClick(nil);             //this changes the comport
  {if CheckBoxClearTerminalOnPortChange.Checked
    then begin
      ButtonClearClick(nil);
    end;}
end;
{function PortSettingsString:string;
begin
  if Form1.Port1.open
    then begin

    end
    else begin

    end;
end;  }
procedure TForm1.CheckBoxInvertDataClick(Sender: TObject);
begin
  HexEmulator.InvertData:=CheckBoxInvertData.Checked;
end;
procedure TForm1.CheckBoxMaskMSBClick(Sender: TObject);
begin
  HexEmulator.MaskMSB:=CheckBoxMaskMSB.Checked;
end;

procedure TForm1.ButtonSetRTSClick(Sender: TObject);
begin
  Port1.RTS:=true;
end;

procedure TForm1.ButtonClrRTSClick(Sender: TObject);
begin
  Port1.RTS:=false;
end;

procedure TForm1.ButtonSetDTRClick(Sender: TObject);
begin
  Port1.DTR:=true;
end;

procedure TForm1.ButtonClearDTRClick(Sender: TObject);
begin
  Port1.DTR:=false;
end;

procedure TForm1.Button500msBreakClick(Sender: TObject);
begin
  Port1.SendBreak(10,true);
end;

procedure TForm1.ButtonBLE1SetBaudClick(Sender: TObject);
begin
  if (ComboBoxBLE1Baud.ItemIndex<0) then ComboBoxBLE1Baud.ItemIndex:=0;
  SendAsciiString('AT+BAUD'+inttostr(ComboBoxBLE1Baud.ItemIndex),false,false,false);
end;

function SendStringQueue(Add:boolean; NewString:string=''):boolean;
  const GAPTIME=500;
  //const    SCount:cardinal=0;
  const  SL:TStrings=nil;
begin
  result:=true;
  if Add then begin //adding strings
    if (SL=nil) then begin
      SL:=tStringList.Create;
    end;
    if not Form1.TimerSendStringQueue.Enabled then begin //we are not waiting for any previous string
      Form1.TimerSendStringQueue.Interval:=GAPTIME; //Strt Timer.
      Form1.TimerSendStringQueue.Enabled:=true;
      Add:=false; //make 1st string be sent immediately....
    end;
    SL.Add(NewString); //add to end
  end;
  if not Add then begin //Timer tick so send string
    if (SL.Count=0) then begin //strings all sent, and last string time has elapsed, so stop timer
        Form1.TimerSendStringQueue.Enabled:=false;//stop timer
    end else begin
      Form1.TerminalNewLine;
      Form1.SendAsciiString(SL[0],false,false,false); //send from start
      SL.Delete(0); //and remove it
      //and implicitly leave timer running so a new string sould be added even after last string is gone, but before timer is done
    end;
  end;
end;
procedure TForm1.TimerSendStringQueueTimer(Sender: TObject);
begin
  SendStringQueue(false);
end;




procedure TForm1.ButtonBLE1QuerySettingsClick(Sender: TObject);
begin
  ButtonClearClick(nil);
  CheckBoxHalfDuplex.Checked:=true;
  SendStringQueue(true,'AT+NAME?');
  SendStringQueue(true,'AT+VERS?');
  SendStringQueue(true,'AT+BAUD?');
  SendStringQueue(true,'AT+PARI?');
  SendStringQueue(true,'AT+BIT7?');
  SendStringQueue(true,'AT+STOP?');
  SendStringQueue(true,'AT+FLOW?');
  SendStringQueue(true,'AT+SHOW?');
  SendStringQueue(true,'AT+MODE?');
  SendStringQueue(true,'AT+POWE?');
  SendStringQueue(true,'AT+PASS?');
  SendStringQueue(true,'AT+TYPE?');
  SendStringQueue(true,'AT+PWRM?'); //sleep mode
  SendStringQueue(true,'AT+ROLE?');
  SendStringQueue(true,'AT+IMME?');
end;
procedure TForm1.ButtonBLE1ClearClick(Sender: TObject);
begin
  CheckBoxHalfDuplex.Checked:=true;
  SendStringQueue(true,'AT');       //break connection
  SendStringQueue(true,'AT+CLEAR'); //clear MAC so it doesn't re-establish
  SendStringQueue(true,'AT+DISC?');
end;

procedure TForm1.ComboBoxHexCSVFormatCharsCloseUp(Sender: TObject);
begin
  Tcombobox(Sender).Width:=ComboBoxHexCSVFormat.Width div 2;
  //Self.ActiveControl := ComboBoxHexCSVFormat; //nil;
  ComboBoxHexCSVFormat.SelLength:=0;
  ComboBoxHexCSVFormat.SelStart:=length(ComboBoxHexCSVFormat.Text);
  //ComboBoxHexCSVFormatChars.LeftJustify;
  ComboBoxHexCSVFormatChars.SelLength:=0;
  ComboBoxHexCSVFormatChars.SelStart:=1;
end;

procedure TForm1.ComboBoxHexCSVFormatCharsDropDown(Sender: TObject);
begin
  ComboBoxHexCSVFormatChars.Width:=ComboBoxHexCSVFormat.Width;
end;

procedure TForm1.ComboBoxHexCSVFormatCharsSelect(Sender: TObject);
begin
  ComboBoxHexCSVFormat.Text:=ComboBoxHexCSVFormat.Text+ ComboBoxHexCSVFormatChars.Text[1];
end;

procedure TForm1.ComboBoxPhoneStdCommandsDblClick(Sender: TObject);
begin
  ComboBoxPhoneStdCommandsSelect(Sender);
  if Sender<>nil then
    TCombobox(Sender).PutStringAtTop(100);
end;

procedure TForm1.ComboBoxPhoneStdCommandsSelect(Sender: TObject);
var CB:Tcombobox; S:string; A: TArray<String>;
begin
  CheckBoxHalfDuplex.Checked:=true;
  if assigned(Sender) and (Sender is TComboBox) then begin
    S:=TCombobox(Sender).Text;
  end;
  if assigned(Sender) and (Sender is TButton) then begin
    S:=TButton(Sender).Caption;
  end;

  StatusBarHint:=S; //put whole on hint

  A := S.Split([' ']);
  S:=A[length(A)-1];
  if CheckBoxPhoneAddEqualsQ.Checked then
    S:=S+'=?';
  SendStringQueue(true,S+CR);
  if assigned(Sender) and (Sender is TComboBox) then begin
    TCombobox(Sender).Text:=S;
  end;
end;

procedure TForm1.ComboBoxBLE1ConnectCommandsDblClick(Sender: TObject);
begin
  CheckBoxHalfDuplex.Checked:=true;
  SendStringQueue(true,ComboBoxBLE1ConnectCommands.Text);
end;

procedure TForm1.ComboBoxBLE1StdCommandsDblClick(Sender: TObject);
begin
  CheckBoxHalfDuplex.Checked:=true;
  SendStringQueue(true,ComboBoxBLE1StdCommands.Text);
  ComboBoxBLE1StdCommands.PutStringAtTop(100);
end;
procedure TForm1.ComboBoxBLE1StdCommandsSelect(Sender: TObject);
begin
  CheckBoxHalfDuplex.Checked:=true;
  SendStringQueue(true,ComboBoxBLE1StdCommands.Text);
//  ComboBoxPutStringAtTop(ComboBoxBLE1StdCommands,100); //making edit line blank whe used in OnSelect ??
end;

procedure TForm1.ButtonBLE1RSSIClick(Sender: TObject);
begin
  //ButtonClearClick(nil);
  CheckBoxHalfDuplex.Checked:=true;
  SendStringQueue(true,'AT+RSSI?');
  SendStringQueue(true,'AT+BATT?');
end;

function SendAsAsciiOrLiteral(Literal:boolean):TSendAs; overload;
// used to support comboboxes with a literal checkbox
begin
  if Literal
    then result:=sasLiteral
    else result:=sasAscii;
end;

function SendAsAsciiOrLiteral(Literal:TCheckbox):TSendAs; overload;
begin
  result:=SendAsAsciiOrLiteral(Literal.Checked);
end;

function ConvertString(S:ansistring; SendAs:TSendAs; CRCType:integer=0; AppendCR:boolean=false; AppendLF:boolean=false; StripSpaces:boolean=false):ansistring;
  var OK:boolean;
begin
  OK:=true; //used for numeric/hex conversions
  //first expand/convert string to chars including spaces
  case SendAs of
    sasLiteral: ;
    sasASCII: S:=ExpandEscapeString(S);
    sasNumbers: OK:=NumericStringToChars(S);
    sasHex: OK:=HexString2Chars(S);
  end;
  //then remove spaces
  if StripSpaces then begin
    S:=filterl(S,' '); // remove spaces
  end;
  //then add CRC
  S:=CRCAdd(S,CRCType);
  //then add EOL chars
  if AppendCR then S:=S+char(13);
  if AppendLF then S:=S+char(10);
  if OK
    then result:=S
    else result:='';
end;
function ComboBoxConvertString(CB:TComboBox; SendAs:TSendAs):ansistring; overload;
//does conversion & push combobox, but no AppendCRLF, strips spaces, addcandstrings etc. Used by other comboboxes of the send tab
begin
  result:=ConvertString(CB.Text, SendAs);
  if result<>''
      then CB.PutStringAtTop(100); // insert into history list, only if conversion worked
end;


function ComboBoxConvertString(CB:TComboBox; SendAs:TSendAs; AppendCR, AppendLF:TCheckbox; LiteralFromCheckbox:boolean=true):ansistring; overload;
var {OK:boolean;} S, Original:ansistring;
begin
  Original:=CB.Text;
  S:=Original;
  if LiteralFromCheckbox and Form1.CheckBoxLiteralStrings.Checked and (SendAs=sasAscii)
    then SendAs:=sasLiteral;

  S:=ConvertString(S, SendAs, CRCTypeFromUI, AppendCR.Checked, AppendLF.Checked, Form1.CheckboxStripSpaces.checked);
    if S<>'' then begin
    // insert (text form) into history list, only if conversion worked
    CB.PutStringAtTop(100);
    Form1.AddCannedString(Original,S);
  end;
  result:=S;
end;
//function ComboBoxConvertString(CB:TComboBox; AsNumber, LiteralAscii: boolean; AsHex:boolean=false):ansistring;
//var //index:integer;
//    S,Original:ansistring;
//    OK:boolean;
//begin
//  Original:=CB.text;
//  S:=Original;
//  OK:=true;
//
//  if AsNumber then OK:=NumericStringToChars(S);
//  if AsHex    then OK:=HexString2Chars(S);
//
//
//  if OK then begin
//    // insert (text form) into history list
//    ComboBoxPutStringAtTop(CB,100);
//    Form1.AddCannedString(Original,S);
//  end;
//  if not LiteralAscii then begin //should never happen with AsXXX
//    S:=ExpandEscapeString(S);
//  end;
//  result:=S;
//end; //CheckBoxString

const DELAY_CHUNK=200;
procedure TForm1.SendStringN(S:ansistring; N:integer=1;NLBefore:boolean=false;NLAfter:boolean=false);
// The core of sendstringXX with repeats, newlines etc
var i,Delay:integer; {CRCStr:ansistring;} //N:integer; NLBefore,NLAfter:boolean
    //OriginalNumTimesToSend:integer;
begin
  //OriginalNumTimesToSend:=SpinEditNumTimesToSend.Value;
//        SpinEditFileSendDelay.ShowHint:=false;
//        SpinEditFileSendDelay.Update;
//        SpinEditFileSendDelay.ShowHint:=true;
  if SpeedButtonCancelSend.Visible then exit; //interlock to stop reentrancy...
  GroupBoxSendString.Color:=clRed;
  for i:=1 to N do
    begin
      try //port1.processcommunications can also crash
      if NLBefore then TerminalNewLine;
//      while (Port1.OutBuffFree<length(S)) do //room to fit this string in the buffer
//        begin
//          sleep(0); //yield remainder of thread...
//          Port1.ProcessCommunications;
//        end;
      SpeedButtonCancelSend.Visible:=true;
      while (Port1.OutBuffUsed>0) and not SpeedButtonCancelSend.Down do //wait until buffer is free...
        begin
          sleep(0); //yield remainder of thread...
          Application.ProcessMessages;
//          if Port1.Dispatcher=nil  //doesn't seem to work
//            then break;
          Port1.ProcessCommunications;
        end;
      if i>1 then begin
        StatusBarHint:='Repeat #'+inttostr(i)+' of '+inttostr(N);
        if SpinEditFileSendDelay.Value>1 then
            StatusBarHint:=StatusBarHint+'  delay '+inttostr(SpinEditFileSendDelay.Value)+' ms';
        //SpinEditNumTimesToSend.Value:=N-i+1;
        Delay:=SpinEditFileSendDelay.Value;
        while not SpeedButtonCancelSend.Down do begin
          Port1.ProcessCommunications;
          Form1.update;
          Application.ProcessMessages;
          if Delay>DELAY_CHUNK
            then begin
              Delay:=Delay-DELAY_CHUNK;
              sleep(DELAY_CHUNK);
            end else begin
              sleep(Delay);
              break;
            end;//if
        end; //while
      end; //if
      if SpeedButtonCancelSend.Down
            then break;

      if CheckBoxHalfDuplex.checked then AdTerminal1.WriteString(S);
      //have to write to buffer or else the newline and chars will be in wrong order
//      AdTerminal1.Emulator.Buffer.ForeColor:=clLime;
//      if CheckBoxHalfDuplex.checked then AdTerminal1.Emulator.Buffer.WriteString(S);
      if NLAfter then TerminalNewLine;
//      try
        Port1.PutString(S);
      except
        on E:exception do begin

//          PortErrorMessage('Error in SendString, '+CR+CR
//           +ApdStatusERROR.hint+CR+CR +E.Message);
          Break;
        end;
      end; //except
      if not Port1.Open then break;

    end;  //for
    //SpinEditNumTimesToSend.Value:=OriginalNumTimesToSend;
    //ensure that button stays down when clicked multiple times
    SpeedButtonCancelSend.AllowAllUp:=true;
    SpeedButtonCancelSend.Down:=false;
    SpeedButtonCancelSend.AllowAllUp:=false;
    SpeedButtonCancelSend.Visible:=false;
    GroupBoxSendString.Color:=clBtnFace;
end;
procedure TForm1.SpeedButtonCancelSendDblClick(Sender: TObject);
begin
  SpeedButtonCancelSend.AllowAllUp:=true;
//  if not SpeedButtonCancelSend.Down then begin
//    SpeedButtonCancelSend.AllowAllUp:=true;
    SpeedButtonCancelSend.Down:=false;
    SpeedButtonCancelSend.AllowAllUp:=false;
    SpeedButtonCancelSend.Visible:=false;
    GroupBoxSendString.Color:=clBtnFace;
//  end;
end;

procedure TForm1.SendString(S:ansistring; SendAs:TSendAs=sasLiteral; CRCType:integer=0; AppendCR:boolean=false; AppendLF:boolean=false; StripSpaces:boolean=false);
begin
  S:=ConvertString(S,SendAs, CRCType, AppendCR, AppendLF, StripSpaces);
  SendStringN(S);
end;
//procedure TForm1.SendString(S:string; SendAs:TSendAs=sasLiteral; CRCType:integer=0; AppendCR:boolean=false; AppendLF:boolean=false; StripSpaces:boolean=false);
//begin
//  SendString(AnsiString(S),SendAs,CRCType, AppendCR, AppendLF, StripSpaces);
//end;
procedure TForm1.SendStringSlow(S:ansistring; milliseconds:cardinal); //send short strings with a delay between characters.
  var i:integer;
begin
  for I := 1 to length(S) do begin
    Form1.Port1PutChar(S[i]);
    sleep(milliseconds);
  end;
end;

procedure TForm1.SendTabSendString1(SendAs:TSendAs);
begin
  SendTabSendString(comboboxconvertstring(ComboBoxSend1,SendAs,CheckBoxCR1,CheckBoxLF1, False) );
end;

procedure TForm1.SendTabSendString(S:ansistring);
begin
  SendStringN(S,SpinEditNumTimesToSend.value, CheckboxNLBefore.Checked, CheckboxNLAfter.Checked);
end;

procedure TForm1.SendASCIIString(S:ansistring;AppendCR,AppendLF,StripSpaces:boolean);
begin
  SendString(S,sasLiteral, 0, AppendCR, AppendLF, StripSpaces);
end; //send asciistring


procedure TForm1.ButtonSendNumbers1Click(Sender: TObject);
begin
  SendTabSendString(ComboBoxConvertString(ComboBoxSend1,sasNumbers,CheckBoxCR1,CheckBoxLF1));
end;

procedure TForm1.ButtonSendNumbers2Click(Sender: TObject);
begin
  SendTabSendString(ComboBoxConvertString(ComboBoxSend2,sasNumbers,CheckBoxCR2,CheckBoxLF2));
end;
procedure TForm1.ButtonSendHex1Click(Sender: TObject);
begin
  //SendTabSendString(ComboBoxConvertString(ComboBoxSend1,false,true,true));
  SendTabSendString(comboboxconvertstring(ComboBoxSend1,sasHex,CheckBoxCR1,CheckBoxLF1) );
end;

procedure TForm1.ButtonSendHex2Click(Sender: TObject);
begin
  //SendTabSendString(ComboBoxConvertString(ComboBoxSend2,false,true,true));
  SendTabSendString(comboboxconvertstring(ComboBoxSend2,sasHex,CheckBoxCR2,CheckBoxLF2) );
end;

procedure TForm1.ButtonSendAscii1Click(Sender: TObject);
begin
  //Port1.PutString(comboboxstring(ComboBoxSend1));
  SendTabSendString(comboboxconvertstring(ComboBoxSend1,sasAscii,CheckBoxCR1,CheckBoxLF1) );
end;

procedure TForm1.ButtonSendAscii2Click(Sender: TObject);
begin
  //SendAsciiString(comboboxstring(ComboBoxSend2),CheckBoxCR2.Checked,CheckBoxLF2.Checked,CheckBoxStripSpaces.Checked);
  //SendTabSendAsciiString(comboboxconvertstring(ComboBoxSend2,false,CheckBoxLiteralStrings.Checked),CheckBoxCR2.Checked,CheckBoxLF2.Checked,CheckBoxStripSpaces.Checked);
  SendTabSendString(comboboxconvertstring(ComboBoxSend2,sasAscii,CheckBoxCR2,CheckBoxLF2) );
end;

procedure TForm1.CheckBoxHalfDuplexClick(Sender: TObject);
begin
  AdTerminal1.HalfDuplex:=CheckBoxHalfDuplex.checked;
end;

procedure TForm1.ButtonSetBreakClick(Sender: TObject);
begin
  Port1.SendBreak($FFFF,true);
end;

procedure TForm1.ButtonClearBreakClick(Sender: TObject);
begin
  Port1.SendBreak(0,true);
end;

const ManualSendFileTimeOut=65520;
const AutoQuitSendFileTimeout=200;

procedure SetTransmitTimeOut;
begin
//  if (SendFileAutoQuit or CaptureAutoQuit or PortAutoQuit) //if
  //  then ApdProtocol1.TransmitTimeout:=AutoQuitSendFileTimeOut
    //else ApdProtocol1.TransmitTimeout:=ManualSendFileTimeOut;
end;

//var SendFNameList:TStringList;
procedure TForm1.ButtonSendFileClick(Sender: TObject);
begin
  SelectTabsheet('Send');
  if IsSendingFile then begin
      //ApdProtocol1.InProgress:=not ApdProtocol1.InProgress;
      //put pause toggle here when work out how to do it....
      exit; //don't restart sending file
      end;
  SendFileList.SetFilenames(ComboBoxSendFName); //just incase some change has happened...
  if not SendFileList.AllExist then begin
    LabelProtocolError.Caption:='Missing: '+SendFileList.MissingFiles;
    console.writeln('Missing Send Files: '+SendFileList.MissingFiles);
    if SendFileAutoQuit or CaptureAutoQuit then begin //this will be a fatal error
      QuitNow:=true;
      exitcode:=integer(excFileError);
    end;
    exit;
  end;

  //ApdProtocol1.Filemask:=comboboxstring(ComboBoxSendFName);
  ComboBoxSendFName.PutStringAtTop(10);
  //ApdProtocol1.Filemask:=ComboBoxSendFName.text; //V2 uses this
  //ApdProtocol1.Filename:=ComboBoxSendFName.text;  //try to fix v3 problems
  //if SendFNameList=nil then SendFNameList:=TStringList.Create;
  //SendFNameList.Clear;
  //SendFNameList.Delimiter:=';';
  //SendFNameList.DelimitedText:=ComboBoxSendFName.Text; //(self.text);
  //ApdProtocol1.Filename:=SendFNameList[0];  //first string
  //SendFileList.position:=0;
  //ApdProtocol1.Filename:=SendFileList.Next;  //first string
  //ApdProtocol1.Filename:=SendFileList[0];  //first string

  SetTransmitTimeOut;
  ProgressBarSendFile.Min:=0;
  IsSendingFile:=false;
//  try
////    ApdProtocol1.AsciiBlockLen:=2048;
//    ApdProtocol1.StartTransmit;
//    ProgressBarSendFile.Max:=ApdProtocol1.FileLength;
//    GroupBoxSendFile.color:=clRed;
//    //LabelRepeats.Caption:='# 1';
//    SendFileRepeatCounter:=1;
//    IsSendingFile:=true;
//    //labelprotocolerror.Caption:='Sending';
//    MenuItemSendFile.Caption:='Sending File....';
//    ShowSerialStatus(true);
//  except
//
//  end;
  SendFileStartSend(true);
  //SendFileList.position:=0;
  //SendFileRepeatCounter:=1;
end;

procedure TForm1.SendFileStartSend(Reset:boolean=false);
var fname, SendInfoStr:string;
begin
  if Reset then begin
    SendFileList.position:=0;
    SendFileRepeatCounter:=1;
  end;
  if SendFileList.IsDone then begin
    SendFileList.position:=0; //repeat file list
    inc(SendFileRepeatCounter);
  end;
  fname:=SendFileList.Next; //filename
  ApdProtocol1.Filename:=fname; //filename
  try
    // ApdProtocol1.AsciiBlockLen:=2048;
    ApdProtocol1.StartTransmit;
    ProgressBarSendFile.Max:=ApdProtocol1.FileLength;
    GroupBoxSendFile.color:=clRed;
    //LabelRepeats.Caption:='# 1';
    //SendFileRepeatCounter:=1;
    IsSendingFile:=true;

    //make string. When there are multiple files or multiple repeats, add more info
    SendInfoStr:=' ';
    if SpinEditFileSendRepeats.value>1 then SendInfoStr:=SendInfoStr+'#'+inttostr(SendFileRepeatCounter)+' ';
    if SendFileList.count>1 then SendInfoStr:=SendInfoStr+extractfilename(fname);

    //SendInfoStr:='('+inttostr(SendFileRepeatCounter)+') '+extractfilename(fname);
    MenuItemSendFile.Caption:='Send '+SendInfoStr;
    //ShowSerialStatus(true,SendInfoStr);
  except

  end;
  if ApdProtocol1.InProgress
    then ShowSerialStatus(true,SendInfoStr) //LabelProtocolError.Caption:=SendInfoStr//InProgress'
    else LabelProtocolError.Caption:='Error: Not InProgress when expected';
  TimerSendFile.Enabled:=false; //timer is a 1 shot delay
end;

procedure TForm1.TimerSendFileTimer(Sender: TObject);
begin
  SendFileStartSend;
//      ApdProtocol1.StartTransmit;
//      if ApdProtocol1.InProgress
//        then LabelProtocolError.Caption:='Sending #'+inttostr(SendFileRepeatCounter)//InProgress'
//        else LabelProtocolError.Caption:='Error: Not InProgress when expected';
//      TimerSendFile.Enabled:=false; //timer is a 1 shot delay
end;


procedure TForm1.ApdProtocol1ProtocolFinish(CP: TObject;
  ErrorCode: Integer);
begin
  if (SendFileRepeatCounter=0)  //do once
      or ( SendFileList.IsDone and
          (SendFileRepeatCounter>=cardinal(SpinEditFileSendRepeats.value))
           and (SpinEditFileSendRepeats.value<>0)
         )
    then begin //end of transmit
      case ErrorCode of
        0: begin
            LabelProtocolError.Caption:='Done';
            ProgressBarSendFile.Position:=ApdProtocol1.BytesTransferred; //needed now that serialstatus is updating instead of protocolstatus
        end;
        -6005:LabelProtocolError.Caption:='Stopped'; //not an error
        else begin  //actual erros
          case ErrorCode of
            -6006:begin
                LabelProtocolError.Caption:='Transmit Timeout (Handshaking problem?)';
                //SetLastError(DWORD(excSendFileTimeout));
                ExitCode:=integer(excSendFileTimeout);
                end
            else LabelProtocolError.Caption:='Error: '+ErrorMsg(ErrorCode)+' ('+inttostr(ErrorCode)+')';
          end; //case
          LastErrorMessage:=LabelProtocolError.Caption+CRLF+'while Sending File';
        end; //else
      end; //case
      MenuItemSendFile.Caption:='Send File';
      GroupBoxSendFile.color:=clBtnFace;
      LabelRepeats.Caption:='&Repeats';
      if SendFileAutoquit then begin
        if CaptureMode<>cmoff then begin //we are capturing
          //sleep(500); //snooze for a bit for capture to complete
          //StopCapture;
          if ( CaptureTime=0) //capsecs option was not used to set time
            then begin  //capsecs was not used to set captime, so setup time and idle
              CaptureTime:=3;
              if (CaptureIdleAutoQuitCount=0) //has not been explicitly set on commandline etc
                then CaptureIdleAutoQuitCount:=2;
            end; //if captime
          CaptureStopTime:=now+(CaptureTime/(3600*24));
          CaptureAutoQuit:=true; //And quit when capture is done
          SelectTabSheet('Capture'); //and show the capture tab now....
          if (CaptureIdleAutoQuitCount=0) //has not been explicitly set on commandline etc
                then StatusBarHint:='Send Done. Waiting until Capture Timeout to Quit'
                else StatusBarHint:='Send Done. Waiting until Idle or Timeout to Quit';
        end else Form1.Close;  // if not capturing, close here (fast) if capturing, close in timer routine
      end; //if autoquit
      IsSendingFile:=false;
    end
    else begin  //there is another repeat to do
      //SendFileRepeatCounter:=SendFileRepeatCounter+1;
      if SpinEditFileSendDelay.Value<50
        then begin  //short delays just use sleep
          sleep(SpinEditFileSendDelay.Value);
          TimerSendFileTimer(nil); //starts
          end
        else begin  //longer delays use the timer
          TimerSendFile.Interval:=SpinEditFileSendDelay.Value;
          TimerSendFile.Enabled:=true;
          LabelProtocolError.Caption:='Pause '+inttostr(SpinEditFileSendDelay.Value)+'ms #'+inttostr(SendFileRepeatCounter);
        end; //if
    end;
end;
//-----------------------------------
procedure TForm1.BitBtnAbortSendFileClick(Sender: TObject);
begin
  //SendFileCounter:=SpinEditFileSendRepeats.value; //make this last....
  TimerSendFile.Enabled:=false;
  SendFileRepeatCounter:=0; //forces a stop....
  if ApdProtocol1.InProgress
    then ApdProtocol1.CancelProtocol //which will call finish
    else ApdProtocol1.OnProtocolFinish(nil,-6005); //must call explicitly to clean up display
  SendFileAutoQuit:=false; //don't close when manual cancel

end;

procedure TForm1.SpinEditLPTChange(Sender: TObject);
begin
  //PICProg.LPTNumber:=SpinEditLPT.value;
end;

procedure TForm1.SpinEditNumTimesToSendDblClick(Sender: TObject);
const SavedValue:integer=1;
const Toggle:boolean=false;
begin
  Toggle:=not Toggle;
  if Toggle then begin
    SavedValue:=SpinEditNumTimesToSend.Value;
    SpinEditNumTimesToSend.SetValue(1);
  end else begin
    SpinEditNumTimesToSend.SetValue(SavedValue);
  end;

end;

procedure TForm1.SpinEditPortAutoCloseChange(Sender: TObject);
begin
  SpinEditPortAutoClose.Increment:=Timer1.Interval;
  SpinEditPortAutoClose.Value := SpinEditPortAutoClose.Value div SpinEditPortAutoClose.Increment * SpinEditPortAutoClose.Increment;
end;

procedure TForm1.SpinEditRxdIdleChange(Sender: TObject);
  var Ticks:longint;
begin
  Ticks:= SpinEditRxdIdle.value div 55;
  SpinEditRxdIdle.SetValue(Ticks * 55);
  RxIdle(Ticks); //set value
end;

procedure TForm1.SpinEditRxdIdleExit(Sender: TObject);
begin
  SpinEditRxdIdle.Visible:=false;
end;

procedure TForm1.BitBtnChangeBinarySyncClick(Sender: TObject);
  var SyncString: string;
begin
  case RadioGroupSyncIs.ItemIndex of
    0: SyncString:='';
    1: SyncString:=ComboBoxSyncString.GetStringPutAtTop;
    2: SyncString:=ComboBoxConvertString(ComboBoxSyncString, sasNumbers );//ComboBoxConvertString(ComboBoxSyncString,true,true);
    else begin
        MessageDlg('Unknown SyncType', mtInformation, [mbOK], 0);
        RadioGroupSyncIs.ItemIndex:=0;
        SyncString:='';
    end;//else
  end; //case
  HexEmulator.SetSync(SyncString,
//  ComboBoxConvertString(ComboBoxSyncXOR,true,true),
//  ComboBoxConvertString(ComboBoxSyncAND,true,true),
  ComboBoxConvertString(ComboBoxSyncXOR,sasNumbers),
  ComboBoxConvertString(ComboBoxSyncAND,sasNumbers),

  CheckBoxLeadingSync.Checked,
  SpinEditSyncShowLength.Value,
  CheckboxHighlightSync.Checked);
  HexEmulator.SyncCount:=0;
end;
procedure TForm1.BitBtnChangeScaleClick(Sender: TObject);
begin
  FormScale(SpinEditScale.Value);

//  if SpinEditScalePPI.Value=0
//  then Scaled:=false
//  else begin
//    Scaled:=true;
//    PixelsPerInch:=SpinEditScalePPI.Value;
//  end;

  //Form1.ScaleBy(SpinEditScale.Value , 100);
end;

(*
procedure TForm1.BitBtnChangeBinarySyncClick(Sender: TObject);
begin
  case RadioGroupSyncIs.ItemIndex of
    0: HexEmulator.SyncString:='';
    1: HexEmulator.SyncString:=comboboxstring(ComboBoxSyncString);
    2: HexEmulator.SyncString:=ComboBoxConvertString(ComboBoxSyncString,true,true);
    else begin
        MessageDlg('Unknown SyncType', mtInformation, [mbOK], 0);
        RadioGroupSyncIs.ItemIndex:=0;
    end;//else
  end; //case
  HexEmulator.SyncAND:= ComboBoxConvertString(ComboBoxSyncAND,true,true);
  if length(HexEmulator.SyncAND)<>length(HexEmulator.SyncString)
    then begin
      HexEmulator.SyncAND:=CharStrS(#255,length(HexEmulator.SyncString));
    end;
  HexEmulator.SyncXOR:= ComboBoxConvertString(ComboBoxSyncXOR,true,true);
  if length(HexEmulator.SyncXOR)<>length(HexEmulator.SyncAnd)
    then begin
      HexEmulator.SyncXOR:=CharStrS(#0,length(HexEmulator.SyncAND));
    end;

end;
*)

procedure TForm1.ButtonSaveFNameClick(Sender: TObject);
begin
  ComboBoxSaveFName.FileChoose(SaveDialog1);
  ComboBoxSaveFName.SetFilenameCheckPathExists;
//  SaveDialog1.FileName:=ComboBoxSaveFName.text;
//  if SaveDialog1.Execute then                              { Display Save dialog box}
//    begin
//      ComboBoxSaveFName.text:=SaveDialog1.FileName;
//      ComboboxRightJustify(ComboBoxSaveFName);
//    end;
end;
procedure TForm1.ButtonTraceFNameClick(Sender: TObject);
begin
  if ComboBoxTraceFName.FileChoose(SaveDialog1)
     then ButtonChangeTraceFNameClick(nil);
//  SaveDialog1.FileName:=ComboBoxTraceFName.text;
//  if SaveDialog1.Execute then                              { Display Save dialog box}
//    begin
//      ComboBoxTraceFName.text:=SaveDialog1.FileName; //will have extension coerced later
//      ComboBoxRightJustify(ComboBoxTraceFName);
//      ButtonChangeTraceFNameClick(nil);
//    end;
end;
procedure TForm1.ButtonSendFNameClick(Sender: TObject);
begin
  ComboBoxSendFName.FileChoose(OpenDialog1);
  ComboBoxSendFNameExit(ComboBoxSendFName);
//  OpenDialog1.Filename:= ComboBoxSendFName.text;
//  if IsDirectory(OpenDialog1.Filename) then begin
//    OpenDialog1.InitialDir:= OpenDialog1.Filename;
//    OpenDialog1.Filename:='';
//  end;
//
//  if OpenDialog1.Execute then                              { Display Open dialog box}
//    begin
//      ComboBoxSendFName.text:=OpenDialog1.FileName;
//      ComboBoxRightJustify(ComboBoxCapturePostFName);
//    end;
end;


//procedure TForm1.Button16Click(Sender: TObject);
//begin
//  PageControl1.SelectNextPage(false);
//end;
//
//procedure TForm1.Button17Click(Sender: TObject);
//begin
//  PageControl1.SelectNextPage(true);
//end;



procedure TForm1.SpeedButtonPowerClick(Sender: TObject);
begin
//  PicProg.Power:=SpeedButtonPower.down;
  //if SpeedButtonPower.down
  //  then SpeedButtonPower.font.color:=cllime
  //  else SpeedButtonPower.font.color:=clwindowtext
end;

procedure TForm1.ButtonResetBothClick(Sender: TObject);
begin
//  PicProg.Reset(0);
end;

procedure TForm1.ButtonReset1Click(Sender: TObject);
begin
//  PicProg.Reset(1);
end;

procedure TForm1.ButtonReset2Click(Sender: TObject);
begin
//  PicProg.Reset(2);
end;

procedure TForm1.PortTriggerAvail(CP: TObject; Count: Word);
var PortIn,PortOut:TApdWinsockPort;
    Block : array[0..1020] of ansiChar; //this must be << OutBufSize, eg 1/4 or less
    ThisCount:word;
begin
  if (Count>0) and (EchoPort.open)
    then begin
  if CP=Port1
    then begin
      PortIn:=Port1;
      PortOut:=EchoPort;
    end
    else begin
      PortIn:=EchoPort;
      PortOut:=Port1;
    end; //if
    //Now transfer the block of data...
    while (count>0) and ((PortOut.OutBuffFree>=Count) or (PortOut.OutBuffFree>=sizeof(block)) ) do begin
      if count> sizeof(block)
        then begin
            ThisCount:=sizeof(block);
            count:=count-sizeof(block);
            end
        else begin
            ThisCount:=count;
        end;
  //    try
        PortIn.GetBlock(Block, ThisCount);
        PortOut.PutBlock(Block, ThisCount); //checked for space above
//except
//  on E : EAPDException do
//    if (E is EBadHandle) then begin
//      ...fatal memory overwrite or programming error
//      halt;
//    end else if E is EBufferIsEmpty then begin
//      ...protocol error, 128 bytes expected
//      raise;

//    end;
//end;

    end; // while




  end; //if
end;

procedure TForm1.EchoPortWsAccept(Sender: TObject; Addr: TInAddr;
  var Accept: Boolean);
begin
  Accept:=true;
  ApdStatusLightEchoConnected.lit:=true;
  LabelEchoConnected.Caption:='Accepted';
  fEchoPortConnected:=true;
  SignalWsConnectedThroughRTSDTR(true,Port1);
end;
procedure TForm1.SetEchoMonitoring;
begin
  SetWSConnectLightOffColor(EchoPort,ApdStatusLightEchoConnected);
  ApdSLControllerEcho.monitoring:=EchoPort.open;
  fMonitorLastCharPort:=0; //clear so no newline on first line
  if EchoPort.Open
    then Port1.OnTrigger:=Port1TriggerEchoOut
    else Port1.OnTrigger:=nil;
end;
procedure TForm1.BitBtnSetEchoPortClick(Sender: TObject);
var
  E    : Integer;
  Temp : Byte;
  SerialControlsColor: TColor;
begin
  EchoPort.Parity   := TParity(EchoParityGroup.ItemIndex);
  EchoPort.Databits := 8 - EchoDataBitsGroup.ItemIndex;
  EchoPort.Stopbits := EchoStopBitsGroup.ItemIndex + 1;

  case HardwareFlowGroup.ItemIndex of
    0: EchoPort.HWFlowOptions := [];
    1: EchoPort.HWFlowOptions := [hwfUseDTR, hwfRequireDSR];
    2: EchoPort.HWFlowOptions := [hwfUseRTS, hwfRequireCTS];
  end;

  if EchoTransmitFlowBox.Checked and EchoReceiveFlowBox.Checked then
    EchoPort.SWFlowOptions := swfBoth
  else if EchoTransmitFlowBox.Checked then
    EchoPort.SWFlowOptions := swfTransmit
  else if EchoReceiveFlowBox.Checked then
    EchoPort.SWFlowOptions := swfReceive
  else EchoPort.SWFlowOptions := swfNone;

  Val(EchoXonCharEdit.Text, Temp, E);
  if (E = 0) then
    EchoPort.XonChar := ansiChar(Temp);
  Val(EchoXoffCharEdit.Text, Temp, E);
  if (E = 0) then
    EchoPort.XoffChar := ansiChar(Temp);
  EchoPort.baud:=strtoint(ComboBoxEchoBaud.text);
  ComboBoxEchoBaud.text:=inttostr(EchoPort.Baud);
  Set_Comport(EchoPort,ComboBoxEchoPort.GetStringPutAtTop);
//  ApdSLControllerEcho.monitoring:=EchoPort.open;
  SetEchoMonitoring;
  ComboBoxEchoPort.text:=Get_ComPortString(EchoPort);
  //do we need to disable the terminal until the telnet connects????
  //if ( ApdPort1.DeviceLayer=dlWinsock ) then begin
  if EchoPort.DeviceLayer=dlWinsock //grey if not a real port
    then SerialControlsColor:=clInactiveBorder
    else SerialControlsColor:=clWindow;
  //end;
  ComboBoxEchoBaud.color:=SerialControlsColor;
  //ParityGroup.color:=SerialControlsColor;
  EchoPortChanged:=false;
end;
//if echo goes on, check echo. If it goes off, uncheck echo and monitor, and close port
// if monitor goes on, open port. If it goes off, uncheck monitor, close port if both off
procedure TForm1.CheckBoxEchoOnClick(Sender: TObject); //enables echoing
begin
    try
      EchoPort.open:= (CheckBoxEchoOn.Checked or CheckBoxEchoPortMonitoring.checked);
 //     EchoPort.open:= (CheckBoxEchoOn.Checked);
    except
      on E: EAlreadyOpen do
        MessageDlg('Port is already open. You must change Port'+char(13)+E.Message, mtInformation, [mbOK], 0);
    end;
    if not EchoPort.open then begin
      CheckBoxEchoOn.Checked:=false;
      CheckBoxEchoPortMonitoring.checked:=false;
    end;
//    CheckBoxEchoOn.Checked := EchoPort.open;
    CheckBoxMonitorNewLineOnDirectionChange.Enabled:=CheckBoxEchoPortMonitoring.checked;

    SetEchoMonitoring;
//    if not CheckBoxEchoOn.Checked  //turning it ON
//      then begin
//        CheckBoxEchoPortMonitoring.checked := false;
//      end ;
    MenuItemEcho.Checked:=  EchoPort.open;
    if CheckBoxEchoPortMonitoring.checked and not CheckBoxEchoOn.Checked
      then MenuItemEcho.caption:= 'Echo to: '+ ComboBoxEchoPort.text
      else MenuItemEcho.caption:= 'Monitor: '+ ComboBoxEchoPort.text;
end;
procedure TForm1.CheckBoxEchoPortMonitoringClick(Sender: TObject);
begin
    try
      //EchoPort.open:=(Sender as TCheckBox).Checked;
      EchoPort.open:= (CheckBoxEchoOn.Checked or CheckBoxEchoPortMonitoring.checked);
    except
      on E: EAlreadyOpen do
        MessageDlg('Port is already open. You must change Port'+char(13)+E.Message, mtInformation, [mbOK], 0);
    end;
    CheckBoxEchoPortMonitoring.checked:= EchoPort.open and CheckBoxEchoPortMonitoring.checked;
    CheckBoxMonitorNewLineOnDirectionChange.Enabled:=CheckBoxEchoPortMonitoring.checked;
//    ApdSLControllerEcho.monitoring:=EchoPort.open;
    SetEchoMonitoring;
end;
procedure TForm1.CheckBoxEnableTimerEventsClick(Sender: TObject);
begin
  if ComServer.StartMode=smAutomation then
    RTI.Set_EnableTimerCallbacks(Form1.CheckBoxEnableTimerEvents.Checked);
end;

//D3 procedure TForm1.FontDialog1Apply(Sender: TObject; Wnd: Integer);
procedure TForm1.FontDialog1Apply(Sender: TObject; Wnd: HWND);
begin
       AdTerminal1.Active:=false;
       AdTerminal1.Enabled:=false;
       if Sender is TFont then AdTerminal1.Font:=TFont(Sender);
       if Sender Is TFontDialog then AdTerminal1.Font:=TFontDialog(Sender).Font;
       //AdTerminal1.Font:=FontDialog1.Font;
       AdTerminal1.Enabled:=true;
       AdTerminal1.Active:=true;
       SetFormSizeFromRowsCols(true,true);
end;
procedure TForm1.ButtonFontSizeClick(Sender: TObject);
begin
   AdTerminal1.Active:=false;
   AdTerminal1.Enabled:=false;
   AdTerminal1.Font.Size:=strtoint( TButton(Sender).Caption );
   AdTerminal1.Enabled:=true;
   AdTerminal1.Active:=true;
   SetFormSizeFromRowsCols(true,true);
end;
procedure TForm1.ButtonFontClick(Sender: TObject);
begin

   FontDialog1.Font:=AdTerminal1.Font;
   if FontDialog1.Execute
     then begin
       FontDialog1Apply(FontDialog1,0);
       //SetFormSizeFromRowsCols(true,true);
    end;
end;


procedure TForm1.CheckBoxBigEndianClick(Sender: TObject);
begin
  HexEmulator.BigEndian:=CheckBoxBigEndian.Checked;
end;

procedure TForm1.CheckBoxTraceClick(Sender: TObject);
begin
  if CheckBoxTrace.Checked
    then  Port1.Tracing :=tlOn
    else  Port1.Tracing :=tlOff;
end;

procedure TForm1.CheckBoxLazyPaintClick(Sender: TObject);
begin
  AdTerminal1.UseLazyDisplay:=CheckBoxLazyPaint.Checked;
end;

procedure TForm1.CheckBoxLogClick(Sender: TObject);
begin
  if CheckBoxLog.Checked
    then  Port1.Logging :=tlOn
    else  Port1.Logging :=tlOff;
end;


procedure TForm1.ComboBoxTraceFNameChange(Sender: TObject);
begin
  ButtonChangeTraceFName.Visible:=true;
end;






procedure TForm1.ButtonOpenLPTClick(Sender: TObject);
var NT:string;
    PortResultString:string;
begin
//  messagedlg('Not available yet in Delphi 7 version. Use V1.99.34 or earlier',mtWarning,[mbOK],0);
//  exit;
//  PICProg.LPTNumber:=SpinEditLPT.value;
//  PicProg.Open:=true;
  //PicProg.LPTNumber:=1;
  //PicProg.OpenDriver;
//  if PicProg.RunningWinNT
//    then NT:='NT'
//    else NT:='9x';
//  PortResultString:='Win'+NT+' '+inttohex(PicProg.LPTBasePort,8);
  //buttonOpenLPT.caption:=PortResultString;
  {PicProg.Port[$378+2]:=2;}
  //PicProg.SetOpen(true);
  // PicProg.Power:=true;
  //ButtonOpenLPT.height:=40;
//  if PicProg.ActiveHW and PicProg.Open and (PicProg.LPTBasePort<>0)
//    then begin
//      //ButtonOpenLPT.height:=40;
//      ButtonResetBoth.Enabled:=true;
//      ButtonReset1.Enabled:=true;
//      ButtonReset2.Enabled:=true;
//      SpeedButtonPower.Enabled:=true;
//      GroupBoxPP.color:=clAqua;
//      GroupBoxPP.Hint:=PortResultString;
//      end
//    else begin
//      //ButtonOpenLPT.height:=15;
//      GroupBoxPP.color:=clRed;
//      GroupBoxPP.Hint:='Failed to open LPT'+inttostr(PicProg.LPTNumber)+' '+PortResultString;
//    end;
end;

procedure TForm1.MenuItemShowClick(Sender: TObject);
begin
  MenuItemShow.checked:=not MenuItemShow.checked;
  if MenuItemShow.checked then begin
    Visible:=true;
    WindowState:=wsNormal;
    show;
    ShowWindow( Application.Handle, SW_RESTORE );
    MenuItemShow2.Visible:=false; //more obvious checkbox for restoring from TrayIcon, rather than hidden in menu
    PopupMenu1.AutoPopup:=true;
    end
  else begin
      Visible:=false;
      MenuItemShow2.Visible:=true;
      MenuItemShow2.Checked:=false;
  end;
end;
procedure TForm1.MenuItemStayOnTopClick(Sender: TObject);
begin
  if MenuItemStayOnTop.Checked
    then FormStyle:=fsStayOnTop
    else FormStyle:=fsNormal;
end;
procedure TForm1.MenuItemNewsClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open',
  'https://sourceforge.net/p/realterm/news',nil,nil, SW_SHOWNORMAL);
end;

//procedure TForm1.ClearStayOnTop(Sender: TObject);
//begin
//  MenuItemStayOnTop.Checked:=false;
//  FormStyle:=fsNormal;
//end;


procedure TForm1.MenuItemScaleClick(Sender: TObject);
var Caption:string;
    Percent:integer;
begin
  if (Sender<>nil)
    then Caption:=TMenuItem(Sender).Caption;
  Caption:=ReplaceText(Caption,'&','');
  Caption:=ReplaceText(Caption,'%','');
  Percent:=strtointdef(Caption,0); //default to auto
  FormScale(Percent); //autoscale
end;

procedure TForm1.MenuItemScrollDownClick(Sender: TObject);
//var OldRow:integer;
begin
    SendMessage(AdTerminal1.Handle, WM_VSCROLL, SB_LINEUP, 0);

//  OldRow:=AdTerminal1.Emulator.Buffer.Row;
//  AdTerminal1.Emulator.Buffer.Row:=1;
//  AdTerminal1.Emulator.Buffer.MoveCursorUp(true);
//  AdTerminal1.Emulator.Buffer.Row:=OldRow+1;
end;

procedure TForm1.MenuItemScrollUpClick(Sender: TObject);
//  var OldRow:integer;
begin
    SendMessage(AdTerminal1.Handle, WM_VSCROLL, SB_LINEDOWN, 0);
  //AdTerminal1.ScrollBy(0,10);
  //SendMessage(tv_files.Handle, WM_VSCROLL, SB_LINEUP, 0);
//  OldRow:=AdTerminal1.Emulator.Buffer.Row;
//  AdTerminal1.Emulator.Buffer.Row:=AdTerminal1.Emulator.Buffer.RowCount;
//  AdTerminal1.Emulator.Buffer.MoveCursorDown(true);
//  AdTerminal1.Emulator.Buffer.Row:=OldRow-1;
end;

procedure TForm1.MenuItemCloseClick(Sender: TObject);
begin
  form1.close;
end;

procedure TForm1.TrayIcon1Click(Sender: TObject);
begin
  popupmenu1.Popup(0,0);
end;


procedure TForm1.MenuItemBitTimingClick(Sender: TObject);
begin
  ICRCommand(2);
end;

procedure TForm1.MenuItemCaptureClick(Sender: TObject);
begin
  if IsCapturing//MenuItemCapture.Checked
    then begin
      CaptureAutoQuit:=false; //don't autoquit when stop button pressed
      StartCapture(cmOff);
      end
    else begin
      StartCapture(cmOn);
    end;
end;

procedure TForm1.MenuItemPortClick(Sender: TObject);
begin
  Form1.SelectTabSheet('Port');
  Form1.MenuItemShow.checked:=false;//will be inverted
  Form1.MenuItemShowClick(Sender);
end;

{
procedure UnhookAllSpies(Spy:TVicCommSpy); //used to remove all hooks
  var i:Integer;
begin
  for i:=1 to MaxComHandles do begin
    if Spy.IsHooked[i] then Spy.Unhook(i);
  end;
end;
}
procedure TForm1.SpyModeOpen(Open:boolean); //programatically enter start mode.
begin
  SpeedButtonSpy1.Down:=Open;
  SpeedButtonPort1OpenClick(nil);
end;

procedure SpyExplanationMessage;
begin
  //showmessage(                                        messagedlg('Confirmation',mtError, mbOKCancel, 0)
  messagedlg(
 'The port (ie the other application you are trying to spy on) must be closed before you start SPY.'+CR
 +' You must close the other application before you stop spying.'+CR
  +' Once you start SPY, Realterm is unable to quit, until the other application has closed.'+CR
 +CR
  +'  [Start Realterm]'+CR
  +'      [Press SPY]'+CR
  +'          [Start Other App]'+CR
  +'              [do stuff you want to spy on]'+CR
  +'          [Close Other App]'+CR
  +'      [Stop Spy]'+CR
  +'  [Close Realterm]'+CR
  +CR
  +'You can try opening the port before SPY to see if it is free before starting'+CR
  +' Demo version is limited in how long it operates'+CR
          ,mtInformation, [mbOK], 0);
end;
procedure TForm1.SpyOpen(State:boolean);
    begin
      if State=true
        then begin

        end
//        else begin
//                CommSpy1.UnhookAll;
//      if CommSpy1.IsNoneCommHooked
//        then CommSpy1.Opened:=false
//        else begin
//          ShowMessage('You must close the comport before you will be able to exit Realterm or reconnect the spy'
//             +CRLF+'(ie close the application you are spying on)');
//          sleep(0);
////          CommSpy1.Opened:=false;
//        end;
//        end;//if
    end;

const FirstComportNumber=1; //for windows not unix

function TForm1.SpyDriversInstalled:boolean; //detect an install of the driver, using the Realterm driver installer.
// Just using dirty directory detection, so I don't waste too much time on it.
begin
  result:=DirectoryExists('C:\Program Files\BEL\Realterm\SpyDrivers'); //xp32 default
  result:=result or DirectoryExists('C:\Program Files64\BEL\Realterm\SpyDrivers'); //I think this is for vista
  result:=result or DirectoryExists(JustPathNameL(Application.ExeName)+'\SpyDrivers'); //and try where the exe is
  //showmessage(JustPathNameL(Application.ExeName)+'\SpyDrivers');
end;
procedure TForm1.PortErrorMessage(Msg:string);
begin
  LastErrorMessage:=Msg;
  if (ComServer.StartMode<>smAutomation)
    then MessageDlg(Msg, mtError, [mbOK], 0) //show dialog if interactive
    else SetStatusBarHint(Msg,true); //StatusBarHint:=Msg; //if ActX or no error dialogs mode
//      if StatusBar1.SimplePanel
//        then StatusBar1.SimpleText := Msg
//        else StatusBar1.panels[0].Text:=Msg; //if ActX or no error dialogs mode
end;
procedure TForm1.PortOpenTry(Port:TApdWinsockPort;Open:boolean=true);
begin
    try
      Port.open:=Open;
      LastErrorMessage:='';
    except
      on E: EAlreadyOpen do begin
        PortErrorMessage('Port is already open. You must change Port'+char(13)+E.Message);
        Port.open:=false;
        end;
      on E: eBadId do begin
        PortErrorMessage('BadID, Probably PORT does not exist: '+ComboboxComPort.Text+ char(13)+
                         '(dbl-click in port dropdown to scan ports)'+#13+E.Message+#13+#13+
                         'Valid:'+#13+
                         'PortNumber eg "9" '+#13+
                         'Port name in Registry with backslash eg "\VCP0"'+#13+
                         'full windows createfile name eg "\\.\COM9"'+#13 +
                         'IP-Address:Port e.g "127.0.0.1:telnet" or "127.0.0.100:9856"' +#13+
                         'Telnet/Winsock server:port e.g "server:telnet" or "server:9856"' ) ;
        Port.open:=false;
        end;
      on E: eBaudRate do begin
        PortErrorMessage('BaudRate Error, Probably an impossible baudrate'+char(13)+E.Message);
        Port.open:=false;
        end;
      on E: EOpenComm do begin
        PortErrorMessage('Error Opening Comm, '+char(13)+E.Message);
        Port.open:=false;
        end;
    end; //try
end;//fn




procedure TForm1.Port1Open(OpenPort:boolean);
begin
  if not OpenPort
    then begin //button up
      Port1.open:=false;
      AdTerminal1.Enabled:=true; //so that scrollback still works when port is closed?
      PortWsErrorReopen:=false;  //so autoopen is halted
    end;
  if OpenPort
    then begin
      BitBtnSetPortClick(nil);
      if (Port1.DeviceLayer=dlWinsock) and (Port1.WsMode=wsClient)
        then Port1.Open:=false; //attempt to force a reconnect - ugly kludge
      PortOpenTry(Port1,true);
   end;
  if Port1.Open then begin
    AdTerminal1.enabled:=true;
    ApdSLController1.monitoring:=true;
    if Form1.CheckBoxClearTerminalOnPortOpen.Checked
        then begin
          Form1.ButtonClearClick(nil);
        end;
  end;

  Port1.AutoOpen := CheckboxPortAutoOpen.checked;

  SpeedButtonPort1Open.Down:=Port1.Open;
  //SetPortAndBaudCaptions;
end;
procedure TForm1.SpeedButtonPort1OpenClick(Sender: TObject);
  var ComNumber:integer;
begin
   if not NoNagAboutSpy and SpeedButtonSpy1.Down
     then begin
       ShowForm(SpyNagDlg,true); //SpyNagDlg.ShowModal;
       NoNagAboutSpy:=true;
     end;
//  if not SpeedButtonPort1Open.Down
//    then begin //button up
//      Port1.open:=false;
//      AdTerminal1.Enabled:=true; //so that scrollback still works when port is closed?
//    end;
  if not SpeedButtonSpy1.Down
    then begin  //un-spy
      SpeedButtonSpy1Click(nil);
      try
        SpyOpen(false);
      except
        showmessage('eee');
      end;
    end;
  //Perhaps should try to unload driver always here, even though it will stall

  Port1Open(SpeedButtonPort1Open.Down);

//  if SpeedButtonSpy1.Down
//    then begin  //spy
//      ComNumber:=GetPhysicalComNumber(ComboBoxComPort.text);
//      if  ComNumber>=FirstComportNumber
//        then begin //valid comport so try to hook
//          CommSpy1.opened:=true; //open it
//          if not CommSpy1.Opened then messagedlg('Failed to open Spy Driver. '+#13+#13
//             +CommSpy1.ErrorMessage+#13
//             +'Running as: '+IsUserAdminStr+#13+#13
//             +'Probably drivers are not installed'+#13
//             +'or not running as Administrator'+#13
//             +'or change to Windows security are preventing operation'
//             ,mtError, [mbOK], 0);
//          if not CommSpy1.IsHooked[ComNumber] then CommSpy1.hook(ComNumber);
//          if CommSpy1.IsHooked[ComNumber]
//             then begin  //success
//               SpeedButtonSpy1.Down:=true;
//               end
//             else begin //failure
//               SpeedButtonSpy1.Down:=false;
//               SpyExplanationMessage;
//             end;
//          end
//        else begin //not a comport so don't try to hook
//          SpeedButtonSpy1.Down:=false;
//          CommSpy1.UnhookAll;
//        end;
//    end;
  SetPortAndBaudCaptions;
//  if not (SpeedButtonPort1Open.Down or SpeedButtonSpy1.Down)
//    then AdTerminal1.
end;

procedure TForm1.Hide1Click(Sender: TObject);
begin
  Form1.visible:=false
end;

procedure TForm1.PositionFloatingButtons;
  const STATUS_FROM_EDGE=10; BUTTONS_FROM_EDGE=1;
  function ActiveRHSOnTab:integer;
    var T:TTabsheet; I:integer; C:TControl;
  begin
    result:=0;
    T:=PageControl1.ActivePage;
    for i:= 0 To T.ControlCount - 1 Do begin
      C:=T.Controls[i];
      if  not (C is TLabel) and not (C is TLinkLabel)
        and (C.visible)
      then begin
        result:= max(result, C.Left+C.Width);
      end;
    end;
  end;
  procedure SetLeft(X:integer;G:TWinControl=nil);
    var I:integer;
  begin
    if G=nil then G:=GroupBoxStatus;
    For i := 0 To G.ControlCount - 1 Do
      if G.Controls[i] is TApdStatusLight then
        G.Controls[i].Left := X;
  end;
  const STATUS_LIGHT_NORMAL_LEFT=10; STATUS_LIGHT_MIN_LEFT=3;
  procedure SqueezeStatusLights;
    var P:tpoint; G,L:TControl; //X1,Y1,X2,Y2:integer;
        //dX,NewX:integer;
    begin
      //C:=ApdStatusLightConnected;
      G:=GroupBoxStatus; L:=ApdStatusLightConnected;
      P:=Point(0,0);
      P.X:=ClientRect.Width;
      //edge of groupbox
      P:={Parent.}ClientToScreen(P); //on screen
      P:=G.ScreenToClient(P);      //edge of client on GB
      P.X:=P.X-L.Width;             //puts rhs at left of light
      if P.X>=2 then begin
          P.X:=min(P.X,STATUS_LIGHT_NORMAL_LEFT);
          SetLeft(P.X);
      end
      else begin
          P.X:=P.X-STATUS_LIGHT_MIN_LEFT;
          G.Left:=G.Left+P.X;
          SetLeft(STATUS_LIGHT_MIN_LEFT);
      end;
  end;
  var GBX,PBX:integer;
  const MISC_TAB_RHS=600; EVENTS_TAB_RHS=655;
begin
  GBX:=min(PageControl1.Width,ClientRect.Width + PageControl1.Margins.Right); //only as wide as page control
  PBX:=GBX-PanelFloatingButtons.Width-BUTTONS_FROM_EDGE;
  if TabSheetEvents.Visible
    then PBX:=max(PBX, EVENTS_TAB_RHS * fscale div 100)
    else PBX:=max(PBX, MISC_TAB_RHS * fscale div 100);
//  PanelFloatingButtons.Left:=PBX;//ageControl1.Width-PanelFloatingButtons.Width-BUTTONS_FROM_EDGE;
  PanelFloatingButtons.Top:=PageControl1.Top+1;
//  //GBX:=PageControl1.Width-GroupBoxStatus.Width-STATUS_FROM_EDGE;
  GBX:=GBX-GroupBoxStatus.Width-STATUS_FROM_EDGE; //get left edge of GB
  GBX:=max(GBX,ActiveRHSOnTab); //only let it cover inactive area
  GroupBoxStatus.Left:=GBX;
  GroupBoxStatus.Top:=PageControl1.Top+TabSheetDisplay.Top;
  SqueezeStatusLights;
end;
procedure TForm1.PageControl1Change(Sender: TObject);
begin
  PositionFloatingButtons;
end;
procedure TForm1.SetWinState(WinState:integer); //also sets new states eg full
begin
  if (WinState<>0) then begin //only normal window will be allowed to stay on top
          FormStyle:=fsNormal;
          MenuItemStayOnTop.checked:=false;
          //AdTerminal1.Columns:=SpinEditTerminalCols.Value; //reset if it has been
          ChangeRowsCols(0,SpinEditTerminalCols.Value);
  end;
  if (WinState<>4) then  //not miniterminal

  case WinState of  //borders on/off
    3: begin    //fullscreen
          SysMenuAddRemoveExtraItems(false); //remove extra items before removing border or menu gets destroyed
          BorderStyle:=bsNone;
          MenuItemFullScreen.Checked:=true;
        end;
    else begin
        if BorderStyle=bsNone then begin
          BorderStyle:=bsSizeable;
          SysMenuAddRemoveExtraItems(true); //restore system menu
          end
        else BorderStyle:=bsSizeable; //just in case it was someting else
        MenuItemFullScreen.Checked:=false;
    end;
  end;
  case Winstate of
    -1:;
    0,4: self.WindowState:=wsNormal;
    1: self.WindowState:=wsMinimized;
    2,3: self.WindowState:=wsMaximized;
  end;


end;
function TForm1.GetWinState:integer;
begin
    if Form1.BorderStyle=bsNone
      then result:=3
      else result:=ord(Form1.WindowState);
end;

procedure SetIAddress_PCA9544; begin SetI2CAddress($E0,'PCA9544'); end;
procedure SetIAddress_PCA9545; begin SetI2CAddress($E0,'PCA9545'); end;
procedure SetIAddress_MAX127;  begin SetI2CAddress($50,'MAX127'); end;
procedure SetIAddress_aSC7511; begin SetI2CAddress($98,'aSC7511'); end;
procedure SetIAddress_BL301; begin SetI2CAddress($60,'BL301'); end;

procedure TForm1.FormScale(Percent:integer); //set screen scale to % of design size
  function AutoScale:integer; //automatically set the scale to fill usable area
  var A:TRect;
  begin
    A:=Screen.WorkAreaRect;
    result:=floor(100*min((A.Width / FDesignWidth),(A.Height / FDesignHeight)));
  end;
begin
  //if Percent=0 then Percent:=100; //fscale wasn't init'd
  if Percent=0 then Percent:=AutoScale;
  SpinEditScale.SetValue(Percent); //and set with autoscale or values from menuitems
  //Percent:=140;
  if true {Scaled} then
  begin
    DisableAlign;
    //ScaleBy(FDesignWidth, FPrevWidth); //scale back to design size
    ScaleBy(100 *1000, fScale *1000);   //scale back to original
    ScaleBy(Percent *1000, 100 *1000);
    //Scaled:=false;
    SetFormSizeFromRowsCols(true,true);
    //Width:= FdesignWidth*Percent div 100;
    //Height:=FDesignHeight*Percent div 100;
    //PositionFloatingButtons;
    EnableAlign;
    fScale:=Percent;
    //FormResize(nil); //force buttons, status bar etc to be realigned
    MakeFullyVisible;
  end;
  FPrevWidth := Width;
  FPrevHeight :=Height;
end;


procedure TForm1.FrameI2CMem1ButtonI2CMemBrowseReadFilesClick(Sender: TObject);
begin
  FrameI2CMem1.ButtonI2CMemBrowseReadFilesClick(Sender);

end;



procedure TForm1.FrameI2CMem1ButtonI2CMemBrowseWriteFilesClick(Sender: TObject);
begin
  FrameI2CMem1.ButtonI2CMemBrowseWriteFilesClick(Sender);
end;

procedure TForm1.FormResize(Sender: TObject);
//var NumRows, CharHeight:integer;
const LastWindowState:TWindowState=wsNormal; //only holding Normal/Max
begin
//  if (WindowState<>wsNormal) then begin //only normal window will be allowed to stay on top
//          FormStyle:=fsNormal;
//          MenuItemStayOnTop.checked:=false;
//  end;
  //only when user drags for maximise/normal transitions
  if (FIsWMSizeMove) or (LastWindowState<>WindowState) then begin
      SetRowsColsFromFormSize(4, FResizeColumnsFromWidth);
      if (WindowState<>wsNormal) then begin //only normal window will be allowed to stay on top
          FormStyle:=fsNormal;
          MenuItemStayOnTop.checked:=false;
      end;
  end;
  if (WindowState=wsNormal) or (WindowState=wsMaximized)
    then LastWindowState:=WindowState;

  AdTerminal1.Height:=Form1.ClientHeight - PageControlAndBarsHeight;
  if PageControl1.Visible then begin
    PageControl1.Align:=alNone; //set to alBottom is designer so designer view all works ok...
    StatusBar1.Top:=ClientHeight-StatusBar1.Height;
    PageControl1.Top:=ClientHeight-StatusBar1.Height-PageControl1.Height;
    StatusBarFormattedData.Align:=alNone;
    StatusBarFormattedData.Top:=ClientHeight-StatusBar1.Height-PageControl1.Height-StatusBarFormattedData.Height;
    PositionFloatingButtons;
  end;
  SetStatusPanelWidth;
  //StatusBar1.Align:=alNone;
  //StatusBar1.Align:=alBottom;
  //PageControl1.Align:=alBottom;
end;
procedure TForm1.SetWSConnectLightOffColor(Port:TApdWinsockPort;A:TApdStatusLight);
begin
   if (Port.DeviceLayer=dlWinsock) and (Port.WsMode=wsServer)
   and (Port.Open)
     then A.NotLitColor:=clAqua
     else A.NotLitColor:=clBtnFace;
end;

procedure TForm1.EchoPortWsDisconnect(Sender: TObject);
const AlreadyTryingToClosePort:boolean=false;
begin
  if AlreadyTryingToClosePort then exit; //kludge as closing port calls this
  ApdStatusLightEchoConnected.lit:=false;

  LabelEchoConnected.Caption:='Disconnect';
  fEchoPortConnected:=false;
  SignalWsConnectedThroughRTSDTR(false,Port1);
  if (EchoPort.wsMode=wsClient) and (EchoPort.DeviceLayer=dlWinsock) and EchoPort.Open //not if a server
    then begin
      AlreadyTryingToClosePort:=true;
//      EchoPort.Open:=false; //force the port to close, since they don't reconnect anyway
      CheckBoxEchoOn.checked:=false;
    end;
   AlreadyTryingToClosePort:=false;
end;

procedure TForm1.EchoReceiveFlowBoxClick(Sender: TObject);
begin

end;

//uses DTR or RTS to signal state of the winsock connection through the comport pins of the echoing serial port
procedure TForm1.SignalWsConnectedThroughRTSDTR(Connected:boolean; OtherPort:TApdWinsockPort);
begin
  if CheckboxEchoOn.checked and OtherPort.open and (OtherPort.DeviceLayer<>dlWinsock)
    then begin
      if (CheckBoxSignalWsWithDTR.checked)
        then begin
          OtherPort.DTR:=Connected;
        end;
      if (CheckBoxSignalWsWithRTS.checked)
        then begin
          OtherPort.RTS:=Connected;
        end;
  end;
end;

procedure TForm1.EchoPortWsConnect(Sender: TObject);
begin
  ApdStatusLightEchoConnected.lit:=true;
  LabelEchoConnected.Caption:='Connected';
  fEchoPortConnected:=true;
  SignalWsConnectedThroughRTSDTR(true,Port1);
end;


procedure TForm1.MenuItemEchoClick(Sender: TObject);
begin
  CheckBoxEchoOn.checked:= not CheckBoxEchoOn.checked;
  CheckBoxEchoOnClick(nil);
end;

procedure TForm1.MenuItemFullScreenClick(Sender: TObject);
begin
    if MenuItemMiniTerminal.Checked and MenuItemFullScreen.Checked then begin //Mini->full
      MenuItemMiniTerminal.Checked:=false;
      MenuItemMiniTerminalClick(nil)
    end;

    if MenuItemFullScreen.checked
    then SetWinState(3)
    else SetWinState(0);
end;

procedure TForm1.MenuItemGlobalHotkeys1Click(Sender: TObject);
begin
  TMenuItem(Sender).checked:=not TMenuItem(Sender).checked;
  GlobalHotKeys1.RegisterAll(TMenuItem(Sender).checked,Form1.Handle); //register/unregister
end ;

procedure TForm1.MenuItemLastErrorMessageClick(Sender: TObject);
begin

end;

//These two not sensible naming, but leave them as they work for now.
procedure CopyTerm2Pos(var T:TAdTerminal; var P:TPoint; RowCol:boolean=false);
begin
  if RowCol then begin
  P.X:=T.Columns;
  P.Y:=T.Rows;
  end else begin
  P.X:=Form1.Left;
  P.Y:=Form1.Top;
  end;
end;
procedure CopyPos2Term(var P:TPoint; T: TAdTerminal; RowCol:boolean=false);
begin
  if RowCol then begin
    Form1.ChangeRowsCols(P.Y,P.X,true);
    //T.Columns:=P.X;
    //T.Rows:=P.Y;
  end else begin
    Form1.Left:=P.X;
    Form1.Top:=P.Y;
  end;
end;

procedure TForm1.MenuItemMacro1Click(Sender: TObject);
begin
  if assigned(Macro1) then ExecuteParameterString(Macro1.Text);
end;

procedure TForm1.MenuItemMacro2Click(Sender: TObject);
begin
  if assigned(Macro2) then ExecuteParameterString(Macro2.Text);
end;

procedure TForm1.MenuItemMiniTerminalClick(Sender: TObject);
const EMPTY_POS=-9999;
const MiniPos:TPoint = (X:EMPTY_POS;Y:EMPTY_POS); MiniRC:TPoint=(X:24;Y:16);
      NormalPos:TPoint = (X:100;Y:0);
begin
  //Full->Mini
  if MenuItemMiniTerminal.Checked and MenuItemFullScreen.Checked then begin
    MenuItemFullScreen.Checked:=false;
    MenuItemFullScreenClick(nil);
  end;
  //now setup posn and rows/cols
  HideControls1.Checked:=MenuItemMiniTerminal.Checked;
  if MenuItemMiniTerminal.Checked then begin // -> Mini
        CopyTerm2Pos(AdTerminal1,NormalPos); //save normal position
        if MiniPos.X=EMPTY_POS then begin //first time make it match Normal window...
          MiniPos:=NormalPos;
          SetDisplayWidth(true);
          MiniRC.X:=AdTerminal1.Columns; //Y is set in default const
        end else begin //we have had mini before , so have it in the same place
          CopyPos2Term(MiniPos,AdTerminal1);
          CopyPos2Term(MiniRC,AdTerminal1,true); //set rows/cols from saved
        end;
        HideControls(MenuItemMiniTerminal.Checked,MiniRC.Y{, MenuItemMiniTerminal.Checked});
    end else begin //Restore-> Normal
        CopyTerm2Pos(AdTerminal1,MiniPos);     //save mini pos
        CopyTerm2Pos(AdTerminal1,MiniRC,true); // save mini size
        CopyPos2Term(NormalPos,AdTerminal1); //restore norm position
        //FResizeColumnsFromWidth:=false;
        SpinEditTerminalColsChange(nil); //Set back to value in Cols control
        HideControls(MenuItemMiniTerminal.Checked,SpinEditTerminalRows.value{, MenuItemMiniTerminal.Checked});
    end;

  //HideControls(MenuItemMiniTerminal.Checked,MiniRC.Y, MenuItemMiniTerminal.Checked);
  MenuItemStayOnTop.Checked:=MenuItemMiniTerminal.Checked;
  MenuItemStayOnTopClick(nil);
  FResizeColumnsFromWidth:=MenuItemMiniTerminal.Checked; //here so resizing has happened before we enable auto col setting
end;

procedure TForm1.MenuItemOpenPortClick(Sender: TObject);
begin
  SpeedButtonPort1Open.Down:=not SpeedButtonPort1Open.Down;
  SpeedButtonPort1OpenClick(nil);
end;

procedure TForm1.WMDropFiles(var Msg: TWMDropFiles);
var
  DropH: HDROP;               // drop handle
  DroppedFileCount: Integer;  // number of files dropped
  FileNameLength: Integer;    // length of a dropped file name
  FileName: string;           // a dropped file name
  I: Integer;                 // loops thru all dropped files
  //DropPoint: TPoint;          // point where files dropped
  Filenames: string;          //list of filenames
begin
  inherited;
  DropH := Msg.Drop;   // Store drop handle from the message
  try
    DroppedFileCount := DragQueryFile(DropH, $FFFFFFFF, nil, 0);     // Get count of files dropped
    for I := 0 to Pred(DroppedFileCount) do     // Get name of each file dropped and process it
    begin
      FileNameLength := DragQueryFile(DropH, I, nil, 0);       // get length of file name
      // create string large enough to store file
      // (Delphi allows for #0 terminating character automatically)
      SetLength(FileName, FileNameLength);
      DragQueryFile(DropH, I, PChar(FileName), FileNameLength + 1); // get the file name
      if length(Filenames)>0 then Filenames:=Filenames+';'; //names are ; delimited
      Filenames:=Filenames+Filename; //append to list
      // process file name (application specific)
      // ... processing code here
    end; //for
    SelectTabsheet('Send');
    ComboBoxSendFName.Text:=Filenames;
    ComboBoxSendFNameExit(ComboBoxSendFName);
    // Optional: Get point at which files were dropped
    //DragQueryPoint(DropH, DropPoint);
    // ... do something with drop point here
  finally
    // Tidy up - release the drop handle
    // don't use DropH again after this
    DragFinish(DropH);
  end;
  // Note we handled message
  Msg.Result := 0;
end;

procedure TForm1.WMHotKey(var Msg: TWMHotKey);//global hotkey handler
var S:string;
begin

//  if StatusBar1.SimplePanel
//    then StatusBar1.SimpleText:= S
//    else StatusBar1.Panels[0].Text:=S;
   StatusBarHint:=S;
   GlobalHotKeys1.ProcessWMHotKey(Msg);
end;

procedure TForm1.SysMenuAddRemoveExtraItems(Add:boolean=true);
//
var
  SysMenu, SubMenu : HMenu;
  const NumItems:integer=0;

  procedure InsertM(Position,I:integer;J:integer=-1;S:string='');
  // https://msdn.microsoft.com/en-us/library/windows/desktop/ms647987(v=vs.85).aspx
    var M:TMenuItem; H:thandle; Flags:cardinal;
  begin
    M:=PopupMenu1.Items;
    if I>=0 then M:=M.Items[I];
    Flags:=MF_BYPOSITION+MF_STRING;
    if M.Count>1 then Flags:=Flags+MF_POPUP;

    if J>=0 then M:=M.Items[J];
    H:=M.Handle;
    if S='' then S:=M.Caption;
    InsertMenu(SysMenu,Position,Flags,H,pwidechar(S));
    inc(NumItems);
  end;
  procedure InsertSeparator(Position:integer);
  begin
    InsertMenu(SysMenu,Position,MF_BYPOSITION,MF_SEPARATOR,nil); {Add a seperator bar to main form-form1}
    inc(NumItems);
  end;
  procedure RemoveItems;
  var i:integer;
  begin
    for i := 1 to NumItems do  //remove items from top
      RemoveMenu(SysMenu,0,MF_BYPOSITION);
    NumItems:=0;
  end;

  procedure DeleteAppend(ID:cardinal); //to move standard menuitems to submenu
  var
    Caption: string;
    CaptionLen: Integer;
  begin
  CaptionLen := GetMenuString(SysMenu, ID, nil, 0, MF_BYCOMMAND);
  if CaptionLen > 0 then begin
    Inc(CaptionLen);
    SetLength(Caption, CaptionLen);
    GetMenuString(SysMenu, ID, PChar(Caption), CaptionLen, MF_BYCOMMAND);

    DeleteMenu(SysMenu, ID, MF_BYCOMMAND);
    AppendMenu(SubMenu, MF_STRING, ID, PChar(Caption));
    end;
  end;
  procedure MoveDefaultSysMenuItemsToSubmenu(Caption:string='';JustSeparator:boolean=false);
  //Can either have a a caption or JustSeparator (submenu will be inaccessible)
  // https://stackoverflow.com/questions/44735708/system-menu-how-to-hide-move-standard-menuitems/44743027#44743027
  begin
  SubMenu := CreateMenu; //make submenu to move them into
    if SubMenu <> 0 then begin
      DeleteAppend(SC_RESTORE);
      DeleteAppend(SC_MOVE);
      DeleteAppend(SC_SIZE);
      DeleteAppend(SC_MINIMIZE);
      DeleteAppend(SC_MAXIMIZE);
      if JustSeparator then begin
          DeleteMenu(SysMenu, 0, MF_BYPOSITION); //remove separator above CLOSE
          InsertMenu(SysMenu, 0, MF_BYPOSITION or MF_POPUP or MF_SEPARATOR, SubMenu, '');
        end else begin
          DeleteMenu(SysMenu, 0, MF_BYPOSITION); //remove separator above CLOSE
          InsertMenu(SysMenu, 0, MF_BYPOSITION or MF_POPUP, SubMenu, PChar(Caption));
          InsertMenu(SysMenu, 1, MF_BYPOSITION or MF_SEPARATOR, 0, nil);
      end;
    end;
  end;
  procedure DestroySubmenu;
    var Info: TMenuItemInfo;
  begin
    Info.cbSize := SizeOf(Info);
    Info.fMask := MIIM_SUBMENU;
    if GetMenuItemInfo(GetSystemMenu(Handle, False), 0, True, Info) then
      DestroyMenu(Info.hSubMenu);
    //GetSystemMenu(Handle, True);
  end;

begin
  SysMenu := GetSystemMenu(Handle, FALSE) ;   {Get system menu}
  //InsertMenu(SysMenu,1,MF_BYPOSITION+MF_STRING,SC_MyMenuItem2,'pqr');
  if Add then begin
    MoveDefaultSysMenuItemsToSubmenu('',true);
 //   InsertSeparator(0);
    InsertM(0,PopupMenu1.Items.Count-2);
    InsertM(0,-1,-1,'Menu'); //help
    InsertM(0,7);
    end
  else begin  //remove items
    RemoveItems;
    DestroySubmenu;
  end;
end;

procedure TForm1.ShowSysMenu(Show:boolean=true);
var P:TPoint;
begin
  P:=ClientToScreen(Point(0,0));
  TrackPopupMenu(GetSystemMenu(Handle, FALSE),
     TPM_LEFTALIGN+TPM_TOPALIGN+{TPM_RETURNCMD+}TPM_NONOTIFY+ TPM_RECURSE,
                 P.X,P.Y,0,self.Handle,nil);
end;
procedure TForm1.ShowPopupMenu(Handle:HMENU; Show:boolean=true);
var P:TPoint;
    T:TdateTime;
    NumTimes:integer;
begin
  P:=ClientToScreen(Point(100,175)); //200,300
  T:=now;
  repeat //Trackmenu will block unless previous menu was dismissed by clicking on form
    TrackPopupMenu(Handle ,
     TPM_LEFTALIGN+TPM_TOPALIGN+{TPM_RETURNCMD+}TPM_NONOTIFY+ TPM_RECURSE,
                 P.X,P.Y,0,self.Handle,nil);
    inc(NumTimes);
  until ((now-T)>(1/(24*3600*3))) OR ( NumTimes>=2 ); //test that it has blocked for more than 1/3 second

end;

procedure TForm1.WMSysCommand(var Msg: TWMSysCommand);
//  https://www.delphipower.xyz/guide_7/customizing_the_system_menu.html
var Item: TMenuItem;
begin

  Item := PopupMenu1.FindItem (Msg.CmdType, fkCommand);
  if assigned(Item) then Item.Click
  else
  //  case Msg.CmdType of
  //    //put any other specials in here
  //  else
   inherited;
  //  end;
end;

procedure TForm1.WMEnterSizeMove(var Message: TMessage); //message WM_ENTERSIZEMOVE;
begin
  FIsWMSizeMove:=true;
end;
procedure TForm1.WMExitSizeMove(var Message: TMessage);// message WM_EXITSIZEMOVE;
begin
  FIsWMSizeMove:=false;
end;
//procedure TForm1.WMDEVICECHANGE(var Msg: TMessage);
//begin
//  //HandleWMDeviceChange(Msg);
//end;
procedure TForm1.TimerCallbackTimer(Sender: TObject);
begin
  RTI.SendEventOnTimer;
end;
procedure TForm1.ApdProtocol1ProtocolStatus(CP: TObject; Options: Word);
//var CPS:integer;
//const LastBytesSent:integer;
begin
//  CPS:=
//  ProgressBarSendFile.Position:=ApdProtocol1.BytesTransferred;
//  LabelProtocolError.Caption:='Sending: '+inttostr(ApdProtocol1.BytesRemaining);
end;


procedure TForm1.HideControls(Hide:boolean; NumRows:integer{; IsNarrow:boolean=false});
//var BorderWidth,BorderHeight:integer;
begin
  PageControl1.Visible:=not HideControls1.Checked;
  GroupBoxStatus.Visible:=not HideControls1.Checked;
  PanelFloatingButtons.Visible:= not HideControls1.Checked;
  if Hide
    then FPrevWidth:=Form1.Width //save
    else Form1.Width:=FPrevWidth; //restore
  ChangeRowsCols(NumRows,0);
  SetFormSizeFromRowsCols(Hide);  //set width if hidden
  if Hide then begin //Set the FORM scroll bar kick in points
    VertScrollbar.Range:= 0;    //never scrcollbar with hidden controls. Terminal will scrollbar itself
    HorzScrollBar.Range:= 0;
  end else begin
    VertScrollbar.Range:= 300;
    HorzScrollBar.Range:= FDesignWidth-20;
  end;
  //  AdTerminal1.Align:=alTop;
end;
procedure TForm1.HideControls1Click(Sender: TObject);
const HideRows:integer=43;
begin
  if HideControls1.Checked
    then HideControls(HideControls1.Checked,HideRows)   //hide
    else  //restore
      if MenuItemMiniTerminal.Checked  //exiting miniterm when Hide is pressed
        then begin
          MenuItemMiniTerminal.Checked:=false;
          MenuItemMiniTerminalClick(nil)
        end else begin  //exiting hide when hide is pressed
          HideRows:=AdTerminal1.Rows; //save for next time
          FResizeColumnsFromWidth:=false;
          SpinEditTerminalRowsChange(nil); //Set back to value in Cols control
          HideControls(HideControls1.Checked,SpinEditTerminalRows.Value); //un hide
        end;
end;


procedure TForm1.SpinEditAsciiCharDelayChange(Sender: TObject);
  var value:integer;  V : cardinal;
begin
  value:=SpinEditAsciiCharDelay.value;
  if value<=0 then begin
      ApdProtocol1.AsciiCharDelay:=0;
      V:=abs(value);
      V:=floor(intpower(2,(V+5)));
//      ApdProtocol1.AsciiBlockLen:=V;
    end else begin
      ApdProtocol1.AsciiCharDelay:=value;
//      ApdProtocol1.AsciiBlockLen:=32;
  end;
//  StatusBarHint:='Block Size='+inttostr(ApdProtocol1.AsciiBlockLen);
end;

procedure TForm1.SpinEditAsciiLineDelayChange(Sender: TObject);
begin
  ApdProtocol1.AsciiLineDelay:=SpineditAsciiLineDelay.value;
end;



procedure TForm1.ButtonClearClick(Sender: TObject);
begin
  AdTerminal1.Clear;
  AdTerminal1.Emulator.Buffer.SetCursorPosition(1,1);
  CharCount:=0;
  ShowSerialStatus(true);
  if AdTerminal1.Enabled
    then ActiveControl:=AdTerminal1;
  HexEmulator.SyncCount:=0;
end;
procedure TForm1.SpinEditTerminalColsChange(Sender: TObject);
  var NumCols : integer;
begin
  try
    if SpinEditTerminalCols.Value<2 then raise Exception.Create('');
    if SpinEditTerminalCols.Value>263 then raise Exception.Create(''); //>263 error on close
    NumCols:=SpinEditTerminalCols.Value;
   except //catches non numeric values

    //on Exception do begin
      SpinEditTerminalCols.Color:=clRed;
      exit;
    //end;
    //on EConvertError do exit;
  end;
//  if (NumCols<2) then NumCols:=2; //validate
  SpinEditTerminalCols.Color:=clWindow;
  //AdTerminal1.Columns:=NumCols;
  ChangeRowsCols(0,NumCols,false);
  SpinEditTerminalCols.Value:=AdTerminal1.Columns;
  //possibly we shoudl be calling optimise here to get best width, rather than user selected width
end;

procedure TForm1.SpinEditTerminalColsDblClick(Sender: TObject);
begin
  SetRowsColsFromFormSize(0,true,false, true);
end;



function TForm1.PageControlAndBarsHeight:integer;
//var PageControlAndBarsHeight:integer;
begin
  result:= StatusBar1.Height;
  if PageControl1.Visible then
    result:=result + PageControl1.Height;
  if StatusBarFormattedData.Visible then
    result:=result+StatusBarFormattedData.Height;
end;



procedure TForm1.ChangeRowsCols(NewRows,NewCols:integer; SetFormWidth:boolean=false);
var OldRows, OldCols, OldCol, OldRow, NewRow, NewCol, I :Integer;
begin

  OldRows:=AdTerminal1.Rows;
  OldCols:=AdTerminal1.Columns;

  if (NewRows=0) then NewRows:=OldRows;
  if (NewCols=0) then NewCols:=OldCols;

  OldCol:=AdTerminal1.Emulator.Buffer.Col;
  OldRow:=AdTerminal1.Emulator.Buffer.Row;

  if (NewRows = OldRows) and (NewCols=OldCols)then exit;

  if (NewRows > OldRows) then begin //growing
    if false then begin  //keep cursor row same from bottom
        NewRow:=(NewRows-OldRows) + OldRow;
        NewCol:=OldCol;
      end else begin  //keep cursor at same row...
        NewRow:=OldRow;
        NewCol:=OldCol;
        AdTerminal1.Emulator.Buffer.Row:=OldRows; //move to end and insert a line
        for I := OldRows to NewRows-1 do begin
          AdTerminal1.Emulator.Buffer.Row:=I; //move to end and insert a line
          AdTerminal1.Emulator.Buffer.MoveCursorDown(true);//InsertLines(OldRows-NewRows - max(0,OldRow-NewRows));
        end;//for
    end;

  end else begin //shrinking
    NewRow:=OldRow - max(0,OldRow-NewRows);//(NewCols-OldCols) + Row;
    NewCol:=OldCol;
    AdTerminal1.Emulator.Buffer.Row:=1;
    AdTerminal1.Emulator.Buffer.InsertLines(OldRows-NewRows - max(0,OldRow-NewRows));
  end;
    if (OldCol>NewCols) then begin //cursor will be off screen, so wrap
      NewCol:=0;
      inc(NewRow);
    end else //at last column the cursor stalls waiting for newline
      if (OldCol=OldCols) then inc(NewCol);
    // this is the ONLY place these are changed in whole program...
    AdTerminal1.Rows:=NewRows;
    AdTerminal1.Columns:=NewCols;
 //   SetFormSizeFromRowsCols(SetFormWidth);
 //   Form1.Repaint; //setting FormHeight, clears ROW
    AdTerminal1.Emulator.Buffer.SetCursorPosition(NewRow,NewCol);
    //was in setrowscolsfromform, but better here for diagnostics for now....
    StatusBarHint:='Rows: '+inttostr(AdTerminal1.Rows)
            +' x Cols:'+inttostr(AdTerminal1.Columns); //show actual rows
end;

procedure TForm1.ButtonPostProcessFNameClick(Sender: TObject);
begin
  ComboBoxCapturePostFName.FileChoose(OpenDialog2);
  ComboBoxCapturePostFName.SetFilenameCheckFileExists;
end;



//procedure AddDblClickToRadioGroup(RG:TRadioGroup; RB:TRadioButton);
// Var
//   I:integer; C:TControl; S:string;
// begin
//
// for I := 0 to RG.ControlCount - 1 do begin
//   C:=RG.Controls[I];
//   S:=C.ClassName;
//   if C.ClassNameIs('TGroupButton') then
//     TRadioButton(C).OnDblClick:= RB.OnDblClick;
// end; //for
//end; //fn

procedure TForm1.FrameControl(C:Tcontrol; CL:Tcolor=clRed);
const CL_CLEAR_FRAME=clBtnFace;
var
  Canvas: TControlCanvas;
  R:TRect;
  ClearIt:boolean;
const FRAME_WIDTH=10;
begin
  ClearIt:=CL=-1;
  Canvas := TControlCanvas.Create;
  try
    Canvas.Control := C;
    Canvas.Pen.Style := psSolid;
    Canvas.Pen.Width := FRAME_WIDTH * fScale div 100;
      if ClearIt then begin
        CL:=CL_CLEAR_FRAME;
        //Canvas.Pen.Style := psClear; //doesn't work
      end;
    Canvas.Pen.Color:=CL;
    Canvas.Brush.Style:=bsClear;
    R:=rect(0,0,Canvas.Control.Width,Canvas.Control.Height);
    R.Offset(0,0);
   // R.Inflate(-FRAME_WIDTH,-FRAME_WIDTH);

    Canvas.Rectangle(R);  //X1,Y1,X2,Y2)
    if ClearIt then begin
        C.repaint;
        //C.update;
      end;
finally
  Canvas.Free;
end;
end;
procedure TForm1.ButtonPlay1Click(Sender: TObject);
  var tt:ttabsheet; F:TStatusBar; var CL:tcolor;
var
  Canvas: TControlCanvas;
begin
  FrameControl(StatusBar1);
     // F.Canvas.Handle:=GetDCEx(Form1.Handle, 0, DCX_PARENTCLIP);

end;
procedure TForm1.ButtonPlay2Click(Sender: TObject);
begin
  FrameControl(StatusBar1,-1);
end;

procedure TForm1.SetRowsColsFromFormSize(WhenGreaterBy:integer=0;
                                  SetCols:boolean=false;
                                  ForceRows:boolean=false;ForceCols:boolean=false);
var TermRows:integer;
    TermCols:integer;
    procedure CalcColsFromForm;
    var CharW,TermW,N:integer;
    begin
      CharW:=AdTerminal1.GetTotalCharWidth;
      TermW:=Form1.ClientWidth;
      if (AdTerminal1.Emulator = AdEmulator_Hex)
        then N:= HexEmulator.NumChars
        else N:=1;
      TermW:=TermW - 8 - GetSystemMetrics(SM_CYHSCROLL);
      TermCols:=floor(TermW / (CharW*N))*N; //whole multiples of N
      TermCols:=max(TermCols,4);
      TermCols:=min(TermCols,255);
    end;

    procedure CalcRowsFromForm;
    var TermHeight,CharHeight:integer;
    begin
      CharHeight:=AdTerminal1.GetTotalCharHeight;
      TermHeight:=Form1.ClientHeight-PageControlAndBarsHeight;
      TermHeight:=TermHeight- (CharHeight div 2); //allow some extra space...
      TermRows:=floor(TermHeight/CharHeight); //possible number of rows...
    end;
var NewRows,NewCols:integer;
begin //SetRowsColsFromFormSize
  CalcRowsFromForm;
  //set Rows
  NewCols:=AdTerminal1.Columns; //default to same
  NewRows:=AdTerminal1.Rows;

  if (WhenGreaterBy = 0) then
    NewRows := TermRows; // then just set it

  if ((TermRows > AdTerminal1.Rows) // growing
    and (TermRows + WhenGreaterBy > SpinEditTerminalRows.Value)) then
    NewRows := TermRows;

  if (TermRows < AdTerminal1.Rows) // shrinking back to set value
  then
    if MenuItemMiniTerminal.checked then
    begin
      NewRows := max(TermRows, 8) //miniterminal is >=8 rows
    end
    else begin //not miniterminal
      if ForceRows then
      begin
        NewRows := TermRows; //make it exactly fit form
        //SetSpinEditValue(SpinEditTerminalRows, TermRows);
      end
      else
      begin
        NewRows := max(TermRows, SpinEditTerminalRows.Value); //don't go smaller than spineditrows
        // normally limit to
      end;
    end;
  //if ForceRows then SpinEditSetValue(SpinEditTerminalRows, TermRows);
  if ForceRows then SpinEditTerminalRows.SetValue(TermRows);
  // Set Cols
  if SetCols then
  begin
    CalcColsFromForm;
    NewCols := TermCols;
    // if we are forcing rows, then we will want change the SpinEdit for cols too.
    if (ForceCols) or (ForceRows) then
      //SpinEditSetValue(SpinEditTerminalCols, TermCols);
      SpinEditTerminalRows.SetValue(TermRows);
  end;



  // AdTerminal1.Rows:=NewRows;
  // AdTerminal1.Columns:=NewCols;
  ChangeRowsCols(NewRows, NewCols, SetCols);
  // StatusBarHint:='Rows: '+inttostr(AdTerminal1.Rows)
  // +' x Cols:'+inttostr(AdTerminal1.Columns); //show actual rows
end;


procedure TForm1.SetFormSizeFromRowsCols(SetWidthFromCols:boolean=false; MinWidthFromPanel:boolean=false);
var TermHeight{, TermWidth}, CharHeight, CharW:integer;
    FCH,FCW,BorderHeight,BorderWidth:integer; //formclientwidth
    SRect:TRect;
    DoRecalc:boolean;
  begin
    repeat //allows a restart if screen is too small
      DoRecalc:=false;
      CharHeight := AdTerminal1.GetTotalCharHeight;
      TermHeight := (CharHeight * AdTerminal1.Rows);
      TermHeight := TermHeight + (CharHeight div 2);
      // GetSystemMetrics(SM_CYVSCROLL);
      FCH := TermHeight + PageControlAndBarsHeight;

      CharW := AdTerminal1.CharWidth;
      FCW := CharW * AdTerminal1.Columns + 4{8} + GetSystemMetrics(SM_CYHSCROLL);
      SRect := Screen.WorkAreaRect;
      BorderWidth:=Form1.Width-Form1.ClientWidth;
      BorderHeight:=Form1.Height-Form1.ClientHeight;

      if (SRect.Height < FCH+BorderHeight) then begin
        Form1.Height :=SRect.Height;
        DoRecalc:=true;
      end;
      if (SRect.Width < FCW+BorderWidth) then
      begin
        if SetWidthFromCols //so calc'd columns will be right
          then Form1.{Client}Width  :=min(FCW,SRect.Width{-BorderWidth})
          else Form1.{Client}Width  :=min(Form1.{Client}Width,SRect.Width{-BorderWidth});
        DoRecalc:=true;
      end;
      if DoRecalc then begin
        SetRowsColsFromFormSize(0, not SetWidthFromCols, true); //reset rows/cols to fit
      end;
    until not DoRecalc;


    Form1.ClientHeight := FCH;
    if SetWidthFromCols
      then begin
        if MinWidthFromPanel then FCW:=max(FCW, PageControl1.width);//FDesignWidth-BorderWidth);
        Form1.ClientWidth := FCW;
      end else begin
        if MinWidthFromPanel then begin
          //PageControl1.width seems to give a valid after scaling width
          FCW:=PageControl1.width;//+BorderWidth; //max(FCW,FDesignWidth-BorderWidth);
          Form1.ClientWidth := FCW;
        end;
      end;
   //   else Form1.ClientWidth :=min(Form1.ClientWidth,SRect.Width); //if we didn't change COLs then clip to keep on screem

//  if SetWidthFromCols then begin
//    CharW:=AdTerminal1.CharWidth;
//    Form1.ClientWidth:=CharW* AdTerminal1.Columns
//                        +8 + GetSystemMetrics(SM_CYHSCROLL);
//  end;
  MakeFullyVisible;
end;
procedure TForm1.SpinEditTerminalRowsChange(Sender: TObject);
var NumRows{, CharHeight,TermHeight}:integer;
begin
  try
    NumRows:=SpinEditTerminalRows.Value;
   except //catches non numeric values
    on EConvertError do exit;
  end;
  if not (NumRows>=SpinEditTerminalRows.MinValue) then exit; //don't proceed for very small numbers

  //AdTerminal1.Rows:=NumRows;
  ChangeRowsCols(NumRows,0);
  SetFormSizeFromRowsCols(false); //SetFormSizeFromRowsCols(false);
  //SpinEditTerminalRows.Value:=AdTerminal1.Rows;
end;

procedure TForm1.SpinEditTerminalRowsDblClick(Sender: TObject);
begin
  SetRowsColsFromFormSize(0, false, true, false);
end;

procedure TForm1.AdTerminal1Click(Sender: TObject);
begin
  PageControl1.Hint:='Ctrl+Tab to step through tab sheets'; //override 1st hint
end;


procedure TForm1.RadioGroupBusNumClick(Sender: TObject);
begin
  SetHalfDuplex(true);
  //ComboBoxBusNum.text:=ComboBoxBusNum.Items[RadioGroupBusNum.ItemIndex+1];
  SendAsciiString('G'+inttohex(RadioGroupBusNum.ItemIndex+1,1),false,false,true);
end;

procedure TForm1.SetHalfDuplex(State:boolean);
begin
  if (State and (not CheckBoxHalfDuplex.checked)) then CheckBoxHalfDuplex.checked:=true;
  if ((not State) and CheckBoxHalfDuplex.checked) then CheckBoxHalfDuplex.checked:=false;
end;

procedure TForm1.ButtonIStartClick(Sender: TObject);
begin
  SetHalfDuplex(true);
  //I2CBusy:=true;
  SendString('S');
end;

procedure TForm1.ButtonIStopClick(Sender: TObject);
begin
  SetHalfDuplex(true);
  SendString('P');
  //I2CBusy:=false;
end;
{procedure TForm1.IChipAddress(Address:word; Name:string);
begin
  Address:=Address  and $FFFE; //in case given as read
  if GetI2CAddress(false)=Address then return; //not change so do nothing....

  Form1.ComboboxIAddress.text:=Name+' '+str2hex(Address,4); //put in the combobox
  ComboBoxPutStringAtTop(Form1.ComboboxIAddress,100);

end   }

function GetI2CAddress(IncludeSubAddress:boolean):word;
var BaseAddress,SubAddress,WC:word;
    DeviceAddressStr,Delims: string;
begin
  SubAddress:=2*Form1.SpinEditISubAddress.value;
  Delims:=' :,;';
  WC:=WordCountL(Form1.ComboboxIAddress.text,Delims);
  DeviceAddressStr:=ExtractWordL(WC,Form1.ComboboxIAddress.text,Delims);
  if str2wordl(DeviceAddressStr,BaseAddress)
  //if str2wordl(Form1.EditIAddress.text,BaseAddress)
    then begin
      Form1.ComboboxIAddress.PutStringAtTop(100);
      if (BaseAddress and 1)>0 //force to be 0 in write bit
        then begin
        BaseAddress:=BaseAddress and $FFFE;
        //Form1.EditIAddress.text:='0x'+inttohex(BaseAddress,2);
      end;
      result:=BaseAddress;
      if IncludeSubAddress then result:=BaseAddress+SubAddress;
    end
    else begin
       //Form1.EditIAddress.text:='0x00';
       result:=0;
    end;
    Form1.GroupboxIaddress.Caption:= 'Address:'+'0x'+inttohex(result,2);
end;
procedure SetI2CAddress(NewAddress:word; ChipName:string);
  var A:word;
begin
  A:=GetI2CAddress(false);
  if A<>NewAddress then begin
    showmessage('Changed I2C Address to: 0x'+inttohex(NewAddress,2)+' for '+ChipName+CRLF+CRLF+'subaddress set to 0');
    Form1.ComboboxIAddress.text:=ChipName+' 0x'+inttohex(NewAddress,2);
    Form1.ComboboxIAddress.PutStringAtTop(100);
    Form1.SpinEditISubAddress.value:=0;

  end;
end;

procedure TForm1.IRead(BytesToRead:byte);
  var Address:word;
begin
  SetHalfDuplex(true);
  Address:=GetI2CAddress(true);
  Address:=Address or 1;  //force read
  SendString('S'+inttohex(Address,2)+inttohex(BytesToRead,2)+'P');
end;
procedure TForm1.ButtonIReadClick(Sender: TObject);
  //var Address:word;

begin
  //SetHalfDuplex(true);
  //Address:=GetI2CAddress;
  //Address:=Address or 1;
  IRead(SpinEditIBytes2Read.value);
end;
{procedure ICheckAddress(BaseAddress:word; Name:string); //checks that address has been set for this type of chip...
begin
  if GetI2CAddress(false)<>BaseAddress
    then begin
       //prompt

       ComboBoxIAddress.text:=Name+' 0x'+inttohex(BaseAddress,2); //make it the combobox value

    end;
end; }

procedure TForm1.IWrite(S:ansistring);
  var Address:word;
begin
  SetHalfDuplex(true);
  Address:=GetI2CAddress(true);
  Address:=Address and (not 1);
  SendAsciiString('S'+inttohex(Address,2)+uppercase(S)+'P',false,false,true);
end;

procedure TForm1.ButtonIWriteClick(Sender: TObject);
//  var Address:word;
begin
//  SetHalfDuplex(true);
//  Address:=GetI2CAddress;
//  Address:=Address and (not 1);
//  SendAsciiString('S'+inttohex(Address,2)+uppercase(EditIData2Write.text)+'P',false,false,true);
  IWrite(EditIData2Write.text);
end;
procedure TForm1.IWriteThenRead(WriteData:ansistring;BytesToRead:byte);
var Address:byte;
begin
  SetHalfDuplex(true);
  Address:=GetI2CAddress(true);
  Address:=Address and $FE;
  SendString('S'+inttohex(Address,2)+WriteData +'R'+inttohex(BytesToRead,2)+'P');
end;

procedure TForm1.ButtonIRead1WireIDClick(Sender: TObject);
begin
  SetHalfDuplex(true);
  SendAsciiString(':SW33R08',false,true,true);
end;

procedure TForm1.ButtonIGetStatusClick(Sender: TObject);
begin
  SetHalfDuplex(true);
  SendString('?');
end;


procedure TForm1.ButtonIQueryPinsClick(Sender: TObject);
begin
  SetHalfDuplex(true);
  SendString('Q');
end;

procedure TForm1.ButtonNewLineClick(Sender: TObject);
begin
//    AdTerminal1.Emulator.Buffer.DoLineFeed;
//    AdTerminal1.Emulator.Buffer.DoCarriageReturn;
    TerminalNewLine;
    ActiveControl:=AdTerminal1;
end;
procedure TForm1.TerminalNewLine;
begin
    AdTerminal1.Emulator.Buffer.DoLineFeed;
    AdTerminal1.Emulator.Buffer.DoCarriageReturn;
end;

procedure TForm1.CheckBoxNewLineClick(Sender: TObject);
begin
  //Note that this must be duplicated in the change emulator routine
  AdTerminal1.Emulator.Buffer.UseNewLineMode:=CheckBoxNewLine.checked;
  AdEmulator_VT100.NewLineMode:=CheckBoxNewLine.checked;
end;


procedure TForm1.CheckBoxNoSleepClick(Sender: TObject);
begin
  if IsCapturing
      then begin
        BlockSleep(CheckboxNoSleep.Checked);
        if CheckboxNoSleep.Checked
          then TrayIcon1.Hint:= TrayIcon1.Hint + NO_SLEEP_TRAYICON_STRING
          else TrayIcon1.Hint:= stringreplace(TrayIcon1.Hint, NO_SLEEP_TRAYICON_STRING,'',[]);
      end;
end;

procedure TForm1.CheckBoxPadLeftClick(Sender: TObject);
begin
  HexEmulator.PadLeft:=CheckboxPadLeft.Checked;
end;

procedure TForm1.CheckBoxPortAutoCloseClick(Sender: TObject);
begin
  SpinEditPortAutoClose.Visible:=CheckBoxPortAutoClose.Checked and CheckBoxPortAutoOpen.Checked;
end;

procedure TForm1.CheckBoxPortAutoOpenClick(Sender: TObject);
begin
  CheckboxPortAutoClose.Enabled := CheckBoxPortAutoOpen.checked;
  CheckboxPortAutoCloseClick(nil);
  Port1.AutoOpen := CheckboxPortAutoOpen.checked;
end;


procedure TForm1.CheckBoxPostShowCMDClick(Sender: TObject);
const StateWas:TCheckboxState=cbUnchecked; 
var CB:TCheckbox;
begin //natural order is unchecked->gray->check
  CB:=Sender as TCheckbox;
  case StateWas of
    cbUnchecked: CB.State:=cbChecked ;
    cbChecked: CB.State:=cbGrayed;
    cbGrayed: CB.State:=CBUnChecked;
  end;
  StateWas:=CB.State;
end;

procedure TForm1.SpinEditFileSendRepeatsChange(Sender: TObject);
begin
  SpinEditFileSendDelay.enabled:= not(SpinEditFileSendRepeats.value=1);
end;

procedure TForm1.StWMDataCopy1DataReceived(Sender: TObject;
  CopyData: tagCOPYDATASTRUCT);
var
  S : string;
begin
  S := String(PChar(CopyData.lpData));
  //SetString(S, PChar(copyData.lpData), copyData.cbData div SizeOf(Char)); //more robust: http://stackoverflow.com/questions/7540706/wm-copydata-with-and-without-quotes-yields-different-results
  StatusBarHint:='Remote:'+S;
  ExecuteParameterString(S);
end;
//----------------
function AppWndProcWMCopyData(Handle: hWnd; Msg, wParam, lParam: Cardinal): LongInt; stdcall;
var
  CDS   : TCopyDataStruct; {S:string;}
begin
  result:=0; //should never be used....
  if (Msg = WM_COPYDATA { fCustomMsg } ) then
  begin
    CDS := PCopyDataStruct(Pointer(lParam))^;
    if (CDS.dwData = WMCOPYID) then
      Form1.StWMDataCopy1DataReceived(nil, CDS);
    result := 1;
  end
  else if Assigned(WProc) then
    result := CallWindowProc(WProc, Handle, Msg, wParam, lParam);
end;
//-----------------
procedure TForm1.ExecuteParameterString(S:string);
begin
  Parameter1.Execute_Line(S);
  if Port1Changed then BitBtnSetPortClick(nil);
  if EchoPortChanged then BitBtnSetEchoPortClick(nil);
end;

procedure TForm1.TrayIcon1RightClick(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  MenuItemShowClick(Sender);
end;




procedure TForm1.ApdProtocol1ProtocolError(CP: TObject;
  ErrorCode: Integer);
begin
  LabelProtocolError.Caption:='Error';
end;

procedure TForm1.ButtonSMBusAlertClick(Sender: TObject);
begin
  SetHalfDuplex(true);
  SendString('S1901P');
end;

procedure TForm1.ButtonI2CGCAResetClick(Sender: TObject);
begin
  SetHalfDuplex(true);
  SendString('S0006'+'P');
end;

procedure TForm1.ButtonI2CSend2M5451D4Click(Sender: TObject);
  const FirstTime:boolean=true;
  var S:string;
begin
    SetHalfDuplex(true);
    if FirstTime then begin
      ButtonM5451ClearClick(Sender);
      //SendString('Y W000000000000 '); //send 6 bytes of zeros to ensure sync the first time
      FirstTime:=false;
    end;
    S:=EditI2CDigits.Text;
    if CheckBoxI2CM5451_Color.Checked  then S:=S+'.';
    SendAsciiString('Y101 '+ Str2M5451D4(S),false,true,false);
end;

procedure TForm1.ButtonGPIBCtrlCClick(Sender: TObject);
  var EntryFlowOptions: THWFlowOptionSet;
      C:ansichar;
begin
  EntryFlowOptions:=Port1.HWFlowOptions;
  Port1.HWFlowOptions:=[]; //now flow control so it WILL be sent
  C:= ansichar(3);
  Port1.PutChar(C); //^C
  if CheckBoxHalfDuplex.checked then AdTerminal1.WriteString(C);
  Port1.HWFlowOptions:=EntryFlowOptions; //restore
end;

procedure TForm1.ButtonGPIBSetupClick(Sender: TObject);
begin
  ComboBoxBaud.text:='9600';
  HardwareFlowGroup.ItemIndex:=1; //DTR/DSR
  ParityGroup.ItemIndex:=0; //none
  DataBitsGroup.ItemIndex:=0; //8 bit
  BitBtnSetPortClick(nil);

  CheckBoxHalfDuplex.Checked:=true;
  CheckBoxNewLine.Checked:=true;

  CheckBoxLF1.Checked:=true;
  CheckBoxLF2.Checked:=true;
  CheckBoxCR1.Checked:=false;
  CheckBoxCR2.Checked:=false;

  SpinEditNumTimesToSend.value:=1;
end;

procedure TForm1.ButtonGPIBRSTClick(Sender: TObject);
begin
  SendAsciiString('*RST',False,True,false);
end;

procedure TForm1.ButtonGPIBIDNClick(Sender: TObject);
begin
  SendAsciiString('*IDN?',False,True,false);
end;

procedure TForm1.ButtonGPIBTSTClick(Sender: TObject);
begin
  SendAsciiString('*TST?',False,True,false);
end;

procedure TForm1.ButtonGPIBERRClick(Sender: TObject);
begin
  SendAsciiString('SYST:ERR?',False,True,false);
end;

procedure TForm1.ButtonSend0Click(Sender: TObject);
begin
  Port1PutChar(chr(0));
end;

procedure TForm1.ButtonSend3Click(Sender: TObject);
begin
  Port1PutChar(chr(3));
end;

procedure TForm1.EditSendNumericChange(Sender: TObject);
  var S:ansistring;
      L:integer;
  procedure PutValidString;
  begin
    if ( NumericStringToChars(S) ) then begin
      Port1PutString(S);
    end;
  end; //PutValidString
begin
  S:=EditSendNumeric.text;
  L:=length(S);
  if (L>1) then begin //when a space is typed....
    case ( S[L] ) of
      ' ',',': begin
             PutValidString;
             EditSendNumeric.text:=''; //clear last value out
           end;
 {     '$': begin
             S:=copy(S,1,L-1); //remove trailing $
             PutValidString;
             EditSendNumeric.text:='$'; //clear last value out
            end;
 }     else ; //wait for more chars
    end;

  end;
end;
procedure TForm1.SendCannedString(Index:integer); //index is 0 based
begin
  if (Index<=CannedStrings.count)
    then begin
      Port1PutString(CannedStrings[Index]);
    end;
end; //SendCannedString

procedure TForm1.MenuItemSendCRLFClick(Sender: TObject);
begin
  Port1.PutString(CRLF);
end;

procedure TForm1.MenuItemSendFileClick(Sender: TObject);
begin
  ButtonSendFileClick(nil);
end;

procedure TForm1.MenuItemSendStringClick(Sender: TObject);
begin
  with Sender as TMenuItem do
    SendCannedString(Tag);
end;

procedure TForm1.SpeedButtonSpy1Click(Sender: TObject);
begin
  if SpeedButtonSpy1.Down
    then begin //try to spy
//      if SpeedButtonPort1Open.Down then begin
//        SpeedButtonPort1Open.Down:=false;
//        SpeedButtonPort1OpenClick(nil);
//      end;
//      VicCommSpy1.hook(1);

//      BitBtnSetPortClick(nil);
//      if (Port1.DeviceLayer=dlWinsock) and (Port1.WsMode=wsClient)
//        then Port1.Open:=false; //attempt to force a reconnect - ugly kludge
//      Port1.Open:=true;
      end
    else begin //button open port for spying
//      VicCommSpy1.unhook(1);
//      Port1.open:=false; //close port

//      end;
//  if Port1.Open then begin
//    AdTerminal1.enabled:=true;
//    ApdSLController1.monitoring:=true;
  end;
//  SpeedButtonSpy1.Down:=VicCommSpy1.IsHooked[1];
end;
{
procedure TForm1.VicCommSpy1Received(ComNumber: Byte; sValue: String);
//  var SaveColor:TColor;
begin
//  SaveColor:=Color4WriteChar;
  Color4WriteChar:=Color4SpyRx;
//  sleep(0);
  AdTerminal1.WriteString(sValue);
//  sleep(0);
  //Color4WriteChar:=SaveColor;
end;

procedure TForm1.VicCommSpy1Sent(ComNumber: Byte; sValue: String);
//  var SaveColor:TColor;
begin
//  SaveColor:=Color4WriteChar;
  Color4WriteChar:=Color4SpyTx;
//  sleep(0);
  AdTerminal1.WriteString(sValue);
//  sleep(0);
  //Color4WriteChar:=SaveColor;
end;
}
procedure TForm1.MenuItemCopyTerminalClick(Sender: TObject);
begin
  AdTerminal1.CopyToClipboard;
end;

procedure TForm1.MenuItemPasteTerminalClick(Sender: TObject);
begin
  AdTerminal1.PasteFromClipboard;
end;

procedure TForm1.ButtonIWrite00Click(Sender: TObject);
begin
  //IWrite('00');
  EditIData2Write.text:=EditIData2Write.text+'00 ';
end;

procedure TForm1.ButtonIWriteFFClick(Sender: TObject);
begin
  //IWrite('FF');
  EditIData2Write.text:=EditIData2Write.text+'FF ';
end;

procedure TForm1.ButtonM5451ClearClick(Sender: TObject);
begin
  SetHalfDuplex(true);
//  SendString('Y W0000000000 Y101 0000000000 '); //send 6 bytes of zeros to ensure sync, then send zeros
  SendString(ClearM5451D4Str);
end;


procedure TForm1.ButtonIWAsciiClick(Sender: TObject);
var S:string;
begin
//  EditIData2Write.text:=EditIData2Write.text+IAscii2Hex(EditIWAscii.Text, CheckboxIWCompactAscii.checked)+' ';
  //S:=ComboBoxConvertString(ComboboxIWAscii,false,CheckboxIWAsciiLiteral.checked);
  if CheckboxIWAsciiLiteral.checked
    then S:=ComboBoxConvertString(ComboboxIWAscii, sasLiteral)
    else S:=ComboBoxConvertString(ComboboxIWAscii, sasAscii);

  S:=IAscii2Hex(S, CheckboxIWCompactAscii.checked);
  EditIData2Write.text:=EditIData2Write.text+S+' ';
end;

procedure TForm1.ButtonIWClearClick(Sender: TObject);
begin
  EditIData2Write.text:='';
end;

procedure TForm1.ButtonIWByteClick(Sender: TObject);
var value:byte;
begin
  value:=byte(strtoint(StExpressionEditIW.text));
  EditIData2Write.text:=EditIData2Write.text+inttohex(value,2)+' ';
  StExpressionEditIW.text:=inttostr(value);
end;

procedure TForm1.ButtonIWWordBEClick(Sender: TObject);
var value:integer;
begin
  value:=word(strtoint(StExpressionEditIW.text));
  EditIData2Write.text:=EditIData2Write.text+inttohex(value,4)+' ';
  StExpressionEditIW.text:=inttostr(value);
end;

procedure TForm1.ButtonIWWordLEClick(Sender: TObject);
var value:integer;
    S:shortstring;
begin
  value:=word(strtoint(StExpressionEditIW.text));
  S:=inttohex(value,4);
  EditIData2Write.text:=EditIData2Write.text+S[3]+S[4]+S[1]+S[2]+' ';
  StExpressionEditIW.text:=inttostr(value);
end;

function TForm1.IWBitValue:byte;
begin
  result:=0;
  if SpeedButtonIWBit7.Down then result:=result+128 ;
  if SpeedButtonIWBit6.Down then result:=result+64 ;
  if SpeedButtonIWBit5.Down then result:=result+32 ;
  if SpeedButtonIWBit4.Down then result:=result+16 ;

  if SpeedButtonIWBit3.Down then result:=result+8 ;
  if SpeedButtonIWBit2.Down then result:=result+4 ;
  if SpeedButtonIWBit1.Down then result:=result+2 ;
  if SpeedButtonIWBit0.Down then result:=result+1 ;
end;

procedure TForm1.ButtonIWBitClearClick(Sender: TObject);
  var NewState:boolean;

begin
  NewState:= (IWBitValue=0);
  SpeedButtonIWBit7.Down:=NewState;
  SpeedButtonIWBit6.Down:=NewState;
  SpeedButtonIWBit5.Down:=NewState;
  SpeedButtonIWBit4.Down:=NewState;

  SpeedButtonIWBit3.Down:=NewState;
  SpeedButtonIWBit2.Down:=NewState;
  SpeedButtonIWBit1.Down:=NewState;
  SpeedButtonIWBit0.Down:=NewState;

end;

procedure TForm1.ButtonIWBitClick(Sender: TObject);
  var value:byte;
begin
  value:=IWBitValue;
  EditIData2Write.text:=EditIData2Write.text+inttohex(value,2)+' ';
  StExpressionEditIW.text:=inttostr(value);
end;

procedure TForm1.ButtonIWNotBitClick(Sender: TObject);
  var value:byte;
begin
  value:=255 xor IWBitValue;
  EditIData2Write.text:=EditIData2Write.text+inttohex(value,2)+' ';
  StExpressionEditIW.text:=inttostr(value);
end;
procedure RadioGroupTelnetClick(RadioGroupWsTelnet:TRadioGroup; Port: TApdWinsockPort);
  var wstold,wstnew:boolean;
begin

  wstold:= Port.WsTelnet;
  wstnew:=(RadioGroupWsTelnet.ItemIndex=1);
  Port.WsTelnet:=wstnew;
  if (Port.DeviceLayer=dlWinsock) and (Port.Open) and (wstold<>wstnew)
    then begin
      messageDlg('You need to close and reopen the port for the change to happen',
                mtWarning,[mbOK],0);
    end;
end;

procedure TForm1.RadioGroupWsTelnetClick(Sender: TObject);
begin
  RadioGroupTelnetClick(TRadioGroup(Sender),Port1);
end;
procedure TForm1.RadioGroupEchoWsTelnetClick(Sender: TObject);
begin
  RadioGroupTelnetClick(TRadioGroup(Sender),EchoPort);
end;


procedure TForm1.ComboBoxComPortDblClick(Sender: TObject);
begin
  //FormScanPorts.Show;  //not needed if using registry....
  PopulateComNumbers(PortScanLastPort,true);
  ComboBoxComPort.DroppedDown:=true;
end;

procedure TForm1.ComboBoxComPortDropDown(Sender: TObject);
begin
  PopulateComNumbers(PortScanLastPort,true);
end;

procedure TForm1.ComboBoxComPortSelect(Sender: TObject);
  var CB:TComboBox;
begin
  CB:=TComboBox(Sender);
  case (CB.Items.Count-CB.ItemIndex) of
    1: begin
        PopulateComNumbers(PortScanLastPort,true,true); //exhaustive Search
        CB.ItemIndex:=0;
        CB.DroppedDown:=true;
        end;
    2: begin
        PopulateComNumbers(PortScanLastPort,true);
        CB.ItemIndex:=0;
        CB.DroppedDown:=true;
      end;
    3: begin   //CLEAR
        CB.Text:=CB.Items[0]; //Text has been lost to [CLEAR], but what was in Text should be at top of list
        CB.ClearExcept(0,4); //keep actions at end
        CB.ItemIndex:=0;
        CB.DroppedDown:=true; //and leave it open to
      end;
    4: begin
         ShellExecute(Handle, 'open','devmgmt.msc',nil,nil, SW_SHOWNORMAL);
       end;
    else //Its a port name not an action
      BitBtnSetPortClick(nil); //press Change button
    end; //case
end;

procedure TForm1.ComboBoxCRCChange(Sender: TObject);
begin
  CRCType2UI(); //gray controls
end;

procedure TForm1.CommSpy1Received(CommIndex: Byte; Data: ansiString;
  Info: Cardinal);
begin
  Color4WriteChar:=Color4SpyRx;
  AdTerminal1.WriteStringSource(Data,csPort);
end;

procedure TForm1.CommSpy1Sent(CommIndex: Byte; Data: ansiString;
  Info: Cardinal);
begin
  Color4WriteChar:=Color4SpyTx;
  AdTerminal1.WriteStringSource(Data,csKeyboard);
end;


procedure TForm1.CheckboxScrollbackClick(Sender: TObject);
begin
  AdTerminal1.Scrollback:=CheckboxScrollback.checked;
  SpinEditScrollbackRows.Visible:=CheckboxScrollback.checked;
  if CheckboxScrollback.checked
    and (SpinEditScrollbackRows.value<>AdTerminal1.ScrollbackRows)then begin
      SpinEditScrollbackRows.value:=AdTerminal1.ScrollbackRows;
      //AdTerminal1.ScrollbackRows:=SpinEditScrollbackRows.value;
  end;
end;

{procedure TForm1.LabelI2CChipClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open',
  'http://www.i2cchip.com',nil,nil, SW_SHOWNORMAL);
end;}
procedure TForm1.HTMLClick(Link:string);
begin
  ShellExecute(Handle, 'open', PChar(Link), nil,nil, SW_SHOWNORMAL);
end;
procedure TForm1.LabelHTMLClick(Sender: TObject);
begin
  HTMLClick((Sender as TLabel).Caption);
end;
procedure TForm1.LinkLabelHTMLClick(Sender: TObject; const Link: string;
  LinkType: TSysLinkType);
begin
  HTMLClick(Link);
end;
procedure TForm1.Donate(From:string='MN');//from
  var Link:string;
begin
//  Link:=LinkLabelDonate.Caption;
  Link:='https://www.paypal.com/cgi-bin/webscr?';
  Link:=Link+'item_name=Donation+to+support+RealTerm+Development';
  //Link:=Link+'&item_number='+AFVersionCaption1.info;
  Link:=Link+'&cmd=_donations';
  Link:=Link+'&business=RealtermDonations%40i2cchip.com';
  Link:=Link+'&custom=V'+rtUpdate.CurrentVersion ;
  Link:=Link+'_'+rtUpdate.RunInfoStr(true);
  Link:=Link+'&bn=Realterm_Donate_WPS_NZ';
  Link:=Link+'&on0=RunCount&os0='+inttostr(rtUpdate.RunCount);
  Link:=Link+'&on1=RunHours&os1='+rtUpdate.RunHoursStr(true);
  Link:=Link+'&on2=Version&os2='+rtUpdate.CurrentVersion;
  Link:=Link+'&on3=From&os3='+From;
  HTMLClick(Link);
end;
procedure TForm1.MenuItemDonateClick(Sender: TObject);
begin
  Donate('MN');
end;
procedure TForm1.DonateLabelHTMLClick(Sender: TObject;  const Link: string;
  LinkType: TSysLinkType);
begin
  Donate('LK');
end;

procedure TForm1.AllHelp(JustLinks:boolean=false);
begin
  ShellExecute(Handle, 'open',
  'http://realterm.sourceforge.net',nil,nil, SW_SHOWNORMAL);
  ShellExecute(Handle, 'open',
  'https://sourceforge.net/p/realterm/news/',nil,nil, SW_SHOWNORMAL);
  //writeln('F1 is the help key');
  if not JustLinks then begin
    ShellExecute(Handle, 'open',
      pwidechar(ExpandEnvVars('file://%ProgramFiles%\BEL\Realterm\change_log.txt')),
      nil,nil, SW_SHOWNORMAL);
    ShowForm(AboutBox, true);//.showmodal;
  end;
end;

procedure TForm1.AllHelpClick(Sender: TObject);
begin
  AllHelp;
end;


procedure TForm1.SHT(S:ansistring);
  const FirstTime:boolean=true;
begin
    if FirstTime then begin
       SetHalfDuplex(true);
    end;
    if FirstTime or (S='')
      then begin
        SendAsciiString('PY1WFFFFP',false,true,false); //send the clear string
    end;
    FirstTime:=false;
    SendAsciiString(S,false,true,false);
end;
function SHTStr(command,delay,WriteData:ansistring;NRead:cardinal):ansistring;
  var PreambleStr,CRCStr,WrAckStr:ansistring;
begin
  case (1+Form1.RadioGroupBusNum.ItemIndex) of
  1,5: PreambleStr:= 'O00FD00FC00FD00FF00FE00FC';
  2,6: PreambleStr:= 'O 00F7 00F3 00F7 00FF 00FB 00F3';
  3,7: PreambleStr:= 'O 007F 003F 007F 00FF 00BF 003F';
  else showmessage('Preamble string only done for Bus1-3. Using Bus 1 string...')
  end; //case

  if Form1.CheckBoxSHTCRC.Checked
    then CRCStr:='YR01Y1W00'
    else CRCStr:='';
  if Form1.CheckboxSHTWrHideAck.Checked
    then WrAckStr:='Y1W01'
    else WrAckStr:='Y1R01';

  result:=PreambleStr+'YW'+command+WrAckStr;

  if Writedata<>''
    then result:=result+'YW'+WriteData+WrAckStr;

  case NRead of
    0: ;
    1: result:=result+'L'+delay+CRCStr+'YR01Y1WFF';
    2: result:=result+'L'+delay+'YR01Y1W00'+CRCStr+'YR01Y1WFF';
    else
      result:='??????????????????';
  end; //case

  result:=result+'P';
  //result:=PreambleStr+'YW'+command+'Y1R01L'+delay+'YR01Y1W00'+CRCStr+'YR01Y1WFFP';
end;

procedure TForm1.ButtonSHTClearClick(Sender: TObject);
begin
  SHT('');
end;

procedure TForm1.ButtonSHTReadTempClick(Sender: TObject);
begin
    SHT(SHTStr('03','0100','',2));
end;
procedure TForm1.ButtonSHTReadHumidityClick(Sender: TObject);
begin
  //SHT(SHTPreambleStr+'YW05Y1R01L0050YR01Y1W00YR01Y1WFFP');
  SHT(SHTStr('05','0050','',2));

end;

procedure TForm1.ButtonSHTReadStatusClick(Sender: TObject);
begin
  SHT(SHTStr('07','0100','',1));
end;

procedure TForm1.ButtonSHTSoftResetClick(Sender: TObject);
begin
  SHT(SHTStr('1E','0100','',0));
end;

procedure TForm1.ButtonSHTWriteStatusClick(Sender: TObject);
begin
  SHT(SHTStr('06','0000',EditSHTStatus.Text,0));
end;

procedure TForm1.CheckBoxTraceHexClick(Sender: TObject);
begin
  Port1.TraceHex:=CheckboxTraceHex.Checked;
end;

procedure TForm1.CheckBoxLogHexClick(Sender: TObject);
begin
  Port1.LogHex:=CheckboxLogHex.Checked;
end;

procedure TForm1.ButtonIWriteThenReadClick(Sender: TObject);
//var Address:byte;
begin
  IWriteThenRead(LabeledEditIWriteB4Data.Text,SpinEditIBytes2Read2.value);
{  SetHalfDuplex(true);
  Address:=GetI2CAddress;
  Address:=Address and $FE;
  SendString('S'+inttohex(Address,2)+LabeledEditIWriteB4Data.Text +'R'+inttohex(SpinEditIBytes2Read.value,2)+'P');
}
end;

procedure TForm1.SpeedButtonEditDataPacketFormattedClick(Sender: TObject);
begin
  EditPacket(ApdDataPacketFormatted ,'Hex Formatted Packet Settings');
end;

procedure TForm1.SpeedButtonBL301ClearLedButtonsClick(Sender: TObject);
  var NewState:boolean;
begin
  NewState:= (BL301LedBitValue=0);
  SpeedButtonBL301Leds7.Down:=NewState;
  SpeedButtonBL301Leds6.Down:=NewState;
  SpeedButtonBL301Leds5.Down:=NewState;
  SpeedButtonBL301Leds4.Down:=NewState;

  SpeedButtonBL301Leds3.Down:=NewState;
  SpeedButtonBL301Leds2.Down:=NewState;
  SpeedButtonBL301Leds1.Down:=NewState;
  SpeedButtonBL301Leds0.Down:=NewState;

end;

function TForm1.BL301LEDBitValue:byte;
begin
  result:=0;
  if SpeedButtonBL301Leds7.Down then result:=result+128 ;
  if SpeedButtonBL301Leds6.Down then result:=result+64 ;
  if SpeedButtonBL301Leds5.Down then result:=result+32 ;
  if SpeedButtonBL301Leds4.Down then result:=result+16 ;

  if SpeedButtonBL301Leds3.Down then result:=result+8 ;
  if SpeedButtonBL301Leds2.Down then result:=result+4 ;
  if SpeedButtonBL301Leds1.Down then result:=result+2 ;
  if SpeedButtonBL301Leds0.Down then result:=result+1 ;
end;

procedure TForm1.ButtonBL301WriteAscii2LCDClick(Sender: TObject);
 var S:string;
begin
  SetIAddress_BL301;
  S:=ComboBoxConvertString(ComboboxBL301Ascii,SendAsAsciiOrLiteral(CheckboxBL301AsciiLiteral.checked));
  S:=IAscii2Hex(S, false);
  IWrite(S);
end;


procedure TForm1.ButtonBL301InitLCDClick(Sender: TObject);
begin
  SetIAddress_BL301;
  IWrite('C0');
end;



procedure TForm1.ButtonBL301SetContrastClick(Sender: TObject);
begin
    IWrite('F0'+inttohex(SpinEditBL301Contrast.Value,2));
end;

procedure TForm1.ButtonBL301SetLedsClick(Sender: TObject);
begin
  SetIAddress_BL301;
  IWrite('F2'+inttohex(BL301LEDBitValue,2));
end;

procedure TForm1.ButtonBL301ReadSwitchesClick(Sender: TObject);
begin
  SetIAddress_BL301;
  IWriteThenRead('F1',1);
end;
procedure TForm1.ButtonBL301MInitClick(Sender: TObject);
begin
  SetIAddress_BL301;
  SetIAddress_BL301;
  IWrite('D0');
end;
procedure TForm1.ButtonBL301MAsciiClick(Sender: TObject);
 var S:string;
begin
  SetIAddress_BL301;
  S:=ComboBoxConvertString(ComboboxBL301MString,SendAsAsciiOrLiteral(CheckboxBL301AsciiLiteral));
  S:=IAscii2Hex(S, false);
  IWrite('E'+inttohex(SpinEditBL301MNumDisplay.Value,1)+'00'+S);
end;

var SSS:string;
procedure TForm1.ButtonASC7511LocalClick(Sender: TObject);
//var ET:EventTimer;
//var i:word;
begin
  SetIAddress_aSC7511;
  label9.Caption:='-';
  Port1.TriggerLength:=1;
  IWriteThenRead('00',1); //high byte
  IWriteThenRead('15',1); //low byte

  sleep(500);
  Port1.ProcessCommunications;
  //while Port1.CharReady do begin
    //SSS:=SSS+Port1.GetChar;
  //end;
  //NewTimer(ET,10);
  //repeat
    //Port1.ProcessCommunications;
  //until TimerExpired(ET);
  //label9.Caption:=inttostr(Port1.InBuffUsed);
//  label27.Caption:=inttostr(Port1.InBuffUsed);
  label27.Caption:=SSS;
end;

procedure TForm1.ButtonASC7511RemoteClick(Sender: TObject);
begin
  SetIAddress_aSC7511;
  IWriteThenRead('01',1); //hi byte
  IWriteThenRead('10',1); //low byte
end;

procedure TForm1.ButtonASC7511StatusClick(Sender: TObject);
begin
  SetIAddress_aSC7511;
  IWriteThenRead('02',1);
end;

procedure TForm1.Button1WireCheckPresenceClick(Sender: TObject);
begin
  SetHalfDuplex(true);
  SendAsciiString(':S?',false,true,true);
end;

procedure TForm1.ButtonASC7511ConfigClick(Sender: TObject);
begin
  SetIAddress_aSC7511;
  IWriteThenRead('03',1);
end;

procedure TForm1.ButtonASC7511RateClick(Sender: TObject);
begin
  SetIAddress_aSC7511;
  IWriteThenRead('04',1);

end;
//type
{procedure GetChars(N:Word; MaxMS:word)
begin
  Sleep(WaitMs); //wait for the data to arrive...
  Port1.TriggerLength:=N;

end; }
procedure TForm1.Port1TriggerAvail(CP: TObject; Count: Word);
const CharCount:integer=0;
var i:word;
begin
  //CharCount:=Charcount+Count;
  IncCharCount(Count);
  label9.Caption:=inttostr(count)+' '+inttostr(Port1.InBuffUsed)+' '+inttostr(CharCount);
  for i:=1 to Count do begin
    //SSS:=SSS+Port1.GetChar;
  end
end;

procedure TForm1.SpiCSButtonClick(Sender:TObject; CommandStr:ansistring);
 procedure ButtonHighlight(Button:TButton; Highlight:boolean);
 begin
   if Highlight
     then begin
       Button.Font.Color:=clLime;
       Button.Font.Style:=[fsBold];
       end
     else begin
       Button.Font.Color:=clBtnFace;
       Button.Font.Style:=[];
     end;
 end;
begin
  SendAsciiString(commandStr,false,true,true);
  ButtonHighlight(ButtonSpiCS00,false);
  ButtonHighlight(ButtonSpiCS01,false);
  ButtonHighlight(ButtonSpiCS10,false);
  ButtonHighlight(ButtonSpiCS11,false);

  ButtonHighlight(Sender as TButton,true);
end;

procedure TForm1.ButtonSpiCSInitClick(Sender: TObject);
begin
  ButtonSpiCS00.Enabled:=true;
  ButtonSpiCS01.Enabled:=true;
  ButtonSpiCS10.Enabled:=true;
  ButtonSpiCS11.Enabled:=true;

  SetHalfDuplex(true);
  SpiCSButtonClick(ButtonSpiCS11, 'PO30CF');
end;

procedure TForm1.ButtonSpiCS00Click(Sender: TObject);
begin
  SpiCsButtonClick(Sender,'O00');
end;

 procedure TForm1.ButtonSpiCS01Click(Sender: TObject);
begin
  SpiCsButtonClick(Sender,'O20');
end;

procedure TForm1.ButtonSpiCS10Click(Sender: TObject);
begin
  SpiCsButtonClick(Sender,'O10');
end;

procedure TForm1.ButtonSpiCS11Click(Sender: TObject);
begin
  SpiCsButtonClick(Sender,'O30');
end;
function Get1WireRomIDCommandString:string;
  var L:integer;
begin
  result:='CC';//skip rom command is default
  with Form1 do begin
  if CheckBox1WireUseRomID.checked
    then begin
      L:=length(ComboBox1WireRomID.Text);
      if L=16
        then begin
          result:='55'+ComboBox1WireRomID.Text;
          ComboBox1WireRomID.PutStringAtTop(100);
        end
        else showmessage('1Wire Rom ID must be 16 Hex characters not '+inttostr(L)+CRLF
                         +ComboBox1WireRomID.Text+CRLF+CRLF
                         +'Get it using Read Rom ID button');
    end;
  end;//with
end;
procedure TForm1.ButtonIRead1WireDS1820Click(Sender: TObject);
var RomID:string;
begin
  SetHalfDuplex(true);
  RomID:= 'SW'+Get1WireRomIDCommandString;
  SendAsciiString(RomID+'44 L0400 '+RomID+'BE R02',false,true,true);
end;

procedure TForm1.Button1WireDS2450ReadADCClick(Sender: TObject);
var RomID:string;
begin
  SetHalfDuplex(true);
  RomID:= 'SW'+Get1WireRomIDCommandString;
  //untested: might need a read of 2 crc bytes after convert command ie 3C 0F00 R02
  SendAsciiString(RomID+'3C 0F00 L0004'+RomID+'AA 0000 R08',false,true,true);
end;



procedure TForm1.SpinEditScaleDblClick(Sender: TObject);
begin
  FormScale(0);  //autoscale
  TSpinedit(sender).value:=fScale; //and show it....
end;

procedure TForm1.SpinEditScrollbackRowsChange(Sender: TObject);
var SaveEmulator: TAdTerminalEmulator;
begin
//  AdTerminal1.Active:=false;
//  AdTerminal1.enabled:=false;
//  AdTerminal1.Scrollback:=false;
//  SaveEmulator:=AdTerminal1.Emulator;
//  AdTerminal1.Emulator:=nil;

  if SpinEditScrollbackRows.value<AdTerminal1.Rows
    then begin
      AdTerminal1.ScrollbackRows:=AdTerminal1.Rows;
      SpinEditScrollbackRows.value:=AdTerminal1.Rows;
    end
    else begin
      AdTerminal1.ScrollbackRows:=SpinEditScrollbackRows.value;
    end;
//  AdTerminal1.Emulator:=SaveEmulator;
//  AdTerminal1.Scrollback:=true;
//  AdTerminal1.Enabled:=true;
//  AdTerminal1.Active:=true;
end;

procedure TForm1.RadioGroupPCA9544BusNumClick(Sender: TObject);
begin
  SetIAddress_PCA9544;
  if (RadioGroupPCA9544BusNum.ItemIndex=0)
    then IWrite('00')
    else IWrite(inttohex(RadioGroupPCA9544BusNum.ItemIndex-1+4,2));
end;

procedure TForm1.ButtonPCA9544StatusClick(Sender: TObject);
begin
  SetIAddress_PCA9544;
  IRead(1);
end;


procedure TForm1.TabSheetI2CShow(Sender: TObject);
begin
  //Throws errors with GroupBoxIAddress, but not with new box with same controls inside
  //GroupBoxIAddress.Visible:=false;
  //GroupBoxIAddress.Enabled:=false;
  //GroupBoxIAddress.Parent:= nil;
  //GroupBoxIAddress.Parent:=TabSheetI2C2.Parent;//(Sender as TTabsheet);
  //GroupBox9.Parent:= TabSheetI2C2;
  {if Sender=TabSheetI2C
    then begin
    end;                   }

end;

procedure TForm1.ButtonChangeTraceFNameClick(Sender: TObject);
  var SaveTraceState, SaveLogState: TTraceLogState;
begin
  SaveTraceState:=Port1.Tracing;
  SaveLogState:=Port1.Logging;
  Port1.Tracing:=tlOff;
  Port1.Logging:=tlOff;

  Port1.TraceName:=forceextensionL(ComboBoxTraceFName.text,'trc');
  ComboBoxTraceFname.Text:=Port1.LogName ; //update coerced string
  Port1.LogName:=forceextensionL(ComboBoxTraceFName.text,'log');
  ButtonChangeTraceFName.Visible:=false;
  ComboBoxTraceFName.PutStringAtTop(10);
  ComboBoxTraceFName.SetFilenameCheckPathExists;

  Port1.Tracing:=SaveTraceState;
  Port1.Logging:= SaveLogState;
end;

procedure PortMomentaryChangeTraceLogState(Port:TApdWinsockPort; S:TTraceLogState);
var SaveTraceState, SaveLogState: TTraceLogState;
begin
  SaveTraceState:=Port.Tracing;
  SaveLogState:=Port.Logging;
  Port.Tracing:=S;
  Port.Logging:=S;
  Port.Tracing:=SaveTraceState;
  Port.Logging:= SaveLogState;

end;
procedure TForm1.ButtonClearTraceLogClick(Sender: TObject);
  //var SaveTraceState, SaveLogState: TTraceLogState;
begin
  PortMomentaryChangeTraceLogState(Port1,tlClear);
//  SaveTraceState:=Port1.Tracing;
//  SaveLogState:=Port1.Logging;
//  Port1.Tracing:=tlClear;
//  Port1.Logging:=tlClear;
//  Port1.Tracing:=SaveTraceState;
//  Port1.Logging:= SaveLogState;
end;

procedure TForm1.ButtonDumpTraceLogClick(Sender: TObject);
  //var SaveTraceState, SaveLogState: TTraceLogState;
begin
  PortMomentaryChangeTraceLogState(Port1,tlDump);
//  SaveTraceState:=Port1.Tracing;
//  SaveLogState:=Port1.Logging;
//  Port1.Tracing:=tlDump;
//  Port1.Logging:=tlDump;
//  Port1.Tracing:=SaveTraceState;
//  Port1.Logging:= SaveLogState;
end;

//procedure TForm1.ButtonUser1Click(Sender: TObject);
//begin
//  SendTabSendAsciiString(comboboxconvertstring(ComboBoxSend1,false,CheckBoxLiteralStrings.Checked),CheckBoxCR1.Checked,CheckBoxLF1.Checked,CheckBoxStripSpaces.Checked);
//end;

procedure TForm1.ButtonWriteINIFileClick(Sender: TObject);
//  var S:string;
begin
  //MakeINIParameterFile();
  //ClearStayOnTop;
  ShowForm(ParameterINIDlg, false); //.show;
end;

{function TForm1.FormHelp(Command: Word; Data: Integer;
  var CallHelp: Boolean): Boolean;
begin
  CallHelp:=false;
  Help1Click(nil);
  //showmessage(form1.HelpFile);
end; }

procedure TForm1.ButtonBSEnterATClick(Sender: TObject);
begin
  SendAsciiString('+++',true,false,false);
end;

procedure TForm1.ButtonBSExitATClick(Sender: TObject);
begin
  SendAsciiString('ATMD',true,false,false);
end;

procedure TForm1.ButtonBSFastModeClick(Sender: TObject);
begin
  SendAsciiString('ATMF',true,false,false);
end;


procedure TForm1.ButtonBSBaudClick(Sender: TObject);
procedure BSSetBaud;
  procedure PutASTW(Baud:integer);
  begin
    Baud:=round(Baud*0.004096);
    SendAsciiString('ATSW20,'+inttostr(Baud)+',0,0,1',true,false,false);
  end;
  function ActualBaud(Baud:integer):integer;
    var BaudNumber:integer;
  begin
    BaudNumber:=round(Baud*0.004096);
    result:= round(BaudNumber/0.004096);
  end;
  var baud:integer;
begin
  try
{    if ComboboxBSBaud.ItemIndex>=1
      then ComboboxBSBaud.Text:=ComboboxBSBaud.Items[ComboboxBSBaud.ItemIndex];
    baud:=strtoint(ComboBoxBSBaud.text); }
    if ComboboxBSBaud.ItemIndex>=0
      then baud:=strtoint(ComboboxBSBaud.Items[ComboboxBSBaud.ItemIndex])
      else baud:=strtoint(ComboBoxBSBaud.text);
    PutASTW(baud);
    ComboBoxBSBaud.PutStringAtTop(20); //only if baud string was valid
    //ComboBoxBSBaud.Text:=inttostr(ActualBaud(Baud));
  except
  end; //try
end;
begin
  BSSetBaud;
end;

procedure TForm1.ButtonBSQueryBaudClick(Sender: TObject);
begin
  SendAsciiString('ATSI,8',true,false,false);
  //returned value is the stored count number in HEX. Multiply by 244 to get actual baud rate
end;

procedure TForm1.ButtonBSRSSIClick(Sender: TObject);
begin
  SendAsciiString('ATRSSI',true,false,false);
end;

procedure TForm1.ButtonBSParkClick(Sender: TObject);
begin
  SendAsciiString('ATPARK',true,false,false);
end;



procedure TForm1.ButtonSendLFClick(Sender: TObject);
begin
  Port1PutChar(chr($0A));
end;

procedure TForm1.ButtonMax127ReadClick(Sender: TObject);
  var Command:byte;
//      S:string;
begin
  SetIAddress_MAX127;
  Command:= 128+ (SpinEditMax127Channel.Value*16)+(RadioGroupMax127Range.ItemIndex*4);
  IWrite(inttohex(Command,2)+'P R02');
end;

procedure TForm1.RadioGroupSendEventClick(Sender: TObject);

begin

  if ComServer.StartMode=smAutomation then
  begin
    RTI.SendEvent(RadioGroupSendEvent.ItemIndex);
  end ;
  RadioGroupSendEvent.ItemIndex:=0;
end;

procedure TForm1.StatusBarHintTimeStampNow(ShowCaptureTimeStamp:boolean=true);
  //var S:string;
begin
  if ShowCaptureTimeStamp
    then StatusBarHint:=TimeStampStr(RadioGroupTimeStamp.ItemIndex,now,ComboboxTimeStampFormat.Text)
    else StatusBarHint:=TimeStampStr(-1,now,ComboboxDisplayTimeStampFormat.Text);
end;
procedure TForm1.RadioGroupTimeStampClick(Sender: TObject);
begin
  StatusBarHintTimeStampNow;
end;

procedure TForm1.RadioGroupTimeStampContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  ComboboxTimeStampFormat.Visible := not ComboboxTimeStampFormat.Visible;
  if ComboboxTimeStampFormat.Visible then ComboboxTimeStampFormat.SetFocus;
  Handled:=true;
  StatusBarHintTimeStampNow;
end;


procedure TForm1.RadioButtonTimeStampDummyDblClick(Sender: TObject);
begin
  ComboboxTimeStampFormat.Visible:= not ComboboxTimeStampFormat.Visible;
  StatusBarHintTimeStampNow;
end;
procedure TForm1.ComboBoxExitCheckPath(Sender: TObject);
begin
  TCombobox(Sender).SetFilenameCheckPathExists();
end;
procedure TForm1.ComboBoxExitCheckFileExists(Sender: TObject);
begin
  TCombobox(Sender).SetFilenameCheckPathExists();
  CBBigSize(ComboBoxCapturePostFName,false);
end;

procedure TForm1.ComboBoxSendFNameExit(Sender: TObject);
begin
  SendFileList.SetFilenames(TCombobox(Sender));
  TCombobox(Sender).RightJustify;
end;

procedure TForm1.ComboBoxTimeStampFormatChange(Sender: TObject);
begin
  StatusBarHintTimeStampNow(Sender=ComboboxTimeStampFormat);
end;

procedure TForm1.ComboBoxTimeStampFormatExit(Sender: TObject);
begin
  TCombobox(Sender).PutStringAtTop;
  TCombobox(Sender).Visible:=false;
  StatusBarHintTimeStampNow(Sender=ComboboxTimeStampFormat);
end;

procedure TForm1.CheckBoxDirectCaptureClick(Sender: TObject);
begin
  PanelSpecialCapture.Visible:= (CheckBoxDirectCapture.Checked);
  CheckBoxCaptureDisplay.Enabled:=CheckBoxDirectCapture.Checked;
  CheckBoxCaptureRestart.Enabled:=CheckBoxDirectCapture.Checked;
end;

procedure TForm1.CheckBoxDisplayTimeStampClick(Sender: TObject);
begin
  if CheckboxDisplayTimeStamp.checked then StatusBarHintTimeStampNow(false);
  //if ComboboxDisplayTimeStampFormat.Visible then ComboboxDisplayTimeStampFormat.Visible:=false;
end;

procedure TForm1.CheckBoxRxdIdleContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  SpinEditRxdIdle.Visible:= not SpinEditRxdIdle.Visible;
  if SpinEditRxdIdle.Visible then SpinEditRxdIdle.SetFocus;
  Handled:=true;
end;
procedure TForm1.CheckBoxDisplayTimeStampContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  ComboBoxDisplayTimeStampFormat.Visible:= not ComboBoxDisplayTimeStampFormat.Visible;
  if ComboBoxDisplayTimeStampFormat.Visible then ComboBoxDisplayTimeStampFormat.SetFocus;
  Handled:=true;
end;
procedure TForm1.ButtonEditCaptureClick(Sender: TObject);
var cline:string;
begin
  cline:=QuoteFileName(ExpandEnvVars(ComboboxSaveFName.text));
  ShellExecute(Handle, 'edit', PChar(cline), nil,nil, SW_SHOWNORMAL);
end;

procedure TForm1.ButtonEditDataTrigger1Click(Sender: TObject);
begin
  //SetDataTriggerLight;
  EditPacket(ApdDataPacket1,'Data Trigger 1');
  ApdDataPacket1.Enabled:=CheckboxDataTrigger1.Checked; //overwrite whatever the editor did, as it seems to leave it not responding
end;

procedure TForm1.CheckBoxDataTrigger1Click(Sender: TObject);
begin
  ApdDataPacket1.Enabled:= CheckBoxDataTrigger1.checked;
end;
procedure TForm1.ApdDataPacket1Packet(Sender: TObject; Data: Pointer;
  Size: Integer);
  var S:ansistring;
begin
  SetDataTriggerLight(true);
  //CheckboxDataTrigger1.Checked:=ApdDataPacket1.Enabled;
  if RTI<>nil
    then begin
        RTI.SendEventOnDataTrigger(1,ApdDataPacket1);
    end
    else begin
      ApdDataPacket1.GetCollectedString(S);
      LabeledEditDataTriggerLastString1.Text:=S;
      StatusBarFormattedData.SimpleText:=S;
    end;
end;

procedure SetCheckbox(C:TCheckbox; Checked:boolean);
var OnClickEvent: TNotifyEvent;
begin
  OnClickEvent:=C.OnClick;
  C.OnClick:=nil;
  C.Checked:=Checked;
  C.OnClick:=OnClickEvent;
end;

procedure TForm1.ApdDataPacket1Timeout(Sender: TObject);
  const TimeoutMsg='Data Trigger Timed-Out';
begin
  SetDataTriggerLight(false);
  SetCheckbox(CheckboxDataTrigger1,false);
  if RTI<>nil
    then begin
        RTI.SendEventOnDataTimeout(1,ApdDataPacket1);
    end
    else begin
      LabeledEditDataTriggerLastString1.Text:=TimeoutMsg;
      StatusBarFormattedData.SimpleText:=TimeoutMsg;
    end;
end;
procedure TForm1.StatusBar1DblClick(Sender: TObject);
begin
  StatusBar1.SimplePanel:=not StatusBar1.SimplePanel;
  if StatusBar1.SimplePanel
    then StatusBar1.Hint:='Doubleclick here to toggle Status information'
    else StatusBar1.Hint:='Doubleclick here to toggle extended Help';
end;

procedure TForm1.StatusBar1DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
  const Rect: TRect);
begin
  if Panel.Index = 0 then begin
 //StatusBar.Canvas.Font.Name := 'Times New Roman';
 StatusBar.Canvas.Font.Color := clRed;
 //StatusBar.Canvas.Font.Size := 12;
 if length(StatusBar.Panels[0].Text)=0 then
  StatusBar.Canvas.TextRect(Rect,Rect.Left,Rect.Top, 'Update Available V3.0.0.29');
 end;

end;

procedure TForm1.ButtonBL233_BitBashIdleClick(Sender: TObject);
begin
  SetHalfDuplex(true);
  SendAsciiString('O 00 FF ',false,true,true);
  SpeedButtonP0.Down:=false;
  SpeedButtonP1.Down:=false;
  SpeedButtonP2.Down:=false;
  SpeedButtonP3.Down:=false;
  SpeedButtonP4.Down:=false;
  SpeedButtonP5.Down:=false;
  SpeedButtonP6.Down:=false;
  SpeedButtonP7.Down:=false;

end;
{ Attempt to add CRLF key.

  if AdTerminal1.Emulator.KeyboardMapping=nil then begin
      //exit;
      AdTerminal1.Emulator.KeyboardMapping.Create;
  end;
  AdTerminal1.Active:=false;
  AdTerminal1.Emulator.KeyboardMapping.Add('\x0D','VK_RETURN');
  AdTerminal1.Emulator.KeyboardMapping.Add('shift+VK_RETURN','DEC_CRLF');
  AdTerminal1.Emulator.KeyboardMapping.Add('shift+VK_EXECUTE','DEC_CRLF');
  AdTerminal1.Emulator.KeyboardMapping.Add('DEC_CRLF','\0x0D\0x0A');
  AdTerminal1.Active:=true;
}

procedure TForm1.ApdDataPacketFormattedStringPacket(Sender: TObject;
  Data: AnsiString);
  var SFormatted:ansistring;
begin
  //StatusBarFormattedData.SimpleText:=Data;
  SFormatted:=ConvertDelimitedHexStr2Dec(Data, true, false, ComboBoxHexCSVFormat.text);
  if RadioGroupHexCSVTerminalShows.ItemIndex=0
    then AdTerminal1.WriteStringSource(SFormatted,csUnknown);      // csWriteChar
  StatusBarFormattedData.SimpleText:=SFormatted;
end;



procedure TForm1.ApdDataPacketI2CPacket(Sender: TObject; Data: Pointer;
  Size: Integer);
  var S:ansistring;
begin
  ApdDataPacketI2C.GetCollectedString(S);
  StatusBarFormattedData.SimpleText:=S;
end;

procedure TForm1.ApdDataPacketI2CStringPacket(Sender: TObject;
  Data: AnsiString);
begin
  StatusBarFormattedData.SimpleText:=Data;
end;

procedure TForm1.LabelApdStatusTXDDblClick(Sender: TObject);
begin
  Port1.SendBreak(10,true);
end;

procedure TForm1.PanelBaud1DblClick(Sender: TObject);
begin
  ComboBoxBaudMult.Visible:= not ComboBoxBaudMult.Visible;
end;





procedure TForm1.CheckBoxCaptureDisplayClick(Sender: TObject);
begin
  if self.CaptureMode<>cmOff then begin //only change during capturing
    AdTerminal1.Active:=CheckBoxCaptureDisplay.Checked;
  end;
end;



procedure TForm1.CheckBoxCaptureEOLContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  ComboBoxCaptureEOLChar.Visible:=true;
  if ComboBoxCaptureEOLChar.Visible then ComboBoxCaptureEOLChar.SetFocus;
  Handled:=true;
end;

procedure TForm1.CheckBoxCRCClick(Sender: TObject);
begin
  //TCheckBox(Sender).Checked;
  CRCType2UI(); //gray controls
end;

procedure TForm1.CheckBoxCRLFClick(Sender: TObject);
begin
  AdEmulator_Hex.ReturnKeySendsCRLF:=CheckBoxCRLF.Checked;
  AdShowAllEmulator.ReturnKeySendsCRLF:=CheckBoxCRLF.Checked;
end;

procedure TForm1.ButtonPCA9545StatusClick(Sender: TObject);
begin
  SetIAddress_PCA9545;
  IRead(1);
end;

const PHONE_SEND_LF=true;
procedure TForm1.ButtonPhoneSendCaptionClick(Sender: TObject);
begin
  CheckBoxHalfDuplex.Checked:=true;
  if assigned(Sender) then
    SendAsciiString(TButton(Sender).Caption,true,PHONE_SEND_LF,false);
end;

procedure TForm1.ButtonPhoneExitATModeClick(Sender: TObject);
begin
  CheckBoxHalfDuplex.Checked:=true;
  SendAsciiString('ATMD',true,PHONE_SEND_LF,false);
end;

procedure TForm1.CheckBox1WireUseRomIDClick(Sender: TObject);
begin
  ComboBox1WireRomID.Enabled:= CheckBox1WireUseRomID.Checked;
end;

procedure TForm1.CheckBox9545_BusXClick(Sender: TObject);
  var B:byte;
begin
    SetIAddress_PCA9545;
    B:=0;
    if CheckBox9545_Bus0.Checked then B:=B+ 1;
    if CheckBox9545_Bus1.Checked then B:=B+ 2;
    if CheckBox9545_Bus2.Checked then B:=B+ 4;
    if CheckBox9545_Bus3.Checked then B:=B+ 8;
    //CheckBox9545_AllOff.Checked:=(B=0);
    IWrite(inttohex(B,2));
end;
procedure TForm1.SendBreak1Click(Sender: TObject);
begin
  Port1.SendBreak(1,true);
end;

procedure TForm1.C1Click(Sender: TObject);
begin
  //Port1.PutChar(char(3));
  Port1PutChar(chr(3)); //echos to terminal in half duplex
end;

procedure TForm1.ButtonI2CTestM5451Click(Sender: TObject);
  const FirstTime:boolean=true;
  var i,digit,displaycolor:integer;
   S:ansistring;
   procedure SendString(S:ansistring);
   begin
     if displaycolor=2 then S:=S+'.';
     with Sender as TButton do begin

 //      if displaycolor=1   //appears that we can't actually change the text color in practice
 //        then Font.Color:=clLime
 //        else Font.Color:=clRed;
       Caption:=S;
       Update;
      end; //with
     SendAsciiString('Y101 '+ Str2M5451D4(S),false,true,false);
     sleep(330);
   end;
begin
    SetHalfDuplex(true);
    if FirstTime then begin
      ButtonM5451ClearClick(Sender);
      //SendString('Y W000000000000 '); //send 6 bytes of zeros to ensure sync the first time
      FirstTime:=false;
    end;
    for displaycolor:=1 to 2 do begin
    for digit:=4 downto 1 do begin
    for i:=0 to 10  do begin
    S:='    ';
    if i=10
      then S[digit]:='.'
      else S[digit]:=ansichar(i+ integer('0'));
    //if color=2 then S:=S+'.';


    SendString(S);
    end; // for i
    end; //for digit
    SendString('1    ');
    SendString('.    ');
    SendString(' ');
    SendString('1.8888');
    end; // for color
    with Sender as TButton do begin
      Caption:='Test'; //restore
      Font.Color:=clWindowText;
      end; //with
end;

procedure TForm1.CheckBoxI2CM5451_ColorClick(Sender: TObject);
begin
  with Sender as TCheckbox do begin
  if checked
    then Color:=clRed
    else Color:=clLime;
  end
end;

(*
type TCharSourceColors = object
    Color4Keyboard: TColor;
    Color4Port: TColor;
    Color4WriteChar: TColor;
    Color4SpyTx : TColor;
    Color4SpyRx : TColor;
    constructor Create;

end; //tcharsourcecolors

procedure TCharSourceColors.Create;
begin
  Color4Keyboard:=clRed;
  Color4Port    :=clYellow;
  Color4WriteChar:=clLime;
  Color4SpyTx:=clRed;
  Color4SpyRx:=clYellow;
end;

function TCharSourceColors.CharSource2Color(CharSource:TAdCharSource):TColor;
begin
  case CharSource of
    csUnknown: ;
    csKeyboard: Buffer.ForeColor:= Color4Keyboard;
    csPort: begin
              IncCharCount(1);
              Buffer.ForeColor    := Color4Port;
            end;
    csWriteChar: Buffer.ForeColor:=Color4WriteChar;
    //else
  end; //case
end;
*)


procedure TForm1.ButtonTerminalEnableClick(Sender: TObject);
begin
  AdTerminal1.enabled:=true;
end;

procedure TForm1.ButtonTerminalActiveClick(Sender: TObject);
begin
  AdTerminal1.active:=true;
end;

procedure TForm1.ButtonPopupMenuClick(Sender: TObject);
begin
  PopupMenu1.Popup(Form1.Left,form1.Top);
end;



procedure TForm1.ButtonAddCannedStringClick(Sender: TObject);
begin
  AddCannedString(EditCannedStringTitle.Text, EditCannedStringContents.Text);
end;



procedure TForm1.SpeedButtonP0Click(Sender: TObject);
var D:byte; commandStr:shortstring;
procedure DoButton(N:integer;Button:TSpeedButton);
begin
  if Button.Down then begin
    D:=D or N;
  end;
end;
begin
  D:=0;
  DoButton(1,SpeedButtonP0);
  DoButton(2,SpeedButtonP1);
  DoButton(4,SpeedButtonP2);
  DoButton(8,SpeedButtonP3);
  DoButton(16,SpeedButtonP4);
  DoButton(32,SpeedButtonP5);
  DoButton(64,SpeedButtonP6);
  DoButton(128,SpeedButtonP7);

  SetHalfDuplex(true);
  commandStr:='O 00'+inttohex(D xor 255,2);
  SendAsciiString(commandStr,false,true,true);

end;

procedure TForm1.ButtonBL233EEPromDlgClick(Sender: TObject);
begin
  SetHalfDuplex(true);
  //BL233EEPromDlg.show;//showmodal;
  BL233EEPromDlg.visible:=not BL233EEPromDlg.visible;
end;

procedure TForm1.ButtonBL233ReadPinsClick(Sender: TObject);
begin
  SetHalfDuplex(true);
  SendAsciiString('Q',false,true,true);
end;

procedure TForm1.LabelSyncCountClick(Sender: TObject);
begin
  HexEmulator.SyncCount:=0;
end;




procedure TForm1.HexCSVFormatTest(Sender: TObject);
begin
  StatusBarFormattedData.SimpleText:=ConvertDelimitedHexStr2Dec(Edit1.text, true, false, ComboBoxHexCSVFormat.text);
end;

procedure TForm1.EditColorsChange(Sender: TObject);
begin
  SetColors((Sender as TEdit).Text);
end;

procedure TForm1.SetColors(ColorString:ansistring);
//Sets the colors used in the terminal from a ASCII string of single letters for each color
function ParseColorChar(C:ansichar):TColor;
begin
  //C:=uppercase(C);
  if C>='a' then
    C:= ansichar(byte(C)- (byte('a') - byte('A')) ); //upper case char
  case C of
    'R':result:=clRed;
    'G':result:=clGreen;
    'B':result:=clBlue;
    'C':result:=clAqua;
    'Y':result:=clYellow;
    'M':result:=clFuchsia;
    'K':result:=clBlack;
    'W':result:=clWhite;
    'T':result:=clTeal;
    'P':result:=clPurple;
    'L':result:=clLime;
    'O':result:=clOlive;
    'N':result:=clMaroon;
    else result:=clGray;
    end; //case
end; //fn
var i:integer;
    ThisColor:TColor;
const DefaultColorString=ansistring('RYLRYK');
begin
  //default is 'RYLRYK'
  for i:=1 to length(DefaultColorString) do begin
    if i<=length(ColorString)
      then ThisColor:=ParseColorChar(ColorString[i])
      else ThisColor:=ParseColorChar(DefaultColorString[i]);
    case i of
      1: Color4Keyboard:=ThisColor;
      2: Color4Port:=ThisColor;
      3: Color4WriteChar:=ThisColor;
      4: Color4SpyTx:=ThisColor;
      5: Color4SpyRx:=ThisColor;
      6: begin
          Color4Background:=ThisColor;  //added to try and make ansi emulator have right background
          AdTerminal1.Color:=ThisColor;
          if (AdTerminal1.Emulator=AdEmulator_VT100) then begin
            AdTerminal1.Emulator.Buffer.BackColor:=Color4Background; //added to try and make ansi emulator have right background
            AdTerminal1.Clear;
            end;//if

          end;
      else
    end; //case
    end; //for
end;
procedure TForm1.ButtonScanBusClick(Sender: TObject);
  var Address:integer;
begin
  //clear screen
  AdTerminal1.Clear;
  AdTerminal1.Emulator.Buffer.SetCursorPosition(1,1);

  //half duplex off
  SetHalfDuplex(false);
  SendAsciiString('J0A',false,false,true); //enable ACK/NACK mode
  //setup
  SendAsciiString('T'+IAscii2Hex('Add 0 2 4 6 8 A C E   0 2 4 6 8 A C E '+CRLF,false),false,false,true);
  Address:=$0;
  while Address<=$FE do begin
    if (Address and $1F)=0 then begin //start of each line
      //type address
      SendAsciiString('T0D0A'+'T'+IAscii2Hex(inttohex(Address,2)+'  ',false),false,false,true);
    end;
    if (Address and $1F)=$10 then begin //middle of each line
      SendAsciiString('T2020',false,false,true); //spaces betwen blocks
    end;
    SendAsciiString(':S'+inttohex(Address,2)+'P'+chr(10)+'T20',false,false,true);
//    Port1.ProcessCommunications;
//    AdTerminal1.Update;
    inc(Address,2);
    //sleep(10);
  end;
  SendString('T'+IAscii2Hex(CRLF,false));
  SendString('T'+IAscii2Hex('  "K" at addresses with slave present '+CRLF,false));
  SendString('J'+inttohex(ICRBitValue,2)+' ');
  SetHalfDuplex(true);
  end;

procedure TForm1.ButtonI2CCRMoreClick(Sender: TObject);
  var P:TPoint;
begin
  P:=GroupBoxI2CControlRegister.ClientOrigin;
  PopupMenuI2CControlRegister.Popup(P.x,P.y);
end;

function TForm1.ICRBitValue:byte;
begin
  result:=0;
  if MenuItemCR7.Checked then result:=result+128 ;
  if MenuItemCR6.Checked then result:=result+64 ;
  if MenuItemCR5.Checked then result:=result+32 ;
  if MenuItemCR4.Checked then result:=result+16 ;

  if MenuItemCR3.Checked then result:=result+8 ;
  if MenuItemCR2.Checked then result:=result+4 ;
  if MenuItemCR1.Checked then result:=result+2 ;
  if MenuItemCR0.Checked then result:=result+1 ;

  //sync the items
//  CheckBoxMenuItemCR7.Checked :=MenuItemCR7.Checked ;
//  CheckBoxMenuItemCR1.Checked :=MenuItemCR1.Checked ;
  CheckBoxMenuItemCR7.SetChecked(MenuItemCR7.Checked) ;
  CheckBoxMenuItemCR1.SetChecked(MenuItemCR1.Checked) ;
end;
function TForm1.ICR2BitValue:byte;
begin
  result:=0;
  if MenuItemCR27.Checked then result:=result+128 ;
  if MenuItemCR26.Checked then result:=result+64 ;
  if MenuItemCR25.Checked then result:=result+32 ;
  if MenuItemCR24.Checked then result:=result+16 ;

  if MenuItemCR23.Checked then result:=result+8 ;
  if MenuItemCR22.Checked then result:=result+4 ;
  if MenuItemCR21.Checked then result:=result+2 ;
  if MenuItemCR20.Checked then result:=result+1 ;

end;

procedure TForm1.CheckBoxMenuItemCR7Click(Sender: TObject);
begin
  MenuItemCR7.Checked:=(Sender as TCheckbox).Checked;
  MenuItemCRClick(Sender);
end;

procedure TForm1.CheckBoxMenuItemCR1Click(Sender: TObject);
begin
  MenuItemCR1.Checked:=(Sender as TCheckbox).Checked;
  MenuItemCRClick(Sender);
end;

procedure TForm1.PopupMenu1Popup(Sender: TObject);
  var Menu:TPopupMenu;
      PopupComponent : Tcomponent;
      ThisButton:TButton;
  procedure SetHelpTopic(Component:TComponent=nil);
    var S,HelpURL:string;
  begin
    if Component=nil then Component:=PopUpComponent;

     if IsPublishedProp(Component, 'Caption') then begin
       S:=GetStrProp(Component, 'Caption');
     end;
     if IsPublishedProp(Component, 'HelpKeyword') then begin
       HelpURL:=GetStrProp(Component, 'HelpKeyword');
     end;

    MenuItemContextHelp.Caption:='Help on '+S;
    MenuItemContextHelp.Hint:=HelpURL;
    MenuItemContextHelp.Visible:=true;
  end;
begin
  Menu:= TPopupMenu(Sender);
  PopupComponent:=Menu.PopupComponent;
  MenuItemContextHelp.Visible:=false;
  if PopupComponent is TControl then begin
    if TControl(PopupComponent).HelpKeyword<>'' then SetHelpTopic;
//    with PopupComponent as Tcontrol begin
//      if TControl(PopupComponent).HelpKeyword
//    end;
  end;

  if (PopupComponent is TButton) then begin
    ThisButton:=TButton(Menu.PopupComponent);
    MenuItemAddHotkey.Caption:='Add Hotkey to: '+ThisButton.Caption;
    end
  else begin
//    if (PopupComponent is TForm) then begin
//      Menu.PopupPoint
//        PopupComponent:=TForm(PopupComponent).  ObjectAtPoint(TForm(PopupComponent).MousePos)
//    end;
    if not (Menu.PopupComponent=nil) and not (PopupComponent is TForm)
      then MenuItemAddHotkey.Caption:='Add Hotkey to: '+Menu.PopupComponent.Classname;
  end;
end;

procedure TForm1.PopupMenuI2CControlRegisterChange(Sender: TObject;
  Source: TMenuItem; Rebuild: Boolean);
  var value:byte;
begin
  value:=ICRBitValue;
  SetHalfDuplex(true);
  //I2CBusy:=true;
  SendString('J'+inttohex(value,2)+' ');
end;

procedure TForm1.MenuItemCRClick(Sender: TObject);  //send main control register
  //var value:byte;
begin
  ICRCommand(1);
//  value:=ICRBitValue;
//  SetHalfDuplex(true);
//  //I2CBusy:=true;
//  SendString('J'+inttohex(value,2)+' ');
end;

procedure TForm1.MenuItemCR2Click(Sender: TObject); //send both control registers - timing =0
//  var value,value2:byte;
begin
  ICRCommand(3);
//  value:=ICRBitValue;
//  value2:=ICR2BitValue;
//  SetHalfDuplex(true);
//  //I2CBusy:=true;
//  SendString('J'+inttohex(value,2)+' 00 '+inttohex(value2,2)+' ');
end;


procedure TForm1.ICRCommand(N:integer); //send the J command from the control menus
  var value,value2,timingvalue:byte;
  S:string;
begin
  value:=ICRBitValue;

  value2:=ICR2BitValue;
  timingvalue:=0;
  if MenuItemBitTiming00.Checked  then timingvalue:=0;
  if MenuItemBitTiming08.Checked  then timingvalue:=8;
  if MenuItemBitTiming10.Checked  then timingvalue:=16;
  if MenuItemBitTiming20.Checked  then timingvalue:=32;

  if BL233EEPromDlg.visible then begin// must be eeprom values we want to change....
    BL233EEPromDlg.SetControlRegisters(N,value,value2);
    exit;
  end;
  //changing live via J command
  SetHalfDuplex(true);
  S:='J'+inttohex(value,2)+' ';
  if (N>=2) then S:=S+inttohex(timingvalue,2)+' ';
  if (N>=3) then S:=S+inttohex(value2,2)+' ';
  SendString(S);
end;


procedure TForm1.MenuItemCRDefaultClick(Sender: TObject);
begin
  MenuItemCR7.Checked :=false ;
  MenuItemCR6.Checked :=false ;
  MenuItemCR5.Checked :=false ;
  MenuItemCR4.Checked :=false ;

  MenuItemCR3.Checked :=true  ;
  MenuItemCR2.Checked :=false ;
  MenuItemCR1.Checked :=false ;
  MenuItemCR0.Checked :=false ;
  MenuItemCRClick(Sender);
end;
procedure TForm1.MenuItemCR2DefaultClick(Sender: TObject);
begin
  MenuItemCR27.Checked :=false ;
  MenuItemCR26.Checked :=false ;
  MenuItemCR25.Checked :=false ;
  MenuItemCR24.Checked :=false ;

  MenuItemCR23.Checked :=false ;
  MenuItemCR22.Checked :=false ;
  MenuItemCR21.Checked :=false ;
  MenuItemCR20.Checked :=false ;
  MenuItemCR2Click(Sender);
end;

//procedure TForm1.ShowForm(F: TForm; Modal: Boolean=false);
//
//begin
//end;

procedure TForm1.ShowForm(F: TForm; Modal: Boolean=false);
var SaveFS:TFormStyle;
begin
  //form1.FormStyle;  //if main is stay-on-top
  SaveFS:=FormStyle;
  Formstyle:=fsnormal;
  if Modal
    then begin
      F.showmodal;
      Formstyle:=SaveFS;
      //MenuItemStayOnTop.Checked := (SaveFS=fsStayOnTop);
    end
    else begin
      F.Show;
      MenuItemStayOnTop.Checked := false;
    end;
end;

procedure TForm1.ButtonShowAboutClick(Sender: TObject);
begin
  ShowForm(AboutBox, true); //.showmodal;
end;

procedure TForm1.ButtonShowEventsTabClick(Sender: TObject);
begin
  if TabSheetEvents.TabVisible then begin
    TabSheetEvents.TabVisible:=false;
    PageControl1.ActivePage:=TabSheetMisc;
    ButtonShowEventsTab.Caption:='Show Events Tab';
  end else begin
    TabSheetEvents.TabVisible:=true;
    PageControl1.ActivePage:=TabSheetEvents;
    ButtonShowEventsTab.Caption:='Hide Events Tab';
  end;
end;

procedure TForm1.ButtonShowLastErrorClick(Sender: TObject);
  var AppInfo:string;
begin
  AppInfo:=#13+#13+#13+AppOSRunInfoStr+#13+#13
            +'Ports: '+AppOSInstallPortStr+#13+#13
            +'ctrl-C to copy this to clipboard';
  if length(LastErrorMessage)<>0
    then MessageDlg('Last Error Message was:'+chr(13)+chr(13)+LastErrorMessage+AppInfo,mtInformation,[mbOK],0)
    else MessageDlg('Last Error Message is empty'+AppInfo,mtInformation,[mbOK],0);
end;

procedure TForm1.SpeedButtonShowFormattedDataClick(Sender: TObject);
begin
  if SpeedButtonShowFormattedData.Down
    then RadioGroupHexCSVStatusShows.ItemIndex:=1
    else RadioGroupHexCSVStatusShows.ItemIndex:=0;
  ShowHideStatusBarFormattedData;
end;

procedure TForm1.ButtonHexCSVFormatClick(Sender: TObject);
var P:TPoint;
begin
  P:=GroupBoxHexCSV.ClientOrigin;
  PopupMenuHexCSVFormat.Popup(P.x,P.y);
end;

procedure TForm1.ComboBoxHexCSVFormatDblClick(Sender: TObject);
begin
  ButtonHexCSVFormatClick(nil);
end;

procedure TForm1.HexCSVFormatChars1Click(Sender: TObject);
begin
    ComboBoxHexCSVFormat.Text:=ComboBoxHexCSVFormat.Text+(Sender as TMenuitem).Caption[2];
end;

procedure TForm1.Clear1Click(Sender: TObject);
begin
  ComboBoxHexCSVFormat.Text:='';
end;

procedure TForm1.RadioGroupHexCSVTerminalShowsClick(Sender: TObject);
begin
  if RadioGroupHexCSVTerminalShows.ItemIndex=0
    then RadioGroupHexCSVStatusShows.Items[1]:= RadioGroupHexCSVTerminalShows.Items[1]
    else RadioGroupHexCSVStatusShows.Items[1]:= RadioGroupHexCSVTerminalShows.Items[0];
end;
procedure TForm1.RadioGroupMiscFeaturesClick(Sender: TObject);
const GROUPBOX_GAP=5;
const LastN:integer=0;
var ThisN,N:integer; ThisGB,LastGB:TGroupBox;
  procedure ShowIfN(GB:TGroupBox);
  begin
    if RadioGroupMiscFeatures.ItemIndex=N then begin
      GB.Visible:=true;
      GB.Left:=RadioGroupMiscFeatures.Left+GROUPBOX_GAP+ RadioGroupMiscFeatures.Width;
      GB.Top:=-2;
      ThisGB:=GB;
      ThisN:=N; //for next time
    end
    else begin
      GB.Visible:=false;
    end;
    if (N=LastN) then begin
      LastGB:=GB;
    end;
    N:=N+1;
  end;
begin
  n:=0;
  ShowIfN(GroupBoxPhone);
  ShowIfN(GroupBoxBLE);
  ShowIfN(GroupBoxBlueSmirf);
  ShowIfN(GroupBoxPP);
  ShowIfN(GroupBoxGPIB);

  //show last on right of selected
  LastGB.Left:=ThisGB.Left+GROUPBOX_GAP+ThisGB.Width;
  LastGB.Visible:=true;
  LastN:=ThisN;
end;

procedure TForm1.ShowHideStatusBarFormattedData;
begin
  StatusBarFormattedData.Visible:= (RadioGroupHexCSVStatusShows.ItemIndex=1);
  FormResize(nil);
end;

procedure TForm1.RadioGroupHexCSVStatusShowsClick(Sender: TObject);
begin
  ShowHideStatusBarFormattedData;
end;


end.
