unit DeviceChangeNotifier;
// https://github.com/bandoche/OhMyUSBCloner/blob/master/U_Usb.pas

interface
  uses Winapi.Windows, Winapi.Messages, System.SysUtils
       , System.Variants, System.Classes, Registry, Masks;
  type

    TDeviceNotifyProc = procedure(Sender: TObject; Added:boolean; const DeviceName: String) of Object;

    TDeviceNotifier = class
    private
      hRecipient: HWND;
      FNotificationHandle: Pointer;
      FDeviceArrival: TDeviceNotifyProc;
      FDeviceRemoval: TDeviceNotifyProc;
      FDeviceArrivalRemoval:TDeviceNotifyProc;
      FOnWin: TProc;
      fLastDevStr:string; //holds last devices inserted
      procedure WndProc(var Msg: TMessage);

    public
      constructor Create(GUID_DEVINTERFACE : TGUID);
      constructor CreateComportNotifier;
      property OnDeviceArrival: TDeviceNotifyProc read FDeviceArrival write FDeviceArrival;
      property OnDeviceRemoval: TDeviceNotifyProc read FDeviceRemoval write FDeviceRemoval;
      property OnDeviceArrivalRemoval: TDeviceNotifyProc read FDeviceArrivalRemoval write FDeviceArrivalRemoval;
      destructor Destroy; override;
      function GetUsbInfo(const ADeviceString: string;ADataList:TStrings;
                 out AFriendlyName,APortName: string ):boolean; overload;
      function GetUsbInfo(const ADeviceString: string; ADataList:TStrings):boolean; overload;

 //     procedure ShowLastDeviceInfo;
      //property OnWin: TProc read FOnWin write FOnWin;
    end;
    const
      GUID_DEVINTERFACE_COMPORT  : TGUID = '{86E0D1E0-8089-11D0-9CE4-08003E301F73}';

    var DeviceNotifier : TDeviceNotifier;

implementation
type
    TProc = procedure (text: string) of object;

    BroadcastHdr  = ^DEV_BROADCAST_HDR;
    DEV_BROADCAST_HDR = packed record
      dbch_size: DWORD;
      dbch_devicetype: DWORD;
      dbch_reserved: DWORD;
    end;
    TDevBroadcastHdr = DEV_BROADCAST_HDR;

  type
    PDevBroadcastDeviceInterface  = ^DEV_BROADCAST_DEVICEINTERFACE;
    DEV_BROADCAST_DEVICEINTERFACE = record
      dbcc_size: DWORD;
      dbcc_devicetype: DWORD;
      dbcc_reserved: DWORD;
      dbcc_classguid: TGUID;
      dbcc_name: Char;
    end;
    TDevBroadcastDeviceInterface = DEV_BROADCAST_DEVICEINTERFACE;

  const
    DBT_DEVICESOMETHING        = $0007;
    DBT_DEVICEARRIVAL          = $8000;
    DBT_DEVICEREMOVECOMPLETE   = $8004;
    DBT_DEVTYP_DEVICEINTERFACE = $00000005;

  constructor TDeviceNotifier.Create(GUID_DEVINTERFACE : TGUID);
  var
    NotificationFilter: TDevBroadcastDeviceInterface;
  begin
    inherited Create;
    hRecipient := AllocateHWnd(WndProc);
    ZeroMemory (@NotificationFilter, SizeOf(NotificationFilter));
    NotificationFilter.dbcc_size := SizeOf(NotificationFilter);
    NotificationFilter.dbcc_devicetype := DBT_DEVTYP_DEVICEINTERFACE;
    NotificationFilter.dbcc_classguid  := GUID_DEVINTERFACE;
    //register the device class to monitor
    FNotificationHandle := RegisterDeviceNotification(hRecipient, @NotificationFilter, DEVICE_NOTIFY_WINDOW_HANDLE);
  end;
  constructor TDeviceNotifier.CreateComportNotifier;
  begin
    Create(GUID_DEVINTERFACE_COMPORT);
  end;

  procedure TDeviceNotifier.WndProc(var Msg: TMessage);
  var
    Dbi: PDevBroadcastDeviceInterface;
    DevString,DevType,DeviceName,DriverName,FriendlyName,AClass:string;
    procedure GetNames;
    begin
      //DeviceName:=PChar(@Dbi.dbcc_name);
      DevString := PChar(@Dbi.dbcc_name);
      fLastDevStr:=DevString;
      //GetUsbInfo(DevString,DevType,DriverName,FriendlyName,AClass);

      //GetUsbInfo(sDevString,sDevType,sDriverName,sFriendlyName);
    end;
  begin
    //OnWin (Format ('msg = %d, wparam = %d, lparam = %d', [msg.Msg, msg.WParam, msg.LParam]));
    with Msg do
    if (Msg = WM_DEVICECHANGE) and ((WParam = DBT_DEVICEARRIVAL) or (WParam = DBT_DEVICEREMOVECOMPLETE) or
                                    (WParam = DBT_DEVICESOMETHING)) then
    try
      Dbi := PDevBroadcastDeviceInterface (LParam);
      if Assigned(Dbi) and (Dbi.dbcc_devicetype = DBT_DEVTYP_DEVICEINTERFACE) then
      begin
        GetNames();
        if WParam = DBT_DEVICEARRIVAL then
        begin
          if Assigned(FDeviceArrival) then
            FDeviceArrival(Self, True, PChar(@Dbi.dbcc_name));
          if Assigned(FDeviceArrivalRemoval) then
            FDeviceArrivalRemoval(Self, True, PChar(@Dbi.dbcc_name));

        end
        else
        if WParam = DBT_DEVICEREMOVECOMPLETE then
        begin
          if Assigned(FDeviceRemoval) then
            FDeviceRemoval(Self, False, PChar(@Dbi.dbcc_name));
          if Assigned(FDeviceArrivalRemoval) then
            FDeviceArrivalRemoval(Self, False, PChar(@Dbi.dbcc_name))
        end;
      end;
    except
      Result := DefWindowProc(hRecipient, Msg, WParam, LParam);
    end
    else
      Result := DefWindowProc(hRecipient, Msg, WParam, LParam);
  end;
