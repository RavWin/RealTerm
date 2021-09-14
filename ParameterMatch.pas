//Main Parameter Handler routine.
//Include in Realterm1.pas
//Too much private access to TForm1 to split into a unit
//procedure TForm1.ParameterParamMatch(Sender: TObject; CaseMatch: Boolean;
//  Param, Reference: String);
//  procedure MakeAPPDATADirs;
//  var D1,D2:string;
//  begin
//    D1:=ExpandEnvVars('%APPDATA%');
//    D2:=ExpandEnvVars('%LOCALAPPDATA%');
//    if not (DirectoryExists(D1) and DirectoryExists(D2)) and
//       (mrYes = messagedlg('Create APPDATA and LOCALAPPDATA Directories for Realterm?'+#13+#13+
//                          D1+#13+D2, mtConfirmation, [mbYes,mbNo], 0) )
//        then begin
//          if not DirectoryExists(D1) and not CreateDir(D1) then showmessge('Unable to Create'+#13+#13+ D1);
//          if not DirectoryExists(D2) and not CreateDir(D2) then showmessge('Unable to Create'+#13+#13+ D2);
//    end;
//
//  end;
begin
{baud=9600 port=server:telnet capcount=9876 capfile=c:\temp\smap.xxx framesize=7 display=3 bigend=1 visible=0 RTS=0 DTR=1 flow=2}
   Reference:=AnsiDequotedStr(Reference,'"'); // remove quotes that have come through the first instance message passing
   if QuitNow then exit; //don't process any more when going to quit
   param:=uppercase(param);
   //IsRemoteCommand:=(Sender=ParameterRemote);
   IsRemoteCommand:=not Parameter1.useProgramParams;
   if (param='INIFILE') then begin
     Parameter1.AddParamFileDuringExecute(Reference);
   end;
   if (param='BAUD') or (param='BD') then begin
     ComboBoxBaud.text:=Reference;
     Port1Changed:=true;
   end;
   if (param='PORT') or (param='PT') then begin
     ComboBoxComPort.text:=Reference;
     Port1Changed:=true;
   end;
   if (param='PORTQUIT') or (param='PQ') then begin
     ComboBoxComPort.text:=Reference;
     Port1Changed:=true;
     PortErrorQuit:=true; //signal to form1.create, that it should quit if port error
   end;
   if (param='CAPFILE') or (param='CF') then begin
     ComboBoxSaveFname.SetFilenameCheckPathExists(Reference);
   end;
   if (param='FRAMESIZE') or (param='FS') then begin
     SpinEditFrameSize.value:= strtoint(Reference);
   end;
   if (param='CAPCOUNT' ) or (param='CC') then begin
     ComboBoxCaptureSize.text:=Reference;
     RadioGroupCaptureSizeUnits.ItemIndex:=0;  //bytes
     ComboBoxCaptureSizeChange(nil);
   end;
   if (param='CAPSECS' ) or (param='CS') then begin
     ComboBoxCaptureSize.text:=Reference;
     RadioGroupCaptureSizeUnits.ItemIndex:=1; //secs
     ComboBoxCaptureSizeChange(nil);
   end;
   if (param='CAPLINES' ) then begin
     ComboBoxCaptureSize.text:=Reference;
     RadioGroupCaptureSizeUnits.ItemIndex:=2; //secs
     ComboBoxCaptureSizeChange(nil);
   end;
   if (param='CAPEOL' ) then begin
     if Reference='' then begin
        CheckBoxCaptureEOL.checked:=false;
     end else begin //param given
        CheckBoxCaptureEOL.checked:=true;
        ComboBoxCaptureEOLChar.text:=Reference;
        ComboBoxCaptureEOLCharChange(nil); //setting text doesn't seem to trigger it???
        ComboBoxCaptureEOLChar.PutStringAtTop;
     end;
   end;

   if (param='CAPAUTONAME') then begin
     value:=strtoint(Reference);
     if (Value>=RadioGroupCaptureAutoFileName.Items.Count) or (value<0)
       then Value:=0;
     RadioGroupCaptureAutoFileName.ItemIndex:=Value;

   end;
   if (param='CAPHEX' ) or (param='CX') then begin
     CheckBoxCaptureAsHex.Checked:=not (Reference='0');
   end;
   if (param='TIMESTAMP' ) or (param='TS') then begin
     if length(Reference)>1  //not a simple number 0-9
     then begin   //must be a format string
        ComboboxTimestampFormat.text:=Reference;
        Value:=RadioGroupTimeStamp.Items.Count-1; //last one
     end else begin
          value:=strtoint(Reference);
     end;
     if (Value>=RadioGroupTimeStamp.Items.Count) or (value<0)
       then Value:=0;
     RadioGroupTimeStamp.ItemIndex:=Value; //secs
   end;
   if (param='CAPPROCESS') then begin
     if (length(reference)=1) and (reference[1]='0')
      then CheckboxCapturePostProcess.checked:=false
      else begin
        CheckboxCapturePostProcess.checked:=true;
        if (length(Reference)>0)
          then ComboboxCapturePostFName.PushString(reference,100);
          //then ComboBoxPushString(ComboboxCapturePostFName,reference,100);
      end;
   end;

   if (Param='TSDELIMITER')  then begin
     case Reference[1] of
       ',': value:=0;
       ' ': value:=1;
       else begin  //third button is variable
         value:=2;
         RadioGroupTimeStampDelimiter.Items[2]:=Reference[1]; //Ensure only a single char. This will be used for delimiter later
         end;
     end; //case
     RadioGroupTimeStampDelimiter.ItemIndex:=Value;
   end;

   if (param='CAPTURE') or (param='CP') then begin
     if IsRemoteCommand
      then begin
        StartCapture(CaptureModeOrText(reference,ComboBoxSaveFname));
      end
      else begin
        CaptureAutoStart:=CaptureModeOrText(reference,ComboBoxSaveFname);
        //CaptureAutostart:=cmOn;
      end;
   end;
   if (param='CAPQUIT') or (param='CQ') then begin
     CaptureAutostart:=cmOn;
     CaptureAutoQuit:=true;
     if length(reference)>0 then ComboBoxSaveFname.SetFilenameCheckPathExists(Reference);
   end;
   if (Param='CAPDIRECT') or (param='CD') then begin
     CheckboxDirectCapture.Checked:=not (Reference='0');
   end;
   if (param='DISPLAY'  ) or (param='DS') then begin
     value:=strtointdef(Reference,0);
     RadioGroupDisplayTypeSet(false,value);
     //Form1.RadioGroupDisplayType.ItemIndex:=value;
   end;
   if (param='VISIBLE') or (param='VS')then begin
   //not totally sure why visible can't be changed here.....
     if IsRemoteCommand
       then Form1.visible:= (Reference='0')
       else SetPending(PendingInvisible,(Reference='0'));
   end;
   if (param='WINDOWSTATE') or (param='WS') then begin
     UpperRef:=upperCase(reference);
     if (UpperRef='MIN') then reference:='1';
     if (UpperRef='NORM') then reference:='0';
     if (UpperRef='MAX') then reference:='2';
     if (UpperRef='FULL') then reference:='3';
     Form1.SetWinState(strtointdef(reference,0));
  //   if IsRemoteCommand
    //   then Form1.SetWindowState(strtoint(reference))
      // else Form1.fWindowState:=strtoint(reference); ////form is created after this is parsed. WindowState etc can't be changed here...
   end;
   if (param='BIGEND'  ) or (param='BN') then begin
     CheckBoxBigEndian.checked:=(Reference='1');
     CheckBoxBigEndianClick(nil);
   end;
   if (param='FLOW'  ) or (param='FW') then begin
     SetFlow(Reference,Form1.HardwareFlowGroup,Port1,ReceiveFlowBox,TransmitFlowBox,Port1Changed);
   end;
   if (param='EFLOW'  ) or (param='EFW') then begin
       SetFlow(Reference,Form1.EchoHardwareFlowGroup,EchoPort,EchoReceiveFlowBox,EchoTransmitFlowBox, EchoPortChanged);
   end;

   if (param='RTS')  then begin
     Port1.RTS:=(Reference='1');
   end;
   if (param='DTR')  then begin
     Port1.DTR:=(Reference='1');
   end;
   if (param='CLOSED') then begin
     if IsRemoteCommand
       then Port1.Open:= not (reference='1')
       else Port1.AutoOpen:= not (reference='1');
   end;
   if (param='OPEN') then begin
     if IsRemoteCommand
       then Port1.Open:= not (reference='0')
       else begin
         Port1.AutoOpen:= not (reference='0');
         CheckboxPortAutoOpen.Checked:=Port1.AutoOpen;
       end;
   end;
   if (param='SPY') then begin
     if IsRemoteCommand
       then begin
         SpyModeOpen(not (reference='0'));
       end
       else SpyModeAutoStart:= not (reference='0');
   end;
   if (param='TAB') then begin
     if not SelectTabSheet(Reference) then begin //select the tabsheet by name
       console.showmessage('Unknown tabsheet name "' + Reference +'"');
     end;
   end;
   if (param='EBAUD') then begin
     ComboBoxEchoBaud.text:=Reference;
     EchoPortChanged:=true;
   end;

   if (param='ECHO') then begin
     if (length(Reference)<>0) then ComboBoxEchoPort.text:=Reference;
   //  BitBtnSetEchoPortClick(nil);
     CheckBoxEchoOn.checked:=true;
   //  CheckBoxEchoOnClick(nil); //and open the port
     EchoPortChanged:=true;
   end;
   if (param='HALF') then begin
     if length(Reference)=0
       then CheckboxHalfDuplex.checked:=true
       else CheckboxHalfDuplex.checked:= (Reference='1');
   end;
   if (param='LFNL') then begin
     if length(Reference)=0
       then CheckboxNewLine.checked:=true
       else CheckboxNewLine.checked:= (Reference='1');
   end;
   if (param='CRLF') then begin
     if length(Reference)=0
       then CheckboxCRLF.checked:=true
       else CheckboxCRLF.checked:= (Reference='1');
   end;


   if (param='CAPTION') then begin
     Form1.SetCaption(Reference);
