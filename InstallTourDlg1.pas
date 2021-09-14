unit InstallTourDlg1;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,vcl.comctrls, System.TypInfo,
  Realterm1, Helpers;

type
  TState=(tsIntro,tsPopup,tsSysMenu,tsExit);
  TPhaseType=(tpEnumerate,tpShow,tpHide,tpStop);
  TPhaseSet=set of TPhaseType;
const tpSH=[tpShow,tpHide];
type
  TTourType=(ttAll,ttUpdate,ttAllUpdates,ttPhone);
  TTourSet=set of TTourType;
type
  TMethod = procedure of object;
  TTour = class(TForm) //generic form with an iterator tour
    Timer: TTimer;
    private
    fTF: TMethod;  //Tour Function
    fPhase:TPhaseType; //state variable
    fQStep:integer; // individual substeps
    fQSection:integer;      // logical sections / blocks
    fQi:integer;        // counter used to number-off
    fVersionMatchCount:integer;
    fNumSteps:integer;
    fNumSections:integer;
    fNumVersionMatches:integer;
    fDefaultPhaseSet: TPhaseSet;
    fFeatureVersion:string; //stored when a version compare is done
    Hiding: Boolean;
    Showing: Boolean;
    fSections:TStrings;
    TourSet:TTourSet;

    fAnimateFn:TMethod; //the xFunction will be called by animate timer
    fAnimateQStep:integer; //inc'd each call of xFn
    fAnimateQSubStep:integer;
    fAnimateNumSubSteps:integer;
    fAnimateQi:integer;   //inc'd each call of Do;
    fAnimateHidingInterval, fAnimateShowingInterval:integer;
    Animating:Boolean;    //this call is animation
    AnimateHiding:boolean; //animation is in hiding phase

    function IsMatchQ(FilterMatch:boolean=true;SectionMatch:boolean=true):boolean;
    procedure StartAnimate(F:TMethod;ShowingInterval:integer=-1;HidingInterval:integer=-1); overload;
    procedure DoQ(F: TMethod); //executes F for all IsQ - setup animations
    procedure StopAnimate;
    procedure AnimateCallback(Sender:TObject);
    procedure DoTF(TF: TMethod=nil); //checks assigned and stores/uses fTF
    procedure SetPhase(P:TPhasetype);

    protected
    property Phase:TPhaseType read fPhase write SetPhase;
    procedure SetHeading(S: string); virtual; abstract;
    property Heading:string write SetHeading;
    procedure SetMsg(S: string);     virtual; abstract;
    property Msg:string write SetMsg;
    Procedure DoAnimate(F:TProc;OnlyShowing:boolean=true;ShowingInterval:integer=-1;HidingInterval:integer=-1); overload;
    procedure DoAnimate(C1:Tcontrol;C2:Tcontrol=nil; OnlyShowing: Boolean=false; ShowingInterval: Integer = -1; HidingInterval: Integer = -1); overload;
    procedure DoAnimateHiddenPair(C1, C2: TControl; Tab: TTabsheet);
    procedure DoAnimate(S1:string; OnlyShowing: Boolean=True; ShowingInterval: Integer = -1; HidingInterval: Integer = -1); overload;
    procedure SetAnimateInterval(ShowingInterval:integer=-1;HidingInterval:integer=-1;NumSubSteps:integer=-1);

    procedure DoNext(TF: TMethod=nil;JumpTo:integer=-1);
    procedure StartQ(TF:TMethod=nil);
    procedure StopQ(TF:TMethod=nil);
    procedure NextQ(NextSection:boolean=true);
    function  EndQ:boolean; //sets the end or returns isend

    function IsPhase(P: TPhaseType): boolean;

    function IsQ(FilterMatch: boolean=true;PhaseSet:tphaseset=[];Head:string=''): boolean; overload;
//    function IsQ(F:TProcedure;FilterMatch:boolean=true;PhaseSet:tphaseset=[];Head:string=''):boolean; overload;
    function IsQ(F:TMethod;FilterMatch:boolean=true;PhaseSet:tphaseset=[];Head:string=''):boolean; overload;
    function IsQ(F:TMethod; Version:string;PhaseSet:tphaseset=[];Head:string=''):boolean; overload;

    function IsQH(F:TMethod;Head:string;FilterMatch:boolean=true;PhaseSet:tphaseset=[]):boolean; overload;
    function IsQH(F:TMethod;Head:string;Version:string;PhaseSet:tphaseset=[]):boolean; overload;

    public
    constructor Create(AOwner: TComponent) ;

  end;

  TInstallTour = class(TTour)
    Label1: TLabel;
    Panel1: TPanel;
    PanelTitle: TPanel;
    ButtonNext: TBitBtn;
    ButtonDone: TBitBtn;
    ButtonChangeTour: TBitBtn;
    PanelHeading: TPanel;
    ButtonHelp: TBitBtn;
    ComboBoxHeading: TComboBox;
    ComboBoxTour: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure ButtonDoneClick(Sender: TObject);
    procedure ButtonNextClick(Sender: TObject);
    procedure ButtonChangeTourClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure ButtonHelpClick(Sender: TObject);
    procedure ComboBoxHeadingSelect(Sender: TObject);
    procedure ComboBoxTourSelect(Sender: TObject);
  private
    FocusedControl:TWinControl;
    procedure xIntro;
    procedure xPopup;
    procedure xSysMenu;
    procedure TheTour({Sender: TObject});
    procedure xComport;
    procedure xStatusBar;
    procedure xIcon;
    procedure x38;
//    procedure SetTourType(Change: boolean=false);
    procedure x35;
    procedure xIni;
//    procedure IconStep(Sender: TObject);
//    procedure xStatusBarAnimate(Sender: tobject);
//    procedure xHiddenControlsAnimate(Sender: TObject);
    procedure xHiddenControls;
    procedure xFinish;
    procedure xAbout;
    procedure SetHeading(S: string); override;
    procedure SetFocusControl(C: TWinControl=nil);
    procedure RestoreButtons;
    procedure SetTour(T: TTourType); overload;
    procedure SetTour(I : Integer); overload;
    procedure xPhoneGroup;
    procedure xPhoneCom;
    procedure xUSBPlug;
    procedure x41;
    procedure xIconAnimate(IC: TIconStyle);
    procedure x41_DAListHelp(S: string);
    procedure x44;
    property Heading:string write SetHeading;
  protected
    procedure SetMsg(S: string);  override;
  public
    property Msg:string write SetMsg;
    { Public declarations }
  end;

var
  InstallTourDlg: TInstallTour;

implementation

