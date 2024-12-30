unit Cachorro;

interface

uses
  Animal;

type
  TCachorro = class(TAnimal)
    public
      procedure EmitirSom ; override;

  end;

implementation

{ TCachorro }

procedure TCachorro.EmitirSom;
begin
  writeln('O cachorro faz AU AU!');
end;

end.