//     Caption:=Reference;
//     MenuItemTitle.Caption:=Reference;
//     TrayIcon1.Hint:=MenuItemTitle.Caption+'  ,'+StatusBar1.Panels[StatusBarPanelEnd].text;
//     Application.Title:=Reference; //shown on start bar when minimised
   end;
   if (param='HIDECONTROLS') then begin
     HideControls1.Checked:= (Reference<>'0');  //default to hide
     HideControls1Click(nil);
   end;
   //CONTROLS depreciated - to be phased out
   if (param='CONTROLS') then begin
     HideControls1.Checked:= (Reference='0');  //default to show
     HideControls1Click(nil);
   end;
   if (param='MONITOR') then begin
     CheckBoxEchoPortMonitoring.checked:=(Reference='1') or (Reference='');
     CheckBoxEchoPortMonitoringClick(nil);
   end;
   if (param='DATA') then begin //sets data format
     case Reference[1] of
       '8': Port1.DataBits:=8;
       '7': Port1.DataBits:=7;
       '6': Port1.DataBits:=6;
       '5': Port1.DataBits:=5;
       else
         DataBitsFormatErrorMessage;
     end; //case
     case uppercase(Reference)[2] of
       'N': Port1.Parity:=pNone;
       'O': Port1.Parity:=pOdd;
       'E': Port1.Parity:=pEven;
       'M': Port1.Parity:=pMark;
       'S': Port1.Parity:=pSpace;
       else
         DataBitsFormatErrorMessage;
     end; //case
     case Reference[3] of
       '1': Port1.StopBits:=1;
       '2': Port1.StopBits:=2;
       else
         DataBitsFormatErrorMessage;
     end; //case
     Port1Changed:=true;
   end; //DATA
   if (param='EDATA') then begin //sets data format
     case Reference[1] of
       '8': EchoPort.DataBits:=8;
       '7': EchoPort.DataBits:=7;
       '6': EchoPort.DataBits:=6;
       '5': EchoPort.DataBits:=5;
       else
         DataBitsFormatErrorMessage;
     end; //case
     case uppercase(Reference)[2] of
       'N': EchoPort.Parity:=pNone;
       'O': EchoPort.Parity:=pOdd;
       'E': EchoPort.Parity:=pEven;
       'M': EchoPort.Parity:=pMark;
       'S': EchoPort.Parity:=pSpace;
       else
         DataBitsFormatErrorMessage;
     end; //case
     case Reference[3] of
       '1': EchoPort.StopBits:=1;
       '2': EchoPort.StopBits:=2;
       else
         DataBitsFormatErrorMessage;
     end; //case
    EchoPortChanged:=true;
   end; //edata
   if (param='WINSOCK') then begin
     value:=strtoint(Reference);
     if (value<0) then Value:=0;
     Form1.RadioGroupWsTelnet.ItemIndex:=Value;
   end;
   if (param='EWINSOCK') then begin
     value:=strtoint(Reference);
     if (value<0) then Value:=0;
     Form1.RadioGroupEchoWsTelnet.ItemIndex:=Value;
   end;
   if (param='CHARDLY') then begin //set char delay
     value:=strtoint(Reference);
     //if (value<0) then Value:=0;
     Form1.SpinEditAsciiCharDelay.Value:=Value;
   end;
   if (param='LINEDLY') then begin //set char delay
     value:=strtoint(Reference);
     if (value<0) then Value:=0;
     Form1.SpinEditAsciiLineDelay.Value:=Value;
   end;
   if (param='ROWS') then begin
     value:=strtoint(Reference);
     if (value<=0) then Value:=16;
     Form1.SpinEditTerminalRows.Value:= Value;
   end; //ROWS
   if (param='COLS') then begin
     value:=strtoint(Reference);
     if (value<=0) then Value:=16;
     Form1.SpinEditTerminalCols.Value:= Value;
   end; //COLS

   if (param='SENDFILE') or (param='SF') then begin
     if IsRemoteCommand
      then begin
        if BooleanOrText(reference,ComboBoxSendFname)
          then ButtonSendFileClick(nil)
          else BitBtnAbortSendFileClick(nil);
      end
      else begin //from commandline
        //ComboboxSendFname.text:=Reference;
        SendFileList.SetFilenames(Reference,ComboboxSendFname);
        SendFileAutostart:=true;
      end;
   end;

   if (param='SENDFNAME') then begin
        //ComboboxSendFname.text:=Reference;
        SendFileList.SetFilenames(Reference,ComboboxSendFname);
    end;
   if (param='SENDQUIT')  or (param='SQ') then begin
     if length(Reference)>0 then SendFileList.SetFilenames(Reference,ComboboxSendFname);//ComboboxSendFname.text:=Reference;
     SendFileAutostart:=true;
     SendFileAutoQuit:=true;
   end;
   if (param='SENDDLY') then begin
     value:=strtoint(Reference);
     Form1.SpinEditFileSendDelay.Value:= Value;
     //Form1.SpinEditFileSendRepeats.Value:=0; //default to endless
   end; //SENDDLY
   if (param='SENDREP') then begin
     value:=strtoint(Reference);
     Form1.SpinEditFileSendRepeats.Value:= Value;
   end; //SENDREP
   if (param='FIRST') then begin
     if IsFirstInstance then begin //receiving instance
        if (reference='0') and (WProc<>nil)
          then WProc := Pointer(SetWindowLong(Application.Handle, gwl_WndProc,Integer(WProc)));
       if ((reference='1') or (reference='2')) and (WProc=nil)
          then WProc := Pointer(SetWindowLong(Application.Handle, gwl_WndProc,Integer( @AppWndProcWMCopyData)));
       if (reference='2')
          then ChangeMessageFilter; //open up UIPI filter, only when user explicitly authorises it
     end else begin //sending instance
