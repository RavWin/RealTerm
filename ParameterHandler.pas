unit ParameterHandler;

interface

uses Classes,math;
//  procedure ParameterInterpreter(Param, Reference: String);
  procedure MakeINIParameterFile();
  procedure MakeINIStrings(var SS:TStrings;MatchName:string='';AddUnmatchedName:boolean=true); overload;
  procedure MakeINIStrings(var SS:TStrings;Params:Tstrings); overload;
  function GetFolderPath( CSIDLFolder: Integer): string; //gets special windows folders

implementation

uses Realterm1, CRC, EscapeString, SHFolder, Windows, Messages, SysUtils, Graphics, Controls, Forms, Dialogs,
  StdCtrls, AdPort, AdWnPort, AdProtcl, {AdTerm,} AdSocket, ExtCtrls, Spin,
  AdStatLt,AdWUtil, {AdIniDB,} adExcept, Paramlst, ComCtrls, ToolWin, Buttons,
  checklst, Menus, PicProgN, PortIO, {verslab,} AFVersionCaption,
  ADTrmEmu, OoMisc, Mask, AdSpcEmu, AdPStat, StBase, StWmDCpy, StFirst,
  {TVicCommUnit,} StExpr, StVInfo,  AppEvnts, AdPacket, rtUpdate1;

