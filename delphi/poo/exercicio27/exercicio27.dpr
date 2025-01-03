program exercicio27;

//Crie uma classe chamada TContador que registre o n�mero de inst�ncias criadas.
//Use um m�todo de classe chamado TotalInstancias que retorne a quantidade de objetos instanciados.

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

type
  TContador = class
    private
      class var ContInstancia : integer;

    public
      constructor Create;
      class function TotalInstancias : integer;

  end;

{ TContador }

constructor TContador.Create;
begin

  ContInstancia := ContInstancia + 1;

end;

class function TContador.TotalInstancias;
begin

  Result := ContInstancia;

end;

var
  Classe1,Classe2,Classe3 : TContador;

begin
  try
    Classe1 := TContador.Create;
    Classe2 := TContador.Create;
    Classe3 := TContador.Create;
    writeln('N�mero de inst�ncias criadadas : ' , TContador.TotalInstancias);
  finally
    Classe1.Free;
    Classe2.Free;
    Classe3.Free;
  end;

  readln;
end.
