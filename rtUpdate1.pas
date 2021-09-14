unit rtUpdate1;
// Checks for updated version of Realterm available
// tracks and reports usage etc
interface
uses classes, ExtActns, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent,vcl.AppAnalytics;

type
  TrtUpdate = class;
  TOnUpdateAvailableEvent = procedure(Updater:TrtUpdate) of object;
  TrtUpdate = class
    private
      fStartTime:TDateTime; //this run
      fRunDays:double; //from Registry
      fRunCount:integer; //loaded from Reg
      fLastUpdateCheckTime:tdatetime;
      fAutomaticInternetEnabled:boolean;
      fDoCheckForUpdates:boolean; //flag to enable checking
      fUpdateVersion, fCurrentVersion: string;
      fITVersion, fInstallParamVersion:string;
      fVersionCompareFail:boolean; //used for validate
      fUpdateAvailable:boolean;
      fOnUpdateAvailable: TOnUpdateAvailableEvent; //called when update becomes available
      fHttpStrings:TStringList;  //strings read from update server
      fAnalytics : TAppAnalytics;
      fDoSendAnalytics : boolean;
    NetHTTPRequest1: TNetHTTPRequest;
    NetHTTPClient1: TNetHTTPClient;
    procedure UpdateLastChecked;
    function CompareVersionStrs(NewV, OldV: string): integer;
    procedure RegWriteStr(Key, S: string);
    procedure SetITVersion(V: string='');

    //function GetVersionInfo(ShortInfo:boolean=false): string;

 //     function CheckTime:boolean;

    protected
    procedure OpenFromReg();
    procedure httpGetUpdateInfoRequestCompleted(const Sender: TObject;
      const AResponse: IHTTPResponse);
  public
   // BusyChecking:boolean;

    ShowUpdateNow:boolean;
    function ValidateVersionStr(V: string): boolean;
    function VersionPartStr(Part: integer; V: string): string;
    function VersionPart(Part: integer; V: string): integer; overload;
    destructor destroy; override; //gated for repeat rate, show once and so on.
    property CurrentVersion:string read fCurrentVersion;
    property UpdateVersion:string read fUpdateVersion;
    property UpdateAvailable:boolean read fUpdateAvailable;
    property ITVersion:string read fITVersion write SetITVersion;
    property InstallParamVersion:string read fInstallParamVersion write fInstallParamVersion;
    function ITVersionIsNewer(V:string):boolean; //true if V is newer than IT version i.e. we should show features of V
    function RegistryKeyBase:string; //used so help/installtour can report where it is
    function RunTime:double; //actual current value
    property RunCount:integer read fRunCount;
    function RunHoursStr(JustNumbers: boolean=false): string;
    function RunInfoStr(JustNumbers:boolean=false):string;
    //property RunDays:TDateTime;

    //called to setup current version and action callback
    procedure SetupForUpdate({CurrentVersion:string;} OnAvailFn:TOnUpdateAvailableEvent; Analytics:TAppAnalytics=nil);
    //launches the check if due
    function LaunchUpdateCheck(ForceCheckNow:boolean=false):boolean;
    //compares and execute OnUpdateAvail function
    procedure CheckVersionsForUpdate; //latest version real from update server
    constructor Create();
    procedure UpdateRunTimeCount(); //to registry
    procedure ReportRunInfo(Force:boolean=false);
  end;//class

  var RTUpdate:TRTUpdate;

implementation
uses Registry, sysutils, windows, Forms, rtAboutBox;

//const ROOT_KEY=HKEY_LOCAL_MACHINE;  // needs elevated permissions
const ROOT_KEY=HKEY_CURRENT_USER;     //does not need any permissions
const SW_KEY='Software\BEL\Realterm\';
const RUN_DAYS_KEY='Run Days';
const RUN_COUNT_KEY='Run Count';
const LAST_CHECKED_FOR_UPDATES_KEY='Last Update Check';
const UPDATE_VERSION_KEY='Latest Version';
const IT_VERSION_KEY='IT Version'; //used for install tour
const NO_UPDATE_CHECKS_KEY='Block Update Checks';
const UPDATE_CHECK_PERIOD=1; //days

function TrtUpdate.RegistryKeyBase:string; //just for reporting to users
    begin
      result:='HKEY_CURRENT_USER\'+SW_KEY;
    end;
function TRTUpdate.RunTime:double;
begin
  result:=fRunDays+(now - fStartTime);
