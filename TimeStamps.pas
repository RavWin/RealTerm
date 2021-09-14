//unify timestamp formatting functions into one place...
unit TimeStamps;

interface
uses Sysutils, DateUtils , math;

  function MakeAutoFileName(FName:string; Format:integer=0;Keep:boolean=true):string; //Only to be used by one process at a time, as it is not re-entrant as keeps a lastT
  //call with fname='' to restart sequential numbering . Keep false to just demo result and not move pointers
  function TimeStampStr(Format:integer; TS:TDateTime; CustomFormat:string=''):ansistring;
  //type tTimeStampFormat=(tsUnix,tsUnixHex,tsMatlab,tsSystem,tsCustomFormat,tsFileYMD,tsFileUnix);
  function RxIdle(Ticks:longint=0):boolean; //timer for rx idle period
implementation

uses oomisc;
var RxIdleTimer:EventTimer; RxIdleTicks:longint;
function RxIdle(Ticks:longint=0):boolean;
 begin
   if Ticks<>0 then RxIdleTicks:=Ticks; //init the value
   result:=TimerExpired(RxIdleTimer);
   NewTimer(RxIdleTimer,RxIdleTicks);
end; //fn

function TimeStampStr(Format:integer; TS:TDateTime; CustomFormat:string=''):ansistring;
// =always use custome format (so radiogroup can change without affecting other users
var TD:TDateTime;
  function UnixDateStr(AsHex:boolean=false):string;
  begin
    TD:=TS-UnixDateDelta;
    if AsHex
      then result:= inttohex( round(TD*24*3600),8)
      else result:= inttostr( round(TD*24*3600));
  end;
  function MatlabDateStr:string;
  const MatlabDateDelta=-693960;
  begin
    TD:=TS-MatlabDateDelta;
    result:= floattostrf(TD,ffgeneral,12,2);
  end;
  function CustomFormatDateStr:string;
  //var S:string;
  begin
    DateTimeToString(result,CustomFormat,TS);//ymds
    //result:=S;
  end;

  function SystemDateStr:string;
  begin
    result:='"'+DateTimeToStr(TS)+'"';//System/Locale format
  end;

  begin
    case Format of
      0: result:='';
      1: result:=UnixDateStr(false);//unix
      2: result:=UnixDateStr(true); //unixHex
      3: result:=MatlabDateStr;//matlab
      4: result:=SystemDateStr;//:='"'+DateTimeToStr(TS)+'"';//System/Locale format
      -1, 5: result:=CustomFormatDateStr;
      else result:='';
    end; //case
  end; //fn

{$WRITEABLECONST ON}
function MakeAutoFileName(FName:string; Format:integer=0;Keep:boolean=true):string; //Only to be used by one process at a time, as it is not re-entrant as keeps a lastT
    const SeparatorChar='_';
    var T:tdatetime; SameMinute:boolean; FileExtensionIndex:integer; D:string;
    const LastT:tdatetime=0; SequentialFileNumber:cardinal=1;

  begin
    result:=FName; //default
    if FName='' then begin  //Clear - but at moment it leaves T,LastT alone, so SameMinute not affected
      SequentialFileNumber:=1;
      exit;
    end;
      T:=now;
      SameMinute:=floor(T*24*60) = floor(LastT*24*60);
      case Format of
        0: D:='';
        1: if SameMinute
              then DateTimeToString(D, SeparatorChar+'yyyy-mm-dd_hhnn-ss',T)//ymds
              else DateTimeToString(D, SeparatorChar+'yyyy-mm-dd_hhnn',T);//ymds
        2: D:=SeparatorChar+ inttostr(DateTimetoUnix(T));//UnixDateStr(now);//unix
        3: begin
             D:=SeparatorChar+ inttostr(SequentialFileNumber);
             if Keep then inc(SequentialFileNumber);

        end;
        else D:='';
      end; //case
      FileExtensionIndex:=LastDelimiter('.', result); //find the end...
      if FileExtensionIndex=0 then FileExtensionIndex:=length(result)+1;
      insert(D,result,FileExtensionIndex); //and insert it before the "."
      if Keep then LastT:=T; //save for next time
    end; //fn


end.
