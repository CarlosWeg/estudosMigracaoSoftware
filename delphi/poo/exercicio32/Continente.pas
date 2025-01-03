unit Continente;

interface

uses
  Pais;

type TContinente = class
  private
    function GetNome: string;
      protected
        FNome : string;
        FListaPaises : array [1..10] of TPais;
      public
        constructor Create(ANome : string);
        procedure AdicionarPais(APais : TPais);
        function DimensaoTotal : real;
        function PopulacaoTotal : real;
        function DensidadePopulacional : real;
        function PaisMaiorPopulacao : TPais;
        function PaisMenorPopulacao : TPais;
        function PaisMaiorDimensao : TPais;
        function PaisMenorDimensao : TPais;
        function DiferencaMenorMaiorPais : real;
        property Nome : string read GetNome;


end;

implementation

{ TContinente }

procedure TContinente.AdicionarPais(APais: TPais);
var
  i: integer;
begin
  i := Low(FListaPaises);

  // Encontre o primeiro �ndice vazio no array
  while (i <= High(FListaPaises)) and (FListaPaises[i] <> nil) do
    i := i + 1;

  if i <= High(FListaPaises) then
    FListaPaises[i] := APais;

end;


constructor TContinente.Create(ANome: string);
begin

  FNome := ANome;

end;

function TContinente.DensidadePopulacional: real;
var
  i: integer;
  densidade: real;
begin

  densidade := 0;

  for i := Low(FListaPaises) to High(FListaPaises) do
  begin
    densidade := densidade + FListaPaises[i].VerificarDensidadePop;
  end;

  Result := densidade;

end;

function TContinente.DiferencaMenorMaiorPais: real;
var
  maior, menor : TPais;
  diferenca : real;
begin

  maior := PaisMaiorDimensao;
  menor := PaisMenorDimensao;

  diferenca := maior.Dimensao - menor.Dimensao;

  Result := diferenca;

end;

function TContinente.DimensaoTotal: real;
begin

end;

function TContinente.GetNome: string;
begin
  Result := FNome;
end;

function TContinente.PaisMaiorDimensao: TPais;
var
  i : integer;
  maior : TPais;
begin

  maior:=FListaPaises[1];

  for i := (Low(FListaPaises)+1) to High(FListaPaises) do
  begin

    if FListaPaises[i].Dimensao > maior.Dimensao then
      maior := FListaPaises[i];

  end;

  Result := maior;

end;

function TContinente.PaisMaiorPopulacao: TPais;
var
  i : integer;
  maior : TPais;
begin

  maior := FListaPaises[1];

  for i := (Low(FListaPaises)+1) to High(FListaPaises) do
  begin

    if FListaPaises[i].Populacao > maior.Populacao then
      maior := FListaPaises[i];

  end;

  Result := maior;

end;

function TContinente.PaisMenorDimensao: TPais;
var
  i : integer;
  menor : TPais;
begin

  menor := FListaPaises[1];

  for i := (Low(FListaPaises)+1) to High(FListaPaises) do
  begin

    if FListaPaises[i].Dimensao < menor.Dimensao then
      menor := FListaPaises[i];

  end;

  Result := menor;

end;

function TContinente.PaisMenorPopulacao: TPais;
var
  i : integer;
  menor : TPais;
begin

  menor := FListaPaises[1];

  for i := (Low(FListaPaises)+1) to High(FListaPaises) do
  begin

    if FListaPaises[i].Populacao < menor.Populacao then
      menor := FListaPaises[i];

  end;

  Result := menor;

end;

function TContinente.PopulacaoTotal: real;
var
  i : integer;
  populacao : real;
begin

  for i := (Low(FListaPaises)+1) to High(FListaPaises) do
  begin
    populacao := populacao + FListaPaises[i].Populacao;
  end;

end;

end.
