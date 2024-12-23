program exercicio10;

//Propriedade Somente Leitura

//Crie uma classe chamada TRetangulo com as seguintes propriedades:

//Altura e Largura (tipo Double): permitem leitura e escrita.
//Area (tipo Double): é uma propriedade apenas de leitura que retorna o valor calculado da área (Altura × Largura).

type
  TRetangulo = class
    private
      FAltura : Double;
      FLargura : Double;
      function GetAltura : Double;
      procedure SetAltura (AAltura : Double);
      function GetLargura : Double;
      procedure SetLargura (ALargura : Double);
      function GetArea : Double;
    public
      property Altura : Double read GetAltura write SetAltura;
      property Largura : Double read GetLargura write SetLargura;
      property Area : Double read GetArea;
  end;

{ TRetangulo }

function TRetangulo.GetAltura: Double;
begin

  Result := FAltura;

end;

function TRetangulo.GetArea: Double;
begin

  Result := FAltura * FLargura;

end;

function TRetangulo.GetLargura: Double;
begin

  Result := FLargura;

end;

procedure TRetangulo.SetAltura(AAltura: Double);
begin

  FAltura := AAltura;

end;

procedure TRetangulo.SetLargura(ALargura: Double);
begin

  FLargura := ALargura;

end;

var
  Retangulo : TRetangulo;

begin

  Retangulo := TRetangulo.Create;

  try
    Retangulo.Altura := 5;
    Retangulo.Largura := 8;
    writeln('Altura do Retângulo : ',Retangulo.Altura:0:2);
    writeln('Largura do Retângulo : ',Retangulo.Largura:0:2);
    writeln('Área do Retângulo : ',Retangulo.Area:0:2);
  finally
    Retangulo.Free;
  end;

  readln;

end.

