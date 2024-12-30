unit Somar;

interface

  type
  TSomar = class
  public
    function Somar(A , B : integer) : integer; overload;
    function Somar(A , B : double) : double; overload;
    function Somar(A , B , C : integer) : integer; overload;
  end;

implementation

{ TSomar }

function TSomar.Somar(A, B: integer): integer;
begin

  Result := A + B;

end;

function TSomar.Somar(A, B: double): double;
begin

  Result := A + B;

end;

function TSomar.Somar(A, B, C: integer): integer;
begin

  Result := A + B + C;

end;

end.
