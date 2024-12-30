unit Quadrado;


interface

uses
  Forma;

type
  TQuadrado = class(TForma)
  public

    function CalcularArea(lado : double) : double;

  end;

implementation

{ TQuadrado }

function TQuadrado.CalcularArea(lado: double): double;
begin

  Result := lado * lado;

end;

end.
