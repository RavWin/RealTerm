unit Helpers;

interface

uses vcl.samples.spin //TSpin
      ,system.Classes,Vcl.ExtCtrls,System.SysUtils, vcl.controls, //TRadioGroup
      StdCtrls, VCL.Dialogs, VCL.Menus, VCL.Graphics, StSystem, ioutils   // TCombobox
;
//procedure SpinEditSetValue(Spin:TSpinEdit; Value:integer);
function QuoteFilename(S:string):string;
function ExpandEnvVars(const Str: string): string;
function DirectoryExistsOrMakeIt(FName:string; MissingStr: string = 'Directory does not exist';ResultIfNoDirInFNAME:boolean=true):boolean; //true if DirExists when done
function CompareStringLists(LB,LS:tstringlist) : integer;
function BoolColor(B:boolean; CT:TColor=clLime; CF:tColor=clRed):TColor;

//TRadioGroupHelper = class helper for TRadioGroup
//public
//  procedure SetItemByString(Value:String);
//  procedure AddDblClick(RB:TRadioButton; NButton:integer=-1);
//  procedure AddHintToRadioGroupButton(RG:TRadioGroup; Hint:string; NButton:integer=-1);
//
//end;
procedure SetGroupItemByString(Value:String; RadioGroup:TRadioGroup);
procedure AddDblClickToRadioGroup(RG:TRadioGroup; RB:TRadioButton; NButton:integer=-1);
procedure AddHintToRadioGroupButton(RG:TRadioGroup; Hint:string; NButton:integer=-1);
//procedure ComboBoxPutStringAtTop(CB:TComboBox; MaxLength:integer);
//procedure ComboBoxClearExcept(CB:TComboBox; NKeepAtTop:cardinal=0;NKeepAtEnd:cardinal=1);
//procedure ComboBoxPushString(CB:TComboBox; S:string; Maxlength:Integer=100);
//function ComboboxGetStringPutAtTop(CB:TComboBox):string;

type TSpinEditHelper = class helper for TSpinEdit
  public
    procedure SetValue(Value:integer); //sets value without triggering OnChange event
  end;

type TComboboxHelper = class helper for TCombobox
  private
  public
  procedure AddListAtTop(L: TStrings);
  procedure PutStringAtTop(MaxLength:integer=100);
  procedure ClearExcept(NKeepAtTop:cardinal=0;NKeepAtEnd:cardinal=1);
  procedure PushString(S:string; Maxlength:Integer=100);
  function  GetStringPutAtTop:string;
  procedure RightJustify;
  procedure LeftJustify;
  function FileChoose(OpenDialog: TOpenDialog):boolean;
  function SetFilenameCheckFileExists(FName: string=''): boolean;
  function SetFilenameCheckPathExists(FName:string=''; CheckIsFile:boolean=false):boolean; //if FName is empty just check...
  function SetFilenameCheckFileOrPathExists(FName:string=''; CheckIsFile:boolean=true; CheckIsPath:boolean=true):boolean; //true if either a path or a file
end;

type TRadioButtonHelper = class helper for TRadioButton
  public
  procedure ToggleChecked;    //without triggering OnClick
  procedure SetChecked(Value:boolean); //without triggering OnClick
end;

type TCheckBoxHelper = class helper for TCheckBox
  public
  procedure ToggleChecked;    //without triggering OnClick
  procedure SetChecked(Value:boolean); //without triggering OnClick
end;

type TMenuItemHelper = class helper for TMenuItem
  public
  procedure ToggleChecked;    //without triggering OnClick
  procedure SetChecked(Value:boolean); //without triggering OnClick
  procedure SetCheckedFromBit(var V:cardinal; mask:cardinal=0); //Used to check menuitems from a flag byte/word. Call repeatedly , from bit0
  procedure GetCheckedToBit(var V:cardinal; mask:cardinal=0); //set bit in V from checked. shifting from left, so must call correct number of times i.e. 8,16 etc
end;

type TOpenDialogHelper = class helper for TOpenDialog
  public
    function ExecuteMakeDirIfMissing: boolean;
end;

implementation
uses Windows, {graphics,}ConsoleConnector;

const CRLF=#13+#10;
//function QuoteFilename(S:string):string;
//begin
//  if (pos(' ',S)>0) then S:='"'+S+'"';
//  result:=S;
//end;
function QuoteFilename(S:string):string;
  var P:string;
begin
  P:=tpath.GetFullPath(S);
  if (pos(' ',S)>0) then S:='"'+S+'"';
  result:=S;
end;
function BoolColor(B:boolean; CT:TColor=clLime; CF:tColor=clRed):TColor;
begin
    if B
    then result:=CT
    else result:=CF;
end;