//       ActivateFirstCommandline(WM_COPYDATA);
       ActivateFirstCommandline;
       if (GetLastError<>0)
        then begin //failed SendMessage
          ExitCode:=GetLastError; //should be 5=excUIPIBlockedMessage
          console.ShowMessage('Sending Message to first instance FAILED: '+CRLF+
                      'ErrorCode='+inttostr(GetLastError)+CRLF+
                      'Error: '+SysErrorMessage(GetLastError)+CRLF+CRLF+
                      'Error 5 is an UIPI access problem. Try starting the first instance with'+CRLF+
                      'realterm.exe first=2 [other params]');
        end;
          QuitNow:=true;
          exit;
     end;
   end;
   if (param='QUIT') or (param='EXIT') then begin
     //Application.Terminate;
//     showmessage('Closing');
//     Form1.Close;
     QuitNow:=true;
     exit;
   end;
   if (param='STRING1') or (param='S1')  then begin
     ComboboxSend1.PushString(reference,100);
   end;
   if (param='STRING2') or (param='S2')  then begin
     ComboboxSend2.PushString(reference,100);
   end;
   //sendstr will change to actually sending the string, not loading the combobox
   if (param='SENDSTR') or (param='SS')  then begin
     ComboboxSend1.PushString(reference,100);
     if ( IsRemoteCommand ) then begin
       //ButtonSendAscii1Click(nil);
       SendTabSendString1(sasAscii);
     end
     else begin
       SendStringAutostart:=true;
       SendStringAutostartAs:=sasAscii;
       //OLD command line parameters it will push into BOTH comboboxes
       //ComboboxSend2.PushString(reference,100);
     end;
   end;

   if (param='SENDNUM') then begin
     ComboboxSend1.PushString(reference,100);
     if ( IsRemoteCommand ) then begin
       //ButtonSendNumbers1Click(nil);
       SendTabSendString1(sasNumbers);
     end
     else begin
       SendStringAutostart:=true;
       SendStringAutostartAs:=sasNumbers;
