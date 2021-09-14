unit EscapeString;
// Expands a python style string ie one with \ (backslash) special chars
// useful to put non printable chars into a string in an edit box
// interprets \NNN as decimal NOT octal like Python and C
//$Date: 2004-02-12 23:49:25+13 $ $Revision: 1.0 $
// sjb 2/5/14 Moved NumericStringToChars into this module
//sjb 30/5/15 added HexString2Chars
interface
function ExpandEscapeString(S:string):string;
function ExpandEscapeCRString(S:string;bsR_CR:boolean=true;bsN_LF:boolean=false):string;
function ExpandEscapeEOLString(S:string):Ansichar;

function NumericStringToChars(var S :ansistring):boolean ;
function HexString2Chars(var S:ansistring):boolean;

implementation
uses ststrl,sysutils;

function ExpandEscapeEOLString(S:string):Ansichar;
begin
  if (S='LF') or (S='lf') then begin
    result:=#10;
    exit;
  end;
  if (S='CR') or (S='cr') then begin
    result:=#13;
    exit;
  end;
  S:=ExpandEscapeString(S); //anything else
  result:=ansichar(S[1]);             // but just the first char
end;

function ExpandEscapeCRString(S:string;bsR_CR:boolean=true;bsN_LF:boolean=false):string;
const FLAGS=[rfReplaceAll]; CR=#13;LF=#10; //, rfIgnoreCase
begin
  if bsR_CR then begin
      S:= stringreplace(S,'\r',CR, FLAGS);
      //but if escaped then \\r -> \CR -> \r
      S:= stringreplace(S,'\'+CR,'\r', FLAGS);
  end;
  if bsN_LF then begin
      S:= stringreplace(S,'\n',CR, FLAGS);
      //but if escaped then \\r -> \CR -> \r
      S:= stringreplace(S,'\'+CR,'\n', FLAGS);
  end;
  result:=S;

end;

function ExpandEscapeString(S:string):string;

  var R:string;
      numstr:string;
      C:char;
      P:integer;
      value:word;
      ConvertNumStrOK:boolean;

  procedure AppendGetRest(NewString:string;CharsToDump:integer);
  begin
     R:=R+NewString;
     S:=copy(S,CharsToDump+1,maxint);
  end;
  procedure Str2Radix(Radix:word=10);
    var  i:integer; v:word;
  begin
    value:=0;
    i:=2; //\ is at 1
    repeat
      v:=word(S[i])-word('0');
      if (v<0) or (v>=Radix) then break;
      value:=value*Radix;
      value:=value+v;
      inc(i);
    until i>4;
    dec(i);
    AppendGetRest(char(value),i);
end;
begin
  R:='';
  while (true) do
    begin
      P:=Pos('\',S);
      if (P=0) or (length(S)=1)
        then begin //no escapes, or last char is escape, so exit
          R:=R+S;
          break;
        end;
      // so a useful escape exists

      C:=S[P+1]; //get the char after the \

      R:=R+copy(S,1,P-1); //copy the chunk that precedes the backslash
      S:=copy(S,P,maxint); //copy the rest including the backslash
      case C of
        '\': AppendGetRest('\',2);
        'n': AppendGetRest(chr(10),2);
        'r': AppendGetRest(chr(13),2);
        't': AppendGetRest(chr(09),2);
        'v': AppendGetRest(chr(11),2);
        'b': AppendGetRest(chr(08),2);
        'a': AppendGetRest(chr(07),2);
        'f': AppendGetRest(chr(12),2);
        '"': AppendGetRest('"',2);
        chr(39):AppendGetRest(chr(39),2); //single quote '
        'x': begin
               numstr:=copy(S,2,3);
               ConvertNumStrOK:=Str2WordL('0'+numstr,value);
               if ConvertNumStrOK
                  then AppendGetRest(char(value),4)
                  else AppendGetRest('\'+numstr,4); //just use as literal if unreadable
             end;
      else begin
          if (C='0') and (S[3]='x')
          then begin //handle the incorrect sequence \0x??
               numstr:=copy(S,2,4);
               ConvertNumStrOK:=Str2WordL(numstr,value);
               if ConvertNumStrOK
                  then AppendGetRest(char(value),5)
                  else AppendGetRest('\'+numstr,5); //just use as literal if unreadable
          end
          else begin
          if (C>='0') and (C<='9') {must be an octal/decimal value}
            then begin
               Str2Radix;
//               numstr:=copy(S,3,P-1);  {octal string}
//               ConvertNumStrOK:=Str2WordL(numstr,value);
//               if ConvertNumStrOK
//                  then AppendGetRest(char(value),4)
//                  else AppendGetRest('\'+numstr,4); //just use as literal if unreadable
            end
            else begin //unknown escape sequence
              AppendGetRest('\'+C,2); //just pass the char straight thru and swallow the \
            end
          end;
        end
      end; {case}
    end;
    result:=R;
end;
//----------------------------------------
//takes a string of hex chars+others. Ignores all non hex chars
function HexString2Chars(var S:ansistring):boolean;
var i,j:cardinal;
    B:byte;
    C:ansichar;
    //R:ansistring;
    FirstNibble:boolean;
begin
  j:=1;
  FirstNibble:=true;
  for i := 1 to length(S) do begin
    C:=S[i];
    case C of
      '0'..'9':     B:=byte(C)-$30;
      'A'..'F': B:=byte(C)-$41+10;
      'a'..'f': B:=byte(C)-$61+10;
      else continue;
    end; //case
    if FirstNibble
      then S[j]:=ansichar(B shl 4)   //first (hi) nibble
      else begin
        inc(byte(S[j]),B);    //second (lo) nibble
        inc(j);
      end;
    FirstNibble:= not FirstNibble;
  end;//for
    result:=FirstNibble; //success if second nibble.
    if result
    then SetLength(S,j-1)
    else S:=''; //error
end;//fn
function NumericStringToChars(var S :ansistring):boolean ;
   var i,WC, Value:word; R:ansistring;
begin
  WC:=WordCountL(S,' ,');
  R:='';
  i:=1;
  result:=true;
  while ( i<=WC ) do begin
    if Str2WordL(ExtractWordL(i,S,' ,'),Value) and (Value<256)
      then
        R:=R+ansichar(Value)
      else begin
        R:='';
        result:=false;
        break;
      end;
    i:=i+1;
  end;
  S:=R;
end; //NumericStringToChars
//-------

end.