//-------------- Parameter Parser ----------------------------
//
////procedure TForm1.ParameterParamMatch(Sender: TObject; CaseMatch: Boolean;
//procedure ParameterInterpreter(
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
//           '0': begin result:=cmOff; Form1.CheckboxCaptureRestart.Checked:=false; end;
//           '1': begin result:=cmOn;  Form1.CheckboxCaptureRestart.Checked:=false; end;
//           '2': begin result:=cmAppend;  Form1.CheckboxCaptureRestart.Checked:=false; end;
//           '3': begin
//                  result:=cmOn;
//                  Form1.CheckboxCaptureRestart.Checked:=true;
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
//    if (Reference[1]='X') or (Reference[1]='x')
//      then begin  //enable software flow control
//        ReceiveFlowBox.Checked:=true;
//        TransmitFlowBox.Checked:=true;
//      end else begin
//     value:=strtoint(Reference);
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
//     Form1.ItemIndexToHWFlowOptions(Group.ItemIndex,Port);
//     PortChanged:=true;
//     end; //if
//  end;
//  //---------------- fn begins ---------
//begin
//{baud=9600 port=server:telnet capcount=9876 capfile=c:\temp\smap.xxx framesize=7 display=3 bigend=1 visible=0 RTS=0 DTR=1 flow=2}
//   Reference:=AnsiDequotedStr(Reference,'"'); // remove quotes that have come through the first instance message passing
//   if Form1.QuitNow then exit; //don't process any more when going to quit
//   param:=uppercase(param);
//   //IsRemoteCommand:=(Sender=ParameterRemote);
//   with Form1 do begin
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
//     ComboBoxSaveFname.text:=Reference;
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
//     value:=strtoint(Reference);
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
//          then ComboBoxPushString(ComboboxCapturePostFName,reference,100);
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
//     if length(reference)>0 then ComboBoxSaveFname.text:=Reference;
//   end;
//   if (Param='CAPDIRECT') or (param='CD') then begin
//     CheckboxDirectCapture.Checked:=not (Reference='0');
//   end;
//   if (param='DISPLAY'  ) or (param='DS') then begin
//     value:=strtoint(Reference);
//     if (Value>=Form1.RadioGroupDisplayType.Items.Count) or (value<0)
//       then Value:=0;
//     Form1.RadioGroupDisplayType.ItemIndex:=value;
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
//       else Port1.AutoOpen:= not (reference='0');
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
//       showmessage('Unknown tabsheet name "' + Reference +'"');
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
//        ComboboxSendFname.text:=Reference;
//        SendFileAutostart:=true;
//      end;
//   end;
//
//   if (param='SENDFNAME') then begin
//        ComboboxSendFname.text:=Reference;
//    end;
//   if (param='SENDQUIT')  or (param='SQ') then begin
//     if length(Reference)>0 then ComboboxSendFname.text:=Reference;
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
//          ShowMessage('Sending Message to first instance FAILED: '+CRLF+
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
//     ComboBoxPushString(ComboboxSend1,reference,100);
//   end;
//   if (param='STRING2') or (param='S2')  then begin
//     ComboBoxPushString(ComboboxSend2,reference,100);
//   end;
//   //sendstr will change to actually sending the string, not loading the combobox
//   if (param='SENDSTR') or (param='SS')  then begin
//     ComboBoxPushString(ComboboxSend1,reference,100);
//     if ( IsRemoteCommand ) then begin
//       ButtonSendAscii1Click(nil);
//     end
//     else begin  //command line parameters it will push into BOTH comboboxes
//       ComboBoxPushString(ComboboxSend2,reference,100);
//     end;
//   end;
//
//   if (param='SENDNUM') then begin
//     ComboBoxPushString(ComboboxSend1,reference,100);
//     if ( IsRemoteCommand ) then begin
//       ButtonSendNumbers1Click(nil);
//     end
//     else begin  //command line parameters it will push into BOTH comboboxes
//       ComboBoxPushString(ComboboxSend2,reference,100);
//     end;
//   end;
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
//     SetPending(PendingHelp);
//     SetPending(PendingInstall);
//     PortScanLastPortOnStartup:=4;
//     if (length(Reference)<>0)
//        then PendingMessage:=Reference
//        else PendingMessage:='Realterm has just been installed.'+CRLF+
//        'Please read the change log to see what has been added or changed.'+CRLF+CRLF+
//        'F1 launches help. Read all the tooltips, as they are a rich source of help.'+CRLF+CRLF+
//        'The status line continues to show the tooltips after they have gone.'+CRLF+
//        '   Double click the status line to see longer help strings'+CRLF+CRLF+
//        'There are many useful Hotkeys and more being added. Look through the Popup Menu and learn them all'+CRLF+CRLF+
//        'Be sure to Subscribe at Sourceforge, and watch News or RSS (about dialog has web links';
//
//   end;
//   if (param='MSGBOX') then begin //brings up a message box
//     SetPending(PendingStuff);
//      if (length(Reference)<>0)
//        then PendingMessage:=Reference
//        else PendingMessage:='Usage: MSGBOX="you must give a string for me to show here"';
//   end;
////   if (param='MSGBAR') then begin //brings up a message box
////     StatusBarFormattedData.SimpleText:=reference;
////     StatusBarFormattedData.Visible:=true;
////     SetPending(PendingStuff);
////      if (length(Reference)<>0)
////        then PendingMessage:=Reference
////        else PendingMessage:='Usage: MSGBOX="you must give a string for me to show here"';
////   end;
//
//
//   if (param='HEXCSV') then begin
//     ComboBoxPushString(ComboBoxHexCSVFormat,reference,100);
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
//      ComboBoxPushString(ComboBoxSyncString,reference);
//   end;
//
//   if (param='BSYNCAND') then begin
//      ComboBoxPushString(ComboBoxSyncAND,reference);
//   end;
//   if (param='BSYNCXOR') then begin
//      ComboBoxPushString(ComboBoxSyncXOR,reference);
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
//
//   end; //with Form1
//end;

//--------------------------------------------------------------
//      INI Writer
//--------------------------------------------------------------

function BS(V:boolean):string; //BooleanString '0' or '1'
begin
  result:=inttostr(ord(V));
end; //fn

