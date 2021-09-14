unit RTAboutBox;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ShellApi, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent;

  function AppOSRunInfoStr:string;
  function AppOSInstallInfoStr:string;
  function AppOSInstallPortStr:string;
  function MemoryUsed: cardinal;
  function IsUserAdmin: Boolean;
  function IsUserAdminStr(SingleChar:boolean=false):string;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    Label99: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    MemoParams1: TMemo;
    Label6: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    LabelHtmlChangeLog: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    LabelHTMLExampleDirectory: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    LabelVersionInfo: TLabel;
    Label19: TLabel;
    Image1: TImage;
    Label20: TLabel;
    LabelWindowsVersion: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    BitBtnOK: TBitBtn;
    BitBtnShowINI: TBitBtn;
    ButtonUpdateCheck: TButton;
    procedure LabelHTMLClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtnOKClick(Sender: TObject);
    procedure BitBtnShowINIClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonUpdateCheckClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

procedure AnalyticsReportInstall;
//procedure AnalyticsReportRunInfo;
const CR=#13; CRLF=#13+#10;
//const HelpMessage_Install=
//        'Realterm has just been installed. I will show you a few features now...'+CR+CR+
//        '               ----  <esc> to move along  ----' +CR+CR+
//        'Right-Click for Popup-menu, and SystemMenu icon on toolbar'+CR+
//        'F1 launches help. '+CR+
//        'Read all the tooltips carefully, as they are a rich source of help.'+CR+CR+
//        'The status line continues to show the tooltips after they have gone.'+CR+
//        '   Double click the status line to see longer help strings'+CR+CR+
//        'There are many useful Hotkeys and more being added. '+CR+
//        '   Look through the Popup Menu and learn them all'+CR+CR+
//        'Be sure to Subscribe at Sourceforge, and watch News or RSS';

implementation

uses realterm1,Parameter_INI_Dialog, CodeSignChecker1,RTUpDate1,helpers,
     vcl.AppAnalytics,comportfinder;
{uses gnugettextD5;}
{$R *.DFM}

procedure AnalyticsReportInstall;
var S,SUI:string;
begin
    S:=AppOSInstallInfoStr;
    if rtUpdate.ITVersion=''  //make it easier to see updates
    then SUI:='Install_Info'
    else SUI:='Update_Info';

    {$IFNDEF DEBUG}
    if not Form1.AppAnalytics1.Active then begin  //perhaps we are missing isnatlls because timer1 fires before end of formcreate
      Form1.AppAnalytics1.Active:=true;
      S:='z'+S;
    end;
    Form1.AppAnalytics1.TrackEvent('Install', SUI,
      S, RTUpdate.RunCount );
    {$ENDIF}
    S:=AppOSInstallPortStr;
    {$IFNDEF DEBUG}
    Form1.AppAnalytics1.TrackEvent('Install', 'Install_Ports',
      S, RTUpdate.RunTime*24);
    Form1.AppAnalytics1.StartSending; //should not be needed, but missing so many installs??
    {$ENDIF}
end;

procedure TAboutBox.LabelHTMLClick(Sender: TObject);
  var H, url:string;
begin
  H:= (Sender as TLabel).Hint;
  if (length(H)>7) and (H[1]='h') and (H[2]='t')
    then url:= (Sender as TLabel).Hint
    else url:=(Sender as TLabel).Caption;
  url:=ExpandEnvVars(url); //in case there is an unfixed one still lurking.
  ShellExecute(Handle, 'open', PChar(url),nil,nil, SW_SHOWNORMAL);
end;

procedure TAboutBox.ButtonUpdateCheckClick(Sender: TObject);
begin
  rtupdate.LaunchUpdateCheck(true);

end;

procedure TAboutBox.OKButtonClick(Sender: TObject);
begin
  AboutBox.Close;
end;

procedure TAboutBox.BitBtnOKClick(Sender: TObject);
begin
  AboutBox.Close;
end;

procedure TAboutBox.BitBtnShowINIClick(Sender: TObject);
begin
   ParameterINIDlg.show;
end;



procedure TAboutBox.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //Formstyle:=fsNormal;
end;
function AppOSRunInfoStr:string;  //used by LastErrorMessage
  var ExeDateStr:string;
begin
  ExeDateStr := DateToStr(FileDateToDateTime(FileAge(Application.ExeName)));
  result:= Form1.Caption+#13
            +Application.ExeName+' '+ExeDateStr+#13
            +CodeSignedString('','Broadcast Equipment Ltd')+#13
            +TOSVersion.ToString+' '+IsUserAdminStr+#13
            +'Memory Used: '+inttostr(MemoryUsed div 1000)+'kb'
            +' '+RTUpdate.RunInfoStr+#13
            +' Font:'+Form1.Font.Name+inttostr(Form1.Font.Size)+' Term:'+Form1.AdTerminal1.Font.Name+inttostr(Form1.AdTerminal1.Font.Size)+#13
            +' Screen:'+inttostr(Screen.Width)+'x'+inttostr(Screen.Height)+' '+inttostr(Screen.PixelsPerInch)+'ppi, Design:'+inttostr(Form1.PixelsPerInch)
            //+' '+Form1.
            ;
end;
function AppOSInstallInfoStr:string;  //used to report Install
  var ExeDateStr:string;
