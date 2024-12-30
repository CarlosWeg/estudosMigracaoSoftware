program exercicio23;

//Implemente uma classe base TPessoa com atributos privados Nome e Idade, e um método para
//exibir essas informações. Crie uma classe derivada TEstudante que adicione um atributo Curso.
//Implemente um método na classe derivada que exiba o curso do estudante.

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Pessoa in 'Pessoa.pas',
  Estudante in 'Estudante.pas';

var
  Estudante : TEstudante;
  Pessoa : TPessoa;

begin

  try
    Pessoa := TPessoa.Create('Joaquina',20);
    Estudante := TEstudante.Create('Leonardo',35,'Engenharia de Software');
    Pessoa.ExibirInformacoes;
    Estudante.ExibirInformacoes;
  finally
    Pessoa.Free;
    Estudante.Free;
  end;

  readln;

end.