function QuoteString( Str : string;  DoQuote : boolean=false; const Quote : char = '"' ) : String;
//Enclose a string in quotes IF NEEDED, and double up quotes when they are insiode the string.
//If DoQuote is true, then ALWAYS enclose in quotes
// eg baud=56000 does not need quotes. string1=abc$1 def=pqr  definitely does
// I have taken the chars which will force quoting from here: http://www.robvanderwoude.com/escapechars.php
// it is probably more chars, but not really any problem from quoting more often than needed
 Var
   Loop : Integer;
   //DoQuote : boolean;
 Begin
   //Result := Quote;
   //DoQuote:=false;
   For Loop := 1 to length( Str ) Do
   Begin
     Result := Result + Str[ Loop ];
     If Str[ Loop ] = Quote Then begin
            Result := Result + Quote;
            DoQuote:=true;
      end else
         case Str[ Loop ] of
            ' ','%','^','&','<','>','|',#39,'`',',',';',
            '[',']','.','*','!','?','\','"','=' : DoQuote:=true;
     end;

   End;
   if DoQuote then
     Result := Quote + Result + Quote;
 End;

function MakeValueLine(Name:string; C:TObject):string;
  var S:string;
begin
  if C is TCombobox then S:=QuoteString(TCombobox(C).text)
  else if C is TSpinEdit then S:=inttostr(TSpinEdit(C).value)
  else if C is TCheckBox then S:=BS(TCheckbox(C).checked)
  else if C is TRadioGroup then S:=inttostr(TRadioGroup(C).ItemIndex)
  else if C is TEdit then S:=QuoteString(TEdit(C).text)
  else if C is TMenuItem then S:=BS(TMenuItem(C).checked)
  //else if C is String then S:=QuoteString(C)

  else S:='*** UNKNOWN in MakeValueLine ***';
  result:=Name+'='+S;
end;//proc


function FlowStr(HWFlowGroup:TRadioGroup;RXFlowBox,TXFlowBox:TCheckbox):string; //get flow string from flow control group
  // 0-3 = HW flow set; +8=RX-XON, +4=TX XON
    var value:integer;
  begin
     value:=HWFlowGroup.ItemIndex;
     if RxFlowBox.Checked then value:=value+8;
     if TxFlowBox.Checked then value:=value+4;
     result:=inttostr(value);
  end;  //fn

function DataStr(Port:TApdWinsockPort):string;
  var P:char;
begin
  with Port do begin
    case Parity of
      pNone: P:='N';
      pOdd: P:='O';
      pEven: P:='E';
      pMark: P:='M';
      pSpace: P:='S';
      else P:='?'; //should never occur
    end;
    result:=inttostr(DataBits) + P + inttostr(StopBits);
  end;//with
end;

function GetFolderPath( CSIDLFolder: Integer): string;
begin
  SetLength(Result, MAX_PATH);
  SHGetFolderPath(0, CSIDLFolder, 0, 0, PChar(Result));
  SetLength(Result, StrLen(PChar(Result)));
  if (Result <> '') then
    Result  := IncludeTrailingBackslash(Result);
  //Result:=Result+'BEL\Realterm\';
  //Result:=Result+'realterm.ini'; //ChangeFileExt(Application.ExeName, '.ini');
end;

procedure MakeINIStrings(var SS:TStrings; Params:Tstrings); overload;
  var i,j,N:integer; P:string;
begin
  for i := 0 to Params.count-1 do begin
    P:=Params[i];
    if P<>'' then
      j:=SS.Count;
      MakeINIStrings(SS,P,true);
      N:=SS.Count-j;
  end;
end;
procedure MakeINIStrings(var SS:TStrings;MatchName:string='';AddUnmatchedName:boolean=true); overload;
var NameMatched:boolean;
//procedure Q(Name:string); overload;
//begin
//  SS.Append(Name);
//end;
//procedure Q(Name:string; C:boolean=false); overload;
//begin
//  SS.Append(Name+'='+BS(C));
//end;
function K(Name:string):boolean;
begin
  result:=(Name=MatchName);
  NameMatched:=NameMatched or result; //flag that we had a match
  result:=(MatchName='') or result; //will always match if strings is blank
  result:=not result;
