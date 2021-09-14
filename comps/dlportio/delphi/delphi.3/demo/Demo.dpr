program Demo;

uses
  Forms,
  Main in 'Main.pas' {Main_Win};

{$R *.RES}

{$E exe}

begin
  Application.Initialize;
  Application.Title := 'DriverLINX wrapper component demo';
  Application.CreateForm(TMain_Win, Main_Win);
  Application.Run;
end.
