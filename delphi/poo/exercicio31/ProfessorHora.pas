unit ProfessorHora;

interface

uses
  Professor;

type
  TProfessorHora = class(TProfessor)
    private
      FSalarioHora : real;
    public
      constructor Create(AMatricula, ANome: string;
      ACargaHoraria, ASalarioHora : real); virtual;
      function CalculaSalario : real ; override;
  end;

implementation

{ TProfessorHora }

function TProfessorHora.CalculaSalario : real;
begin

  Result := FSalarioHora * CargaHoraria;

end;

constructor TProfessorHora.Create(AMatricula, ANome: string; ACargaHoraria,
  ASalarioHora: real);
begin

  inherited Create(AMatricula,ANome,ACargaHoraria);
  FSalarioHora := ASalarioHora;
  Salario := CalculaSalario;

end;

end.
