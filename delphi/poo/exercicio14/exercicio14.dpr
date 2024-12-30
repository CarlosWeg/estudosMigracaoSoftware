program exercicio14;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Somar in 'Somar.pas';

var
  CalculoSoma : TSomar;

begin

  try
    CalculoSoma := TSomar.Create;
    writeln(CalculoSoma.Somar(1,2)) ;
    writeln(CalculoSoma.Somar(22.5,21.2):0:2);
    writeln(CalculoSoma.Somar(2,3,1));
  finally
    CalculoSoma.Free;
  end;

  readln;

end.
