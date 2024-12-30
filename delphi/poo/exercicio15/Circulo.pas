unit Circulo;

interface

uses
  Forma;

type
  TCirculo = class (TForma)
    public

      function CalcularArea(Raio : double) : double;

  end;

implementation

{ TCirculo }

function TCirculo.CalcularArea(Raio: double): double;
begin

  Result := 3.14 * Raio * Raio;

end;

end.