begin
  ExeDateStr := DateToStr(FileDateToDateTime(FileAge(Application.ExeName)));
  result:=  'W'+inttostr(TOSVersion.major)+inttostr(TOSVersion.minor)
            +IsUserAdminStr(true)
            +inttostr(Screen.Width)+'x'+inttostr(Screen.Height)+'x'+inttostr(Screen.PixelsPerInch)
            +StringReplace(Form1.Font.Name, 'Tahoma', 'TH', [rfReplaceAll, rfIgnoreCase])+inttostr(Form1.Font.Size)//+','
                +StringReplace(Form1.AdTerminal1.Font.Name, 'Terminal_Ctrl+Hex', 'TCH', [rfReplaceAll, rfIgnoreCase])+inttostr(Form1.AdTerminal1.Font.Size)
            +','+floattostrf(MemoryUsed/1e6,ffFixed,4,1)+'M'
            +inttostr(RTUpdate.RunCount)+'s'+rtupdate.RunHoursStr(true)+'h'
            +RTUpdate.VersionPartStr(3,RTUpdate.ITVersion)+'>'
            +RTUpdate.VersionPartStr(3,RTUpdate.CurrentVersion)
            ;
end;
function AppOSInstallPortStr:string;
begin
    ComportList.Delimiter:=';';
    ComportList.StrictDelimiter:=true;
    result:=ComportList.DelimitedText;
    if result='' then result:='No Ports';
end;
procedure TAboutBox.FormShow(Sender: TObject);
var ExeDate:TDateTime; //F:TCustomForm;
begin
  LabelHtmlChangeLog.Caption:=ExpandEnvVars(LabelHtmlChangeLog.Caption);
  LabelHTMLExampleDirectory.Caption:=ExpandEnvVars(LabelHTMLExampleDirectory.Caption);
  //Form1.ClearStayOnTop;

  //F:= GetParentForm(Self);
  //Formstyle:=TForm(F).FormStyle;
  //Formstyle:=fsNormal; Formstyle:=form1.FormStyle;  //if main is stay-on-top
  FileAge(Application.ExeName,ExeDate);
  MemoParams1.Lines:=Form1.Parameter1.ParamWatch;
  LabelVersionInfo.Caption:=Form1.Caption
                            +'    '+#13#10+Application.ExeName
                            +' '+DateToStr(ExeDate)
                            +#13+CodeSignedString('','Broadcast Equipment Ltd');
  LabelWindowsVersion.Caption:=TOSVersion.ToString+#13+'Memory Used: '+inttostr(MemoryUsed div 1000)+'kb'
  +'   '+RTUpdate.RunInfoStr
  +' '+IsUserAdminStr;
  //AboutBox.Caption:=AboutBox.Caption+'  '+CodeSignedString('','Broadcast Equipment Ltd')+#13
end;

//  https://stackoverflow.com/questions/437683/how-to-get-the-memory-used-by-a-delphi-program
function MemoryUsed: cardinal;
var
    st: TMemoryManagerState;
    sb: TSmallBlockTypeState;
begin
    GetMemoryManagerState(st);
    result := st.TotalAllocatedMediumBlockSize + st.TotalAllocatedLargeBlockSize;
    for sb in st.SmallBlockTypeStates do begin
        result := result + sb.UseableBlockSize * sb.AllocatedBlockCount;
    end;
end;
//var b:boolean;
function IsUserAdminStr(SingleChar:boolean=false):string;
begin
  if IsUserAdmin
      then result:='Admin'
      else result:='User';
  if SingleChar then result:=result[1];                                        //: BOOL; stdcall; external 'Imagehlp.dll';
end;
//https://stackoverflow.com/questions/6261865/looking-for-delphi-7-code-to-detect-if-a-program-is-started-with-administrator-r
function CheckTokenMembership(TokenHandle: THandle; SIdToCheck: PSID; var IsMember: BOOL): boolean; StdCall; External 'AdvApi32.dll';
function IsUserAdmin: Boolean;
var
  b: BOOL;
  AdministratorsGroup: PSID;

const
  SECURITY_NT_AUTHORITY: SID_IDENTIFIER_AUTHORITY =
    (Value: (0,0,0,0,0,5)); // ntifs
  SECURITY_BUILTIN_DOMAIN_RID: DWORD = $00000020;
  DOMAIN_ALIAS_RID_ADMINS: DWORD = $00000220;
//  DOMAIN_ALIAS_RID_USERS : DWORD = $00000221;
//  DOMAIN_ALIAS_RID_GUESTS: DWORD = $00000222;
//  DOMAIN_ALIAS_RID_POWER_: DWORD = $00000223;
begin
  {
    This function returns true if you are currently running with admin privileges.
    In Vista and later, if you are non-elevated, this function will return false
    (you are not running with administrative privileges).
    If you *are* running elevated, then IsUserAdmin will return true, as you are
    running with admin privileges.

    Windows provides this similar function in Shell32.IsUserAnAdmin.
    But the function is deprecated, and this code is lifted
    from the docs for CheckTokenMembership:
      http://msdn.microsoft.com/en-us/library/aa376389.aspx
  }

  {
    Routine Description: This routine returns TRUE if the callers
    process is a member of the Administrators local group. Caller is NOT
    expected to be impersonating anyone and is expected to be able to
    open its own process and process token.
      Arguments: None.
      Return Value:
        TRUE - Caller has Administrators local group.
        FALSE - Caller does not have Administrators local group.
  }
  b := AllocateAndInitializeSid(
      SECURITY_NT_AUTHORITY,
      2, //2 sub-authorities
      SECURITY_BUILTIN_DOMAIN_RID,  //sub-authority 0
      DOMAIN_ALIAS_RID_ADMINS,      //sub-authority 1
      0, 0, 0, 0, 0, 0,             //sub-authorities 2-7 not passed
      AdministratorsGroup);
  if (b) then
  begin
    if not CheckTokenMembership(0, AdministratorsGroup, b) then
      b := False;
    FreeSid(AdministratorsGroup);
  end;
  Result := b;
end;
end.

