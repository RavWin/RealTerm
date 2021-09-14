unit Parameter_INI_Dialog;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Grids, Vcl.ValEdit, Vcl.Dialogs, Vcl.ButtonGroup, Vcl.CheckLst,
  Vcl.Samples.Spin, Vcl.JumpList;

type
  TParameterINIDlg = class(TForm)
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Memo1: TMemo;
    Panel1: TPanel;
    GroupBoxParamHelp: TGroupBox;
    ListBoxParamHelp: TListBox;
    Panel2: TPanel;
    BitBtnSeeCommandLine: TBitBtn;
    BitBtnHelp: TBitBtn;
    Panel3: TPanel;
    ComboBoxIniFName: TComboBox;
    BitBtnExecuteSingleParam: TBitBtn;
    BitBtnExecuteParams: TBitBtn;
    BitBtnDone: TBitBtn;
    BitBtnSave: TBitBtn;
    BitBtnLoad: TBitBtn;
    BitBtnClear: TBitBtn;
    BitBtnRecover: TBitBtn;
    Splitter1: TSplitter;
    BitBtn1: TBitBtn;
    ValueListEditorParams: TValueListEditor;
    BitBtnMakeParamList: TBitBtn;
    BitBtnMacro1: TBitBtn;
    BitBtnMacro2: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure BitBtnSaveClick(Sender: TObject);
    procedure BitBtnLoadClick(Sender: TObject);
//    procedure ListBoxParamHelpDblClick(Sender: TObject);
    procedure BitBtnHelpClick(Sender: TObject);
    procedure BitBtnExecuteParamsClick(Sender: TObject);
    procedure BitBtnDoneClick(Sender: TObject);
    procedure Memo1Click(Sender: TObject);
    procedure Memo1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BitBtnExecuteFileClick(Sender: TObject);
    procedure BitBtnSeeCommandLineClick(Sender: TObject);
    procedure ComboBoxIniFNameChange(Sender: TObject);
    procedure ListBoxParamMakeDblClick(Sender: TObject);
    procedure BitBtnClearClick(Sender: TObject);
    function  LastMemoLines(L:TStrings=nil):TStrings;
    procedure BitBtnRecoverClick(Sender: TObject);
    procedure BitBtnExecuteSingleParamClick(Sender: TObject);
    procedure SpinButtonSortOrderDownClick(Sender: TObject);
    procedure ValueListEditorParamsMakeDblClick(Sender: TObject);
    procedure BitBtnMakeParamListClick(Sender: TObject);
    procedure FindParam(Param:string);
    procedure BitBtnMacro1Click(Sender: TObject);
    procedure BitBtnMacro2Click(Sender: TObject);
  private
    { Private declarations }
    fLastMemoLines:TStrings;
    fParamsSorted:boolean;
    procedure MakeParamList(Sorted:boolean=true);

  public
    destructor destroy; override;
    { Public declarations }
   procedure MacroButtonDo(M:integer;ForceCaptionToMacro:boolean=false;
                             LoadFile:boolean=false;FileName:string='');

  end;
//DefaultStart DefaultNoParams                              StartWithParams StartNoParams
const DEFAULT_MACRO_PATH='%APPDATA%\Realterm\';
const DEFAULT_STARTMACRO_NAME='Realterm_Default';
const ALWAYS_STARTMACRO_NAME='Realterm_Always';
const DEFAULT_MACROX_NAME='Realterm_Macro';
const MACRO_EXT='.ini';
var
  ParameterINIDlg: TParameterINIDlg;

implementation
uses ParameterHandler, realterm1, helpers, shellapi,SHFolder,math,menus;

{$R *.dfm}
procedure GotoCommandLineHelp(P:string);
  var url:string;
begin
  url:='http://realterm.sf.net/index.html';
  if length(P)>0
    then url:=url+'#cmd'+P
    else url:=url+'#Command_Line_Parameters';
  ShellExecute(ParameterINIDlg.Handle, 'open', PChar(url),nil,nil, SW_SHOWNORMAL);
end;


