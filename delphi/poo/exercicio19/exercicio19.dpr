program exercicio19;

// Crie uma hierarquia de formas geom�tricas com c�lculo de �rea e per�metro.
// Implemente valida��es para garantir que as dimens�es sejam positivas.

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Forma in 'Forma.pas',
  Quadrado in 'Quadrado.pas',
  Circulo in 'Circulo.pas';

var
  Circulo : TCirculo;
  Quadrado : TQuadrado;

begin

  try
    Quadrado := TQuadrado.Create('Vermelho',5);
    Circulo := TCirculo.Create('Verde',3);
    writeln('�rea do quadrado : ' , Quadrado.CalcularArea:0:3);
    writeln('Per�metro do quadrado : ' , Quadrado.CalcularPerimetro:0:3);
    writeln('�rea do c�rculo : ' , Circulo.CalcularArea:0:3);
    writeln('Comprimento do c�rculo : ' , Circulo.CalcularPerimetro:0:3);
  finally
    Circulo.Free;
    Quadrado.Free;
  end;

  readln;

end.
