program exercicio24;

//Crie uma classe base chamada TVeiculo com um m�todo virtual Mover. Derive TCarro que sobrescrever= o m�todo Mover.
//Crie uma lista de ve�culos e demonstre o uso do polimorfismo para chamar o m�todo Mover de cada ve�culo.

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  Veiculo in 'Veiculo.pas',
  Carro in 'Carro.pas';

var
  Carro01 : TCarro;

begin
  try
    Carro01 := TCarro.Create('Verde');
    writeln('Informa��es do carro :');
    writeln('Cor : ' , Carro01.Cor);
    Carro01.Mover;
  finally
    Carro01.Free;
  end;

  readln;

end.
