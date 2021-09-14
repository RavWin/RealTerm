unit FilenameList;
//implements a filename-list I can use for multiple file sends
interface
uses classes, stdctrls;

type
  TFilenameList = class(TStringlist)
  private
    fposition : cardinal;
    fMissingFiles : string;
    //ErrorMessage:string;

  public
    function AllExist:boolean;
    property MissingFiles:string read fMissingFiles;
    property position:cardinal read fposition write fposition;
    procedure SetFilenames(S:string) overload;
    procedure SetFilenames(var CB:TCombobox) overload;  //set FROM CB
    procedure SetFilenames(S:string; var CB:TCombobox) overload; //set CB and
    function Next:string;
    function IsLast:boolean;
    function IsDone:boolean;
    constructor create;
  end;

implementation
  uses sysutils,graphics;

  function TFilenameList.AllExist:boolean;
  var fname:string;
  begin
    result:=true;
    fMissingFiles:='';
    for fname in self do begin
      if not fileexists(fname)
        then begin
          result:=false;
          fMissingFiles:= fMissingFiles+extractfilename(fname)+';';
        end;
    end;
  end;

  procedure TFilenameList.SetFilenames(var CB:TCombobox) overload;
  begin
    SetFilenames(CB.Text);
    if AllExist then begin
      CB.Color:=clWindow;
      end else begin
        CB.Color:=clRed;
    end;
  end;
  procedure TFilenameList.SetFilenames(S:string; var CB:TCombobox) overload;
  begin
    CB.Text:=S;
    SetFilenames(CB);
//    if AllExist then begin
//      CB.Color:=clWindow;
//      end else begin
//        CB.Color:=clRed;
//    end;
  end;

  procedure TFilenameList.SetFilenames(S:string);
  begin
    self.DelimitedText:=S;
    position:=0; //restart
  end;

  function TFilenameList.Next;
  begin
    if position<self.count
    then begin
      result:=strings[position];
      inc(fposition);
    end else begin
      result:='';
    end;
  end;

  constructor TFilenameList.create;
  begin
    inherited Create;
    Delimiter:=';';
    StrictDelimiter:=true; //only ;
  end;

  function TFilenameList.IsLast:boolean;
  begin
    result:=(position+1=count);
  end;
  function TFilenameList.IsDone:boolean;
  begin
    result:=(position>=count);
  end;

end.