procedure TParameterINIDlg.MacroButtonDo(M:integer;ForceCaptionToMacro:boolean=false;LoadFile:boolean=false;FileName:string='');
var B:TBitBtn; Macro:TStrings; MI:TMenuItem; Other:integer;
  procedure SetMI;
  begin
    if Macro.Count>0 then begin
      MI.Enabled:=true;
      MI.Hint:=Macro.Text;
      end
    else begin
      MI.Enabled:=false;
      MI.Hint:='No Macro';
    end;
  end;
begin
  case M of
    0: begin
      MacroButtonDo(1,ForceCaptionToMacro,LoadFile);
      MacroButtonDo(2,ForceCaptionToMacro,LoadFile);
      exit;
    end;
    1: begin
      if assigned(self) then B:=BitBtnMacro1;
      Other:=2;
      Macro:=Form1.Macro1;
      MI:=Form1.MenuItemMacro1;
    end;
    2: begin
      if assigned(self) then B:=BitBtnMacro2;
      Other:=1;
      Macro:=Form1.Macro2;
      MI:=Form1.MenuItemMacro2;
    end;
  end;
  if ForceCaptionToMacro then begin
    B.Kind:=bkIgnore;
    B.Caption:='Macro'+B.Name[Length(B.Name)];
    exit;
  end;
  if LoadFile then begin
    if FileName='' then
      FileName:=DEFAULT_MACRO_PATH+DEFAULT_MACROX_NAME+inttostr(M)+MACRO_EXT;
      FileName:=expandenvvars(filename);
    if fileexists(Filename) then
    try
      Macro.LoadFromFile(Filename);
      SetMI;
    finally
    end;
    exit;
  end;
  if B.Caption[1]='M' then begin //load macro
    LastMemoLines(Memo1.Lines); //only save of not clear
    Memo1.Clear;
    Memo1.Lines:=Macro;
    B.Kind:=bkCustom;       //change this btn to Save
    B.Caption:='Save';
    B.Glyph:=BitBtnSave.Glyph;
    MacroButtonDo(Other,true);
  end
  else begin
    //Save button;
    Macro.assign(Memo1.Lines);//Macro.SetStrings(Memo1.Lines); //save macro
    B.Kind:=bkIgnore;
    B.Caption:='Macro'+B.Name[Length(B.Name)];
    SetMI;
  end;
end;
procedure TParameterINIDlg.BitBtnClearClick(Sender: TObject);
begin
  LastMemoLines(Memo1.Lines);
  Memo1.Clear;
  //MacroButtonDo(0,true); //reset both buttons
end;

procedure TParameterINIDlg.BitBtnDoneClick(Sender: TObject);
begin
  Close; //if modal, this won't be run....
end;

procedure TParameterINIDlg.BitBtnExecuteParamsClick(Sender: TObject);
begin
  Form1.ExecuteParameterString(Memo1.Lines.Text);
end;


procedure TParameterINIDlg.BitBtnExecuteFileClick(Sender: TObject);
  var L:TStrings;
begin
    if OpenDialog1.ExecuteMakeDirIfMissing then        { Display Open dialog box}
    begin
      try
      L:=TStringList.Create;
      L.LoadFromFile(OpenDialog1.FileName);
      //SaveDialog1.FileName:=OpenDialog1.Filename;
      ComboBoxIniFName.SetFilenameCheckPathExists(OpenDialog1.Filename);
      Form1.ExecuteParameterString(L.Text);
      finally
        L.Free;
      end;
    end;


end;

procedure TParameterINIDlg.BitBtnExecuteSingleParamClick(Sender: TObject);
begin
  Form1.ExecuteParameterString(Memo1.SelText);
end;
function TParameterINIDlg.LastMemoLines(L:TStrings=nil):TStrings;
begin
  if not assigned(fLastMemoLines) then fLastMemoLines:=TStringList.create;
  if L.Count>0 then begin //only if there is something to save
      if assigned(L) then fLastMemoLines.assign(L);
      BitBtnRecover.Enabled:=true;
  end;
  result:=fLastMemoLines;
