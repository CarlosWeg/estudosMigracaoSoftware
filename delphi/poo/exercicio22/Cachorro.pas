unit Cachorro;

interface

uses
  Animal;

type
  TCachorro = class(TAnimal)
    public
      procedure Latir;

  end;

implementation

{ TCachorro }

procedure TCachorro.Latir;
begin
  writeln('O cachorro faz : AU AU!');
end;

end.
