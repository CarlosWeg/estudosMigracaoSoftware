unit Animal;

interface

type

  TAnimal = class
    public
      procedure EmitirSom ; virtual;

  end;

implementation

{ TAnimal }

procedure TAnimal.EmitirSom;
begin
  writeln('O animal está emitindo um som genérico!');
end;

end.
