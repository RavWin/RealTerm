unit CRC;

interface
  function  CRCAdd(S:ansistring;CRCType:integer=999):ansistring;
  procedure CRCType2UI(value:integer=999);
  function CRCTypeFromUI:integer;

implementation
uses CRC8, Checksums, ModbusCRC, sysutils, Realterm1;

function CRCAdd(S:ansistring; CRCType:integer=999):ansistring;
  var i:integer; CRCStr:ansistring;
begin
  if CRCType=999 then CRCType:= CRCTypeFromUI;

  if CRCType<>0
    then begin
      CRCStr:='';
      case abs(CRCType) of
        1: CRCStr:=CRC8_SMBUS(S);
        2: CRCStr:=CRC8_DALLAS(S);
        3: CRCStr:=ModbusCrc16String(S);
        4: CRCStr:=Checksum8(S);
        5: CRCStr:=Checksum16(S);
        6: CRCStr:=CheckXOR8(S);
        7: begin
              result:=CheckNMEA(S);
              exit;
           end//makes a complete packet of it.
        else ;
      end; //case
      if (CRCType<0) //IsHex
        then
          for i:=1 to length(CRCStr)
            do S:=S+IntToHex(Byte(CRCStr[i]),2) //turn it to hex
        else S:=S+CRCStr; //keep as binary
    end;
    result:=S;
end;


procedure CRCType2UI(value:integer=999);
begin //0=CRC Unchecked, 1=first drop down
  if value=999 then value:=CRCTypeFromUI;

  with Form1 do begin
    CheckBoxCRCHex.Enabled:=false;
    CheckBoxCRC.checked:= (value<>0);
    if (value<>0) then begin  //this allows Combobox and Hex to remain unchanged when CRC=0, so all controls can be set.
        ComboBoxCRC.ItemIndex:=abs(value)-1;
        CheckBoxCRCHex.Enabled:= not (ComboboxCRC.Text='NMEA') and not (ComboboxCRC.Text='COBS');
        CheckBoxCRCHex.checked:= (value<0);
     end;
    ComboBoxCRC.Enabled:=CheckBoxCRC.checked;
    CheckBoxCRCHex.Enabled:=CheckboxCRC.checked and CheckBoxCRCHex.Enabled;
  end; //with
end;

function CRCTypeFromUI:integer;
begin
  result:=0;
  if Form1.CheckboxCRC.checked then begin
    result:= Form1.ComboBoxCRC.ItemIndex+1;
    if Form1.CheckboxCRCHex.checked then result:= - result;
  end;
end;
end.