//---------------------
procedure SpinEditSetValue(Spin:TSpinEdit; Value:integer);
var OnChangeEvent: TNotifyEvent;
begin
  OnChangeEvent:=Spin.OnChange;
  Spin.OnChange:=nil;
  Spin.Value:=Value;
  Spin.OnChange:=OnChangeEvent;
end;

procedure TSpinEditHelper.SetValue(Value:integer);
var OnChangeEvent: TNotifyEvent;
begin
  OnChangeEvent:=OnChange;
  OnChange:=nil;
  self.Value:=Value;
  OnChange:=OnChangeEvent;
end;
//-------------------------------------
procedure TMenuItemHelper.SetChecked(Value:boolean);
var OnEvent: TNotifyEvent;
begin
  OnEvent:=OnClick;
  OnClick:=nil;
  Checked:=Value;
  OnClick:=OnEvent;
end;
procedure TMenuItemHelper.ToggleChecked;
begin
  SetChecked(not Checked);
end;
// set/clear from bits. Called successively for each menuitem
// normally tests bit0, and shifts V at each call.
// OR specify MASK, and V is not shifted
procedure TMenuItemHelper.SetCheckedFromBit(var V:cardinal; mask:cardinal=0);
begin
  if self<>nil then begin
    if mask=0
      then SetChecked((1 and V)>0)
      else SetChecked((mask and V)>0);
    end;
  if mask=0 then V:=V shr 1;
end;
procedure TMenuItemHelper.GetCheckedToBit(var V:cardinal; mask:cardinal=0);
  var M:cardinal;
begin
  if mask=0 then V:=V shl 1; //move previous bits over
  if self<>nil then begin
    if mask=0
      then M:=1
      else M:=mask;
    if Checked
      then V:=V or M;
  end;
end;
//-------------------------------------

procedure TRadioButtonHelper.SetChecked(Value:boolean);
var OnEvent: TNotifyEvent;
begin
  OnEvent:=OnClick;
  OnClick:=nil;
  Checked:=Value;
  OnClick:=OnEvent;
end;
procedure TRadioButtonHelper.ToggleChecked;
begin
  SetChecked(not Checked);
end;
//-------------------------------------

procedure TCheckBoxHelper.SetChecked(Value:boolean);
var OnEvent: TNotifyEvent;
begin
  OnEvent:=OnClick;
  OnClick:=nil;
  Checked:=Value;
  OnClick:=OnEvent;
end;
procedure TCheckBoxHelper.ToggleChecked;
begin
  SetChecked(not Checked);
end;
//-------------------------------------
//procedure SetItemByString(Value:String; Default:integer=0; UseItemNumber:boolean=true; MatchLength:integer=0;);
//  var i:integer;
//      ThisItem:string;
//begin
//  if UseItemNumber and TryStrToInt(Value,i) then begin
//     if (i>0) and (i<RadioGroup.
//    exit;
//  end;
//  Value:=uppercase(Value);
//  for i:=0 to RadioGroup.ControlCount-1 do begin
//    ThisItem:= uppercase(RadioGroup.Items[i]);
//    if Value[1]= ThisItem[1]
//      then begin
//        RadioGroup.ItemIndex:=i; // set when match found
//        exit;
//      end;
//  end;
//  //no match
//  //no error handler, just ignore
//end;

procedure SetGroupItemByString(Value:String; RadioGroup:TRadioGroup);
  var i:integer;
      ThisItem:string;
begin
  Value:=uppercase(Value);
  for i:=0 to RadioGroup.ControlCount-1 do begin
    ThisItem:= uppercase(RadioGroup.Items[i]);
    if Value[1]= ThisItem[1]
      then begin
        RadioGroup.ItemIndex:=i; // set when match found
        exit;
      end;
  end;
  //no match
  //no error handler, just ignore
end;
procedure AddDblClickToRadioGroup(RG:TRadioGroup; RB:TRadioButton; NButton:integer=-1);
 Var
   I,J:integer; C:TControl; S:string;
 begin
 J:=0;
 for I := 0 to RG.ControlCount - 1 do begin
   C:=RG.Controls[I];
   S:=C.ClassName;
   if C.ClassNameIs('TGroupButton') then begin //for each button...
     if (J=NButton) or (NButton<0) then
        TRadioButton(C).OnDblClick:= RB.OnDblClick;
     inc(J);
   end;
 end; //for
end; //fn

procedure AddHintToRadioGroupButton(RG:TRadioGroup; Hint:string; NButton:integer=-1);
 Var
   I,J:integer; C:TControl; S:string;
 begin
 J:=0;
 for I := 0 to RG.ControlCount - 1 do begin
   C:=RG.Controls[I];
   S:=C.ClassName;
   if C.ClassNameIs('TGroupButton') then begin //for each button...
     if (J=NButton) or (NButton<0) then
        TRadioButton(C).Hint:= Hint;
        TRadioButton(C).ShowHint:= true;
     inc(J);
   end;
 end; //for
