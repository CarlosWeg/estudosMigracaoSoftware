unit Empregado;

interface

type
  TEmpregado = class
    public
      procedure Trabalhar;
      function ObterSalario : double ; virtual;
  end;

implementation

{ TEmpregado }


function TEmpregado.ObterSalario: double;
begin
  Result := 0;
end;

procedure TEmpregado.Trabalhar;
begin
  writeln('Empregado trabalhando!');
end;

end.
