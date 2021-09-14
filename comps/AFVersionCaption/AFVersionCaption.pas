{
AFVersionCaption.pas  v1.0
A VCL that displays File Version (if any) in its parentform Caption
Copyright (C) 2002  Accalai Ferruccio - AfSoftware
mailto:faccalai@tiscalinet.it - info@afsoftware.it
webpage:www.afsoftware.it;
}

unit AFVersionCaption;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type

  TAFVersionCaption = class(TComponent)
  private
         { Private declarations }
    FInfoPrefix: string;
    FShowInfoPrefix: boolean;
    FCaption: String;
    FOldCaption: String;
    FParenthesis: Boolean;
    fShortInfo: Boolean;
    fOnError: TNotifyEvent;
    fOnNoInfoAvailable: TNotifyEvent;
    function GetInfo: string;
    procedure SetInfoPrefix(Value: String);
    function GetInfoPrefix: string;
    procedure SetShowInfoPrefix(Value: boolean);
    procedure SetShowParenthesis(VAlue: Boolean);
    procedure SetupCaption;
    function GetForm: TForm;
  protected
         { Protected declarations }
    property Form: TForm read GetForm;
  public
         { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Execute; published
         { Published declarations }
    property InfoPrefix: String read GetInfoPrefix write SetInfoPrefix;
    property ShowInfoPrefix: boolean read FShowInfoPrefix write
      SetShowInfoPrefix;
    property ShowParenthesis: Boolean read FParenthesis write
      SetShowParenthesis;
    property ShortInfo: boolean read fShortInfo write fShortInfo;
    property OnError: TNotifyEvent read fOnError write fOnError;
    property OnNoInfoAvailable: TNotifyEvent read fOnNoInfoAvailable write
      fOnNoInfoAvailable;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('AF',[TAFVersionCaption]);
end;

constructor TAFVersionCaption.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ShowInfoPrefix := true;
  FInfoPrefix := 'File Version:';
  FoldCaption := Form.Caption;
  fShortInfo := False;
end;

destructor TAFVersionCaption.Destroy;
begin
  inherited Destroy;
end;


function TAFVersionCaption.GetInfo: string;
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
					 If fShortInfo then
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
            If Assigned(fOnError) then
              fOnError(self);
          end;
      finally
		  FreeMem (Point);
      end;
    end
  else
    begin
      result := '';
      If Assigned(fOnNoInfoAvailable) then
        fOnNoInfoAvailable(self);
    end;
  If result <> '' then
    begin
      if ShowInfoPrefix then
        Result := InfoPrefix+' '+Result;
      if FParenthesis then
        result := '('+result+')';
    end;
end;

procedure TAFVersionCaption.SetInfoPrefix(Value: String);
begin
  if FInfoPrefix = Value then
    exit;
  FInfoPrefix := Value;
  SetupCaption;
end;
procedure TAFVersionCaption.SetShowParenthesis(Value: Boolean);
begin
  if FParenthesis = Value then
    exit;
  FParenthesis := Value;
  SetupCaption;
end;


function TAFVersionCaption.GetInfoPrefix: string;
begin
  result := FInfoPrefix;
end;

procedure TAFVersionCaption.SetShowInfoPrefix(Value: boolean);
begin
  if FShowInfoPrefix = value then
    exit;
  FShowInfoPrefix := Value;
  SetupCaption;
end;


procedure TAFVersionCaption.SetupCaption;
begin
  FCaption := GetInfo;
end;
function TAFVersionCaption.GetForm: TForm;
begin
  if Owner is TCustomForm then
    Result := TForm(Owner as TCustomForm)
  else
    Result := nil;
end;
Procedure TAFVersionCaption.Execute;
begin
  SetUpCaption;
  If pOS('<',FCaption) = 0 then
    Form.Caption := FOldCaption+' '+FCaption
  else
    Form.Caption := FOldCaption;
end;

end.
