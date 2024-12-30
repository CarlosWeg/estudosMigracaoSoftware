unit Veiculo;

interface

type
  TVeiculo = class
    private
      FMarca : string;
      FModelo : string;
      FAno : integer;
    public
      constructor Create(AMarca , AModelo : string ; AAno: integer);
      procedure ExibirDetalhes ; virtual;

  end;

implementation

{ TVeiculo }

constructor TVeiculo.Create(AMarca, AModelo : string; AAno : integer);
begin
  FMarca := AMarca;
  FModelo := AModelo;
  FAno := AAno;
end;

procedure TVeiculo.ExibirDetalhes;
begin

  write('Marca : ' , FMarca , ' | Modelo : ' , FModelo , ' | Ano : ' , FAno);

end;

end.
