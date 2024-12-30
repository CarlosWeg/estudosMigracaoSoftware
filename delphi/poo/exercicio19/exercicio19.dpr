program exercicio19;

// Crie uma hierarquia de formas geométricas com cálculo de área e perímetro.
// Implemente validações para garantir que as dimensões sejam positivas.

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
    writeln('Área do quadrado : ' , Quadrado.CalcularArea:0:3);
    writeln('Perímetro do quadrado : ' , Quadrado.CalcularPerimetro:0:3);
    writeln('Área do círculo : ' , Circulo.CalcularArea:0:3);
    writeln('Comprimento do círculo : ' , Circulo.CalcularPerimetro:0:3);
  finally
    Circulo.Free;
    Quadrado.Free;
  end;

  readln;

end.
