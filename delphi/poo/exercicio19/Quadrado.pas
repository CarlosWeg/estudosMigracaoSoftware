unit Quadrado;

interface

uses
  Forma;

type
  TQuadrado = class(TForma)
    private
      FLado : double;
    public
      Constructor Create(ACor : string ; ALado : double);
      function CalcularArea() : double ; override;
      function CalcularPerimetro() : double ; override;

  end;

implementation

{ TQuadrado }

function TQuadrado.CalcularArea: double;
begin

end;

function TQuadrado.CalcularPerimetro: double;
begin

end;

constructor TQuadrado.Create(ACor: string; ALado: double);
begin

  inherited Create(ACor);

  if (ALado >= 0) then
    FLado := ALado;

end;

end.
