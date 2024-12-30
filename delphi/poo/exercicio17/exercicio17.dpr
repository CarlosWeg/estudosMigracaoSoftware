program exercicio17;

//Crie uma classe base chamada TEmpregado com os métodos Trabalhar e ObterSalario.
//Em seguida, crie duas classes derivadas, TGerente e TEstagiario, que sobrescrevam o método ObterSalario
//para calcular salários específicos.



{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Empregado in 'Empregado.pas',
  Gerente in 'Gerente.pas',
  Estagiario in 'Estagiario.pas';

var
  Empregado : TEmpregado;
  Estagiario : TEstagiario;
  Gerente : TGerente;

begin

  try
    Gerente := TGerente.Create;
    Estagiario := TEstagiario.Create;
    Empregado := TEmpregado.Create;
    writeln('Salário empregado geral : ' , Empregado.ObterSalario:0:2);
    writeln('Salário do gerente : ' , Gerente.ObterSalario:0:2);
    writeln('Salário do estagiário : ' , Estagiario.ObterSalario:0:2);

  finally

    Gerente.Free;
    Estagiario.Free;
    Empregado.Free;

  end;

  readln;

end.