end; //fn

//---------------------------------------

procedure ComboBoxPutStringAtTop(CB:TComboBox; MaxLength:integer;S:string='');
  var Original:string;
      index:integer;
begin
    if (CB.Style=csDropDownList) or (CB.Style=csOwnerDrawFixed)
    then Original:=S
    else Original:=CB.text;
    //Original:=CB.text;
    //index:=CB.ItemIndex;
    index:=CB.Items.IndexOf(Original);
    if index>=0 //if exists then move to top of list, otherwise add
      then CB.Items.Move(index,0) //CB.Items.Delete(Index)
      else begin //doesn't exist
        if CB.Items.Count >= MaxLength //max length of list
          then CB.Items.Delete(CB.Items.Count - 1); //delete last item in list
        CB.Items.Insert(0,Original); //so put at top
      end;
    //CB.Items.Insert(0,Original);
    CB.text:=Original; //seems to be cleared by move
    CB.ItemIndex:=0; //since it is now at top...
end; //ComboBoxPutStringAtTop

//Clear combobox EXCEPT keep items at start and end
procedure ComboBoxClearExcept(CB:TComboBox; NKeepAtTop:cardinal=0;NKeepAtEnd:cardinal=1);
  var Original:string;
      I: cardinal;
      index: integer;
begin
    Original:=CB.text;
    //index:=CB.ItemIndex;
    index:=-1;
    if (NKeepAtTop>=1) and (index>=0)
        then begin
          CB.Items.Move(index,0); //if text exists in list, then move to top of list.
          CB.ItemIndex:=0; //since it is now at top...
        end else CB.ItemIndex:=-1; //since it is not in list
    for I := NKeepAtTop to CB.Items.Count-1-NKeepAtEnd do begin
        CB.Items.Delete(NKeepAtTop); //pulls from list
   end;
   CB.text:=Original; //seems to be cleared by move
end; //ComboBoxPutStringAtTop

procedure ComboBoxPushString(CB:TComboBox; S:string; Maxlength:Integer=100);
begin
  CB.Text:=S;
  ComboBoxPutStringAtTop(CB,MaxLength,S);
end;

function ComboboxGetStringPutAtTop(CB:TComboBox):string;
begin
  //result:=ComboBoxConvertString(CB,false,true); //this adds to canned strings...
  ComboBoxPutStringAtTop(CB,100);
  result:=CB.Text;
end;

  procedure TComboboxHelper.PutStringAtTop(MaxLength:integer=100);
  begin
    ComboBoxPutStringAtTop(self,MaxLength);
  end;
  procedure TComboboxHelper.AddListAtTop(L:TStrings);
  var
     I:integer;
     S:string;
  begin
    if L.Count<1 then exit; //avoid errors if this is empty for some reason
    //implicit else
    for i:=L.Count-1 downto 0 do begin
      S:=L[i];
      if Items.IndexOf(S)=-1  //not already in combobox
        then begin
          Items.Insert(0,S);
        end;
    end; //for
  end;//fn
  procedure TComboboxHelper.ClearExcept(NKeepAtTop:cardinal=0;NKeepAtEnd:cardinal=1);
  begin
    ComboBoxClearExcept(self, NKeepAtTop, NKeepAtEnd);
  end;
  procedure TComboboxHelper.PushString(S:string; Maxlength:Integer=100);
  begin
    ComboBoxPushString(self, S, Maxlength);
  end;
  function  TComboboxHelper.GetStringPutAtTop:string;
  begin
    result:=ComboboxGetStringPutAtTop(self);
  end;

  procedure TComboboxHelper.RightJustify;
  begin
    SelStart := length(text);
  end;
  procedure TComboboxHelper.LeftJustify;
  begin
    SelStart := 1;
    self.SelLength:=1;
  end;

function ExpandEnvVars(const Str: string): string;
var
  BufSize: Integer; // size of expanded string
begin
  // Get required buffer size
  BufSize := ExpandEnvironmentStrings(
    PChar(Str), nil, 0);
  if BufSize > 0 then
  begin
    // Read expanded string into result string
    SetLength(Result, BufSize - 1);
    ExpandEnvironmentStrings(PChar(Str),
    PChar(Result), BufSize);
  end
  else
    // Trying to expand empty string
    Result := '';
end;

type TEventProcedure=procedure(Sender:TObject);