end;
procedure TParameterINIDlg.BitBtnLoadClick(Sender: TObject);
begin
    if ComboBoxIniFName.FileChoose(OpenDialog1) then begin
        LastMemoLines(Memo1.Lines);
        Memo1.Lines.LoadFromFile(OpenDialog1.FileName);
        SaveDialog1.FileName:=OpenDialog1.Filename;
      end;
//    if OpenDialog1.ExecuteMakeDirIfMissing then        { Display Open dialog box}
//    begin
//      if FileExists(OpenDialog1.FileName) then begin
//        LastMemoLines(Memo1.Lines);
//        Memo1.Lines.LoadFromFile(OpenDialog1.FileName);
//        SaveDialog1.FileName:=OpenDialog1.Filename;
//      end;
//      ComboBoxIniFName.SetFilenameCheckPathExists(OpenDialog1.Filename);
//    end;
end;

procedure TParameterINIDlg.BitBtnRecoverClick(Sender: TObject);
begin
  Memo1.Lines.Assign(fLastMemoLines);
end;

procedure TParameterINIDlg.BitBtnSaveClick(Sender: TObject);
begin
  with SaveDialog1 do begin
    if ExecuteMakeDirIfMissing then                              { Display Open dialog box}
    begin
      Memo1.Lines.SaveToFile(FileName );
    end;
  end; //with
end;

procedure TParameterINIDlg.BitBtnSeeCommandLineClick(Sender: TObject);
  var S:string;
begin
//  //showmessage(Form1.Parameter1.ParamString.Text);
//  if mrYes=MessageDlg('Copy Command-Line to Edit?'+#13+13
//     +Form1.Parameter1.ParamString.Text
//     ,mtInformation,[mbYes,mbNo],mrNo)
//    then Memo1.Lines.Add(Form1.Parameter1.ParamString.Text);
  S:=Form1.Parameter1.ParamString.Text;
  if (sender=nil) or InputQuery('Realterm Command Line String','Copy to Editor?',
    S)
    then Memo1.Lines.Add(Form1.Parameter1.ParamString.Text);
end;

procedure TParameterINIDlg.ComboBoxIniFNameChange(Sender: TObject);
begin
  SaveDialog1.Filename:=ComboBoxIniFName.Text;
  OpenDialog1.FileName:=SaveDialog1.Filename;
  ComboBoxIniFName.SetFilenameCheckFileOrPathExists;
end;

procedure TParameterINIDlg.BitBtnMacro1Click(Sender: TObject);
begin
  MacroButtonDo(1);
end;

procedure TParameterINIDlg.BitBtnMacro2Click(Sender: TObject);
begin
  MacroButtonDo(2);
end;

procedure TParameterINIDlg.BitBtnMakeParamListClick(Sender: TObject);
begin
  fParamsSorted:=not fParamsSorted;
  MakeParamList(fParamsSorted);
end;
procedure TParameterINIDlg.MakeParamList(Sorted:boolean=true);
var INI:TStrings; P:TStringlist;
begin
  try
  INI:= TStringlist.Create;{ construct the list }
  P:=TStringlist.Create;
  P.Sorted := Sorted;
  P.AddStrings(Form1.Parameter1.ParamWatch);
  MakeIniStrings(INI, P);
//  ValueListEditorParams.Strings.SetStrings(INI);
  ListBoxParamHelp.Items.SetStrings(INI);
  finally
    P.Free;
    INI.Free;
  end;
end;
procedure TParameterINIDlg.FindParam(Param:string);
  var i:integer;
begin
  ListBoxParamHelp.ItemIndex:=ListBoxParamHelp.Items.IndexOfName(Param);

//  ValueListEditorParams.FindRow(Param,i);
//  ValueListEditorParams.Col:= 0;
//  ValueListEditorParams.Row:=i;

