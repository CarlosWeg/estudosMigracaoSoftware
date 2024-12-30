program exercicio25;

//Crie uma classe base chamada TVeiculo com as seguintes propriedades e m�todos:

//Propriedades: Marca: string; Modelo: string; Ano: Integer.
//M�todo virtual: ExibirDetalhes.

//Crie duas classes derivadas de TVeiculo:
//TCarro com a propriedade adicional NumeroDePortas: Integer.
//TMoto com a propriedade adicional TemCarenagem: Boolean.

//Substitua o m�todo ExibirDetalhes em ambas as classes para mostrar as informa��es espec�ficas de cada tipo de ve�culo.

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Veiculo in 'Veiculo.pas',
  Carro in 'Carro.pas',
  Moto in 'Moto.pas';

var
  Carro : TCarro;
  Moto : TMoto;

begin
  try
    Carro := TCarro.Create('Toyota','Pog',2010,4);
    Moto := TMoto.Create('Suzuki','Nog',2000,False);
    Carro.ExibirDetalhes;
    Moto.ExibirDetalhes;
  finally
    Carro.Free;
    Moto.Free;
  end;

  readln;

end.
