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
  writeln('O animal est� emitindo um som gen�rico!');
end;

end.