uses  Parameter_INI_Dialog, rtUpdate1,ComportFinder,
      RTAboutBox, system.Math, system.types; //Realterm1;
{$J+} //D7
{$R *.dfm}
var F:TForm1;
const CR=#13;

procedure DefaultMinus1(var V:integer; DefaultV:integer); overload;
begin
  if (V=-1) then V:=DefaultV;
end;
//function DefaultMinus1(V:integer; DefaultV:integer):integer; overload;
//begin
//  if (V=-1) then result:=DefaultV else result:=defaultV;
//end;

function AorB(UseA:boolean; var A,B:integer):integer;
begin
  if UseA then result:=A else result:=B;
end;

const CL_TOUR_BACKGROUND=clInfoBk;
procedure ShowSysMenu(Show:boolean=true);
var P:TPoint;
begin
  P:=F.ClientToScreen(Point(0,0));
  if Show then
    TrackPopupMenu(GetSystemMenu(F.Handle, FALSE),
     TPM_LEFTALIGN+TPM_TOPALIGN+{TPM_RETURNCMD+}TPM_NONOTIFY+ TPM_RECURSE,
                 P.X,P.Y,0,F{self}.Handle,nil)
  else
    SendMessage(GetSystemMenu(F.Handle, FALSE), $1F{WM_CANCELMODE}, 0, 0);
end;

procedure ShowPopupMenu(Handle:HMENU; Show:boolean=true;X:integer=100;Y:integer=300);
var P:TPoint;
    T:TdateTime;
    NumTimes:integer;
begin
  P:=F.ClientToScreen(Point(X,Y)); //{Point(100,275)}
  //if not Show then//  SendMessage(GetSystemMenu(Handle, FALSE), $1F{WM_CANCELMODE}, 0, 0);

  T:=now;
  repeat //Trackmenu will block unless previous menu was dismissed by clicking on form
    TrackPopupMenu(Handle ,
     TPM_LEFTALIGN+TPM_TOPALIGN+{TPM_RETURNCMD+}TPM_NONOTIFY+ TPM_RECURSE,
                 P.X,P.Y,0,F{self}.Handle,nil);
    inc(NumTimes);
  until ((now-T)>(1/(24*3600*3))) OR ( NumTimes>=2 ); //test that it has blocked for more than 1/3 second
end;

procedure MoveCursorTo(C:TWincontrol;FocusIt:boolean=false);
  var P:TPoint;
begin
  P:=Point(C.Width div 2 , C.Height div 2);
  P:=C.ClientToScreen(P);
  SetCursorPos(P.X,P.Y);
  if FocusIt and C.Visible and C.Enabled then C.SetFocus;
end;

procedure SidleControls(L,R:TWinControl); //puts R button next to L button
const BUTTON_GAP=15;
begin
  R.Left:=L.Left+L.Width+BUTTON_GAP;
end;

    function SetColor(C:Tcontrol; CL:Tcolor):tcolor;
      var F:tfont;
    begin
      exit;
       if IsPublishedProp(C,'color')
         then begin
           result:=GetPropValue(C,'color');
           SetPropValue(C,'color',CL);
         end
         else //doesn't seem that Tbuttons colors can be changed!
           if C.ClassType=Tbutton then begin
             result:=Tbutton(C).Font.Color;
             Tbutton(C).Font.Color:=CL;
         end
         else ;
    end;
    const X1_CLEAR_FRAME=-9999; //magic #

//Procedure FrameXY(X1,Y1,X2,Y2:integer;CL:Tcolor=clRed); overload;
//    const CL_CLEAR_FRAME=clBtnFace; //clInfoBk;
//
//    const LX1:integer=0;LY1:integer=0;LX2:integer=0;LY2:integer=0;
//    begin
//      if InstallTourDlg.Hiding and not (CL=-1) then begin
//        X1:=X1_CLEAR_FRAME;
//        CL:=-1;
//      end;
//      if X1=X1_CLEAR_FRAME then begin
//        X1:=LX1;X2:=LX2;Y1:=LY1;Y2:=LY2;
//      end;
//      F.Canvas.Handle:=GetDCEx(Form1.Handle, 0, DCX_PARENTCLIP);
//      F.Canvas.Pen.Style := psSolid;
//      F.Canvas.Pen.Width := 4;
//      if CL=-1 then begin
//        CL:=CL_CLEAR_FRAME;
//        //Canvas.Pen.Style := psClear; //doesn't work
//      end;
//      F.Canvas.Pen.Color:=CL;
//      F.Canvas.Brush.Style:=bsClear;
//      F.Canvas.Rectangle(X1,Y1,X2,Y2);
//      LX1:=X1;LX2:=X2;LY1:=Y1;LY2:=Y2; //save for restore later
//    end;
Procedure FrameXY(R:TRect; CL:Tcolor=clRed); overload;
    const CL_CLEAR_FRAME=clBtnFace; //clInfoBk;
    begin
      if InstallTourDlg.Hiding and not (CL=-1) then begin
        CL:=-1;  //clear
      end;
      F.Canvas.Handle:=GetDCEx(Form1.Handle, 0, DCX_PARENTCLIP);
      F.Canvas.Pen.Style := psSolid;
      F.Canvas.Pen.Width := 4;
      if CL=-1 then begin
        CL:=CL_CLEAR_FRAME;
        //Canvas.Pen.Style := psClear; //doesn't work
      end;
      F.Canvas.Pen.Color:=CL;
      F.Canvas.Brush.Style:=bsClear;
      F.Canvas.Rectangle(R);  //X1,Y1,X2,Y2);
//      ReleaseDC(Form1.Handle, F.Canvas.Handle);
    end;
procedure FrameXY(cL:TColor=-1); overload; //restore last frame
    begin
      FrameXY(rect(X1_CLEAR_FRAME,0,0,0),CL);
      FrameXY(TRect.Empty);
      //F.repaint;
    end;
Procedure FrameXY(X1,Y1,X2,Y2:integer;CL:Tcolor=clRed); overload;
begin
  FrameXY(rect(X1,Y1,X2,Y2),CL);
end;

const FRAME_INFLATE=8; FRAME_WIDTH=4;
function ScreenRect(C:TControl):TRect;
begin
 // result.SetLocation(C.Parent.ClientToScreen(Point(C.Left,C.Top)));
 // P:=F.ScreenToClient(P);
  result.SetLocation(F.ScreenToClient(C.Parent.ClientToScreen(Point(C.Left,C.Top))));
  result.Width:=C.Width;
  result.Height:=C.Height;
