unit Pessoa;

interface

type
  TPessoa = class
      private
        FNome : string;
        FIdade : integer;
      public
        constructor Create(ANome : string ; AIdade : integer); virtual;
        procedure ExibirInformacoes; virtual;
  end;

implementation

{ TPessoa }

constructor TPessoa.Create(ANome: string; AIdade: integer);
begin
  FNome := ANome;
  FIdade := AIdade;
end;

procedure TPessoa.ExibirInformacoes;
begin
  writeln('Nome: ' , FNome , ' | Idade: ' , FIdade);
end;

end.
