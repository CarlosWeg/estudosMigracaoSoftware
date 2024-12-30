unit Gerente;

interface

uses
  Empregado;

type
  TGerente = class(TEmpregado)
    public
      function ObterSalario: double ; override;
  end;

implementation

{ TGerente }



{ TGerente }

function TGerente.ObterSalario: double;
begin

  Result := 2000 + 300;

end;

end.
