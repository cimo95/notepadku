program notepadku;

uses
  Forms,
  uutama in 'uutama.pas' {f};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Notepadku';
  Application.CreateForm(Tf, f);
  Application.Run;
end.
