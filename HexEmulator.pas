unit HexEmulator;

interface
 uses ADTrmEmu, TimeStamps;
type
  THexEmulatorShowAs = (NoStr,HexStr, Int8Str, Uint8Str, Int16Str, Uint16Str, Uint32Str, Int32Str, BinaryStr,NibbleStr,Float4Str);
  THexEmulator = object
    private
    ShowChar : boolean; {shows ascii chars}
    UnprintablesBlank: boolean;
    HasTrailingSpace : boolean; {uses a space between chars}
    ShowAs : THexEmulatorShowAs;

//    History: array [1..10] of byte;
//    HistoryLength:integer;
//    HistoryWrPos:integer;
    HistoryString: shortstring;
    SyncString: shortstring;
    SyncLength:integer;

    SyncAND, SyncXOR: AnsiString;
    SyncLeading:boolean;
    IsFrameEnd:boolean;
    fSyncCount:integer;
    fSyncCountChanged:boolean;
    fShowCount:integer;
    fHighlightSync:boolean;
    fPadLeft:boolean;
    procedure NewChar(C:ansichar);
    procedure SetSyncCount(Value:integer);
    public
    NumChars: byte; {the number of chars put on terminal for each incoming char}
    InvertData : boolean;
    MaskMSB:boolean;
    GulpCount:integer;
    BigEndian : boolean;

    procedure Init(iShowChar,iUnPrintablesBlank,iHasTrailingSpace, iInvertData: boolean; iMaskMSB:boolean ;
                      iShowAs:THexEmulatorShowAs;iNumChars:byte);
    procedure SetSync(inSync,inXOR, inAND:AnsiString; inLeading:boolean; inShowCount:integer;inHighlightSync:boolean=false);  //sets the Sync values
    procedure ProcessChar(Sender: TObject;
         C: ansiChar; var ReplaceWith: AnsiString; Commands: TAdEmuCommandList;
         CharSource: TAdCharSource);
    function IsSyncCountChanged:boolean;
    property SyncCount:integer read fSyncCount write SetSyncCount;
    property PadLeft:boolean read fPadLeft write fPadLeft;  //pad numbers to fixed width
//    property ShowCount:integer read fShowCount write fShowCount; //-1=blank until EOL, 0=no blank, N=number of chars after framesunc to show
  end; //HexEmulator

implementation
uses SysUtils, StStrL, {StStrS,} StUtils, Realterm1;
const CR=char(13); LF=char(10);
{$J+} //D7
procedure THexEmulator.Init(iShowChar,iUnPrintablesBlank,iHasTrailingSpace, iInvertData: boolean; iMaskMSB:boolean;
                      iShowAs:THexEmulatorShowAs;iNumChars:byte);
begin
  ShowChar:=iShowChar;
  UnPrintablesBlank  :=iUnPrintablesBlank;
  HasTrailingSpace:=iHasTrailingSpace;
  ShowAs:=iShowAs;
  NumChars:=iNumChars;
  InvertData:=iInvertData;
  MaskMSB:=iMaskMSB;
  //HistoryLength:=0;
  //HistoryWrPos:=0;
  HistoryString:='';
  GulpCount:=0;
  SetSync('','','',false,0);
  fSyncCountChanged:=true;
  fSyncCount:=0;
  fShowCount:=0;
  fHighlightSync:=false;
end;
const TimeStampDelimiter='|';
var TS:tdatetime;
procedure AddTimeStamp(var S:string);
begin
  S:= DateTimeToStr(TS)+TimeStampDelimiter;//ymds
end;
procedure THexEmulator.SetSyncCount(Value:integer);
begin
  fSyncCount:=value;
  fSyncCountChanged:=true;
end;

function THexEmulator.IsSyncCountChanged:boolean;
begin
  result:=fSyncCountChanged;
  fSyncCountChanged:=false;
end;
procedure THexEmulator.NewChar(C:ansichar);
  var i:integer;
