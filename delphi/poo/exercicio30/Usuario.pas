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
  writeln('Ol�, usu�rio');
end;

end.
