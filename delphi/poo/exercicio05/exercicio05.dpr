//Crie uma classe chamada TPessoa que tenha os seguintes atributos: Nome (string) e Idade (inteiro).
//Adicione um m�todo chamado ExibirInformacoes, que mostre no console as informa��es da pessoa.

program  exercicio05;

type
  TPessoa = class
    private
      FNome: string;
      FIdade: integer;
    public
      procedure ExibirInformacoes;
      procedure SetDados(ANome: string; AIdade: integer);
  end;

{ TPessoa }

procedure TPessoa.ExibirInformacoes;
begin

  writeln('Nome da pessoa: ',FNome);
  writeln('Idade da pessoa: ',FIdade);

end;

procedure TPessoa.SetDados(ANome: string; AIdade: integer);
begin

  FNome:=ANome;
  FIdade:=AIdade;

end;

var
  pessoa1: TPessoa;

begin

  pessoa1:=TPessoa.Create;
  pessoa1.SetDados('Carlos',18);
  pessoa1.ExibirInformacoes;
  readln;
  pessoa1.Free;

end.
