unit GlobalHotkeys;
{ Support Global (windows wide) hotkeys
The basic idea he, is that you add menuitems that have shortcut keys defined
Then register/unregister them all as global hotkeys
You must add a WM_Hotkey method to your form which calls ProcessWMHotKey.
ProcessWMHotKey  parses key and calls the OnClick method of the menu

See:
http://www.swissdelphicenter.com/torry/showcode.php?id=2375
http://www.delphitips.net/2007/04/01/global-system-hotkey/
To help debug: http://www.tranglos.com/activehotkeys/

Hotkeys are identified by globalatoms. These seem to be a global namespace, so names like "hotkey1" in the
examples seem a very poor choice. Here I use the applicationname+ +..
F12 appears to be a debug hotkey, perhaps made by Delphi on my system, or maybe by windows

}

interface
uses Vcl.Menus,System.Classes,Windows, Messages, SysUtils, math,forms;
const MAX_NUM_HOTKEYS=40;
type
  TGlobalHotkeys= class
  private
    { Private declarations }
    //GlobalAtomNameBase:string; //used to make windows wide name unique to this application
    //GlobalAtomNameIncludesControlName:boolean; //makes the name include the control
    fHandle:THandle; //handle of upper window???
    fNumHotkeys:integer;
    fMenuItems:array[1..MAX_NUM_HOTKEYS] of TMenuItem;
    fShortcuts:array[1..MAX_NUM_HOTKEYS] of TShortCut;
    fHotkeyIDs:array[1..MAX_NUM_HOTKEYS] of cardinal;
    //fHandles:array[1..MAX_NUM_HOTKEYS] of THandle;
    procedure ShortCutToHotKey(HotKey: TShortCut; var Key : Word; var Modifiers: cardinal);
    procedure RegisterKey(HotKey:TShortcut; Handle:THandle; HKAtomName:string; out Hotkey_id:cardinal);
    procedure UnRegisterKey(Handle:THandle; var Hotkey_id:cardinal);
  public
    { Public declarations }
    GlobalAtomNameBase:string; //used to make windows wide name unique to this application
    GlobalAtomNameIncludesControlName:boolean; //makes the name include the control
    procedure AddMenuHotkey(M:TMenuItem; Shortcut:TShortcut=0);
    procedure RegisterAll(Register:boolean=true;Handle:THandle=0); //can beused to turn on/off all
    procedure UnRegisterAll(Handle:THandle);
    procedure ProcessWMHotKey(var Msg: TWMHotKey);
    constructor Create; overload;
  end;
function GetHotKeyIDName(HotKeyID:integer; PrependHotkeyID:boolean=false):string; //look up the global atom name associated with hotkey

var
  GlobalHotKeys1: TGlobalHotkeys;

implementation



procedure TGlobalHotkeys.ShortCutToHotKey(HotKey: TShortCut; var Key : Word; var Modifiers: cardinal);
var
   Shift: TShiftState;
begin
   ShortCutToKey(HotKey, Key, Shift);
   Modifiers := 0;
   if (ssShift in Shift) then
   Modifiers := Modifiers or MOD_SHIFT;
   if (ssAlt in Shift) then
   Modifiers := Modifiers or MOD_ALT;
   if (ssCtrl in Shift) then
   Modifiers := Modifiers or MOD_CONTROL;
end;



//const HOTKEYID_BASE=71777; //arbitary number

procedure TGlobalHotkeys.AddMenuHotkey(M:TMenuItem; Shortcut:TShortcut=0);
var I:integer;
begin
  inc(fNumHotKeys);
  I:=min(fNumHotKeys,MAX_NUM_HOTKEYS);
  fMenuItems[I]:=M;
  if (Shortcut<>0)
    then fShortcuts[I]:=Shortcut
    else fShortcuts[I]:=M.ShortCut;
  //HOTKEYID_BASE+I;
end;

procedure TGlobalHotkeys.RegisterKey(HotKey:TShortcut; Handle:THandle; HKAtomName:string; out Hotkey_id:cardinal);
var
   Key : Word;
   Modifiers: cardinal;
begin
   ShortCutToHotKey(HotKey, Key, Modifiers);
   Hotkey_id := GlobalAddAtom(pwidechar(HKAtomName));
   RegisterHotKey(Handle, Hotkey_id, Modifiers, Key);
end;
procedure TGlobalHotkeys.UnRegisterKey(Handle:THandle; var Hotkey_id:cardinal);
begin
   UnRegisterHotKey(Handle, Hotkey_id);
   GlobalDeleteAtom(Hotkey_id);
   Hotkey_id:=0;
end;
procedure TGlobalHotkeys.RegisterAll(Register:boolean=true;Handle:THandle=0);
var
  I: Integer;
  HKAtomName:string;
begin
  fHandle:=Handle; //save to
  for I := 1 to fNumHotkeys do begin
    if Register
      then begin
            fHotkeyIDs[I]:=I;
            HKAtomName:=GlobalAtomNameBase+'_'+inttostr(I);
            if GlobalAtomNameIncludesControlName
              then HKAtomName:=HKAtomName+'_'+fMenuItems[I].Name;
            RegisterKey(fMenuItems[I].Shortcut,fHandle, HKAtomName,fHotkeyIDs[I])
      end
      else UnRegisterKey(fHandle,fHotkeyIDs[I]);
  end;
end;
procedure TGlobalHotkeys.UnRegisterAll(Handle:THandle);
begin
  RegisterAll(false,Handle);
  fNumHotKeys:=0;
end;

//---------
procedure TGlobalHotkeys.ProcessWMHotKey(var Msg: TWMHotKey);
var
  I: Integer;
begin
  for I := 1 to fNumHotkeys do begin
    if (Msg.HotKey = fHotKeyIds[I]) then  begin
      if assigned(fMenuItems[I].OnClick) then
        fMenuItems[I].OnClick(nil);
      break;
    end;
  end;
end;

function GetHotKeyIDName(HotKeyID:integer;PrependHotkeyID:boolean=false):string;
var BufStr:widestring;
    PBufStr:PWideChar;
    //size:integer;
begin
  //size:=20;
  SetLength(BufStr,255);
  PBufStr := PWideChar(BufStr);
  GlobalGetAtomName(HotKeyID,pBufStr,255);
  if PrependHotkeyID
    then result:=inttostr(HotKeyID)+':'+BufStr
    else result:=BufStr;
end;
//-----------
constructor TGlobalHotKeys.Create();
begin
  inherited;
  fNumHotKeys:=0;
  GlobalAtomNameBase:=Application.Title;
  GlobalAtomNameIncludesControlName:=true; //and include the name of the control...
end;
initialization
  GlobalHotKeys1:=TGlobalHotKeys.create;
finalization
  GlobalHotkeys1.Free;
end.