end;
function TRTUpdate.RunHoursStr(JustNumbers:boolean=false):string;
var Hours:double; Precision:integer;
begin
  Hours:=RunTime*24;
  Precision:=0;
  if Hours<100 then Precision:=1;
  if Hours<10 then Precision:=2;
  if JustNumbers
    then result:=FloatToStrF(Hours,ffNumber,4,Precision)
    else
  result:='Run '+FloatToStrF(Hours,ffNumber,4,Precision)+' hrs';
end;

function TRTUpdate.RunInfoStr(JustNumbers:boolean=false):string;
var Hours:double; Precision:integer;
begin
  if JustNumbers
    then result:=inttostr(fRunCount+1)+'_'+RunHoursStr(true)
    else
  result:='Run '+inttostr(fRunCount+1)+' times '+RunHoursStr(true)+' hrs';
end;

// https://stackoverflow.com/questions/11699924/error-when-trying-to-save-value-in-registry
//at startup

procedure TRTUpdate.RegWriteStr(Key:string;S:string);
var
  reg        : TRegistry;
  openResult : Boolean;
begin
  try
  reg := TRegistry.Create(KEY_READ or KEY_WRITE);
  reg.RootKey := ROOT_KEY;
  if reg.OpenKey(SW_KEY,True) then
    begin  //opened/created key
    try
      if reg.ValueExists(Key)
        then  reg.WriteString(Key,S);
    finally
      reg.CloseKey();
    end;
    end;
  finally
    reg.Free;
  end;
end;

procedure TRTUpdate.OpenFromReg();
var
  reg        : TRegistry;
begin
  try
  reg := TRegistry.Create(KEY_READ or KEY_WRITE);
  reg.RootKey := ROOT_KEY;

  //reg.Access := KEY_WRITE;
  if reg.OpenKey(SW_KEY,True) then
    begin  //opened/created key
    try
      if  reg.ValueExists(LAST_CHECKED_FOR_UPDATES_KEY) then
        begin
          fLastUpdateCheckTime := reg.ReadDateTime(LAST_CHECKED_FOR_UPDATES_KEY);
          fDoCheckForUpdates:= (now - fLastUpdateCheckTime)>UPDATE_CHECK_PERIOD
        end
        else reg.WriteDateTime(LAST_CHECKED_FOR_UPDATES_KEY, now);

      if  reg.ValueExists(NO_UPDATE_CHECKS_KEY) then
        begin
          fAutomaticInternetEnabled:=not reg.ReadBool(NO_UPDATE_CHECKS_KEY);
          fDoCheckForUpdates := fDoCheckForUpdates AND fAutomaticInternetEnabled;
          fDoSendAnalytics := fDoCheckForUpdates;
        end
        else reg.WriteBool(NO_UPDATE_CHECKS_KEY, false);


      if reg.ValueExists(RUN_COUNT_KEY)
        then  fRunCount:=reg.ReadInteger(RUN_COUNT_KEY)+1
        else reg.WriteInteger(RUN_COUNT_KEY, 0);

      if reg.ValueExists(RUN_DAYS_KEY)
      then begin
        fRunDays:=reg.ReadFloat(RUN_DAYS_KEY);
        end
      else reg.WriteFloat(RUN_DAYS_KEY, 0); //create it

      if reg.ValueExists(UPDATE_VERSION_KEY)
      then begin
        fUpdateVersion:=reg.ReadString(UPDATE_VERSION_KEY);
        end
      else reg.WriteString(UPDATE_VERSION_KEY,''); //create it
      if reg.ValueExists(IT_VERSION_KEY)
      then begin
        fITVersion:=reg.ReadString(IT_VERSION_KEY);
        end
      else reg.WriteString(IT_VERSION_KEY,''); //create it

    finally
      reg.CloseKey();
    end;
    end;
  finally
    reg.Free;
  end;
end;

//called on application close.
procedure TRTUpdate.UpdateRunTimeCount();
var
  reg        : TRegistry;
  openResult : Boolean;
  today      : TDateTime;
begin
  try
  //reg := TRegistry.Create(KEY_READ);
  reg := TRegistry.Create(KEY_READ or KEY_WRITE);
  reg.RootKey := ROOT_KEY;

  //reg.Access := KEY_WRITE;
  if reg.OpenKey(SW_KEY,True) then
    begin  //opened/created key
    try
      if reg.ValueExists(RUN_COUNT_KEY)
        then  reg.WriteInteger(RUN_COUNT_KEY, 1+reg.ReadInteger(RUN_COUNT_KEY))
        else reg.WriteInteger(RUN_COUNT_KEY, 0);

      if reg.ValueExists(RUN_DAYS_KEY)
      then begin
          reg.WriteFloat(RUN_DAYS_KEY, reg.ReadFloat(RUN_DAYS_KEY)+(now - fStartTime));
      end
      else reg.WriteFloat(RUN_DAYS_KEY, 0); //create it

    finally
      reg.CloseKey();
    end;
    end;
  finally
    reg.Free;
  end;