end;
procedure FrameIt(C1:TControl;C2:{TWin}TControl;CL:Tcolor=clRed); overload; //draw a frame outlining both controls
  var R,R2:TRect;
  const SaveC1V:boolean=true;SaveC2V:boolean=true; SaveC1:Tcontrol=nil;SaveC2:TControl=nil;
begin
      if (C1=nil) or (InstallTourDlg.Hiding and not (CL=-1)) then begin
        if (C1=nil) then C1:=SaveC1; //C2:=SaveC2;
        C1.Visible:=SaveC1V;  //C2.Visible:=SaveC2V;
      end
      else begin
        SaveC1:=C1; //SaveC2:=C2;
        SaveC1V:=C1.Visible; //SaveC2V:=C2.Visible;
        C1.Visible:=true; //C2.Visible:=true;
      end;
  R:=ScreenRect(C1);
  if assigned(C2) then begin
    R2:=ScreenRect(C2);
    R.union(R2);
  end;
  R.Inflate(FRAME_INFLATE,FRAME_INFLATE);
  FrameXY(R,CL);
end;
procedure FrameIt(C1:TControl;CL:Tcolor=clRed); overload; //draw a frame outlining both controls
begin
  FrameIt(C1,nil,CL);
end;

procedure SetTab(C:{TWin}TControl;Tab:TTabsheet;var SaveTVis:boolean);
    begin
      if C=nil then begin  //restore sheet1
       F.PageControl1.TabIndex:=0;
       F.Repaint;
       exit;
      end;
      if Tab<>nil then begin
        if F.PageControl1.TabIndex<>Tab.PageIndex then begin
          F.PageControl1.TabIndex:=Tab.PageIndex;
          F.Repaint;
        end;

        SaveTVis:=Tab.Visible;
      end;
    end;
procedure FrameIt(C:{TWin}TControl;Tab:TTabsheet;CL:Tcolor=clRed); overload;
    var SaveTVis :boolean;
    begin
      SetTab(C,Tab,SaveTVis);
      FrameIt(C,CL);
    end;
procedure FrameIt(H:hwnd;CL:TColor=clRed); overload;
  var R:TRect;
begin
  if GetWindowRect(H,R) then
      FrameXY(R);
end;

//------------------ End Graphics Fns --------------------------
//------------------ begin xSection functions ------------------
procedure TInstallTour.xStatusBar;
  begin
    Msg:=
     'It shows port status, and count of chars received'+CR
     +' when usb ports are plugged in or removed'+CR+CR
     +'It shows longer tooltips, '+CR
     +'  and you can dbl-click to expand the hint area'
     ;
    FrameIt(F.StatusBar1);
    F.StatusBar1.Panels[0].Text:='Short hints, and port information';
    F.StatusBar1.SimpleText:='or dbl-click to toggle for long hints and information';
    DoAnimate(procedure begin if Showing then F.StatusBar1DblClick(nil); end);
  end;

  procedure TInstallTour.xIconAnimate(IC:TIconStyle);
  begin
    DoAnimate(procedure begin
      F.UpdateTrayIcon(IC,true);
      end );
  end;

  procedure TInstallTour.xIcon;
  begin
    Msg:='Port activity makes the icon spin'+CR
    +'Even when Realterm is hidden, the Tray and Toolbar Icons still work'+CR+CR
    +'It can show you many states:'+CR
    +' - Closed   (X)'+CR
    +' - Waiting for Telnet connection (blue)'+CR
    +' - Open / receiving (green)'+CR
    +' - Sending (magenta) or Capturing (red)'+CR
    +' - Data Match (yellow)'
    ;
      FrameXY(Rect(-10,-40,40,10));
      F.Timer1.Enabled:=Hiding or not Animating;  //stop mainform timer
      SetAnimateInterval(350,350,2);
      xIconAnimate(iconClosed);
      xIconAnimate(iconWSDisconnect);
      SetAnimateInterval(350,350,4);
      xIconAnimate(iconOpen);
      xIconAnimate(iconSend);
      xIconAnimate(iconCap);
      xIconAnimate(iconMatch);
  end;
  procedure TInstallTour.xUSBPlug;
  begin
    Msg:='When any USB port is plugged or removed,'+CR
    +'it is reported in the Status Bar (not just selected port)'+CR
    +'The little USB label changes to red/green showing the last change'+CR+CR
    +'Click the USB label to show/hide the detailed USB info'+CR
    +'The history combo shows all the previous usb devices'+CR
    +'Notice the Status box label changes to "Status:closed"'+CR
    +'   Try it Now!'
    ;
    F.LabelUSBShow.Color:=BoolColor(Showing,clLime,clBtnFace);
    F.PanelUSBShow.Color:=F.LabelUSBShow.Color;
    F.ComboboxUSBData.Visible:=Showing;
    F.ComboboxUSBHistory.Visible:=Showing;

    FrameIt(F.StatusBar1,F.TabSheetPort);
    FrameIt(F.StatusBar1);
    FrameIt(F.LabelUSBShow);
    FrameIt(F.PanelUSBShow,F.ComboboxUSBHistory);
//    SetAnimateInterval(500,100);
//    DoAnimate(procedure() begin F.LabelUSBShow.Color:=clBlue; end);
//    DoAnimate(procedure() begin F.LabelUSBShow.Color:=clYellow; end);
  end;
  procedure TInstallTour.xPhoneCom;
  begin
       Msg:='The OPEN button must be down, or the port is not open'+CR
       +'When the port is open, some status light normally turn green'+CR
       +'When you type something, the TXD light flashes, and when'+CR
       +'the phone replies the RXD light flashes'+CR+CR
       +'When you move the mouse over the ERROR light, it will show'+CR
       +'the last port error message'
       ;

    if Showing then begin
       FrameIt(F.GroupBoxStatus,F.TabsheetPort);
       FrameIt(F.SpeedButtonPort1Open,F.TabsheetPort);
       end
     else begin
       FrameIt(F.GroupBoxStatus,-1);
       FrameIt(F.SpeedButtonPort1Open,-1);
    end;
  end;
  procedure TInstallTour.xPhoneGroup;
  begin
       Msg:='Basic Commands for Phones and GSM modules are on Misc tab'+CR+CR
       +'The first button sends AT. A Phone or modem will reply with "OK"'+CR
       +'There are buttons for the two basic commands used by RootJunky'+CR
       +'The big issue is to enable the port on your phone first,'+CR
       +'  and to find the correct port that is a phone'+CR
       +'There are other commands to query your phone or GSM data module'+CR
       ;
    if Showing then begin
       FrameIt(F.GroupBoxPhone,F.TabsheetMisc);
       end
     else begin
       FrameIt(F.GroupBoxPhone,-1);
    end;
  end;

  procedure TInstallTour.x38;
  begin
       Msg:='Basic Commands for mobile phone and GSM modules on Misc tab'+CR+CR
       +'The Misc Tab has been re-organised, and legacy functions hidden'+CR
       +'the Show selector lets you choose them.'+CR+CR
       +'The ShowLastError and About buttons are gone -use the Help menu now'
       ;
       FrameIt(F.RadioGroupMiscFeatures,F.TabsheetMisc);
       FrameIt(F.GroupBoxPhone);
  end;
