unit Veiculo;

interface

type
  TVeiculo = class
    private
      FCor : string;
      function GetCor: string;
    public
      constructor Create(ACor : string);
      procedure Mover ; virtual ;
      property Cor : string read GetCor;
  end;

implementation

{ TVeiculo }

constructor TVeiculo.Create(ACor: string);
begin
  FCor := ACor;
end;

function TVeiculo.GetCor: string;
begin

  Result := FCor;

end;


procedure TVeiculo.Mover;
begin

  writeln('O ve�culo est� se movendo!');

end;

end.