end;

procedure TRTUpdate.UpdateLastChecked();
var
  reg        : TRegistry;
  //openResult : Boolean;
  //today      : TDateTime;
begin
  try
  reg := TRegistry.Create(KEY_READ or KEY_WRITE);
  reg.RootKey := ROOT_KEY;
  if reg.OpenKey(SW_KEY,True) then
    begin  //opened/created key
    try
      reg.WriteDateTime(LAST_CHECKED_FOR_UPDATES_KEY, now);
      reg.WriteString(UPDATE_VERSION_KEY,fUpdateVersion);
    finally
      reg.CloseKey();
    end;
    end;
  finally
    if assigned(reg) then reg.Free;
  end;
end;


function TrtUpdate.LaunchUpdateCheck(ForceCheckNow:boolean=false):boolean;
procedure InitNet;
begin
  if fHttpStrings=nil then fHttpStrings:=TStringList.Create;
  if NetHTTPClient1=nil then NetHTTPClient1:= TNetHTTPClient.create(nil{Application});
  if NetHTTPRequest1=nil then NetHTTPRequest1:= TNetHTTPRequest.create(nil{Application});
  NetHttpRequest1.Client:=NetHttpClient1;
  NetHttpRequest1.Asynchronous:=true; //background

end;
begin
  //BusyChecking:=false;
  result:=false;
  if ForceCheckNow or fDoCheckForUpdates then begin
    InitNet;
    fDoCheckForUpdates:=false; //we will only try once per execution
    //BusyChecking:=true;
    NetHttpRequest1.OnRequestCompleted:=httpGetUpdateInfoRequestCompleted;
    NetHttpRequest1.Get('https://realterm.i2cchip.com/updateinfo/latest_version.txt');
    result:=true;
  end;
end;

procedure TrtUpdate.httpGetUpdateInfoRequestCompleted(const Sender: TObject;
  const AResponse: IHTTPResponse);
  //var SL:TStringlist;
begin
  if AResponse.StatusCode=200 then begin
     fHttpStrings.Text:=AResponse.ContentAsString();
     fUpdateVersion:=fHttpStrings.Strings[0];
     UpdateLastChecked; //save now to registry
     CheckVersionsForUpdate;
  end;
end;

procedure TrtUpdate.CheckVersionsForUpdate;
begin
  fUpdateAvailable:= (1=CompareVersionStrs(fUpdateVersion,fCurrentVersion));
  if fUpdateAvailable and assigned(fOnUpdateAvailable)  then
    fOnUpdateAvailable(self);
end;
//true if V is newer than IT version i.e. we should show features of V
function TrtUpdate.ITVersionIsNewer(V:string):boolean;
begin
  result:= (fITVersion='') or (CompareVersionStrs(V,fITVersion)>0);
  if (fInstallParamVersion<>'') then
      result:= result or (CompareVersionStrs(V,fInstallParamVersion)>0);
end;
procedure TrtUpdate.SetITVersion(V:string=''); //default set to current
begin
  if V='' then V:=fCurrentVersion; //just set it to this version
  fITVersion:=V;
  RegWriteStr(IT_VERSION_KEY,fITVersion);
end;
function TrtUpdate.ValidateVersionStr(V:string):boolean; //test or return flag
begin
  if V=''
  then begin
    result:=not fVersionCompareFail;
  end
  else begin
    fVersionCompareFail:=false;
    CompareVersionStrs(V,V);
    result:=not fVersionCompareFail;
    fVersionCompareFail:=false; //leave flag clear
    end;
end;
function TrtUpdate.CompareVersionStrs(NewV,OldV:string):integer; //+1 newV is newer, -1 older
var
  NewA,OldA: TArray<String>;
  i,NewN,OldN:integer;
