unit Carro;

interface

uses
  Veiculo;

type
  TCarro = class(TVeiculo)
    public
      procedure Mover ; override;
  end;


implementation


{ TCarro }

procedure TCarro.Mover;
begin
  writeln('O carro est� se movendo!');
end;

end.
