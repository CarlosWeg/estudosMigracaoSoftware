unit Estudante;

interface

uses
  Pessoa;

type
  TEstudante = class(TPessoa)
    private
      FCurso : string;

    public
      constructor Create(ANome : string ; AIdade : integer; ACurso: string);
      procedure ExibirInformacoes ; override;

  end;

implementation

{ TEstudante }

constructor TEstudante.Create(ANome: string; AIdade: integer; ACurso: string);
begin
  inherited Create(ANome , AIdade);
  FCurso := ACurso;
end;

procedure TEstudante.ExibirInformacoes;
begin
  inherited ExibirInformacoes;
  writeln('Cuso do estudante : ' , FCurso);

end;

end.
