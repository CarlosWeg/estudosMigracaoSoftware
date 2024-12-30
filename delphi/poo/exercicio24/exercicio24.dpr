program exercicio24;

//Crie uma classe base chamada TVeiculo com um método virtual Mover. Derive TCarro que sobrescrever= o método Mover.
//Crie uma lista de veículos e demonstre o uso do polimorfismo para chamar o método Mover de cada veículo.

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
    writeln('Informações do carro :');
    writeln('Cor : ' , Carro01.Cor);
    Carro01.Mover;
  finally
    Carro01.Free;
  end;

  readln;

end.
