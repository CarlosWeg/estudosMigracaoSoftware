unit Cliente;

interface

uses
  Usuario;

type
  TCliente = class(TUsuario)
    public
      procedure hello;
  end;

implementation

{ TCliente }

procedure TCliente.hello;
begin
  inherited;
  writeln('Seja bem-vindo!');
end;

end.