begin
  result:=0; //equal
  NewA := NewV.Split(['.']);
  OldA := OldV.Split(['.']);
  if length(NewA)>4 then begin
    fVersionCompareFail:=true;
    exit;
  end;
  for i := 0 to length(NewA)-1 do begin
    try
      NewN:= strtoint(NewA[i]);
      OldN:= strtoint(OldA[i]);
      if ( NewN > OldN ) then begin
        result:=1; //new is greater then old
        break;
      end;
      if ( NewN < OldN ) then begin
        result:=-1; //new is less then old
        break;
      end;
    except
      fVersionCompareFail:=true; //used for validate
      exit; //break; //if strconvert then return as equal
    end;
  end; //for

end;
//get one part of the version string parts 0-3
function TrtUpdate.VersionPartStr(Part:integer;V:string):string;
var
  A: TArray<String>;
  i,N:integer;
begin
  if V='' then result:='0'
  else begin //fCurrentVersion;
    try
      A := V.Split(['.']);
      result:= A[Part];
    except
      result:=V; //error just return original string
    end;
  end;
 end;
function TrtUpdate.VersionPart(Part:integer;V:string):integer;
begin
  result:=strtoint(VersionPartStr(Part,V));
end;
function GetVersionInfo(ShortInfo:boolean=false): string;
// from AFVersionCaption.pas, Accalai Ferruccio - AfSoftware
var
  Size, Size2: DWord;
  Point, Point2: Pointer;
begin
  Size := GetFileVersionInfoSize(PChar (ParamStr (0)), Size2);
  if Size > 0 then
    begin
		GetMem (Point, Size);
      try
        If GetFileVersionInfo (PChar (ParamStr (0)), 0, Size, Point) then
			 begin
				VerQueryValue (Point, '\', Point2, Size2);
				with TVSFixedFileInfo (Point2^) do
				  begin
					 If ShortInfo then
						result := Format('%d.%.2d', [HiWord (dwFileVersionMS),LoWord
						  (dwFileVersionMS)])
					 else
						result := IntToStr (HiWord (dwFileVersionMS)) + '.' +
						  IntToStr (LoWord (dwFileVersionMS)) + '.' + IntToStr (
						  HiWord (dwFileVersionLS)) + '.' + IntToStr (LoWord (
						  dwFileVersionLS));
              end;
          end
        else
          begin
            result := '';
           // If Assigned(fOnError) then
           //   fOnError(self);
          end;
      finally
		  FreeMem (Point);
      end;
    end
  else
    begin
      result := '';
      //If Assigned(fOnNoInfoAvailable) then
        //fOnNoInfoAvailable(self);
    end;
end;

procedure TrtUpdate.SetupForUpdate({CurrentVersion:string;}
                                   OnAvailFn:TOnUpdateAvailableEvent;
                                   Analytics:TAppAnalytics=nil);
begin
  //fCurrentVersion:=GetVersionInfo; //CurrentVersion;
  fOnUpdateAvailable:=OnAvailFn;
  fAnalytics:=Analytics;
  CheckVersionsForUpdate;   //and do the update changes
{$IFNDEF DEBUG}
  fAnalytics.Active:=true;
{$ENDIF}
end;

const MIN_RUNNING_TIME_TO_REPORT=3/(24*60); //(mins) must have been running this long to report
procedure TrtUpdate.ReportRunInfo(Force:boolean=false);
begin
  if not assigned(fAnalytics) then exit;
  if Force OR
     fDoSendAnalytics AND ((now-fStartTime) > MIN_RUNNING_TIME_TO_REPORT)
    then begin
      fAnalytics.TrackEvent('Usage', 'Closing',
          'Run_Count', RTUpdate.RunCount );
      fAnalytics.TrackEvent('Usage', 'Closing',
          'Run_Time', RTUpdate.RunTime );
      fAnalytics.TrackEvent('Usage', 'CloseInfo',
          AppOSInstallInfoStr, RTUpdate.RunCount );
      fAnalytics.TrackEvent('Usage', 'ClosePorts',
          AppOSInstallPortStr, RTUpdate.RunCount );
    end;
end;

constructor TrtUpdate.Create();
begin
  //inherited Create(AOwner);
//  BusyChecking:=false;
  fUpdateAvailable:=false;
  fCurrentVersion:=GetVersionInfo; //CurrentVersion;
  ShowUpdateNow:=false;
  fStartTime:=now;
  OpenFromReg;
end;
destructor TrtUpdate.destroy;
begin
  fHttpStrings.free;
  NetHTTPRequest1.free;
  NetHTTPClient1.free;
end;

initialization
  rtUpDate:=TrtUpdate.Create; //do here so runxxx always works
finalization
//  rtUpdate.UpdateRunTimeCount;
  rtUpdate.free;
end.
