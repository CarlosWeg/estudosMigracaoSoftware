program exercicio12;

//Crie uma classe chamada TAluno com as seguintes propriedades:

//Matricula (tipo Integer): deve permitir leitura e escrita.
//Nome (tipo string): deve permitir leitura e escrita, mas n�o pode ser vazio.
//NotaFinal (tipo Double): deve permitir leitura e escrita, mas o valor deve estar entre 0 e 10.

uses
  SysUtils;

type
  TAluno = class

    private
      FMatricula : integer;
      FNome : string;
      FNotaFinal  : double;
      function GetMatricula : integer;
      procedure SetMatricula (AMatricula : integer);
      function GetNome : string;
      procedure SetNome (ANome : string);
      function GetNotaFinal : double;
      procedure SetNotaFinal (ANotaFinal : double);

    public
      property Matricula : integer read GetMatricula write SetMatricula;
      property Nome : string read GetNome write SetNome;
      property NotaFinal : double read GetNotaFinal write SetNotaFinal;

  end;

{ TAluno }

function TAluno.GetMatricula: integer;
begin

  Result := FMatricula;

end;

function TAluno.GetNome: string;
begin

  Result := FNome;

end;

function TAluno.GetNotaFinal: double;
begin

  Result := FNotaFinal;

end;

procedure TAluno.SetMatricula(AMatricula: integer);
begin

  FMatricula := AMatricula;

end;

procedure TAluno.SetNome(ANome: string);
begin

  if length(trim(ANome)) > 0 then
    FNome := ANome;

end;

procedure TAluno.SetNotaFinal(ANotaFinal: double);
begin

  if (ANotaFinal >= 0) and (ANotaFinal <= 10) then
    FNotaFinal := ANotaFinal;

end;

var
  Alunos : array [1..5] of TAluno;
  i: integer;

begin

  for i := 1 to 5 do
    begin
      Alunos[i] := TAluno.Create;
      Alunos[i].Matricula := i;
      Alunos[i].Nome := 'Aluno ' + IntToStr(i);
      Alunos[i].NotaFinal := i * 2;
    end;

  for i := 1 to 5 do
    begin
      writeln('Matricula: ', Alunos[i].Matricula);
      writeln('Nome: ' , Alunos[i].Nome);
      writeln('Nota Final: ' , Alunos[i].NotaFinal:0:2);
    end;

  for i := 1 to 5 do
    begin
      Alunos[i].free;
    end;

  readln;

end.