procedure TInstallTour.x35;
begin
       Msg:='You can drag to resize the window, and the StatusLights will remain visible'
       ;
       FrameIt(F.GroupBoxStatus);
       FrameXY(TRect.Create(Point(F.ClientWidth-30,F.ClientHeight-30),40,40));
    end;

procedure TInstallTour.xHiddenControls;
begin
  Msg:='Some very specialised settings are hidden.'+CR
        +'You show them by <right-click> over the assocated control'+CR
        +'  e.g. TimeStamp checkbox has a hidden TimeStampFormat edit'+CR+CR
        +' (the tooltip for the visible control will tell you)'
                    ;
    DoAnimateHiddenPair(F.CheckBoxDisplayTimeStamp,F.ComboBoxDisplayTimeStampFormat,F.TabsheetDisplay);
    DoAnimateHiddenPair(F.CheckBoxRxdIdle,F.SpinEditRxdIdle,nil);
    DoAnimateHiddenPair(F.RadioGroupTimeStamp,F.ComboBoxTimeStampFormat,F.TabSheetCapture);
    DoAnimateHiddenPair(F.CheckBoxCaptureEOL,F.ComboBoxCaptureEOLChar,F.TabSheetCapture);
end;
procedure TInstallTour.xIni;
begin
  Msg:='Commandlines are the way to customise and setup Realterm.'+CR
      +'Explore them from the "IniFile && CmdLine" button on Misc tab'+CR
      +' You can load, edit, and save INI files here.'+CR+
       ' Hint: Only save the params you want to set - not everything!'+CR+CR+
       ' There is a list of all commandline parameters'+CR+
       ' - you can jump staight to the online help for them'+CR+
       ' You can try out commandlines in the editor with "Execute"'
        ;
  FrameIt(F.ButtonWriteINIFile,F.TabSheetMisc);
  if Showing
    then begin
      ParameterINIDlg.show;
      ParameterINIDlg.Left:=Left+Width div 2+50;
    end
    else ParameterINIDlg.hide;
end;
procedure TInstallTour.x44;
  begin
    Msg:='Capture Stop on Whole Lines or a Line-count' +CR
         +'Capture can now end at end-of-line, so lines dont get split.' +CR
         +'This is important with auto-restart and post-processing files'+CR
         +'  where data lines were broken at start and end of files.'+CR
         +'You can edit the EOL char + new params CAPEOL, CAPLINES'+CR+CR
         +'Echo Port Monitor mode adds alternating lines checkbox';
    FrameIt(F.RadioGroupCaptureSizeUnits);
    DoAnimateHiddenPair(F.CheckBoxCaptureEOL,F.ComboBoxCaptureEOLChar,F.TabSheetCapture);
//    DoAnimateHiddenPair(F.CheckBoxMonitorNewLineOnDirectionChange,nil,F.TabsheetEcho);
//    DoAnimate(procedure begin FrameIt(F.CheckBoxMonitorNewLineOnDirectionChange,F.TabsheetEcho); end,false);
    end;

procedure TInstallTour.x41_DAListHelp(S:string);
begin
    DoAnimate(procedure begin
    if not AnimateHiding
      then ParameterINIDlg.FindParam(S)
      else ParameterINIDlg.ListBoxParamMakeDblClick(nil); //ValueListEditorParamsMakeDblClick(nil);
     end ,false);
end;
  procedure TInstallTour.x41;
  begin
    Msg:='At last Startup INI files and Macros'+CR
    +'Realterm_Always.ini and Realterm_Default.ini run at startup'+CR
    +'Always.ini runs before the commandline, Default only if its empty'+CR+CR
    +'Macro1 and Macro2 load at startup, with global Hotkeys on Send menu '+CR
    +'Shift+F10/11 to use. They can do anything the command-line can do!'+CR+CR
    +'Dbl-clicking a Help param adds it to the editor with its value'+CR
    +'The "View Params" button lets you copy the starting command line'+CR
    +' to the Editor'+CR+CR
    +'  Try it Now!'
    ;

//  if not Animating then
    FrameIt(F.ButtonWriteINIFile,F.TabSheetMisc);

  DoAnimate(nil,true,1000,100);
  DoAnimate(procedure begin
  if Showing
    then begin //try to fit non-overlap
      ParameterINIDlg.show;
      ParameterINIDlg.Width:=max(500,min(ParameterINIDlg.Width,
                                 Screen.Width-(Left+Width)));
      ParameterINIDlg.Left:=Screen.Width-ParameterINIDlg.Width;
    end
    else ParameterINIDlg.hide;
    end,true);
  DoAnimate(ParameterINIDlg.BitBtnMacro1,ParameterINIDlg.BitBtnMacro2);
  DoAnimate(procedure begin
    ParameterINIDlg.BitBtnMacro1Click(nil);
     end , false);

  DoAnimate(ParameterINIDlg.BitBtnClear,ParameterINIDlg.BitBtnRecover);
  DoAnimate(procedure begin ParameterINIDlg.BitBtnClearClick(nil) end);
//  SetAnimateInterval(100);
  DoAnimate(ParameterINIDlg.ListBoxParamHelp); //  ValueListEditorParams,nil,true); //just show it
  x41_DAListHelp('port');
  x41_DAListHelp('baud');
  x41_DAListHelp('winw');
  x41_DAListHelp('winh');

  DoAnimate(ParameterINIDlg.ListBoxParamHelp); //ValueListEditorParams); //hide

  DoAnimate(ParameterINIDlg.BitBtnSeeCommandLine);
  DoAnimate(procedure begin
     ParameterINIDlg.BitBtnSeeCommandLineClick(nil)
     end );
  end;

