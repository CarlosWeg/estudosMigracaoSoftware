program exercicio02;

type
  TPessoa = class
  private
    FNome: string;
    FIdade: integer;
  public
    constructor Create(Nome: string; Idade: integer);
    procedure ExibirDados;
  end;

constructor TPessoa.Create(Nome: string; Idade: integer);
begin
  FNome:= Nome;
  FIdade:=Idade;
end;

procedure TPessoa.ExibirDados;
begin

  writeln('Nome: ',FNome);
  writeln('Idade: ',FIdade);

end;

var
  Pessoa1: TPessoa;

begin

  Pessoa1:= TPessoa.Create('Stephanie',28);
  Pessoa1.ExibirDados;
  readln;
  Pessoa1.Free;

end.
