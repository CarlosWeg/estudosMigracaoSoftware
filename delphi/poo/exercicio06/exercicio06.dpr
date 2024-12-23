//Crie uma classe chamada TProduto que tenha os seguintes atributos:
//Nome (string)
//Preco (real)
//Adicione um m�todo chamado ExibirInformacoes para exibir os valores dos atributos no console.
//No programa principal, crie uma inst�ncia da classe, atribua valores aos atributos e chame o m�todo para exibir as informa��es.

program exercicio06;

  type
  TProduto = class
    private
      FNome: string;
      FPreco: real;

    public
      procedure SetInformacoes(ANome: string; APreco: real);
      procedure ExibirInformacoes;
  end;


{ TProduto }

procedure TProduto.ExibirInformacoes;
begin

  writeln('Nome do produto: ',FNome);
  writeln('Pre�o do produto: ',FPreco);

end;

procedure TProduto.SetInformacoes(ANome: string; APreco: real);
begin

  FNome := ANome;
  FPreco := FPreco;

end;

var
  produto1 : TProduto;

begin

  produto1:=TProduto.Create;
  produto1.SetInformacoes('Salsicha',20.00);
  produto1.ExibirInformacoes;

end.
