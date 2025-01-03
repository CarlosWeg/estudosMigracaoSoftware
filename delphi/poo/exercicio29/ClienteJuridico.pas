unit ClienteJuridico;

interface

uses
  Cliente;

type
  TClienteJuridico = class(TCliente)
    private
      FCNPJ : string;
    function GetCnpj: string;
    procedure SetCnpj(const ACNPJ: string);
    public
      procedure Exibir; override;
      property CNPJ : string read GetCnpj write SetCnpj;
  end;

implementation

{ TClienteJuriridico }

procedure TClienteJuridico.Exibir;
begin
  inherited Exibir;
  writeln(' | CNPJ : ' , GetCnpj);
end;

function TClienteJuridico.GetCnpj: string;
begin

  Result:= FCNPJ;

end;

procedure TClienteJuridico.SetCnpj(const ACNPJ: string);
begin

  FCNPJ := ACNPJ;

end;

end.
