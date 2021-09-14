unit Checksums;

interface

function Checksum8( msg :ansistring ) :ansichar;
function Checksum16( msg :ansistring ) :ansistring;
function CheckXOR8( msg :ansistring ) :ansichar;
function CheckNMEA( msg :ansistring ) :ansistring;

implementation
uses SysUtils;
function Checksum8( msg :ansistring ) :ansichar;
var crc: byte; i:integer;  ch:byte;
begin
  crc := 0;
  for i := 1 to length(msg) do begin
    ch:=byte(msg[i]);
    crc := crc+ch;
  end;
  result:= ansichar(crc);
end;

function Checksum16( msg :ansistring ) :ansistring;
var crc: word; i:integer;  ch:byte;
begin
  crc := 0;
  for i := 1 to length(msg) do begin
    ch:=byte(msg[i]);
    crc := crc+ch;
  end;
  result:= ansichar(hi(crc))+ansichar(lo(crc));
end;


function CheckXOR8( msg :ansistring ) :ansichar;
var crc: byte; i:integer;  ch:byte;
begin
  crc := 0;
  for i := 1 to length(msg) do begin
    ch:=byte(msg[i]);
    crc := crc xor ch;
  end;
  result:= ansichar(crc);
end;

//NMEA data is bracketed by $...* Checksum is XOR8, and excludes $*.
//Data= GPGGA,182447.00,4230.39209,N,09828.19232,W,1,10,0.86,4456.0,M,-26.1,M,,
//result= $GPGGA,182447.00,4230.39209,N,09828.19232,W,1,10,0.86,4456.0,M,-26.1,M,,*52
function CheckNMEA( msg :ansistring ) :ansistring;
  var Start,Count:integer;
begin
  //remove $* from ends of string if present
  Start:=1; Count:=length(msg);
  if Count=0 then begin
    result:='';
    exit;
  end;
  if msg[Count]='*' then dec(Count);
  if msg[1]='$' then begin
    Start:=2;
    dec(Count);
  end;

  msg:=Copy(msg,Start,Count);
  //calc result and restore $*
  result:='$'+msg+'*'+ansistring(IntToHex(byte(CheckXOR8(msg)),2));
end;

end.
