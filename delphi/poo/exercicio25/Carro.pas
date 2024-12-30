unit Carro;

interface

uses
  Veiculo;

type
  TCarro = class(TVeiculo)
    private
      FNumeroDePortas : integer;
    public
      constructor Create(AMarca , AModelo : string ; AAno: integer ; ANumeroDePortas : integer);
      procedure ExibirDetalhes;
  end;

implementation

{ TCarro }


{ TCarro }

constructor TCarro.Create(AMarca, AModelo: string; AAno: integer;
  ANumeroDePortas : integer);
begin
  inherited Create(AMarca , AModelo , AAno);
  FNumeroDePortas := ANumeroDePortas;
end;

procedure TCarro.ExibirDetalhes;
begin

  inherited;
  writeln(' | N Portas : ' , FNumeroDePortas);

end;

end.
