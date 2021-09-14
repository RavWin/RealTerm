unit ComportFinder;
interface
uses classes;

function GetPhysicalComNumber(const Value: String):integer;
function ComNumberStr(S:string):string;

type

  TComportList = class(TStringList)
  private
    fFormat : integer;
    fFirstAvailablePort:integer;
    FPrevious :tstringlist;
    FComports : tstringlist;
    fChangedPortStr : string;
    fChangedComName : string;
    fChangedAdded : boolean;   //change was plug in

    fChangedPortNumber : boolean;
    fShownRegKeyMissingMessage : boolean;
    
    function FindChangedPort: boolean;
    procedure ShowRegKeyMissingMessageOnce;

  protected
    //used for sutom sort of lists
    function SortCompareFn(List: TStringList; Index1, Index2: Integer): Integer;
    function LoadFromRegistry:boolean;
    //function ComNumber(S:string):boolean;
    function ComName(S:string):string;
  public
    ChangedPortStr :string;

    NewComName : string;  //a semaphore used for restarting the port
    //function GetChangedComNumber;
    property FirstAvailablePort:integer read fFirstAvailablePort;
    constructor Create;
    destructor Destroy; override;
    function GetComportByKey(Key:string):string;
    function Update:integer;

  end;

  //function GetCommNumberByKey(Key:string):string;
  //procedure GetComDevicesList(out List:TStrings; out FirstAvailablePort:word; Format:integer=1; Sorted:boolean=false);

  var ComportList : TComportList;

implementation

uses registry , strutils, SysUtils, math, windows, dialogs, consoleconnector;
//{$R *.dfm}
//----------- Comport functions moved from Realterm
function ComNumberStr(S:string):string;  //returns just the string if it
  var num,code:integer; numstr:string;
begin
  numstr:=StringReplace(S,'\\.\COM','',[]);
  val(NumStr ,Num,Code);
  if code=0
    then result:=NumStr  //is numeric comport
    else result:=S;      //is something else...
end;
//function Get_ComPortString(Com:TApdWinsockPort; Raw:boolean=false): string;
//begin
//  //with Com do begin
//    if Com.DeviceLayer=dlWinsock
//      then begin
//        if (Com.wsMode = wsServer)
//           then result:='server'
//           else result:=Com.WsAddress;
//        if Com.WsPort<>''
//          then result:=result+':'+Com.WsPort;
//      end
//      else begin
//        //result:=inttostr(Com.ComNumber);
//        result:=Com.ComName;
//        if not Raw then result:=ComNumberStr(result);
//
//      end;
//  //end;
//end;
//
//function IsSame_Comport(S:string; Com:TApdWinsockPort):boolean;
//var CN:string;
//begin
//  Get_ComPortString(Com,true);
//  result:= (S = CN) and  (S=ComNumberStr(CN));
//end;

function GetPhysicalComNumber(const Value: String):integer;
  var ComNumber, code:integer;
begin
  // Parse comport string to find numbered comport
  // eg a simple number: must be a physical comport#
  result:=-1; //invalid
  val(Value,ComNumber,Code);
  if code=0
    then begin //is a numeric port
      result:=ComNumber;
    end;
end;

function GetComXXNumber(Value: String):integer; //get a number in string like "COM43"
  var ComNumber, code:integer;
begin
  // Parse comport string to find numbered comport
  // eg a simple number: must be a physical comport#
  result:=-1; //invalid
  value:=AnsiRightStr(Value,length(value)-length('COM'));
  val(Value,ComNumber,Code);
  if code=0
    then begin //is a numeric port
      result:=ComNumber;
    end;
end;

//--------------------------------------------------
function GetRegistryValue(KeyName,ValName: string): string;
var
  Registry: TRegistry;
begin
  Registry := TRegistry.Create(KEY_READ);
  try
    Registry.RootKey := HKEY_LOCAL_MACHINE;
    // False because we do not want to create it if it doesn't exist
    Registry.OpenKey(KeyName, False);
    Result := Registry.ReadString(ValName);
  finally
    Registry.Free;
  end;
end;
//function JustComNumberStr(S:string):string;
//begin
//  result:=AnsiRightStr(S,length(S)-length('COM'));
//end;
function JustComNumberStrOrCreateFileName(S:string):string;
begin
  result:=AnsiRightStr(S,length(S)-length('COM'));
  if (ansipos('COM',S)<>1) and (strtointdef(result,-1)<0) //must be COMN
    then result:='\\.\'+S;  // it was not a numeric comport
end;

function JustKeyStr(S:string):string;
begin
  result:=AnsiRightStr(S,length(S)-length('\Device'));
end;
const SerialCommRegKey='HARDWARE\DEVICEMAP\SERIALCOMM';

//function GetCommNumberByKey(Key:string):string;
//var S:string;
//begin
//  S:=GetRegistryValue(SerialCommRegKey,'\Device'+Key);
//  S:=JustComNumberStrOrCreateFileName(S); //JustComNumberStr(S);
//  result:=S;
//end;

