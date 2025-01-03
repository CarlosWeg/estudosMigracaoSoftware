unit Professor;

interface

type
  TProfessor = class
  private
    FMatricula : string;
    FNome : string;
    FCargaHoraria : real;
    FSalario: real;
    function GetCargaHoraria: real;
    function GetSalario: real;
    procedure SetSalario(const ASalario: real);
  public
    constructor Create(AMatricula, ANome: string;
    ACargaHoraria : real); virtual;
    function CalculaSalario: real; virtual; abstract;
    property CargaHoraria : real read GetCargaHoraria;
    property Salario : real read GetSalario write SetSalario;
  end;

implementation

{ TProfessor }

constructor TProfessor.Create(AMatricula, ANome: string; ACargaHoraria : real);
begin

  FMatricula := AMatricula;
  FNome := ANome;
  FCargaHoraria := ACargaHoraria;

end;

function TProfessor.GetCargaHoraria: real;
begin

  Result := FCargaHoraria;

end;

function TProfessor.GetSalario: real;
begin

  Result := FSalario;

end;

procedure TProfessor.SetSalario(const ASalario: real);
begin
  FSalario := ASalario;
end;

end.