procedure TInstallTour.xAbout;
begin
//    FrameIt(F.LinkLabelRealtermOnlineManual,F.TabsheetDisplay);
//    Heading:='About box and Online Help';
    Msg:='There is an extensive manual online'+CR+CR
       +'You can bring up help from the menu or F1 key,'+CR+
       ' or the Realterm Online Manual link below'+CR+CR+
       'See that the About box has all the online links for Realterm' +CR+CR+
       'There is system information at the bottom,'+CR
       +' or use LastErrorMessage in the menu to copy to clipboard.'+CR
       +'There are examples in the \Examples directory'
       ;
     if Showing
       then RTAboutBox.AboutBox.show
       else RTAboutBox.AboutBox.hide;
     end; //first time only
procedure TInstallTour.xFinish;
begin
 //    Heading:='The tour is finished';
     Msg:='Realterm will occasionally check for updates automatically'+CR+
     ' and the "News" label will change to "Update"'+CR+CR+
     'You can stop internet access with regedit'+CR+
     'keys are at: '+rtUpdate.RegistryKeyBase+CR+
     'We get occasional usage stats and port analytics'+CR+
     ' and no, that sound is not a black helicopter'+CR+CR+
     'Now click on NEWS && HELP to see all the changes in this version'
     ;
//     FrameIt(F.LinkLabelNews,F.TabsheetDisplay);
     ButtonHelp.Visible:=true;
     if Showing
       then SidleControls(ComboboxTour,ButtonHelp) //.Left:=ButtonChangeTour.Left+ButtonChangeTour.Width+20
       else SidleControls(ButtonDone,ButtonHelp); //ButtonHelp.Left:=ButtonDone.Left+ButtonDone.Width+20;
     SetFocusControl(ButtonHelp);
     ButtonDone.Visible:=not showing;
end;


procedure TInstallTour.xIntro;
  var S:string;
begin
    S:= 'Realterm has just been ';
    if rtUpdate.ITVersion=''
    then S:=S+'installed'
    else S:=S+'updated from V'+rtUpdate.ITVersion;
    Heading:=S;
    S:=
      'I will show you ';
    if ttAll in TourSet then S:=S+'some important features now...  ';
    if ttUpdate in TourSet then S:=S+'just the changes since V'+rtUpdate.ITVersion;
    if ttAllUpdates in TourSet then s:=S+'changes since V3.0.1.34';
    if ttPhone in TourSet then S:=S+'some controls relevant to Phone Unlocking';

    S:=S+CR+CR
      +'You can change to another tour with the selector below'+CR+CR
      +'Read all the tooltips carefully, as they are a rich source of help.'+CR+CR
      +'Right-Click for Popup-menu, and SystemMenu icon on toolbar'+CR
      +'F1 launches help. '+CR

      +'The status line continues to show the tooltips after they have gone.'+CR
      +'   Double click the status line to see longer help strings'+CR+CR
      +'There are many useful Hotkeys and more being added. '+CR
      +'   Look through the Menus and learn them all'
        //+'Be sure to Subscribe at Sourceforge, and watch News or RSS'
      ;
      Msg:=S;
end;
procedure TInstallTour.xComport;
begin
 //     Heading:='Warning: I don''t see any Com-Ports installed yet.';
      Msg:='You will need to plug a port in before you can use Realterm'+CR+CR
      +'New usb ports should show in the Status Bar when they are installed'+CR+CR
      +'You can launch [Device Manager] from the end of the Ports list'+CR
      +'  (if you do have a comport, but it is not being detected)'
      ;
  if Phase=tpShow then begin
      FrameIt(F.ComboBoxComPort,F.TabSheetPort);
      F.ComboBoxComPort.DroppedDown:=true;
      F.ComboBoxComPort.ItemIndex:=F.ComboBoxComPort.Items.Count-4;
      SetFocusControl(ButtonNext);
  end else begin
      FrameIt(F.ComboBoxComPort,-1);
      F.ComboBoxComPort.ItemIndex:=1;
      F.ComboBoxComPort.DroppedDown:=false;
      SetFocusControl(ButtonNext);
  end;
end;
procedure TInstallTour.xPopup;
begin
      FrameIt(F.ButtonPopupMenu);
      Heading:='The PopupMenu';
      Msg:=
         'Explore it now, it has more functions than the System Menu'+CR
         +' and especially take note of all the HotKeys'+CR
         +' - you can use them throughout Realterm'+CR
         +' - Global Send hotkeys can be used from anywhere in Windows!'+CR+CR
         +' <right-click> or <shift+F10> or Popup-Menu key, or ? button'
        ;
     SetFocusControl;

     if Showing then ShowPopupMenu(F.PopupMenu1.handle,Showing,0, Height+10);
     FrameIt(F.PopupMenu1.handle);
end;

procedure TInstallTour.xSysMenu;
begin
    Msg:= ' Look in the Window and Help submenus now....'+CR+CR
           +'There are several different Window modes to try'+CR+CR
           +'You can scale Realterm up on small screens'+CR
           +'or you can have a miniterminal that stays on top'+CR
           +'(Menu submenu has all of PopupMenu in it)'+CR+CR
           +'from keyboard, <alt+SPACE> brings up system menu'
           ;
    FrameXY(Rect(-10,-40,180,150));
    SetFocusControl;
    if Showing then ShowSysMenu();
    //if Hiding then F.AdTerminal1.Repaint;
end;

function TTour.IsPhase(P:TPhaseType):boolean;
begin
  result:=Phase=P;
end;

procedure TTour.StartQ(TF:TMethod=nil); //TF=TourFunction
begin
  //set to count mode - count off lines
    Phase:=tpEnumerate; //first must enumerate it all
    //Showing:=false; Hiding:=False;
    fQStep:=0;         // individual substeps
    fQSection:=0;      // logical sections / blocks
    fQi:=0;        // counter used to number-off
    fVersionMatchCount:=0;
    //fShowPhase:=false;
    //fHidePhase:=false;
    fNumSteps:=0;
    fNumSections:=0;
    fSections.Clear; //clear the heading list - will refill in enumeration
    fDefaultPhaseSet:=[tpShow,tpHide];
    DoTF(TF);
end;

procedure TTour.DoNext(TF:TMethod=nil;JumpTo:integer=-1);
//hides last, then shows this. enumerates if not done yet
begin
  repeat
//    Hiding:=Phase=tpHide;
//    Showing:=Phase=tpShow;
    if (JumpTo>=0) and (Phase=tpShow) then begin//so we Hide before jumping
      fQStep:=JumpTo+1;    //will break if steps<>sections
      fQSection:=JumpTo+1;
    end;
    DoTF(TF);
    if (JumpTo>=0) and (Phase=tpStop) then Phase:=tpShow;
  until (not (Phase in [tpShow,tpEnumerate]));
end;

