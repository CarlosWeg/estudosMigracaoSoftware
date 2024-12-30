unit Gato;

interface

uses
  Animal;

type
  TGato = class(TAnimal)
    public
      procedure EmitirSom ; override;
  end;

implementation

{ TGato }

procedure TGato.EmitirSom;
begin
  writeln('O gato faz MIAU MIAU!');
end;

end.