//OLD command line parameters it will push into BOTH comboboxes
//       ComboboxSend2.PushString(reference,100);
     end;
   end;
   if (param='SENDHEX') then begin
     ComboboxSend1.PushString(reference,100);
     if ( IsRemoteCommand ) then begin
       //ButtonSendHex1Click(nil);
       SendTabSendString1(sasHex);
     end
     else begin
       SendStringAutostart:=true;
       SendStringAutostartAs:=sasHex;
     end;
   end;
   if (param='SENDLIT') then begin
     ComboboxSend1.PushString(reference,100);
     if ( IsRemoteCommand ) then begin
       //CheckboxLiteralStrings.Checked:=true;
       //ButtonSendHex1Click(nil);
       SendTabSendString1(sasLiteral);
     end
     else begin
       SendStringAutostart:=true;
       SendStringAutostartAs:=sasLiteral;
     end;
   end;

   if (param='CR') then begin
     CheckBoxCR1.checked:=not (reference='0');
   end;
   if (param='LF') then begin
     CheckBoxLF1.checked:=not (reference='0');
   end;
   if (param='SCANPORTS') then begin
     //SuppressPortScan:= (reference='0');
     PortScanLastPortOnStartup:=strtoint(reference);
     PortScanLastPort:=max(PortScanLastPort,PortScanLastPortOnStartup);
   end;
   if (param='HELP') then begin
      SetPending(PendingHelp);
   end;
   if (param='I2CADD') then begin
     ComboBoxIAddress.Text:=reference;
   end;
   if (param='SCROLLBACK') then begin
     if (length(Reference)<>0) then begin
        value:=strtoint(Reference);
        if value<>0 then
          Form1.SpinEditScrollbackRows.Value:= abs(Value);
        CheckboxScrollback.checked:= value>0; //Reference<>'0';
     end;

   end; //SCROLL
   if (param='COLORS') then begin
     //SetColors(Reference);
     EditColors.Text:=Reference;
   end;//COLORS
   if (param='INSTALL') then begin //used after installer has been run
     SetPending(PendingInstall); //can set help if it wants
     PortScanLastPortOnStartup:=4;

     if (length(Reference)<>0) then
        try
          strtoint(Reference[1]); //errors if first char is not a digit
            rtUpdate.InstallParamVersion:=(Reference);
          except
            PendingMessage:=Reference;
          end;
   end;
   if (param='MSGBOX') then begin //brings up a message box
     SetPending(PendingStuff);
      if (length(Reference)<>0)
        then PendingMessage:=Reference
        else PendingMessage:='Usage: MSGBOX="you must give a string for me to show here"';
   end;


   if (param='HEXCSV') then begin
     ComboBoxHexCSVFormat.PushString(reference,100);
   end;
   if (param='SCALE') then begin
     value:=strtointdef(Reference,0); //nothing,0 or auto will return 0 ->autoscale
     Form1.SpinEditScale.Value:= Value;
     FormScale(Value);
   end; //SENDREP
   if (param='CLEAR') then begin
     if (Reference='') and (IsRemoteCommand) then Form1.Clear1Click(nil); //clear
     SetClearTerminalCheckboxes(StrtoIntDef(Reference,3));
   end;
   if (param='FONTNAME') then begin
      AdTerminal1.Font.Name:=(reference);
      SetFormSizeFromRowsCols(true,true);
   end;
   if (param='FONTSIZE') then begin
      AdTerminal1.Font.Size:=StrtoIntDef(reference,12);
      SetFormSizeFromRowsCols(true,true);
   end;
   if (param='BSYNCIS') then begin
      RadioGroupSyncIs.ItemIndex:=StrtoIntDef(reference,0);
   end;
   if (param='BSYNCDAT') then begin
      ComboBoxSyncString.PushString(reference);
   end;

   if (param='BSYNCAND') then begin
      ComboBoxSyncAND.PushString(reference);
   end;
   if (param='BSYNCXOR') then begin
      ComboBoxSyncXOR.PushString(reference);
   end;
   if (param='BSYNCHI') then begin
      CheckBoxHighlightSync.checked:=(Reference='1') or (Reference='');
   end;
   if (param='BSYNCLEAD') then begin
      CheckBoxLeadingSync.checked:=(Reference='1') or (Reference='');
   end;
   if (param='BSYNCSHOWCOUNT') then begin
      SpinEditSyncShowLength.value:=StrtoIntDef(reference,-1);
   end;
   if ((param='KEYMAPVT') or (param='KEYMAP'))
              and fileexists(Reference) //check for a valid file...
   then begin
        if (param='KEYMAPVT') then begin
          AdEmulator_VT100.KeyboardMapping.LoadFromFile(Reference);
        end;
        if (param='KEYMAP') then begin
          AdEmulator_Hex.KeyboardMapping.LoadFromFile(Reference);
          AdShowAllEmulator.KeyboardMapping.LoadFromFile(Reference);
        end;
   end;
   if (param='CRC') then begin
     value:=StrtoIntDef(reference,1);
     CRCType2UI(value);
