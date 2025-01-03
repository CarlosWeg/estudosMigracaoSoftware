program exercicio28;

//Crie uma classe chamada TPessoa que tenha as propriedades Nome e Idade.
//Adicione um m�todo de classe chamado CriarComNomePadrao que retorne uma inst�ncia da classe
//TPessoa com o nome "Desconhecido" e idade 0.



{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

type
  TPessoa = class

    private
      FNome : string;
      FIdade : integer;
    function GetIdade: integer;
    function GetNome: string;
    procedure SetIdade(const AIdade: integer);
    procedure SetNome(const ANome: string);

    public
      constructor Create; overload;
      constructor Create (ANome : string ; AIdade : integer) ; overload ;
      class function CriarComNomePadrao : TPessoa;
      property Nome : string read GetNome write SetNome;
      property Idade : integer read GetIdade write SetIdade;

    end;

{ TPessoa }

constructor TPessoa.Create;
begin

  inherited Create;

end;

constructor TPessoa.Create(ANome: string; AIdade: integer);
begin

  FNome := ANome;
  FIdade := AIdade;

end;

class function TPessoa.CriarComNomePadrao: TPessoa;
begin

  Result := TPessoa.Create('Desconhecido',0);

end;

function TPessoa.GetIdade: integer;
begin

  Result := FIdade;

end;

function TPessoa.GetNome: string;
begin

  Result := FNome;

end;

procedure TPessoa.SetIdade(const AIdade: integer);
begin

  FIdade := AIdade;

end;

procedure TPessoa.SetNome(const ANome: string);
begin

  FNome := ANome;

end;

var
  Pessoa : TPessoa;

begin
  try
    Pessoa := TPessoa.CriarComNomePadrao;
    writeln('Nome : ' , Pessoa.Nome);
    writeln('Idade : ' , Pessoa.Idade);
  finally

    Pessoa.Free;

  end;

  readln;

end.

