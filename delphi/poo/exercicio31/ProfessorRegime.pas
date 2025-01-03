unit ProfessorRegime;

interface

uses
  Professor;

type
  TProfessorRegime = class(TProfessor)
    public
      constructor Create(AMatricula , ANome : string ; ASalario : real);
      function CalculaSalario : real;
  end;

implementation

{ TProfessorRegime }

function TProfessorRegime.CalculaSalario: real;
begin

  Result := Salario;

end;

constructor TProfessorRegime.Create(AMatricula, ANome: string ; ASalario : real);
begin

  inherited Create(AMatricula,ANome,40);
  Salario := ASalario;

end;

end.