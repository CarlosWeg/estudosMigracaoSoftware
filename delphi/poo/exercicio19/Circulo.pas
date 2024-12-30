unit Circulo;

interface

uses
  Forma;

type
  TCirculo = class(TForma)
    private
      FRaio : double;
    public
      Constructor Create(ACor : string ; ARaio : double);
      function CalcularArea() : double; override;
      function CalcularPerimetro() : double; override;
  end;

implementation

{ TCirculo }

function TCirculo.CalcularArea(): double;
begin
  Result := 3.14 * FRaio * FRaio;
end;

function TCirculo.CalcularPerimetro(): double;
begin
  Result:= 2 * 3.14 * FRaio;
end;

constructor TCirculo.Create(ACor: string;ARaio: double);
begin
  inherited Create(ACor);
  FRaio := ARaio;
end;

end.
