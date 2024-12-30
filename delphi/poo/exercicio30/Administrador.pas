unit Administrador;

interface

uses
  Usuario;

type
  TAdministrador = class(TUsuario)
    procedure hello;

  end;

implementation

{ TAdministrador }

procedure TAdministrador.hello;
begin
  writeln('Olá, administrador!');
end;

end.
