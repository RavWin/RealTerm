unit ConsoleConnector;
// Connects the/a console to a GUI program
// Can hook exception handler to mirror messages to console.
// To use it, you only need to call ATTACH
// best to make attaching a commandline option e.g -console
//    if FindCmdLineSwitch('console',true) then AttachConsole(true,true);
// When using this, you will use START to launch your program e.g.
// start /w myprogram.exe -console
// creates Console var at end in initialise/finalise - you might want to do this explicitly in your own program instead.
// see: http://www.boku.ru/2016/02/28/posting-to-console-from-gui-app/

//sjb 18Nov16

interface
uses sysutils,forms;

type
     TConsoleConnector = class
     private
       OldExceptionEvent:TExceptionEvent;
       Hooked:boolean;
       BlockApplicationExceptionHandler:boolean; //errors ONLY to console, no error messageboxes blocking program
       procedure DetachErrorHandler;
       procedure GlobalExceptionHandler(Sender: TObject; E: Exception);
       procedure HookExceptionHandler;
     public
       IsAttached:boolean;

       function Attach(
           CreateIfNeeded:boolean=true; //Call ALLOCCONSOLE if no console to attach to
           HookExceptions:boolean=false;  //Hook Application.OnException to echo all unhandled exceptions to console
           OnlyToConsole:boolean=false  // Suppresses exception popups in gui, errors only go to console
           ):boolean;
       procedure Detach;            //detach and unhook
       procedure writeln(S:string); //only writes if console is attached
       procedure ShowMessage(S:string); //Popup ShowMessage box and mirror to console. Obeys OnlyToConsole
     end;

     var Console:TConsoleConnector;

implementation

uses Windows,dialogs;

//winapi function
function AttachConsole(dwProcessId: Int32): boolean; stdcall; external kernel32 name 'AttachConsole';

function TConsoleConnector.Attach(CreateIfNeeded:boolean=true;HookExceptions:boolean=false;OnlyToConsole:boolean=false):boolean;
begin
     IsAttached:=AttachConsole(-1);
     if not IsAttached and CreateIfNeeded
       then begin
         IsAttached:=AllocConsole;
       end;
     result:=IsAttached;
     if HookExceptions then HookExceptionHandler;
end;

procedure TConsoleConnector.Detach;
begin
     FreeConsole;
     IsAttached:=false;
     DetachErrorHandler;
end;

procedure TConsoleConnector.WriteLn(S:string);
begin
     if IsAttached then system.writeln(S);
end;
procedure TConsoleConnector.ShowMessage(S:string);
begin
     self.Writeln(S);
     if BlockApplicationExceptionHandler then exit;
     dialogs.ShowMessage(S);
end;
procedure TConsoleConnector.GlobalExceptionHandler(Sender: TObject; E: Exception);
begin
     self.Writeln(E.Message);
     if BlockApplicationExceptionHandler then exit;
     if assigned(OldExceptionEvent) //i.e there was an old event before we hooked it
       then OldExceptionEvent(Sender,E)
       else Application.ShowException(E);
end;

procedure TConsoleConnector.HookExceptionHandler;
begin
     OldExceptionEvent:=Application.OnException;
     Application.OnException:=GlobalExceptionHandler;
     Hooked:=true;
end;

procedure TConsoleConnector.DetachErrorHandler;
begin
     if Hooked //I have hooked it
       then begin
         Application.OnException:=OldExceptionEvent;
         OldExceptionEvent:=nil;
         Hooked:=false;
       end;
end;

initialization
     Console:=TconsoleConnector.create;
finalization
     Console.Detach;
     Console.Destroy;
end.