begin
  if SyncLength=0 then begin
    IsFrameEnd:=false;
    exit;
  end;

  if length(HistoryString) < SyncLength //length(HexEmulator.SyncString)
    then HistoryString:=HistoryString+C
    else HistoryString:= copy(HistoryString,2,SyncLength)+C;
  //FrameEnd:=(HexEmulator.HistoryString=HexEmulator.SyncString);
  IsFrameEnd:=true;
  for i:=1 to SyncLength do begin  //do bytewise
    IsFrameEnd:= IsFrameEnd and
      (byte(SyncString[i]) = (byte(HistoryString[i]) xor byte(SyncXOR[i])) and byte(SyncAND[i]));
  end;
  if IsFrameEnd then begin
    inc(fSyncCount);
    fSyncCountChanged:=true;
  end
end;
procedure THexEmulator.ProcessChar(Sender: TObject;
  C: ansiChar; var ReplaceWith: AnsiString; Commands: TAdEmuCommandList;
  CharSource: TAdCharSource);
{procedure TForm1.AdEmulator_HexProcessCharOld(CP: TObject; C: Char;
    var Command: TEmuCommand);}
  var CShow:Ansistring; //char to actually display
      BinStr: string;
      //LeadingSpaces:byte;
      FrameEnd:boolean;
  const PendingChars:integer=0; //used where displayed numbers are multi-byte
  const WordInFrameCount:integer=0; //used to allow formatted frames to be displayed
  const LastC:ansiChar=char(0);
  const Blanking:boolean=false; //used to blank words after frame sync

  procedure LeftPadBinStr(N:cardinal);
  begin
    if fPadLeft
      then BinStr:=StringOfChar(' ',N - length(BinStr))+BinStr
      else  BinStr:=' '+BinStr;
  end;

  procedure Make4String(AsFloat:boolean=true; Signed:boolean=false);
  const V: array[1..4] of ansichar='1234';
  begin
    assert(PendingChars>0);
    if (PendingChars>4) then PendingChars:=4;
    if BigEndian
      then V[5-PendingChars]:=C
      else V[PendingChars]:=C;

    if (PendingChars>=4) then begin
        if AsFloat
          then  BinStr:=FloatToStrF(single(V),ffGeneral,4,3){+' '}
          else
            if Signed
              then begin
                BinStr:=IntToStr(Integer(V));
                LeftPadBinStr(12);
                end
              else begin
                BinStr:=UIntToStr(UInt32(V));
                LeftPadBinStr(11);
              end;
        PendingChars:=0;
        inc(WordInFrameCount);
       end
       else BinStr:='';
  end;
begin   //processchar
  if Form1.CheckBoxRxdIdle.checked then begin
    if RxIdle then begin
      //FrameEnd:=true;
      Commands.AddCommand(ecCR);
      Commands.AddCommand(ecLF);
    end;
  end;

  PendingChars:=PendingChars+1; //as at least C is pending
  //we do a raw invert and masking before any other processing at all
  if ( InvertData ) then begin
    C:= ansichar(not byte(C));
  end;
  if MaskMSB then begin
        C:=ansichar(127 and byte(C));
    end;
  NewChar(C);  //sync matching done here
  FrameEnd:=IsFrameEnd;
  if ShowChar
    then begin
        if UnprintablesBlank
             and ((byte(C)<32) or (byte(C)>127))
          then CShow:=' ' //don't try to print control codes
          else CShow:=C;
      end
    else CShow:='';
  case ShowAs of
    NoStr   : begin BinStr:=''; inc(WordInFrameCount); end;
    HexStr  : begin BinStr:=IntToHex(Byte(C),2); inc(WordInFrameCount); end;
    BinaryStr  : begin BinStr:=BinaryBL(Byte(C)); inc(WordInFrameCount); end;
    NibbleStr : begin  // nibbles divided by "."
                BinStr:=BinaryBL(Byte(C));
                insert('.',BinStr,5);
                inc(WordInFrameCount);
              end;
    Int8Str : begin
                BinStr:=IntToStr(shortint(C));
                LeftPadBinStr(5); //was3
                inc(WordInFrameCount);
               end;
    Uint8Str: begin
                BinStr:=IntToStr(byte(C));  //must have space enabled to work properly...
                LeftPadBinStr(4); //was4
                inc(WordInFrameCount);
              end;
    Int16Str,UInt16Str: begin
              if PendingChars>=2 //no chars ready
                then begin   //put a word together
                  if ShowAs=Int16Str
                    then begin
                      if BigEndian
                        then BinStr:=IntToStr(MakeInteger16(byte(LastC),byte(C)))
                        else BinStr:=IntToStr(MakeInteger16(byte(C),byte(LastC)));
                      LeftPadBinStr(7);
                    end
                    else begin //uint16
                      if BigEndian
                        then BinStr:=IntToStr(MakeWord(byte(LastC),byte(C)))
                        else BinStr:=IntToStr(MakeWord(byte(C),byte(LastC)));
                      LeftPadBinStr(6);
                    end;
                  PendingChars:=0; //used them
                  inc(WordInFrameCount);
                  end; //pending
              end;
     Int32Str: begin
                  Make4String(false,true);
                end;
     UInt32Str: begin
                  Make4String(false,false);
                end;

     Float4Str: begin
                  Make4String(true); //MakeFloat4String;
              end;//
  end; //case
  //Command.OtherStr := CShow+BinStr;
  ReplaceWith := CShow+ansistring(BinStr);
  if (HasTrailingSpace) {and not (ShowAs = Uint8str)}
    then ReplaceWith := ReplaceWith + ' ' //Command.OtherStr:=Command.OtherStr+' '
    else begin
