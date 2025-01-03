program exercicio30;

{$APPTYPE CONSOLE}
{$R *.res}
// Crie as seguintes classes:

// Crie uma classe Administrador que estende a classe Usuario. Nesta,
// defina o m�todo hello(), que dever� imprimir: �Ol� Administrador:
// Matheus�. Esta classe n�o ter� propriedades.

// Crie uma classe Cliente que estende a classe Usuario. Tamb�m crie o
// m�todo hello(), que dever� imprimir o mesmo texto hello() da classe
// Usuario e ainda adicionar o texto: �Seja bem vindo�. Esta classe n�o
// ter� propriedades.

uses
  System.SysUtils,
  Usuario in 'Usuario.pas',
  Administrador in 'Administrador.pas',
  Cliente in 'Cliente.pas';

var
  Cli: TCliente;
  Adm: TAdministrador;
  Us: TUsuario;

begin
  try
    Cli := TCliente.Create;
    Adm := TAdministrador.Create;
    Us := TUsuario.Create;

    writeln('Cliente :');
    Cli.hello;
    writeln('Administrador:');
    Adm.hello;
    writeln('Usu�rio:');
    Us.hello;

  finally
    Cli.free;
    Adm.free;
    Us.free;
  end;

  readln;

end.