end;
procedure TParameterINIDlg.FormShow(Sender: TObject);
var INI:TStrings;
begin
  BitBtnRecover.Caption:=''; //seems to assign a caption if empty
  BitBtnMakeParamList.caption:='';
  try
  INI:= TStringList.Create;{ construct the list }
  MakeINIStrings(INI);
  Memo1.Lines:=INI;
  ListBoxParamHelp.Items:=Form1.Parameter1.ParamWatch;
  MakeParamList;
  finally
    INI.Free;
  end;
    if length(SaveDialog1.Filename)=0 then begin
      //SaveDialog1.Filename:= GetFolderPath(CSIDL_LOCAL_APPDATA)+'Realterm\realterm.ini';
      SaveDialog1.Filename:= GetFolderPath(CSIDL_APPDATA)+'Realterm\realterm.ini';
      OpenDialog1.FileName:=SaveDialog1.Filename;
      //SaveDialog1.InitialDir:= GetFolderPath(CSIDL_LOCAL_APPDATA);
      //SaveDialog1.InitialDir:=ExpandEnvVars(SaveDialog1.InitialDir);
      //OpenDialog1.InitialDir:=SaveDialog1.InitialDir;
    end;//if
  //end; //with
end;
procedure TParameterINIDlg.BitBtnHelpClick(Sender: TObject);
begin
  if ListBoxParamHelp.Visible then begin
  with ListBoxParamHelp do begin
    if ItemIndex>=0 then GotoCommandLineHelp(Items.Names[ItemIndex])
    else GotoCommandLineHelp('');
  end;
  end else begin
  with ValueListEditorParams do begin
    if Row>0 then GotoCommandLineHelp(Keys[Row])
    else GotoCommandLineHelp('');
  end;
  end;

end;

//procedure TParameterINIDlg.ListBoxParamHelpDblClick(Sender: TObject);
//begin
//  with Sender as TListBox do
//    GotoCommandLineHelp(Items[ItemIndex]);
//end;

procedure TParameterINIDlg.ListBoxParamMakeDblClick(Sender: TObject);
  var MakeName:string; SS:TStrings;
begin
  SS:=TStringlist.create;
  with ListBoxParamHelp do
    if (ItemIndex>0) and (ItemIndex<Items.Count) then begin
        MakeName:=(Items.Names[ItemIndex]);
        MakeINIStrings(SS, MakeName);
        if SS.Count=0
          then Memo1.Lines.Add(MakeName) //unknowns
          else Memo1.Lines.AddStrings(SS);
    end;
  SS.free;
end;

procedure TParameterINIDlg.ValueListEditorParamsMakeDblClick(Sender: TObject);
  var MakeName:string; SS:TStrings;
begin
//  SS:=TStringlist.create;

  with ValueListEditorParams do
    Memo1.Lines.Add(Strings[Row-1]);

//    MakeName:=(Items[ItemIndex]);
//    MakeINIStrings(SS, MakeName);
//    if SS.Count=0 then Memo1.Lines.Add(MakeName) //unknowns
//    else Memo1.Lines.AddStrings(SS);
//  SS.free;

end;
procedure TParameterINIDlg.Memo1Click(Sender: TObject);
  var LineNum, ListIndex:integer; S:string;
  {$WriteableConst On}
  const LastLine:integer=999;
begin
  LineNum:=Memo1.CaretPos.Y;
  if LineNum=LastLine then exit;

  S:=trim(Memo1.Lines.Names[LineNum]);
  if length(S)=0 then S:=Memo1.Lines[LineNum];
  with ListBoxParamHelp do begin
      ListIndex:=Items.IndexOf(S);
      ItemIndex:=ListIndex;
      TopIndex:=max(0,ListIndex-4);
   end; //do
   LastLine:=Linenum;
end;

procedure TParameterINIDlg.Memo1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (Key=38) OR (Key=40) then Memo1Click(nil); //up/down arrow keys
end;

procedure TParameterINIDlg.OKBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TParameterINIDlg.SpinButtonSortOrderDownClick(Sender: TObject);
begin
//  ValueListEditorParams.Keys.S
end;



destructor TParameterINIDlg.destroy;
begin
  fLastMemoLines.free;
  // Always call the parent destructor after running your own code
  inherited;
end;
end.