// Registry Keys
const
  USBKEY  = 'SYSTEM\CurrentControlSet\Enum\USB\%s\%s';
  USBENUMKEY = 'SYSTEM\CurrentControlSet\Enum';
  USBSTORKEY = 'SYSTEM\CurrentControlSet\Enum\USB'; // \Enum\USBSTOR
  SUBKEY1  = USBSTORKEY + '\%s';
  SUBKEY2  = SUBKEY1 + '\%s';
//from https://github.com/bandoche/OhMyUSBCloner/blob/master/U_Usb.pas
function TDeviceNotifier.GetUsbInfo(const ADeviceString : string;
                                ADataList:TStrings):boolean;
var AFriendlyName, APortName : string;
begin
  result:=GetUsbInfo(ADeviceString,ADataList, AFriendlyName, APortName);
end;

function TDeviceNotifier.GetUsbInfo(const ADeviceString : string; ADataList:TStrings;
                               out AFriendlyName, APortName : string ):boolean;
var sWork,sKey1,sKey2,KeyStr,KeyEnumStr : string;
    oKeys,oSubKeys, U : TStringList;
    oReg : TRegistry;
    oSubKey,oValue:string;
    oType:TRegDataType;
    i,j,ii : integer;
    bFound : boolean;
function MoveToTop(Name:string):string;
var i:integer;
begin
  result:='';
  if not assigned(ADataList) then exit;
  I:=ADataList.IndexOfName(Name);
  if I>=0 then begin
    ADataList.Move(I,0);
    result:=ADataList.ValueFromIndex[0];
  end;
