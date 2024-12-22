program Project1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Pessoa in 'src\Pessoa.pas',
  Cliente in 'Src\Cliente.pas',
  Usuario in 'src\Usuario.pas',
  Administrador in 'src\Administrador.pas';

var
  Pessoa : TPessoa;

begin
  try
    Pessoa := TPessoa.Create;
    writeln('Digite o nome da pessoa: ');
    readln(Pessoa.Nome);
    writeln('O nome da pessoa é: ' + Pessoa.Nome);

    readln;


  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
