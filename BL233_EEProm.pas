unit BL233_EEProm;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.Grids,
  AdPacket, Vcl.Dialogs, Vcl.Menus;

type
  TBL233EEPromDlg = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet3: TTabSheet;
    HelpBtn: TButton;
    Label1: TLabel;
    EditData1: TEdit;
    Label2: TLabel;
    BitBtnChangeData1: TBitBtn;
    ComboBoxDataAddress1: TComboBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    MemoBL233Macros: TMemo;
    BitBtnReadMacros: TBitBtn;
    TabsheetMacros: TTabSheet;
    MemoBL233MacrosSplit: TMemo;
    ComboBoxMacroAddress1: TComboBox;
    Label4: TLabel;
    Label3: TLabel;
    EditMacro1: TEdit;
    BitBtnChangeMacro1: TBitBtn;
    CheckBoxCompactAscii: TCheckBox;
    LabelBL233CommandString: TLabel;
    EditBL233CommandStrSent: TEdit;
    LabelBL233AddressRange: TLabel;
    GroupBox1: TGroupBox;
    EditWatchdogVector: TEdit;
    EditIRQVector: TEdit;
    Label6: TLabel;
    Label5: TLabel;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    StringGridSettings: TStringGrid;
    BitBtnReadSettings: TBitBtn;
    MemoBL233WholeEEprom: TMemo;
    BitBtnReadWholeEEProm: TBitBtn;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    BitBtnLoadEeprom: TBitBtn;
    BitBtnSaveEEProm: TBitBtn;
    BitBtnUpdateSplitMacroLines: TBitBtn;
    BitBtnWriteSplitMacros: TBitBtn;
    CheckBoxLiveUpdate: TCheckBox;
    BitBtnWriteAllEEProm: TBitBtn;
    TabSheet2: TTabSheet;
    Memo1: TMemo;
    ButtonControlRegisters: TButton;
    ComboBoxBaud: TComboBox;
    Label7: TLabel;
    PopupMenufSerial: TPopupMenu;
    fSerialeeprom1: TMenuItem;
    N1: TMenuItem;
    PopupMenufSerial7: TMenuItem;
    PopupMenufSerial6: TMenuItem;
    PopupMenufSerial5: TMenuItem;
    PopupMenufSerial4: TMenuItem;
    PopupMenufSerial3: TMenuItem;
    PopupMenufSerial2: TMenuItem;
    PopupMenufSerial1: TMenuItem;
    PopupMenufSerial0: TMenuItem;
    N2: TMenuItem;
    PopupMenufSerialDefault: TMenuItem;
    ButtonfSerial: TButton;
    procedure BitBtnChangeData1Click(Sender: TObject);
    procedure BitBtnChangeMacro1Click(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtnReadMacrosClick(Sender: TObject);
    procedure ButtonChangeWatchdogVectorClick(Sender: TObject);
    procedure ButtonChangeIRQVectorClick(Sender: TObject);
    procedure BitBtnReadSettingsClick(Sender: TObject);
    procedure BitBtnReadWholeEEPromClick(Sender: TObject);
    procedure BitBtnLoadEepromClick(Sender: TObject);
    procedure BitBtnSaveEEPromClick(Sender: TObject);
    procedure BitBtnUpdateSplitMacroLinesClick(Sender: TObject);
    procedure BitBtnWriteSplitMacrosClick(Sender: TObject);
    procedure MemoBL233MacrosSplitChange(Sender: TObject);
    procedure BitBtnWriteAllEEPromClick(Sender: TObject);
    procedure ButtonControlRegistersClick(Sender: TObject);
    procedure ComboBoxBaudChange(Sender: TObject);
    procedure PopupMenufSerialClick(Sender: TObject);
    procedure ButtonfSerialClick(Sender: TObject);
    procedure TabSheet1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure PopupMenufSerialDefaultClick(Sender: TObject);
  private
    { Private declarations }
    procedure Send(S:string);
    procedure EEWrite(CB:TCombobox; DataStr:string; IsText:boolean=true; CompactAscii:boolean=false);overload;
    procedure EEWrite(Address:word; DataStr:string; IsText:boolean=true; CompactAscii:boolean=false); overload;
    procedure EEWrite(Address:word; Data:byte); overload;

    procedure OnI2CStringPacket(Sender: TObject; Data: AnsiString);
    procedure OnI2CStringPacketDumpToMacros(Sender: TObject; Data: AnsiString);
    procedure OnI2CStringPacketDumpToSettings(Sender: TObject;
      Data: AnsiString);

    procedure ReadBL233eepROM(Handler:TStringPacketNotifyEvent);

    procedure DumpToMacros(DumpStr: string);
    procedure DumpToSettings(DumpStr: string);
    procedure DumpToLinesAsFixedColumns(Lines: TStrings; S:string; LineLength: cardinal=16);
    procedure DumpToLinesAsSplitMacros(Lines: TStrings; S: string);

    procedure OnI2CStringPacketDumpToAll(Sender: TObject; Data: AnsiString);
    procedure DumpToAllEEProm(DumpStr: string);
    procedure DumpToAll(DumpStr: string);

    function GetMacroStringFromSplitMacros:string;
    procedure DumpToSplitMacros(S: string);
    function PopupMenufSerialBitValue:byte;
    procedure PopupMenufSerialBitValueFromStr(S:string);
    procedure PopupMenuI2CControlRegisterBitValueFromStr(S: string);

  public
    { Public declarations }
    procedure SetControlRegisters(N: cardinal; fControl, fControl2: byte);
  end;

var
  BL233EEPromDlg: TBL233EEPromDlg;

implementation
uses i2cx, realterm1, StStrL, Helpers, IOUtils ;
{$R *.dfm}
//TForm1.SendASCIIString(S:ansistring;AppendCR,AppendLF,StripSpaces:boolean);
function RemoveCRLF(S:string):string;
begin
      S:=StringReplace(S, chr(10), '',[rfReplaceAll]);
      S:=StringReplace(S, chr(13), '',[rfReplaceAll]);
      result:=S;
end;
function IsAllHex(S:string):boolean;
  var i:cardinal; c:char;
begin
  result:=false;
  for i := 1 to length(S) do begin
    c:=S[i];
    if not ( ((c>='0') and (c<='9')) or ( (c>='A') and (c<='F')) ) then exit;
  end;
  result:=true;
end;
function AddressFromComboBox(CB:TComboBox):word;
  var Address:word;
    AddressStr, Delims: string; WC:integer;
begin
  Delims:=' :,;';
  //WC:=WordCountL(CB.text,Delims);
  AddressStr:=ExtractWordL(1,CB.text,Delims);
  if str2wordl(AddressStr,Address)
    then begin
      CB.PutStringAtTop(100);
      result:=Address;
    end
    else begin
       //Form1.EditIAddress.text:='0x00';
       result:=0;
    end;
end;

procedure TBL233EEPromDlg.Send(S:string); //put whole command string out
begin
  EditBL233CommandStrSent.text:=S; //show it
  //LabelBL233AddressRange.Caption
  //LabelBL233CommandStringLength.Caption:=length(S);
  Form1.SendStringSlow(S,10); //send with 10ms pause between chars for BL233B
end;

function LengthInEEProm(DataStr:string; IsText:boolean; CompactAscii:boolean):word;
begin
  result:=length(DataStr);
  if not IsText then result:=result div 2;
end;
procedure TBL233EEPromDlg.EEWrite(Address:word; Data:byte); //overload;
begin
  EEWrite(Address, inttohex(Data,2), false,false);
end;
procedure TBL233EEPromDlg.EEWrite(CB:TCombobox; DataStr:string; IsText:boolean=true; CompactAscii:boolean=false);
var Address:word;
begin
  Address:=AddressFromComboBox(CB);
  EEWrite(Address, DataStr,IsText,CompactAscii);
end;
procedure TBL233EEPromDlg.EEWrite(Address:word; DataStr:string; IsText:boolean=true; CompactAscii:boolean=false);
  var S:string; LastAddress,NumBytes:word;
begin
  //Address:=AddressFromComboBox(CB);
  LastAddress:=Address+LengthInEEProm(DataStr,IsText,CompactAscii)-1;
  LabelBL233AddressRange.Caption:='eeprom 0x'+inttohex(Address,2)+'-0x'+inttohex(LastAddress,2);

  S:=IBL233EEWriteStr(Address, DataStr, IsText, CompactAscii);
  EditBL233CommandStrSent.text:=S; //show it

  Form1.SendStringSlow(S,10); //send with 10ms pause between chars for BL233B
end;

procedure TBL233EEPromDlg.OKBtnClick(Sender: TObject);
begin

end;

//used so right-click menu function on main form can be used to update regs here - save effort..
procedure TBL233EEPromDlg.SetControlRegisters(N:cardinal;fControl,fControl2:byte);
begin
  case N of
    1: EEWrite($FB,inttohex(fControl,2),false,false);
    2:; //can't set timing in eeprom
    3: EEWrite($FB,inttohex(fControl,2)+inttohex(fControl2,2),false,false);
  end;
  ReadBL233eepROM(OnI2CStringPacketDumpToSettings); //update display
end;
procedure TBL233EEPromDlg.TabSheet1ContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin

end;

//send the text values from the edit to the
procedure TBL233EEPromDlg.BitBtn1Click(Sender: TObject);
begin
  close;
end;

procedure TBL233EEPromDlg.BitBtn2Click(Sender: TObject);
begin
  Form1.SendString('X5A');
end;

procedure TBL233EEPromDlg.BitBtnChangeData1Click(Sender: TObject);
begin
  EEWrite(ComboBoxDataAddress1, EditData1.Text, false, false);
end;

procedure TBL233EEPromDlg.BitBtnChangeMacro1Click(Sender: TObject);
begin
  EEWrite(ComboBoxMacroAddress1, EditMacro1.Text, true, CheckBoxCompactAscii.checked);
end;

procedure TBL233EEPromDlg.BitBtnLoadEepromClick(Sender: TObject);
  var FileName,S:string;
begin
  with OpenDialog1 do begin
    if Execute then                              { Display Open dialog box}
    begin
      S:=TFile.ReadAllText(FileName);
      S:=RemoveCRLF(S);
      if length(S)<>256 then
        showmessage('EEProm file should contain 256 Hex characters,'+
                     '  not '+inttostr(length(S))
                     +CRLF+CRLF+'Continuing - but data loaded is probably wrong');
      DumpToAll(S);
      SaveDialog1.FileName:=Filename;
    end;
  end; //with

end;
procedure TBL233EEPromDlg.BitBtnSaveEEPromClick(Sender: TObject);
begin
  with SaveDialog1 do begin
    if Execute then                              { Display Open dialog box}
    begin
      if length(ExtractFileExt(Filename))=0 then FileName:=Filename+'.bl233';

      MemoBL233WholeEEprom.Lines.SaveToFile(FileName );
    end;
  end; //with
end;
const MACRO_SPACE=$76+1;

function TBL233EEPromDlg.GetMacroStringFromSplitMacros:string;
  var i:cardinal; S,ThisLine:string; SS:TStrings;
begin
   SS:=MemoBL233MacrosSplit.Lines;
   for i := 0 to SS.Count-1 do begin
     ThisLine:= SS.Strings[i];
      if not ((ThisLine[1]='0') and (ThisLine[2]='x'))
         and (length(ThisLine)>3)
        then //value line not address line
          S:=S+copy(ThisLine,4,1000);
   end;
   //S:=RemoveCRLF(S);
   result:=S;
end;

procedure TBL233EEPromDlg.MemoBL233MacrosSplitChange(Sender: TObject);
  var S:string; CursorPos:TPoint;
begin
  BitBtnWriteSplitMacros.Enabled:=false; //must do update before write is possible
  if CheckBoxLiveUpdate.checked then begin
    CursorPos:=MemoBL233MacrosSplit.CaretPos;
    S:=GetMacroStringFromSplitMacros;
    //MemoBL233MacrosSplit.Lines.Clear;
    //DumpToLinesAsSplitMacros(MemoBL233MacrosSplit.Lines,S);
    DumpToSplitMacros(S);
    MemoBL233MacrosSplit.CaretPos:=CursorPos;
  end;
end;
function TBL233EEPromDlg.PopupMenufSerialBitValue:byte;
  var V:cardinal;
begin
  V:=0;
  PopupMenufSerial7.GetCheckedToBit(V);
  PopupMenufSerial6.GetCheckedToBit(V);
  PopupMenufSerial5.GetCheckedToBit(V);
  PopupMenufSerial4.GetCheckedToBit(V);
  PopupMenufSerial3.GetCheckedToBit(V);
  PopupMenufSerial2.GetCheckedToBit(V);
  PopupMenufSerial1.GetCheckedToBit(V);
  PopupMenufSerial0.GetCheckedToBit(V);
  result:=byte(V);
//  if PopupMenufSerial7.Checked then result:=result+128 ;
//  if PopupMenufSerial6.Checked then result:=result+64 ;
//  if PopupMenufSerial5.Checked then result:=result+32 ;
//  if PopupMenufSerial4.Checked then result:=result+16 ;
//
//  if PopupMenufSerial3.Checked then result:=result+8 ;
//  if PopupMenufSerial2.Checked then result:=result+4 ;
//  if PopupMenufSerial1.Checked then result:=result+2 ;
//  if PopupMenufSerial0.Checked then result:=result+1 ;
end;

procedure TBL233EEPromDlg.PopupMenufSerialBitValueFromStr(S:string);
 var V:cardinal;
begin
  if length(S)<>2 then exit;

  V:=strtoint('$'+S);
  PopupMenufSerial0.SetCheckedFromBit(V);
  PopupMenufSerial1.SetCheckedFromBit(V);
  PopupMenufSerial2.SetCheckedFromBit(V);
  PopupMenufSerial3.SetCheckedFromBit(V);
  PopupMenufSerial4.SetCheckedFromBit(V);
  PopupMenufSerial5.SetCheckedFromBit(V);
  PopupMenufSerial6.SetCheckedFromBit(V);
  PopupMenufSerial7.SetCheckedFromBit(V);
end;
procedure TBL233EEPromDlg.PopupMenuI2CControlRegisterBitValueFromStr(S:string);
 var V:cardinal;
begin
  if length(S)<>4 then exit;

  V:=strtoint('$'+S);

  Form1.MenuItemCR20.SetCheckedFromBit(V); 
  Form1.MenuItemCR21.SetCheckedFromBit(V); 
  Form1.MenuItemCR22.SetCheckedFromBit(V);
  Form1.MenuItemCR23.SetCheckedFromBit(V);
  Form1.MenuItemCR24.SetCheckedFromBit(V);
  Form1.MenuItemCR25.SetCheckedFromBit(V);
  Form1.MenuItemCR26.SetCheckedFromBit(V);
  Form1.MenuItemCR27.SetCheckedFromBit(V);

  Form1.MenuItemCR0.SetCheckedFromBit(V); 
  Form1.MenuItemCR1.SetCheckedFromBit(V); 
  Form1.MenuItemCR2.SetCheckedFromBit(V);
  Form1.MenuItemCR3.SetCheckedFromBit(V);
  Form1.MenuItemCR4.SetCheckedFromBit(V);
  Form1.MenuItemCR5.SetCheckedFromBit(V);
  Form1.MenuItemCR6.SetCheckedFromBit(V);
  Form1.MenuItemCR7.SetCheckedFromBit(V);

end;

procedure TBL233EEPromDlg.PopupMenufSerialClick(Sender: TObject);
begin
  EEWrite($F7,PopupMenufSerialBitValue);
  ReadBL233eepROM(OnI2CStringPacketDumpToSettings);
end;

procedure TBL233EEPromDlg.PopupMenufSerialDefaultClick(Sender: TObject);
begin
  EEWrite($F7,$21);
  ReadBL233eepROM(OnI2CStringPacketDumpToSettings);
end;

procedure TBL233EEPromDlg.BitBtnUpdateSplitMacroLinesClick(Sender: TObject);
  var S:string;
begin
  S:=GetMacroStringFromSplitMacros;
   if length(S)>MACRO_SPACE then begin
     if mrYes = messagedlg('Macros are '+inttostr(length(S)-MACRO_SPACE)+' chars bigger than eeprom'+CRLF+CRLF+
                       'Trim at 0x'+inttohex(MACRO_SPACE-1,2)+'?'
                        ,mtError, [mbYes,mbNo], 0)
        then S:=copy(S,1,MACRO_SPACE); //clip to max length
   end;
   //MemoBL233MacrosSplit.Lines.Clear;
   //DumpToLinesAsSplitMacros(MemoBL233MacrosSplit.Lines,S);
   DumpToSplitMacros(S);
   //BitBtnWriteSplitMacros.Enabled:=length(S)=MACRO_SPACE;
   BitBtnWriteSplitMacros.Enabled:=length(S)<=MACRO_SPACE;

end;

procedure TBL233EEPromDlg.BitBtnWriteAllEEPromClick(Sender: TObject);
  var S:string;
begin
  S:=MemoBL233WholeEEprom.text;
  S:=RemoveCRLF(S);
  //S:=StringReplace(S, ' ', '',[rfReplaceAll]); //remove spaces
  if not IsAllHex(S) then begin
     messagedlg('Valid eeprom has only HEX characters (0-9,A-F)'
                        ,mtError, [mbOk], 0);
     exit; //clip to max length
  end;
  if (length(S)<>256) then begin
     messagedlg('EEProm contents should be *exactly* 256 HEX characters, not '+inttostr(length(S))
                        ,mtError, [mbOk], 0);
     exit; //clip to max length
  end;
  if mrNo = messagedlg('Do you want to overwrite whole eeprom?'+CRLF+CRLF+
                          'Have you saved eeprom contents to file?'
                        ,mtConfirmation, [mbYes,mbNo], 0)
        then exit; //clip to max length
  EEWrite($F7, S, false, false); // CheckBoxCompactAscii.checked);
end;

procedure TBL233EEPromDlg.BitBtnWriteSplitMacrosClick(Sender: TObject);
  var S:string;
begin
  S:=GetMacroStringFromSplitMacros;
  if length(S)<>MACRO_SPACE then begin
     if mrNo = messagedlg('Macros should end at *exactly* 0x'+inttohex(MACRO_SPACE-1,2)+' not 0x'+inttohex(length(S)-1,2)+CRLF+CRLF+
                        'Have you saved eeprom contents to file?'+CRLF+CRLF+
                       'Do you still want to overwrite eeprom macro space?'
                        ,mtWarning, [mbYes, mbNo], 0)
        then exit; //clip to max length
   end else begin
     if mrNo = messagedlg('Do you want to overwrite eeprom macro space?'+CRLF+CRLF+
                          'Have you saved eeprom contents to file?'
                        ,mtConfirmation, [mbYes,mbNo], 0)
        then exit; //clip to max length

   end;
   S:=copy(S,1,MACRO_SPACE); //clip to length anyway....
   EEWrite(0, S, true, false); // CheckBoxCompactAscii.checked);
end;

procedure TBL233EEPromDlg.BitBtnReadMacrosClick(Sender: TObject);
begin
  ReadBL233eepROM(OnI2CStringPacketDumpToMacros);
end;

procedure TBL233EEPromDlg.BitBtnReadSettingsClick(Sender: TObject);
begin
  ReadBL233eepROM(OnI2CStringPacketDumpToSettings);
end;

procedure TBL233EEPromDlg.BitBtnReadWholeEEPromClick(Sender: TObject);
begin
  ReadBL233eepROM(OnI2CStringPacketDumpToAll);
end;

procedure TBL233EEPromDlg.ButtonControlRegistersClick(Sender: TObject);
var
  pnt: TPoint;
begin
  if GetCursorPos(pnt) then
    Form1.PopupMenuI2CControlRegister.Popup(pnt.X, pnt.Y);
end;

procedure TBL233EEPromDlg.ButtonfSerialClick(Sender: TObject);
var
  pnt: TPoint;
begin
  if GetCursorPos(pnt) then
    PopupMenufSerial.Popup(pnt.X, pnt.Y);
end;

procedure TBL233EEPromDlg.ButtonChangeIRQVectorClick(Sender: TObject);
begin
  EEWrite($FF, EditData1.Text, false, false);
end;

procedure TBL233EEPromDlg.ButtonChangeWatchdogVectorClick(Sender: TObject);
begin
  EEWrite($FE, EditData1.Text, false, false);
end;

procedure TBL233EEPromDlg.ComboBoxBaudChange(Sender: TObject);
var BaudDiv:word;
begin
  BaudDiv:=AddressFromComboBox(ComboBoxBaud);
  EEWrite($F8, byte(BaudDiv));
  ReadBL233eepROM(OnI2CStringPacketDumpToSettings);
  showmessage('Reset BL233 to effect change.'+CRLF+'     then'+CRLF+ 'Change Port BaudRate on PORT Tab to new rate');
end;

procedure TBL233EEPromDlg.OnI2CStringPacket(Sender: TObject; Data: AnsiString);
begin

end;
procedure TBL233EEPromDlg.OnI2CStringPacketDumpToAll(Sender: TObject;
  Data: AnsiString);
begin
  DumpToAll(Data);
end;

procedure TBL233EEPromDlg.OnI2CStringPacketDumpToMacros(Sender: TObject;
  Data: AnsiString);
begin
  DumpToMacros(Data);
  DumpToAllEEProm(Data);
end;
procedure TBL233EEPromDlg.OnI2CStringPacketDumpToSettings(Sender: TObject;
  Data: AnsiString);
begin
  DumpToSettings(Data);
  DumpToAllEEProm(Data);
end;
procedure TBL233EEPromDlg.DumpToAll(DumpStr:string);
begin
  DumpToMacros(DumpStr);
  DumpToSettings(DumpStr);
  DumpToAllEEProm(DumpStr);
end;

procedure TBL233EEPromDlg.DumpToSettings(DumpStr:string);
  var Row:cardinal; Address:word;
  procedure FR(N:cardinal;S:string); //FillRow
  begin
    StringGridSettings.Rows[N].Delimiter:=';';
    StringGridSettings.Rows[N].StrictDelimiter:=true;
    StringGridSettings.Rows[N].DelimitedText:=S;
  end;
  function Next(S:string):string;
  var RegisterData:string;
  begin
    RegisterData:=copy(DumpStr,(Row-1)*2+1,2); //get hex data from dump string
    FR(Row,'0x'+inttohex(Address,2)+';'+S+';'+RegisterData);
    inc(Row);
    inc(Address);
  end;
begin
  StringGridSettings.ColWidths[0]:=40;
  StringGridSettings.ColWidths[1]:=100;
  StringGridSettings.ColWidths[3]:=40;
  StringGridSettings.ColWidths[2]:=StringGridSettings.Width-180;
  Address:=$F7;
  FR(0,'Address;Register;Description;Data');
  Row:=1;
  Next('fSerial;Serial Control Register');
  Next('Baud_Div;Baud Rate Divisor');
  Next('TimerDivL;Low byte of Timer');
  Next('TimerDivH;High byte of Timer');
  Next('fControl;Control Register initialise');
  Next('fControl2;Extended Control Register (BL233C)');
  Next('<unused>;');
  Next('Watchdog Vector; Address of Macro');
  Next('IRQ Vector;Address of Macro');

  PopupMenufSerialBitValueFromStr(copy(DumpStr,1,2));
  PopupMenuI2CControlRegisterBitValueFromStr(copy(DumpStr,9,4)); //fControl and fControl2
end;

procedure TBL233EEPromDlg.DumpToMacros(DumpStr:string);
    var S:string;
begin
  EditWatchdogVector.text:=copy(DumpStr,15,2);
  EditIRQVector.text:=copy(DumpStr,17,2);

  ComboBoxMacroAddress1.Pushstring('0x'+EditIRQVector.text+  '  IRQ');
  ComboBoxMacroAddress1.Pushstring('0x'+EditWatchdogVector.text+'  Watchdog');
  ComboBoxMacroAddress1.Pushstring('0x40');
  S:=Hex2AsciiStr(string(DumpStr));
  Delete(S,1,9); //remove setting bytes

  MemoBL233Macros.Lines.Clear;
  //MemoBL233MacrosSplit.Lines.Clear;

  //DumpToLinesAsSplitMacros(MemoBL233MacrosSplit.Lines,S);
  DumpToSplitMacros(S);
  DumpToLinesAsFixedColumns(MemoBL233Macros.Lines,S);
end;
procedure TBL233EEPromDlg.DumpToAllEEProm(DumpStr:string);
    var S:string;
begin
  S:=string(DumpStr);
  MemoBL233WholeEEprom.Lines.Clear;
  DumpToLinesAsFixedColumns(MemoBL233WholeEEprom.Lines,S,16);
end;
procedure TBL233EEPromDlg.DumpToSplitMacros(S:string);
  var OnChange:TNotifyEvent;
begin
  OnChange:=MemoBL233MacrosSplit.OnChange;
  MemoBL233MacrosSplit.OnChange:=nil;
  MemoBL233MacrosSplit.Lines.Clear;
  DumpToLinesAsSplitMacros(MemoBL233MacrosSplit.Lines,S);
  MemoBL233MacrosSplit.OnChange:=OnChange;
end;
procedure TBL233EEPromDlg.DumpToLinesAsSplitMacros(Lines:TStrings;S:string);
  var Line,LineAddress:string;
  i,j: Integer;
begin
  LineAddress:='0x0';
  Line:='   ';
  j:=0;
  for i := 1 to length(S) do begin
    Line:=Line+S[i];
    if ((j mod 2)=0) //and (j>0)
      then LineAddress:=LineAddress+inttohex((i-1) mod 16, 1)
      else LineAddress:=LineAddress+' ';
    inc(j);
    if S[i]='<' then begin
      MemoBL233MacrosSplit.Lines.add(LineAddress);
      MemoBL233MacrosSplit.Lines.add(Line);
      MemoBL233MacrosSplit.Lines.add(' ');
      Line:='   ';
      LineAddress:='0x'+inttohex(i div 16,1);//+'  ';
      //Line:=LineAddress;
      j:=0;
    end;
  end; //for
  if j>0 then begin
      MemoBL233MacrosSplit.Lines.add(LineAddress);
      MemoBL233MacrosSplit.Lines.add(Line);
  end;
end;
procedure TBL233EEPromDlg.DumpToLinesAsFixedColumns(Lines:TStrings;S:string; LineLength:cardinal=16);
var Line:string; i,j:cardinal;
begin
  Line:='';
  j:=0;
  for i := 1 to length(S) do begin
    Line:=Line+S[i];
    if length(Line)=LineLength then begin
      Lines.add(Line);
      inc(j);
      Line:='';
    end;
  end; //for
  if length(Line)>0 then Lines[j]:=Line;
end;

procedure TBL233EEPromDlg.ReadBL233eepROM(Handler:TStringPacketNotifyEvent);
begin
  Form1.ApdDataPacketI2C.OnStringPacket:=Handler; //OnI2CStringPacket;
  Form1.ApdDataPacketI2C.Enabled:=true;
  Form1.ApdDataPacketI2C.EndString:=ansichar($0A);
  Form1.SendString('U');
end;

end.

