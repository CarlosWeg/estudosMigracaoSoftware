unit Cliente;

interface

type

  TCliente = class
    private
      FNome : string;
      FEmail : string;
      FTelefone : string;
    function GetNome: string;
    function GetTelefone: string;
    procedure SetEmail(const AEmail: string);
    procedure SetNome(const ANome: string);
    procedure SetTelefone(const ATelefone: string);
    function GetEmail: string;
    public
      procedure Exibir; virtual;
      property Nome : string read GetNome write SetNome;
      property Email : string read GetEmail write SetEmail;
      property Telefone : string read GetTelefone write SetTelefone;
  end;

implementation

{ TCliente }

procedure TCliente.Exibir;
begin

  write('Nome: ' , GetNome , ' | Email : ' , GetEmail , ' | Telefone : ' , GetTelefone);

end;

function TCliente.GetEmail: string;
begin

  Result := FEmail;

end;

function TCliente.GetNome: string;
begin

  Result := FNome;

end;

function TCliente.GetTelefone: string;
begin

  Result := FTelefone;

end;

procedure TCliente.SetEmail(const AEmail: string);
begin

  FEmail := AEmail;

end;

procedure TCliente.SetNome(const ANome: string);
begin

  FNome := ANome;

end;

procedure TCliente.SetTelefone(const ATelefone: string);
begin

  FTelefone := ATelefone;

end;

end.
