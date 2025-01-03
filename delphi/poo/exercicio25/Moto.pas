unit Moto;

interface

uses
  Veiculo;

type
  TMoto = class(TVeiculo)
    private
      FTemCarenagem : boolean;
    public
      constructor Create(AMarca , AModelo : string ; AAno : integer ; ATemCarenagem : boolean);
      procedure ExibirDetalhes ; override;
  end;

implementation

{ TMoto }

constructor TMoto.Create(AMarca, AModelo: string; AAno: integer;
  ATemCarenagem: boolean);
begin
  inherited Create(AMarca , AModelo , AAno);
  FTemCarenagem := ATemCarenagem;
end;

procedure TMoto.ExibirDetalhes;
begin
  inherited;
  writeln(' | Carenagem : ' , FTemCarenagem);
end;

end.
