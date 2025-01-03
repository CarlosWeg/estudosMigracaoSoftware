unit Pais;

interface

type
  TPais = class

    protected
      FISO : string;
      FNome : string;
      FPopulacao : real;
      FDimensao : real;
      FListaFronteira : array [1..40] of TPais;
    function GetDimensao: real;
    function GetISO: string;
    function GetNome: string;
    function GetPopulacao: real;
    procedure SetDimensao(const ADimensao: real);
    procedure SetIso(const AISO: string);
    procedure SetNome(const ANome: string);
    procedure SetPopulacao(const APopulacao: real);

    public
      property ISO : string read GetISO write SetIso;
      property Nome : string read GetNome write SetNome;
      property Populacao : real read GetPopulacao write SetPopulacao;
      property Dimensao : real read GetDimensao write SetDimensao;

      constructor Create(AISO , ANome : string ; ADimensao : real);
      function VerificarIgualdade(APais : TPais) : boolean;
      function VerificarDensidadePop : real;
  end;

implementation

{ TPais }

constructor TPais.Create(AISO, ANome: string; ADimensao: real);
begin

  FISO := AISO;
  FNome := ANome;
  FDimensao := ADimensao;

end;

function TPais.GetDimensao: real;
begin

  Result := FDimensao;

end;

function TPais.GetISO: string;
begin

  Result := FISO;

end;

function TPais.GetNome: string;
begin

  Result := FNome;

end;

function TPais.GetPopulacao: real;
begin

  Result := FPopulacao;

end;

procedure TPais.SetDimensao(const ADimensao: real);
begin

  FDimensao := ADimensao;

end;

procedure TPais.SetIso(const AISO: string);
begin

  FISO := AISO;

end;

procedure TPais.SetNome(const ANome: string);
begin

  FNome := ANome;

end;

procedure TPais.SetPopulacao(const APopulacao: real);
begin

  FPopulacao := APopulacao;

end;

function TPais.VerificarDensidadePop: real;
begin
  Result := FPopulacao / FDimensao;
end;

function TPais.VerificarIgualdade(APais: TPais): boolean;
begin

  if (APais.ISO = ISO) then
    Result := True
  else
    Result := False;

end;

end.