//      if (CharCount and 1)<>0  //trys to give alternating colors...
//        then begin
//          Command.FColor:=Command.Fcolor xor 255;
//          Command.bColor:=Command.bcolor xor 255;
//        end;
    end;
  //IncCharCount(1);
  if FrameEnd
    then begin
      PendingChars:=0; // forces some sort of sync...
      WordInFrameCount:=0;
      Blanking:=false;
      if Form1.CheckBoxDisplayTimeStamp.Checked then begin
        TS := Now;
        if SyncLeading
        then
          ReplaceWith := char(13) + char(10) + TimeStampStr(-1,Now, Form1.ComboBoxDisplayTimeStampFormat.text) +
            TimeStampDelimiter + ReplaceWith
        else
          ReplaceWith := ReplaceWith + TimeStampDelimiter + TimeStampStr(-1,Now,Form1.ComboBoxDisplayTimeStampFormat.text) +
            char(13) + char(10);
      end else begin
        if (SyncLength=1) and SyncLeading
          then ReplaceWith := char(13) + char(10) + ReplaceWith
          else ReplaceWith := ReplaceWith + char(13) + char(10);
      end;
    end;
  if (fShowCount<>0)then begin
    if Blanking
      then ReplaceWith:=''
      else
        if (fShowCount=-1)
          then Blanking:=((C=CR) or (C=LF))
          else Blanking:=(WordInFrameCount>=fShowCount);
  end;


  if GulpCount>=1
    then begin
      dec(GulpCount);
      //Command.Cmd:=eNone; // swallow this char
      ReplaceWith := '';
    end;

  //Command.Ch:=char(0); //try to prevent spurious screen resizing
  //assert(length(Command.OtherStr)<=10); // is this valid or too late?
  assert(length(ReplaceWith)<=50); // is this valid or too late?
  LastC:=C;
//  if FrameEnd then begin
//    PendingChars:=0; // forces some sort of sync...
//    WordInFrameCount:=0;
//  end;

//  Form1.SetTerminalCharColor(Sender,CharSource,FrameEnd and fHighlightSync);
  if (FrameEnd and fHighlightSync)
      then Commands.AddCommand(ecReverseOnly)
      else Commands.AddCommand(ecRemoveReverse);
  Form1.SetTerminalCharColor(Sender,CharSource);
end;
//-------------------
procedure THexEmulator.SetSync(inSync,inXOR, inAND:AnsiString; inLeading:boolean;
                                inShowCount:integer;inHighlightSync:boolean=false);  //sets the Sync values
begin
 SyncString:=inSync;
 SyncLength:=length(SyncString);
 SyncAnd:=inAND;
 SyncXOR:=inXOR;
 SyncLeading:=inLeading;
 fShowCount:=inShowCount;
 fHighlightSync:=inHighlightSync;

 if length(SyncAND)<>length(SyncString) //sync must be same size or default to FF
    then begin
      SyncAND:=StringOfChar(AnsiChar(255),length(SyncString)); //CharStrL(#255,length(SyncString));
    end;
  if length(SyncXOR)<>length(SyncAnd) //default to 00
    then begin
      SyncXOR:=StringOfChar(AnsiChar(0),length(SyncAND)); //CharStrS(#0,length(SyncAND));
    end;
end;



end.
