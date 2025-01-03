program exercicio26;

//Crie uma classe chamada TCalculadora que tenha m�todos de classe para realizar opera��es
//matem�ticas b�sicas: soma, subtra��o, multiplica��o e divis�o. Cada m�todo deve receber
//dois n�meros como par�metros e retornar o resultado.


{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

type
  TCalculadora = class
    public
      class function soma(a , b : real):real;
      class function subtracao (a , b : real) : real;
      class function multiplicacao (a , b : real) : real;
      class function divisao (a , b : real) : real;
  end;

{ TCalculadora }

class function TCalculadora.divisao(a, b: real): real;
begin

  Result := a / b;

end;

class function TCalculadora.multiplicacao(a, b: real): real;
begin

  Result := a * b;

end;

class function TCalculadora.soma(a, b: real): real;
begin

  Result := a + b;

end;

class function TCalculadora.subtracao(a, b: real): real;
begin

  Result := a - b;

end;

var
  num1,num2: real;

begin
  num1 := 5;
  num2 := 10;
  writeln('N�mero 1 = ' , num1:0:2 , ' | N�mero 2 = ' , num2:0:2);

  try
    writeln('Soma = ' , TCalculadora.soma(num1,num2):0:2);
    writeln('Subtracao: ' , TCalculadora.subtracao(num1,num2):0:2);
    writeln('Multiplica��o = ' , TCalculadora.multiplicacao(num1,num2):0:2);
    writeln('Divis�o = ' , TCalculadora.divisao(num1,num2):0:2);
  finally

  end;
  readln;
end.
