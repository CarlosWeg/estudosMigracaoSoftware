unit Usuario;

interface

type
  TUsuario = class
    public
      procedure hello(); virtual ;
  end;

implementation

{ TUsuario }

procedure TUsuario.hello;
begin
  writeln('Olá, usuário');
end;

end.