end;
procedure Q(Name:string; C:TObject=nil); overload;

begin
  if K(Name) then exit;
  if C=nil
    then SS.Append(Name)
    else SS.Append(MakeValueLine(Name,C));
end;//proc
procedure Q(Name:string; S:string); overload; //for use of other routines
begin
  if K(Name) then exit;
  SS.Append(Name+'='+S);
  //Q(Name+'='+S);
end;

procedure Q(Name:string; B:boolean); overload; //Q of boolean
begin
  Q(Name , inttostr(ord(B)));
end;
procedure Q(Name:string; I:integer); overload; //Q of integer
begin
  Q(Name , inttostr(I));
end;
procedure QS(Name:string; S:string);  //Q of string
begin
  //Q(Name+'="'+S+'"'); //might be better to check if " " is needed ie if spaces...
  Q(Name , QuoteString(S,true));
end;
procedure QCombo(Name:string; CB:TCombobox); //Q of multiple lines of combobox
var I:integer;
begin
  for I := min(5,CB.Items.Count)-1 downto 0 do
    //Q(Name+'="'+CB.Items[I]+'"');
    QS(Name, CB.Items[I]);
end;
var value:integer;
begin
  with Form1 do begin
  Q('PORT', ComboboxComPort);
  Q('FLOW', FlowStr(HardwareFlowGroup,ReceiveFlowBox,TransmitFlowBox));
  Q('BAUD', ComboBoxBaud);
  Q('DATA', DataStr(Port1));
  Q('WINSOCK', RadioGroupWsTelnet);

  Q('CAPFILE', ComboBoxSaveFname);

  case RadioGroupCaptureSizeUnits.ItemIndex of
    0: Q('CAPCOUNT', ComboBoxCaptureSize);
    1: Q('CAPSECS', ComboBoxCaptureSize);
    2: Q('CAPLINES', ComboBoxCaptureSize);
    else Q('CAP???', ComboBoxCaptureSize);
  end;//case

  if CheckBoxCaptureEOL.Checked
    then Q('CAPEOL','')
    else Q('CAPEOL',ComboBoxCaptureEOLChar.text);

  Q('VISIBLE',Form1.visible);
  Q('SCALE', SpinEditScale);
  Q('WINDOWSTATE',GetWinState);
  Q('DISPLAY', RadioGroupDisplayTypeSet(true));
  Q('BIGEND', CheckBoxBigEndian);

  Q('ECHO', ComboboxEchoPort);
  Q('EFLOW' , FlowStr(EchoHardwareFlowGroup,EchoReceiveFlowBox,EchoTransmitFlowBox));
  Q('EBAUD', ComboBoxEchoBaud);
  Q('EDATA' , DataStr(EchoPort));
  Q('EWINSOCK', RadioGroupEchoWsTelnet);

  Q('RTS', Port1.RTS);
  Q('DTR', Port1.DTR);
  // CLOSED
  // OPEN
  Q('TAB' , PageControl1.ActivePage.Caption); //doesn't work, as will always tab with save button...

  Q('HALF', CheckboxHalfDuplex);
  Q('LFNL', CheckboxNewLine);
  Q('CRLF', CheckboxCRLF);
  Q('CAPTION' , '"'+Caption+'"');
  //Q('CAPTION'+'="'+ MenuItemTitle.Caption  +'"');

  Q('CAPDIRECT', CheckboxDirectCapture);
  Q('CAPHEX', CheckBoxCaptureAsHex);
  Q('CAPAUTONAME',RadioGroupCaptureAutoFileName);
  if (RadioGroupTimeStamp.ItemIndex < RadioGroupTimeStamp.Items.Count-1)
    then  Q('TIMESTAMP', RadioGroupTimeStamp)
    else  Q('TIMESTAMP', ComboboxTimeStampFormat); //if last option then it is a format string

  case RadioGroupTimeStampDelimiter.ItemIndex of
    0: Q('TSDELIMITER' ,' ","');
    1: Q('TSDELIMITER' ,'" "');
    2: QS('TSDELIMITER',RadioGroupTimeStampDelimiter.Items[2]);
  end; //case
  Q('HIDECONTROLS', HideControls1.Checked );
  Q('MONITOR', CheckBoxEchoPortMonitoring);

  Q('CHARDLY', SpinEditAsciiCharDelay);
  Q('LINEDLY', SpinEditAsciiLineDelay);

  Q('FRAMESIZE', SpinEditFrameSize);
  Q('ROWS', SpinEditTerminalRows);
  Q('COLS', SpinEditTerminalCols);
  if CheckboxScrollback.checked
    then Q('SCROLLBACK', SpinEditScrollbackRows)
    else Q('SCROLLBACK', false);
  // SENDFILE
  Q('SENDDLY', SpinEditFileSendDelay);
  Q('SENDREP', SpinEditFileSendRepeats);
  //Q('SENDSTR', ComboboxSend1); //for now. Better to have a way to dump and push all lines


  Q('CR', CheckBoxCR1);
  Q('LF', CheckBoxLF1);
  Q('I2CADD', ComboBoxIAddress);

  Q('COLORS', EditColors);
  Q('HEXCSV', ComboBoxHexCSVFormat);
  Q('CLEAR', GetClearTerminalCheckBoxes);
  Q('MSGBOX' , '""'); //just putting in a blank string,
  QCombo('STRING1', ComboboxSend1);
  QCombo('STRING2', ComboboxSend2);
  QCombo('SENDFNAME',ComboboxSendFname);
  QS('FONTNAME',AdTerminal1.Font.Name);
  Q('FONTSIZE',AdTerminal1.Font.Size);
  if CheckboxCapturePostProcess.checked
    then QCombo('CAPPROCESS',ComboboxCapturePostFName)
    else Q('CAPPROCESS',false);
  Q('BSYNCDAT',ComboBoxSyncString);
  Q('BSYNCAND',ComboBoxSyncAND);
  Q('BSYNCXOR',ComboBoxSyncXOR);
  Q('BSYNCHI',CheckBoxHighlightSync);
  Q('BSYNCLEAD',CheckBoxLeadingSync);
  Q('BSYNCSHOWCOUNT',SpinEditSyncShowLength);
  Q('BSYNCIS',RadioGroupSyncIs);
  //KEYMAP, KEYMAPVT  No control exists to save
  Q('CRC',CRCTypeFromUI);
  QS('VERSION',rtUpdate.CurrentVersion{AFVersionCaption1.Info}); //adds this param so you can see what version created an INI file
  if CheckBoxRxdIdle.Checked
    then Q('RXIDLE', SpinEditRxdIdle)
    else Q('RXIDLE', -SpinEditRxdIdle.Value);
  Q('NOSLEEP',CheckboxNoSleep);
  Q('WINX',Form1.LEFT);
  Q('WINY',Form1.TOP);
  Q('WINW',Form1.Width);
  Q('WINH',Form1.Height);
  end; //with Form1
  if not NameMatched and AddUnmatchedName and (MatchName<>'') then SS.addPair(MatchName,'');
end; //proc
procedure MakeINIParameterFile();
var INI:TStrings;
begin
  try
    INI:= TStringList.Create;{ construct the list }
    MakeINIStrings(INI);
    with Form1.SaveDialog1 do begin
    Filename:= 'realterm.ini';
    InitialDir:= GetFolderPath(CSIDL_LOCAL_APPDATA);
    if Execute then                              { Display Open dialog box}
    begin
      INI.SaveToFile(FileName );
    end;
    end; //with

  finally
    INI.Free;
  end;
end;
end.
