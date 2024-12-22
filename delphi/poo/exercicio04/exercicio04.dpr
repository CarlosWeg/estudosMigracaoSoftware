program exercicio04;

uses
  SysUtils;

type
  TCarro = class
  private
    FMarca: string;
    FAno: integer;

  public
    function GetDescricao: string;
    constructor Create(Marca: string;Ano: integer);
  end;
{ TCarro }

constructor TCarro.Create(Marca: string; Ano: integer);
begin

  FMarca:=Marca;
  FAno:=Ano;

end;

function TCarro.GetDescricao: string;
begin

  Result := Format('Carro: %s, Ano: %d', [FMarca, FAno]);
end;

var
  Carro: Tcarro;

begin

  Carro:=TCarro.Create('Toyota',2010);
  writeln(Carro.GetDescricao);
  readln;
  Carro.free;


end.
