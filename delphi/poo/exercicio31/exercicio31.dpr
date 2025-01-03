program exercicio31;

//Leia o enunciado abaixo e realize a abstra��o das informa��es em classes
//(Voc� dever� utilizar o conceito de heran�a e classe abstrata na solu��o):

//Os professores podem trabalhar �em regime�, cuja carga hor�ria � fixa de 40
//horas, e �horistas� cuja carga hor�ria pode variar de semestre a semestre. Todo
//professor possui um n�mero de matr�cula, um nome, uma carga hor�ria e um
//sal�rio. O sal�rio de um professor em regime � fixo, enquanto o sal�rio de um
//professor horista depende do n�mero de horas trabalhadas e do sal�rio/hora.
//Deve existir um m�todo calculaSalario que deve retornar o valor do sal�rio do
//professor.

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  Professor in 'Professor.pas',
  ProfessorHora in 'ProfessorHora.pas',
  ProfessorRegime in 'ProfessorRegime.pas';

var
  PRegime: TProfessorRegime;
  PHora: TProfessorHora;

begin
  try
    PRegime := TProfessorRegime.Create('123', 'Lucas', 1500);
    PHora := TProfessorHora.Create('125', 'Augusto', 50, 7);

    Writeln('Professor em Regime:');
    Writeln('Sal�rio: ', PRegime.CalculaSalario:0:2);
    Writeln;

    Writeln('Professor Horista:');
    Writeln('Sal�rio: ', PHora.CalculaSalario:0:2);

  finally
    PRegime.Free;
    PHora.Free;
  end;
  readln;
end.

