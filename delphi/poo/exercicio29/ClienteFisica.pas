unit ClienteFisica;

interface

uses
  Cliente;

type
  TClienteFisica = class(TCliente)
    private
      FCPF : string;
    function GetCpf: string;
    procedure SetCpf(const ACFP: string);
    public
      procedure Exibir; override;
      property CPF : string read GetCpf write SetCpf;

  end;

implementation


{ TClienteFisica }

procedure TClienteFisica.Exibir;
begin
  inherited Exibir;
  writeln(' | CPF ' , GetCpf);
end;

function TClienteFisica.GetCpf: string;
begin

  Result := FCPF;

end;

procedure TClienteFisica.SetCpf(const ACFP: string);
begin

  FCPF := ACFP;

end;

end.
