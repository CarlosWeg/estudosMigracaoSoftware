program exercicio08;

  type
  TPessoa = class
    private
      FNome : string;
      FIdade : integer;
      procedure SetIdade(AIdade : integer);

    public
      property Nome : string read FNome write Fnome;
      property Idade : integer read FIdade write SetIdade;
      procedure ExibirInformacoes;
  end;

{ TPessoa }

procedure TPessoa.ExibirInformacoes;
begin

  writeln('Nome da pessoa: ' , FNome);
  writeln('Idade da pessoa: ' , FIdade);

end;

procedure TPessoa.SetIdade(AIdade: integer);
begin

  if AIdade > 0 then
  begin
    FIdade := AIdade;
  end;

end;

var
  Pessoa : TPessoa;

begin

  Pessoa := TPessoa.Create;
  try
    Pessoa.Nome := 'Carlos';
    Pessoa.Idade := 20;
    Pessoa.ExibirInformacoes;
  finally
    Pessoa.Free;
  end;

  readln;

end.