procedure TTour.NextQ(NextSection:boolean=true); //moves
begin
  //set to count mode - count off lines
  inc(fQi); //move the counter
 // if NextSection then inc(fQiSection);

  case Phase of
    tpEnumerate: begin
      inc(fQStep);
      if NextSection then inc(fQSection);
    end;
  end;
end;
procedure TTour.SetPhase(P:TPhasetype);
begin
  fPhase:=P;
  case P of
    tpEnumerate, tpStop: begin
      Showing:=false;
      Hiding:=False;
      end;
    tpShow:begin Showing:=true; Hiding:=False;end;
    tpHide:begin Showing:=false; Hiding:=true;end ;
  end;
end;

procedure TTour.DoTF(TF:TMethod=nil);
begin
  if assigned(TF) then begin
    TF;
    fTF:=TF;
    end
  else if assigned(fTF) then fTF
       else assert(true,'Install Tour Function TF should always be assigned');
end;
procedure TTour.StopQ(TF:tMethod=nil);
begin
  if Phase in [tpShow] then begin //just done hide
    Phase:=tpStop;
    DoTF(TF);
  end;
  if Phase in [tpHide] then begin
    DoTF(TF);   //hide
    Phase:=tpStop;
    DoTF(TF);   //stop
  end;

end;



function TTour.EndQ:boolean;
begin
//  inc(fQi);
  result:=false;
  case Phase of  //this is at end, so phase is completed when here
    tpEnumerate: begin  //enumeration ended
        fNumSteps:=fQStep;
        fNumSections:=fQSection;
        fNumVersionMatches:=fVersionMatchCount;
        Phase:=tpShow; //move to show phase
        fQStep:=1; //first Step;
        fQSection:=1; //first Section
    end;
    tpShow: begin
      Phase:=tpHide;
    end;
    tpHide: begin
      if IsMatchQ then begin //this is the end of Show/Hide sequence
        Phase:=tpStop;  //there (might) be a loop with phase=stop. Don't move step
        result:=true; // but we will return stop now
      end
      else begin  //Next loop of show/hide
        Phase:=tpShow;
        inc(fQStep); //next Step
        inc(fQSection);
      end;
    end;
    tpStop: begin   //must have done a tpStop phase through
      result:=true;
    end;
  end;
  fQi:=0;  //back to start
  //fVersionMatchCount:=0;
end;

function TTour.IsMatchQ(FilterMatch:boolean=true;SectionMatch:boolean=true):boolean;
begin
  result:=(fQi=fQStep); //does the counter match this step
end;

//Is it time for this line?
function TTour.IsQ(FilterMatch:boolean=true;PhaseSet:tphaseset=[];Head:string=''):boolean; //overload;
begin
  if FilterMatch then NextQ(true); //each IsQ is a valid section
  result:=FilterMatch and IsMatchQ;
  if PhaseSet=[] then PhaseSet:=fDefaultPhaseSet;
  result:=result and (Phase in PhaseSet);
  if result
     or (FilterMatch and (Phase=tpEnumerate)) then Heading:=Head; //add heading
end;
//function TTour.IsQ(F:TProcedure;FilterMatch:boolean=true;PhaseSet:tphaseset=[];Head:string=''):boolean;
//begin
//  //set to count mode - count off lines
//  result:=IsQ(FilterMatch,PhaseSet,Head);
//  if result and assigned(F) then DoQF(F);
//end;

function TTour.IsQ(F:TMethod;FilterMatch:boolean=true;PhaseSet:tphaseset=[];Head:string=''):boolean;
begin
  result:=IsQ(FilterMatch,PhaseSet,Head);
  //result:=IsQ(FilterMatch,PhaseSet);
  if result and assigned(F) then DoQ(F);
end;
function TTour.IsQ(F:TMethod; Version:string;PhaseSet:tphaseset=[];Head:string=''):boolean;
  var B:boolean;
begin
  //set to count mode - count off lines
  B:=rtUpdate.ITVersionIsNewer(Version);   //are these updates in
  if ttAllUpdates in TourSet then B:=true; //all updates
  B:=B and
  ( (ttAll in TourSet) or (ttUpdate in TourSet) or (ttAllUpdates in TourSet));
  if B and (Phase=tpEnumerate) then
    inc(fVersionMatchCount); //count number of matching versions
  //Heading:='New in V'+Version;
  result:=IsQ(B,PhaseSet, 'New in V'+Version);
  if result then begin
    fFeatureVersion:=Version;
    if assigned(F) then DoQ(F);
  end;
end;
//function TTour.IsQ(F: TProcedure; FilterMatch: boolean; PhaseSet: tphaseset;
//  Head: string): boolean;
//begin
//
//end;

function TTour.IsQH(F:TMethod; Head:string;FilterMatch:boolean=true;PhaseSet:tphaseset=[]):boolean;
begin
  result:=IsQ(F,FilterMatch,PhaseSet,Head);
  //if result and assigned(F) then F;
end;

function TTour.IsQH(F:TMethod; Head:string; Version:string;PhaseSet:tphaseset=[]):boolean;
begin
  //Heading:=Head;
  result:=IsQ(F,Version,PhaseSet,Head);
end;
procedure TTour.DoQ(F:TMethod); //single spot to call F. Sets animations
begin
  //remember, we don't know if F conatins any animate statements at all
  if Showing then StartAnimate(F); //setup for animation on
  F;
  if Hiding then StopAnimate;
end;

//-------------- Animation fns -----------------
const DEFAULT_ANIMATE_HIDING_INTERVAL=250;
const DEFAULT_ANIMATE_SHOWING_INTERVAL=1000;
procedure TTour.SetAnimateInterval(ShowingInterval:integer=-1;HidingInterval:integer=-1;NumSubSteps:integer=-1);
  var B:boolean;
begin
    B:= not Animating;   //so always set during normal
   // B:=B or (fAnimateQi=0);
    B:=B or (fAnimateQi=(fAnimateQStep-1));
    if B then begin
    DefaultMinus1(HidingInterval,DEFAULT_ANIMATE_HIDING_INTERVAL);
    DefaultMinus1(ShowingInterval,DEFAULT_ANIMATE_SHOWING_INTERVAL);
    DefaultMinus1(NumSubSteps,1);
    fAnimateHidingInterval:=HidingInterval;
    fAnimateShowingInterval:=ShowingInterval;
    fAnimateNumSubSteps:=NumSubSteps;
    end;