function PortCompareStr(List: TStringList; Index1, Index2: Integer): Integer;
var S1,S2:string;
begin
  S1:=List.strings[Index1]; S2:=List.Strings[Index2];
  if (S1[1]='\') and (S2[1]<>'\')
    then result:=1
    else if (S1[1]<>'\') and (S2[1]='\')
      then result:=-1
      else result:=AnsiCompareStr(S1,S2);
end;
//procedure GetComDevicesList(out List:TStrings; out FirstAvailablePort:word; Format:integer=1; Sorted:boolean=false);
//var
//  Reg: TRegistry;
//  Val:TStringList;
//  PortList:TStringList;
//  I:Integer;
//  ThisKey,ThisValue,ThisDevice,ThisPort:string;
//const MAXPORTNUM=9999;
//
//procedure SortByPortNumber;//Scans through ports. Finds FirstAvailablePort, Optionally sorts
//var PortNum{, CurrentPos},FindPos:integer;
//
//begin
//  //CurrentPos:=0;
//  if sorted then begin
//    Val.CustomSort(PortCompareStr);
////    FirstAvailablePort:=strtointdef(
//  end;
//  List.Assign(Val);
////  for PortNum:=0 to MaxPortNum do
////    begin
////      FindPos:=PortList.IndexOf(inttostr(PortNum));
////      if FindPos>-1  //this port is found
////        then begin
////          if FirstAvailablePort=0  then FirstAvailablePort:=PortNum;
////          if Sorted then List.add(Val.Strings[FindPos]); //if we are sorting add them 1 by 1
////        end;
////    end;//for
////  if not sorted then List.Assign(Val); //if we are not sorting, add all just as they are
//end;//fn
//
//
//begin
//  Reg:=TRegistry.Create(KEY_READ);
//  try
//    FirstAvailablePort:=0;
//    Val:=TStringList.Create;
//    PortList:=TStringList.Create;
//    try
//      Reg.RootKey:=HKEY_LOCAL_MACHINE; // Section to look for within the registry
//      if not Reg.OpenKey(SerialCommRegKey,False) then
//              ShowMessage('You (probably) do NOT have any Serial Port devices installed in your system'
//              +chr(13)+chr(10)+chr(10)+'Plug in a USB serial adaptor or other serial port device.'
//              +chr(13)+chr(10)+chr(10)+'Launch the  Device Manager and look at Ports(From commandline you can run "mmc devmgmt.msc")'
//              +chr(13)+chr(10)+chr(10)+'Error is: Unable to get ComDevicesList from registry.opening registry key: "'+SerialCommRegKey+'"')
//             // case True of
//               // mbOK : ShellExecute(Handle, 'open', 'mmc devmgmt.msc' ,nil,nil, SW_SHOWNORMAL);
//              //end;
//      else
//      begin
//        Reg.GetValueNames(Val);
//
//        for I:=0 to Val.Count-1 do
//        begin
//          ThisKey:=Val.Strings[I];
//          ThisDevice:=AnsiRightStr(ThisKey, length(ThisKey)-length('\Device'));
//          ThisValue:=Reg.ReadString(ThisKey);
//          //ThisPort:=JustComNumberStr(ThisValue)
//          ThisPort:=JustComNumberStrOrCreateFileName(ThisValue);
//
//          PortList.add(ThisPort);
//          case Format of
//            0: Val.Strings[I]:=ThisValue;
//            1: Val.Strings[I]:=ThisDevice+'='+ThisValue;
//            2: Val.Strings[I]:=ThisPort+' = '+JustKeyStr(ThisKey);
//            3: Val.Strings[I]:=ThisDevice;
//            else Val.Strings[I]:=ThisValue;
//          end; //case
//      end; //for
//      SortByPortNumber;
//      end;
//    finally
//      Reg.Free;
//    end;
//  finally
//    Val.Free;
//    PortList.Free;
//  end;
//end;

function CompareStringLists(LB,LS:tstringlist) : integer;
//find first element of LB missing from LS. LB is bigger list, LS is shorter 
// returns -1 if none
var i,index:integer;
begin
  result:=-1;
  for i := 0 to LB.Count-1 do begin
    index:=LS.IndexOf(LB.Strings[i]);
    if index=-1 then begin  //match is not found.
      result:=i;
      break;
    end;
  end; //for
end;

//------------------------------------------------------
function TComportList.ComName(S:string):string;
  var L:integer;
begin
  result:=S;
  if S='' then exit; 
  L:=AnsiPos(' ',S); //find space at end of number...
  if L>1 then result:=AnsiLeftStr(S,L-1);
  if result[1]<>'\' then result:='\\.\COM'+result;
end;
//strtointdef(result,-1)<0) //must be COMN

function TComportList.FindChangedPort:boolean;
var LB,LS:tstringlist; var Delta, I:integer;
begin
  LB:=self;
  LS:=fPrevious;
  Delta:= self.Count - fPrevious.Count; //+ve if gained then
  if Delta<0 then begin //strings have been lost
    LS:=self;
    LB:=fPrevious;
  end;
  I:=CompareStringlists(LB,LS);
  fChangedAdded:=(I>0) and (Delta>0);
  if (I>0) then begin  //add or remove
      fChangedPortStr:=LB.Strings[I];
    end else begin
      fChangedPortStr:=''; //no change
  end;
end;

function TComportList.GetComportByKey(Key:string):string;
var S:string;
begin
  S:=GetRegistryValue(SerialCommRegKey,'\Device'+Key);
  S:=JustComNumberStrOrCreateFileName(S); //JustComNumberStr(S);
  result:=S;
end;

function TComportList.SortCompareFn(List: TStringList; Index1, Index2: Integer): Integer;
var S1,S2:string;
begin
  S1:=List.strings[Index1]; S2:=List.Strings[Index2];
  if (S1[1]='\') and (S2[1]<>'\')
    then result:=1
    else if (S1[1]<>'\') and (S2[1]='\')
      then result:=-1
      else result:=AnsiCompareStr(S1,S2);
end;
procedure TComportList.ShowRegKeyMissingMessageOnce;
begin
  if not fShownRegKeyMissingMessage then
    Console.ShowMessage('You (probably) do NOT have any Serial Port devices installed in your system'
              +chr(13)+chr(10)+chr(10)+'Plug in a USB serial adaptor or other serial port device.'
              +chr(13)+chr(10)+chr(10)+'Launch the  Device Manager and look at Ports(From commandline you can run "mmc devmgmt.msc")'
              +chr(13)+chr(10)+chr(10)+'Error is: Unable to get ComDevicesList from registry.opening registry key: "'+SerialCommRegKey+'"');
  fShownRegKeyMissingMessage:=true;
end;
function TComportList.LoadFromRegistry:boolean;
var
  Reg: TRegistry;
  Val:TStringList;
  PortList:TStringList;
  I:Integer;
  ThisKey,ThisValue,ThisDevice,ThisPort:string;
  ThisComNumber:integer;

begin
    fFirstAvailablePort:=0;
    Val:=TStringList.Create;
  try
    //PortList:=TStringList.Create;
    Reg:=TRegistry.Create(KEY_READ);
    try

      Reg.RootKey:=HKEY_LOCAL_MACHINE; // Section to look for within the registry
      result:= false;
      if not Reg.OpenKey(SerialCommRegKey,False) //don't create it
      then ShowRegKeyMissingMessageOnce
      else
      begin
        Reg.GetValueNames(Val);
        for I:=0 to Val.Count-1 do
        begin
          ThisKey:=Val.Strings[I];
          ThisDevice:=AnsiRightStr(ThisKey, length(ThisKey)-length('\Device'));
          ThisValue:=Reg.ReadString(ThisKey);
          //ThisPort:=JustComNumberStr(ThisValue)
          ThisPort:=JustComNumberStrOrCreateFileName(ThisValue);
          ThisComNumber:=GetComXXNumber(ThisValue);
          if ThisComNumber>0 then
            if fFirstAvailablePort<=0
              then fFirstAvailablePort:=ThisComNumber
              else fFirstAvailablePort:=min(ThisComNumber, fFirstAvailablePort);

          //PortList.add(ThisPort);
          case fFormat of
            0: Val.Strings[I]:=ThisValue;
            1: Val.Strings[I]:=ThisDevice+'='+ThisValue;
            2: Val.Strings[I]:=ThisPort+' = '+JustKeyStr(ThisKey);
            3: Val.Strings[I]:=ThisDevice;
            else Val.Strings[I]:=ThisValue;
          end; //case
      end; //for
      //if sorted then begin
      Val.CustomSort(PortCompareStr);
      FPrevious.Assign(Self);
      Self.Assign(Val);
      result:=true;
      end;
    finally
      Reg.Free;
    end;
  finally
    Val.Free;
    //PortList.Free;
  end;
end;

function TComportList.Update:integer;
begin
  if LoadFromRegistry then begin
    FindChangedPort;
    ChangedPortStr:=fChangedPortStr;
    fChangedComName := ComName(ChangedPortStr);
    if fChangedAdded
      then NewComName:=fChangedComName
      else NewComName:='';
  end;
end;
constructor TComportList.create;
begin
  inherited Create;
  FPrevious:=TStringList.create;
  fFormat:=2;
  LoadFromRegistry;   //init it...
  FPrevious.Assign(Self);
end;
destructor TComportList.Destroy;
begin
  FPrevious.free;
  inherited;
end;

//-----------------

initialization
  ComportList:=TcomportList.create;
finalization
  ComportList.free;
end.
