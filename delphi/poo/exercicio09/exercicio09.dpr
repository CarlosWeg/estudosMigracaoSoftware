//Criando uma Classe Simples com Propriedades
//Crie uma classe chamada TProduto com as seguintes propriedades:

//Nome (tipo string): deve permitir leitura e escrita.
//Preco (tipo Double): deve permitir leitura e escrita, mas o valor deve ser maior que zero.
//Estoque (tipo Integer): deve permitir leitura e escrita, mas o valor n�o pode ser negativo.

program exercicio09;

type
  TProduto = class
  private
    FNome : string;
    FPreco : double;
    FEstoque: integer;
    procedure SetNome(ANome : string);
    function GetNome : string;
    procedure SetPreco(APreco : double);
    function GetPreco : double;
    procedure SetEstoque(AEstoque : integer);
    function GetEstoque : integer;
  public
    property Nome : string read GetNome write SetNome;
    property Preco : double read GetPreco write SetPreco;
    property Estoque : integer read GetEstoque write SetEstoque;
  end;

{ TProduto }

function TProduto.GetEstoque: integer;
begin

  Result := FEstoque;

end;

function TProduto.GetNome: string;
begin

  Result := FNome;

end;

function TProduto.GetPreco: double;
begin

  Result := FPreco;

end;

procedure TProduto.SetEstoque(AEstoque: integer);
begin

  if AEstoque >= 0 then
  begin
    FEstoque := AEstoque;
  end;


end;

procedure TProduto.SetNome(ANome: string);
begin

  FNome := ANome;

end;

procedure TProduto.SetPreco(APreco: double);
begin

  if APreco > 0 then
  begin
    FPreco := APreco;
  end;

end;

var
  produto01 : TProduto;


begin

  produto01 := TProduto.Create;

  try

    produto01.Nome := 'Bolacha';
    produto01.Preco := 20.00;
    produto01.Estoque := 5;
    writeln('Nome : ',produto01.Nome);
    writeln('Estoque : ',produto01.Estoque);
    writeln('Preco : ',produto01.Preco:0:2);

  finally
    produto01.Free;
  end;

  readln;

end.


