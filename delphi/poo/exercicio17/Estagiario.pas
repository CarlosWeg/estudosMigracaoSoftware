unit Estagiario;

interface

uses
  Empregado;

type
  TEstagiario = class(TEmpregado)
    public
      function ObterSalario : double ; override;
  end;

implementation

{ TEstagiario }

function TEstagiario.ObterSalario: double;
begin
  Result := 900.00;
end;

end.