end;
begin
  AFriendlyName := '';
  APortName:='';
  if not assigned(ADataList) then begin
    U := TStringList.Create;
    ADataList:=U;
  end;


  if ADeviceString <> '' then begin
    bFound := false;
    oReg := TRegistry.Create;
    oReg.RootKey := HKEY_LOCAL_MACHINE;

    // Extract the portions of the string we need for registry. eg.
    // \\?\USB#Vid_4146&Pid_d2b5#0005050400044#{a5dcbf10- ..... -54334fb951ed}
    // We need sKey1='Vid_4146&Pid_d2b5' and sKey2='0005050400044'
    sWork := copy(ADeviceString,pos('#',ADeviceString) + 1,1026);
    sKey1 := copy(sWork,1,pos('#',sWork) - 1);
    sWork := copy(sWork,pos('#',sWork) + 1,1026);
    sKey2 := copy(sWork,1,pos('#',sWork) - 1);

    oKeys := TStringList.Create;
    oSubKeys := TStringList.Create;

    if oReg.OpenKeyReadOnly(USBENUMKEY) then begin
        oReg.GetKeyNames(oKeys);
        oReg.CloseKey;

   for i := 0 to (oKeys.Count - 1) do begin
    KeyEnumStr:=oKeys[i];
    KeyStr:=Format(USBENUMKEY+'\'+KeyEnumStr+'\%s\%s',[skey1,sKey2]);
    // Get the Device type description from \USB key
    //KeyStr:=Format(USBKEY,[skey1,sKey2]);
    if oReg.OpenKeyReadOnly(KeyStr) then begin //found this device

//      ADevType := oReg.ReadString('DeviceDesc');
//      AClass   := oReg.ReadString('Class');
//      AFriendlyName:= oReg.ReadString('FriendlyName');
//      AService:=oReg.ReadString('Service');
//      AMfg:=oReg.ReadString('Mfg');


        ADataList.Clear;
        ADataList.AddPair('RegistryKey',KeyStr); //future ref: https://superuser.com/questions/115854/open-registry-directly-to-a-given-key
        oReg.GetValueNames(oSubKeys);
          for j := 0 to (oSubKeys.Count - 1) do begin
            oSubKey:=oSubkeys[j];
            oType:=oReg.GetDataType(oSubKey);
            if (oType=rdString) or (oType=rdExpandString) //is it a string
              then begin
              oValue:=oReg.ReadString(oSubKey);
              ADataList.AddPair(oSubkey,oValue);
            end;
          end;
        oReg.CloseKey;
      if oReg.OpenKeyReadOnly(KeyStr+'\Device Parameters') then begin
          oReg.GetValueNames(oSubKeys);
          for j := 0 to (oSubKeys.Count - 1) do begin
            oSubKey:=oSubkeys[j];
            oType:=oReg.GetDataType(oSubKey);
            if (oType=rdString) or (oType=rdExpandString) then begin
              oValue:=oReg.ReadString(oSubKey);
              ADataList.AddPair(oSubkey,oValue);
            end;
          end;
        end;
      end;
      oReg.CloseKey;
      bFound:=true;
        MoveToTop('Service');
        MoveToTop('Mfg');
        MoveToTop('Class');
        APortName:=MoveToTop('PortName');
        AFriendlyName:=MoveToTop('FriendlyName');
//      if assigned(ADataList) then begin
//        ADataList.SetStrings(U);
//      end;
   end;
//      oKeys := TStringList.Create;
//      oSubKeys := TStringList.Create;

      // Get list of keys in \USBSTOR and enumerate each key
      // for a key that matches our sKey2='0005050400044'
      // NOTE : The entry we are looking for normally has '&0'
      // appended to it eg. '0005050400044&0'
      //if oReg.OpenKeyReadOnly(USBSTORKEY) then begin
//      if oReg.OpenKeyReadOnly(USBENUMKEY) then begin
//        oReg.GetKeyNames(oKeys);
//        oReg.CloseKey;
//
//        // Iterate through list to find our sKey2
//        for i := 0 to oKeys.Count - 1 do begin
//          if oReg.OpenKeyReadOnly(Format(SUBKEY1,[oKeys[i]])) then begin
//            oReg.GetKeyNames(oSubKeys);
//            oReg.CloseKey;
//
//            for ii := 0 to oSubKeys.Count - 1 do begin
//              if MatchesMask(oSubKeys[ii],sKey2 + '*') then begin
//                // Got a match?, get the actual desc and friendly name
//                if oReg.OpenKeyReadOnly(Format(SUBKEY2,[oKeys[i],
//                                        oSubKeys[ii]])) then begin
//                  ADriverDesc := oReg.ReadString('DeviceDesc');
//                  AFriendlyName := oReg.ReadString('FriendlyName');
//                  oReg.CloseKey;
//                end;
//
//                bFound := true;
//              end;
//            end;
//          end;
//
//          if bFound then break;
//        end;
//      end;

      FreeAndNil(oKeys);
      FreeAndNil(oSubKeys);
      U.Free;
    end
    else begin //key not found
      //AFriendlyName:='KeyNotFound';
    end;

    FreeAndNil(oReg);
  end;
  result:=bFound;
end;

  destructor TDeviceNotifier.Destroy;
  begin
    UnregisterDeviceNotification(FNotificationHandle);
    DeallocateHWnd(hRecipient);
    inherited;
  end;

  end.

