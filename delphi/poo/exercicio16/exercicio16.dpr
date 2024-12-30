program exercicio16;

//Crie uma classe base chamada TVeiculo com os m�todos Acelerar e Frear.
//Em seguida, crie duas classes derivadas, TCarro e TMoto, que implementem mensagens espec�ficas para cada m�todo.

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Veiculo in 'Veiculo.pas',
  Carro in 'Carro.pas',
  Moto in 'Moto.pas';

var

  Veiculo : TVeiculo;
  Moto : TMoto;
  Carro : TCarro;

begin
  try
    Veiculo := TVeiculo.Create;
    Moto := TMoto.Create;
    Carro := TCarro.Create;

    Writeln('Geral = ');
    Veiculo.Acelerar;
    Writeln('Moto = ');
    Moto.Acelarar;
    Writeln('Carro = ');
    Carro.Acelerar;

  finally

    Carro.Free;
    Moto.Free;
    Veiculo.Free;

  end;

  readln;

end.
