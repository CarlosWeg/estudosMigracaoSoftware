program exercicio15;

//Crie uma classe base chamada TForma com um m�todo chamado CalcularArea que retorna 0.
//Em seguida, crie duas classes derivadas, TQuadrado e TCirculo.
//Ambas devem sobrescrever o m�todo CalcularArea para calcular suas respectivas �reas.


{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Forma in 'Forma.pas',
  Quadrado in 'Quadrado.pas',
  Circulo in 'Circulo.pas';

var
  Quadrado : TQuadrado;
  Circulo : TCirculo;

begin
  try
    writeln('�rea do quadrado : ',Quadrado.CalcularArea(5):0:2);
    writeln('�rea do c�rculo : ',Circulo.CalcularArea(2):0:2);
  finally
    Quadrado.Free;
    Circulo.Free;
  end;

  readln;

end.
