unit Veiculo;

interface

type
  TVeiculo = class
    public
      procedure Acelerar ; virtual;
  end;

implementation

{ TVeiculo }

procedure TVeiculo.Acelerar;
begin
  writeln('Estamos acelerando ve�culos!');
end;

end.
