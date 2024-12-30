unit Animal;

interface

type
  TAnimal = class
    private
      FNome : string;
      FIdade : integer;

    public
      Constructor Create (ANome : string ; AIdade : integer);
      procedure Comer;
      procedure Dormir;

  end;

implementation

{ TAnimal }

procedure TAnimal.Comer;
begin
  writeln('O animal está comendo!');
end;

constructor TAnimal.Create(ANome: string; AIdade: integer);
begin

  FNome := ANome;
  FIdade := AIdade;

end;

procedure TAnimal.Dormir;
begin
  writeln('O animal está dormindo!');
end;

end.