end;
procedure TTour.StartAnimate(F:TMethod;ShowingInterval:integer=-1;HidingInterval:integer=-1);
begin
  SetAnimateInterval(ShowingInterval,HidingInterval);
  fAnimateFn:=F;
  fAnimateQi:=0;
  fAnimateQStep:=1;
  fAnimateQSubStep:=1; //? 0 or 1
  AnimateHiding:=false; //start at showing
  Timer.OnTimer:=AnimateCallback;
  Timer.Interval:=100; //quickly launches first call. DoAnimate sets the times of each step
  Timer.Enabled:=false; //this makes timer run, even when xF has no animations
end;
procedure TTour.StopAnimate;
begin
  fAnimateFn:=nil; //stop animation
  Timer.Enabled:=false;
end;
procedure TTour.AnimateCallback(Sender: TObject);
var sShowing,sHiding:boolean;
begin
  fAnimateQi:=0; //restart count  DoAnimate incs first

  //during animate, remove the normal showing/hiding??
  sShowing:=Showing;
  sHiding:=Hiding;
  Hiding:=false;
  Showing:= false;

  Animating:=true; //only set when AnimateFn being called by timer
  if assigned(fAnimateFn) then
    fAnimateFn;
  Animating:=false;

  //restore
  Showing:=sSHowing;
  Hiding:=sHiding;


  if AnimateHiding then begin //just hidden, so we are going to show next..
    if (fAnimateQStep>=fAnimateQi) and (fAnimateQSubStep>=fAnimateNumSubSteps)
    then begin   //end of loop
      fAnimateQStep:=1; //loop again
      fAnimateQSubStep:=1;
    end else begin //loop again , step and substep are 1-Num
      inc(fAnimateQSubStep);
      if fAnimateQSubStep>fAnimateNumSubSteps then begin
        fAnimateQSubStep:=1;
        inc(fAnimateQStep);
      end;

    end;
  end;
  AnimateHiding:= not AnimateHiding; //alternate show/hide
end;
//Do each line of animation F is anon fn.
procedure TTour.DoAnimate(C1:Tcontrol;C2:Tcontrol=nil; OnlyShowing: Boolean=false; ShowingInterval: Integer = -1; HidingInterval: Integer = -1);
begin
  DoAnimate(procedure begin
    FrameIt(C1,C2);
    end, OnlyShowing, ShowingInterval,HidingInterval);
end;
procedure TTour.DoAnimate(S1:string; OnlyShowing: Boolean=True; ShowingInterval: Integer = -1; HidingInterval: Integer = -1);
begin
  DoAnimate(procedure begin Msg:=S1; end, OnlyShowing, ShowingInterval,HidingInterval);
end;
//to alternate hidden controls C1 aqua,c2red
procedure TTour.DoAnimateHiddenPair(C1,C2:TControl;Tab:TTabsheet);
begin
  DoAnimate(procedure begin FrameIt(C1,Tab,clAqua); end,false);
  DoAnimate(C2,nil,false,DEFAULT_ANIMATE_SHOWING_INTERVAL*3 div 2);
  if AnimateHiding or Hiding then begin
      C2.Visible:= false;
      C1.Repaint;
  end;
end;

procedure TTour.DoAnimate(F: TProc;OnlyShowing:boolean=true;ShowingInterval:integer=-1;HidingInterval:integer=-1);
  var sShowing,sHiding:boolean;
begin
  if (fAnimateQi=0) and Showing then
    Timer.Enabled:=true; //this makes timer run only when xFn has a DoAnimation in it
  inc(fAnimateQi);
  if Animating then //only when called by timer
    //match this Step
    if (fAnimateQi = fAnimateQStep) then begin
    //save
      sShowing:=Showing;
      sHiding:=Hiding;
      Hiding:=AnimateHiding;
      Showing:= not AnimateHiding;
      if (not AnimateHiding) or (AnimateHiding and not OnlyShowing)
         then
         if assigned(F) then
            F; //do
      DefaultMinus1(HidingInterval,fAnimateHidingInterval);
      DefaultMinus1(ShowingInterval, fAnimateShowingInterval);
      //set delay to next state MUST NOT be 0
      Timer.Interval:=max(10,AorB(AnimateHiding,HidingInterval,ShowingInterval));

      //restore
      Showing:=sSHowing;
      Hiding:=sHiding;
    end;
   //not animating
    if not Animating and Hiding and assigned(F) then
        F; //do
//  Showing:=false;
//  Animating:=true;
end;
//--------- end Animation fns------------
procedure TInstallTour.RestoreButtons;
begin
  ButtonNext.Visible:=true;
  ButtonDone.Visible:=true;
  SidleControls(ButtonNext,ComboboxTour);
  SidleControls(ComboboxTour,ButtonDone);
  SidleControls(ButtonDone,ButtonHelp);
  SetFocusControl(ButtonNext);
end;
procedure TInstallTour.ButtonChangeTourClick(Sender: TObject);
begin
//  RestoreButtons;
//  SetTourType(true);
//  StartQ;//(TheTour);
//  ButtonNext.Caption:='Next '+inttostr(fQSection)+' of '+inttostr(fNumSections);
//  DoNext;//(TheTour); //first slide
end;
procedure TInstallTour.ComboBoxTourSelect(Sender: TObject);
begin
  RestoreButtons;
//  SetTourType(true);

  SetTour(TTourType(ComboboxTour.ItemIndex)); //set the tour
  StartQ;//(TheTour); //scan it

  if (ttUpdate in TourSet) and (fNumVersionMatches=0)
    then begin
      SetTour(ttAllUpdates);
      //ComboBoxTour.ItemIndex:=ord(ttAllUpdates);
      StartQ;//(TheTour); //scan it
    end;
  ButtonChangeTour.Caption:=ComboboxTour.Text;
  ButtonNext.Caption:='Next '+inttostr(fQSection)+' of '+inttostr(fNumSections);
  DoNext;//(TheTour); //first slide
  end;

procedure TInstallTour.SetFocusControl(C:TWinControl=nil);
begin
  if not self.Visible then exit;
  if not assigned(C)
    then C:=FocusedControl
    else if C.Visible then FocusedControl:=C;
  MoveCursorTo(C,true);
end;
//---------------------------------------------------
procedure TInstallTour.SetHeading(S:string);
begin
  if Showing then begin
       //ComboboxHeading.Enabled:=false;
      try
      if fSections.Strings[fQSection-1]='' //add heading if it was blank
        then fSections.Strings[fQSection-1]:=S;
      except;
      end;

    ComboboxHeading.ItemIndex:=fQSection-1;
    //ComboboxHeading.Text:=S;

    PanelHeading.Caption:=S;
  //  PanelHeading.Height:=25;
  end
  else begin
    if Phase=tpEnumerate then begin