//     CheckBoxCRC.checked:= (value<>0);
//     if (value<>0) then begin  //this allows Combobox and Hex to remain unchanged when CRC=0, so all controls can be set.
//        ComboBoxCRC.ItemIndex:=abs(value)-1;
//        CheckBoxCRCHex.checked:= (value<0);
//     end;
   end;
   if (param='EXITCODE') then begin
       ExitCode:=StrtoIntDef(reference,1); //
       //not using console for this message...
       ShowMessage('Force EXITCODE for debugging batch files...'+CRLF+
                      'ExitCode='+inttostr(ExitCode)+CRLF+CRLF+
                      'CommandLine is:'+CRLF+Form1.Parameter1.ParamString.Text);
       //Application.Terminate;
       QuitNow:=true;
       exit;
   end;
   if (param='CONSOLE') then begin
     //StrtoIntDef(reference,1);
     case StrtoIntDef(reference,1) of
       0: Console.Detach;
       //1 is else
       2: begin
            Console.Attach(true,true,true);
            Console.writeln('Realterm Attached to Console. GUI Error and Message popups suppressed');
          end;
       else begin // 1 or anything else..
            Console.Attach(true,true,false);
            Console.writeln('Realterm Attached to Console');
            end;
     end;
     //Console.Attach(true,true);
     //Console.writeln('Realterm Attached to Console');
   end;
   if (param='RXIDLE') then begin
     value:=StrtoIntDef(reference,1);
     case value of
       0: CheckBoxRxdIdle.Checked:=false;
       1: CheckBoxRxdIdle.Checked:=true;
       else begin
         CheckBoxRxdIdle.Checked:= (value>0);
         SpinEditRxdIdle.value:=abs(value);
       end;
     end; //case
   end;
   if (param='NOSLEEP') then begin
     CheckboxNoSleep.checked:=not (reference='0');
   end;
      if (param='WINX') then begin
     value:=strtointdef(Reference,Form1.Left); //nothing,0 or auto will return 0 ->autoscale
     Form1.Left:= Value;
   end; //
   if (param='WINY') then begin
     value:=strtointdef(Reference,Form1.Top); //nothing,0 or auto will return 0 ->autoscale
     Form1.Top:= Value;
   end; //
   if (param='WINW') then begin
     value:=strtointdef(Reference,Form1.Width); //nothing,0 or auto will return 0 ->autoscale
     PendingWidth:=value;
     Form1.Width:= Value;
   end; //
   if (param='WINH') then begin
     value:=strtointdef(Reference,Form1.Height); //nothing,0 or auto will return 0 ->autoscale
     PendingHeight:=value;
     Form1.Height:= Value;
     //FormScale(Value);
   end; //

end;
