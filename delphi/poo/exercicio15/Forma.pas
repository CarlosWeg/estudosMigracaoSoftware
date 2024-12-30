unit Forma;

interface

type TForma = class
     public
       function CalcularArea: double ; virtual;
     end;


implementation

{ TForma }

function TForma.CalcularArea: double;
begin

  Result := 0;

end;

end.
