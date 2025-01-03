program exercicio11;

//Crie uma classe chamada TPessoa com as seguintes propriedades:

//Nome (tipo string): deve permitir leitura e escrita, mas n�o pode aceitar valores vazios.
//Idade (tipo Integer): deve permitir leitura e escrita, mas o valor deve estar entre 0 e 120.
//Altura (tipo Double): deve permitir leitura e escrita, mas o valor deve estar entre 0.5 e 2.5.
uses
  SysUtils;

type
  TPessoa = class
    private

      FNome : string;
      FIdade : integer;
      FAltura : double;

      function GetNome : string;
      procedure SetNome(ANome : string);
      function GetIdade : integer;
      procedure SetIdade(AIdade : integer);
      function GetAltura  : double;
      procedure SetAltura (AAltura : double);

    public
      property Nome : string read GetNome write SetNome;
      property Idade : integer read GetIdade write SetIdade;
      property Altura : double read GetAltura write SetAltura;

  end;

{ TPessoa }

function TPessoa.GetAltura: double;
begin

  Result := FAltura;

end;

function TPessoa.GetIdade: integer;
begin

  Result := FIdade;

end;

function TPessoa.GetNome: string;
begin

  Result := FNome;

end;

procedure TPessoa.SetAltura(AAltura: double);
begin

  if (AAltura >= 0.5) and (AAltura < 2.5) then
    FAltura := AAltura;

end;

procedure TPessoa.SetIdade(AIdade: integer);
begin

  if (AIdade >= 0) and (AIdade <= 120) then
    FIdade := AIdade;

end;

procedure TPessoa.SetNome(ANome: string);
begin

  if length(trim(ANome)) > 0 then
    FNome := ANome;

end;

var
  Pessoa : TPessoa;

begin

  Pessoa := TPessoa.Create;
  try
    Pessoa.Nome := 'Carlos';
    Pessoa.Idade := 19;
    Pessoa.Altura := 1.45;
    writeln('Nome da pessoa: ',Pessoa.Nome);
    writeln('Altura da pessoa: ', Pessoa.Altura:0:2);
    writeln('Idade da pessoa: ', Pessoa.Idade);
  finally
    Pessoa.Free;
  end;

  readln;

end.