//      ComboboxHeading.Enabled:=false;
      try
      if (fSections.Count<fQSection)
        then fSections.Add(S)
        else fSections.Strings[fQSection-1]:=S;
      except;

      end;
    end;
  end;

end;
procedure TInstallTour.SetMsg(S:string {Force:boolean=false});
begin
  if Animating and (Label1.Caption=S) then exit; //flicker free if unchanged

  Label1.Caption:=S;
  Width :=max(Label1.Width,ButtonDone.Left+ButtonDone.Width)+50;
  Height :=max(50,Label1.Height)+Panel1.Height+PanelTitle.Height+PanelHeading.Height+15;
  Left:=F.Left+ (F.Width div 2) - (Width div 2); //put in middle of form
  Top:=F.Top+10;
  Repaint; //remove grey lines
end;

constructor TTour.Create(AOwner: TComponent); // not being called why?
begin
  inherited;
  Timer:=TTimer.Create(self);
  Timer.Enabled:=false;
end;

procedure TInstallTour.FormCreate(Sender: TObject);

begin
  //inherited;
  F:=Realterm1.Form1;
  BorderIcons := [];
  BorderStyle := bsNone ;

  if not assigned(Timer) then Timer:=TTimer.Create(self);
  Timer.Enabled:=false;
  fSections:=ComboBoxHeading.Items;

  //TTourType=(ttAll,ttUpdate,ttAllUpdates,ttPhone);
  ComboboxTour.Items.Add('Full Tour');
  ComboboxTour.Items.Add('Just Changes');
  ComboboxTour.Items.Add('All Updates');
  ComboboxTour.Items.Add('Phone Unlock');
  SetTour(ttUpdate);
end;

procedure TInstallTour.FormHide(Sender: TObject);
begin
  StopQ;
  F.PageControl1.TabIndex:=0;  //exit on Display tab
  rtUpdate.ITVersion:=''; //set to this version now tour is shown
  F.Timer1.Enabled:=true;
  Close; //not keeping the form when not in use
end;
procedure TInstallTour.SetTour(T:TTourType);
begin
  ComboboxTour.ItemIndex:=ord(T);
  TourSet:=[T];
end;
procedure TInstallTour.SetTour(I:integer);
begin
  if I>ord(High(TTourType)) then I:=0;
  SetTour(TTourType(I));
end;
procedure TInstallTour.FormShow(Sender: TObject);
begin
  SetTour(ttUpdate);
  if (rtUpdate.ITVersion='') then SetTour(ttAll); //new install
  if rtUpdate.InstallParamVersion<>'' then
  try
    SetTour(StrToInt(rtUpdate.InstallParamVersion)); //from cmdline install=X
  except
  if length(rtUpdate.InstallParamVersion)>2 then  //cmdline install=X.x.x.x
    if rtUpdate.ValidateVersionStr(rtUpdate.InstallParamVersion)
    then begin
      rtUpdate.ITVersion:=rtUpdate.InstallParamVersion;
      SetTour(ttUpdate);
    end
    else begin
      rtUpdate.InstallParamVersion:='';
      SetTour(ttAllUpdates); //wasn't valid version so show all updates
    end;
  end;

  StartQ(TheTour);
  ButtonNext.Caption:='Next '+inttostr(fQSection)+' of '+inttostr(fNumSections);
  RestoreButtons;
  SetFocusControl(ButtonNext);
  DoNext(TheTour); //first slide
end;
procedure TInstallTour.ButtonNextClick(Sender: TObject);
begin
  DoNext;//(TheTour);
  SetFocusControl;
  ButtonNext.Caption:='Next '+inttostr(fQSection)+' of '+inttostr(fNumSections);
end;

procedure TInstallTour.ComboBoxHeadingSelect(Sender: TObject);
begin
  DoNext(nil,ComboboxHeading.ItemIndex);
  RestoreButtons;
  ButtonNext.Caption:='Next '+inttostr(fQSection)+' of '+inttostr(fNumSections);
end;


procedure TInstallTour.ButtonHelpClick(Sender: TObject);
begin
  F.AllHelp(true);
  ButtonHelp.Visible:=false;
  ButtonDone.Visible:=true;
end;

procedure TInstallTour.ButtonDoneClick(Sender: TObject);
begin
  Hide;
end;

procedure TInstallTour.TheTour({Sender:TObject});
begin
  //IsQ(x41,'3.0.1.41');
  //IsQH(xIcon,'The Icon shows Port Status');
  //IsQH(xHiddenControls,'Hidden Controls');
    IsQH(xIntro,'Introduction');
    IsQH(xComport,'Warning: I don''t see any Com-Ports installed yet',ComPortList.Count=0); //always warn of no ports
    IsQ(x35,'3.0.1.35');
    IsQ(x38,'3.0.1.38');
    IsQ(xUSBPlug,'3.0.1.41');
    IsQ(x41,'3.0.1.43');
    IsQ(x44,'3.0.1.44');
    //if rtUpdate.ITVersionIsNewer('1.0.0.0') then begin
    if ttPhone in TourSet then begin
      IsQH(xComport,'Comports are shown Here',ComPortList.Count>0);
      IsQH(xPhoneCom,'The Port must be Open');
      IsQH(xUSBPlug,'When USB is Plugged in');
      IsQH(xPhoneGroup,'Special Phone Buttons');
    end;
    if ttAll in TourSet then begin
      IsQH(xPopup,'The PopupMenu');
      IsQH(xSysMenu,'The System Menu');
      IsQH(xStatusBar,'The StatusBar');
      IsQH(xIcon,'The Icon shows Port Status');
      IsQH(xHiddenControls,'Hidden Controls');
      IsQH(xIni,'Command Lines and INI Files');
      IsQH(xAbout,'About box and Online Help');
    end;
      IsQH(xFinish,'The Tour is Finished');
      if Hiding then F.AdTerminal1.Repaint;
    if EndQ then begin //done
      Msg:= 'You can run the tour again from the Help menu'+CR
      +'  or select another tour now'
      ;
      ButtonNext.Visible:=false;
      ButtonDone.Visible:=true;
      ButtonDone.Left:=ButtonNext.Left;
      SidleControls(ButtonDone,ComboboxTour);
      SidleControls(ComboboxTour,ButtonHelp);
//      ButtonChangeTour.Left:=ButtonDone.Left+ButtonDone.Width+BUTTON_GAP;
//      ButtonHelp.Left:=ButtonChangeTour.Left+ButtonChangeTour.Width+BUTTON_GAP;
      SetFocusControl(ButtonHelp);
    end;
    //here at next state

    //F.PageControl1.Repaint;
end;

end.