//  function TComboboxHelper.FileChoose(OpenDialog: TOpenDialog):boolean;
//  begin
//    result:=false;
//    OpenDialog.Filename := ExpandEnvVars(self.text);
//    if IsDirectory(OpenDialog.Filename) then
//    begin
//      OpenDialog.InitialDir := OpenDialog.Filename;
//      OpenDialog.Filename := '';
//    end;
//
//    if OpenDialog.Execute then { Display Open dialog box }
//    begin
//        //self.text := QuoteFileName(OpenDialog.Filename);
//      //self.text := OpenDialog.Filename;
//      //self.RightJustify;
//
//      if (OpenDialog.Files.Count>=1) then begin
//        OpenDialog.Files.Delimiter:=';';
//        self.Text := OpenDialog.Files.DelimitedText;
//        SelStart := length(OpenDialog.Files.Strings[1])+2; //right justify to just beyond end of first file name
//      end;
//      //OnChange(self);
//      result:=true;
//    end;
//  end;

function TComboboxHelper.SetFilenameCheckFileExists(FName:string=''):boolean;
begin
  SetFilenameCheckPathExists(FName,true);
end;
function TComboboxHelper.SetFilenameCheckPathExists(FName:string=''; CheckIsFile:boolean=false):boolean;
begin
  SetFilenameCheckFileOrPathExists(FName,CheckIsFile,not CheckIsFile);
end;
function TComboboxHelper.SetFilenameCheckFileOrPathExists(FName:string=''; CheckIsFile:boolean=true; CheckIsPath:boolean=true):boolean;
begin
  if (length(FName)>0)
    then text:=FName   //setting it
    else FName:=text;   //checking it
  RightJustify;         //right justify filenames in comboboxes

  FName:=ExpandEnvVars(FName);
//  if CheckIsFile
//    then result:=FileExists(FName)
//    else result:=DirectoryExists(ExtractFileDir(FName));
  result:= (CheckIsFile and FileExists(FName)) or (CheckIsPath and DirectoryExists(ExtractFileDir(FName)));
  if result then begin
    result:=true;
    Color:=clWindow;
  end else begin
    result:=false;
    Color:=clRed;
  end;
end;

function DirectoryExistsOrMakeIt(FName:string; MissingStr: string = 'Directory does not exist';ResultIfNoDirInFNAME:boolean=true):boolean; //true if DirExists when done
  var D:string;
begin
  result:=false;
  D:=ExtractFileDir(FName);
  if (D='') then begin  //no dir is given, so can't create...
    result:=ResultIfNoDirInFNAME;
    exit; //no directory specified in path
  end;  
  if DirectoryExists(D)
        then result:=true
        else begin
//          if console.OnlyToConsole then begin
                console.showmessage('Error: '+MissingStr+'!'+CRLF+'  '+D);
                exit;
//            end
//          else begin //normal gui, not console only
//            if mrYes = messagedlg(MissingStr+CRLF+CRLF+
//                       'Create New Directory?'+CRLF+CRLF+
//                        D,mtConfirmation,
//                               [mbYes,mbNo], 0)
//                then result:=CreateDir(D);
//          end;
      end;
end;
function TOpenDialogHelper.ExecuteMakeDirIfMissing:boolean;
begin
    self.FileName:=ExpandEnvVars(Self.FileName);
    if DirectoryExistsOrMakeIt(self.Filename) then //IsDirectory(OpenDialog.Filename) then
    begin
      self.InitialDir := ExtractFileDir(self.Filename); //OpenDialog.InitialDir := OpenDialog.Filename;
      self.Filename := ExtractFileName(self.Filename);
    end;
    result:=self.Execute;
end;
  function TComboboxHelper.FileChoose(OpenDialog: TOpenDialog):boolean;
  //multi-select version...
  begin
    result:=false;
    OpenDialog.Filename:=ExpandEnvVars(self.text);//'';
    OpenDialog.Files.Delimiter:=';';
    OpenDialog.Files.DelimitedText := ExpandEnvVars(self.text);
    if OpenDialog.Files.Count=0
      then OpenDialog.Filename:='' //ExpandEnvVars(self.text)
      else OpenDialog.Filename:=OpenDialog.Files[0];  //use first filename
    if DirectoryExistsOrMakeIt(OpenDialog.Filename) then //IsDirectory(OpenDialog.Filename) then
    begin
      OpenDialog.InitialDir := ExtractFileDir(OpenDialog.Filename); //OpenDialog.InitialDir := OpenDialog.Filename;
      OpenDialog.Filename := ExtractFileName(OpenDialog.Filename);
    end;

    if OpenDialog.Execute then { Display Open dialog box }
    begin
        //self.text := QuoteFileName(OpenDialog.Filename);
      //self.text := OpenDialog.Filename;
      //self.RightJustify;
      self.Text := OpenDialog.Files.DelimitedText;
      SelStart := length(OpenDialog.Files.Strings[0]); //right justify on first string
      if (OpenDialog.Files.Count>1)
        then SelStart := SelStart+2; //right justify to just beyond end of first file name if there are multiple, so we can see the delimiter
      //OnChange(self);
      result:=true;
    end; //execute
  end; //fn

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
end.
