program exercicio32;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Pais in 'Pais.pas',
  Continente in 'Continente.pas';

var
  Brasil, Argentina, Chile: TPais;
  AmericaDoSul: TContinente;
begin
  try
    // Cria��o dos objetos TPais
    Brasil := TPais.Create('BRA', 'Brasil', 8515767.049);
    Brasil.Populacao := 193946886;

    Argentina := TPais.Create('ARG', 'Argentina', 2780400);
    Argentina.Populacao := 43131966;

    Chile := TPais.Create('CHL', 'Chile', 756102);
    Chile.Populacao := 19107216;

    // Cria��o do objeto TContinente e adi��o dos pa�ses
    AmericaDoSul := TContinente.Create('Am�rica do Sul');
    AmericaDoSul.AdicionarPais(Brasil);
    AmericaDoSul.AdicionarPais(Argentina);
    AmericaDoSul.AdicionarPais(Chile);

    // Exibi��o dos dados
    Writeln('Continente: ', AmericaDoSul.Nome);
    Writeln('Dimens�o Total: ', AmericaDoSul.DimensaoTotal:0:2);
    Writeln('Popula��o Total: ', AmericaDoSul.PopulacaoTotal:0:2);
    Writeln('Densidade Populacional: ', AmericaDoSul.DensidadePopulacional:0:2);
    Writeln('Pa�s com Maior Popula��o: ', AmericaDoSul.PaisMaiorPopulacao.Nome);
    Writeln('Pa�s com Menor Popula��o: ', AmericaDoSul.PaisMenorPopulacao.Nome);
    Writeln('Pa�s com Maior Dimens�o: ', AmericaDoSul.PaisMaiorDimensao.Nome);
    Writeln('Pa�s com Menor Dimens�o: ', AmericaDoSul.PaisMenorDimensao.Nome);
    Writeln('Diferen�a entre Menor e Maior Pa�s (Dimens�o): ', AmericaDoSul.DiferencaMenorMaiorPais:0:2);

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

  readln;

  // Libera��o de mem�ria
  Brasil.Free;
  Argentina.Free;
  Chile.Free;
  AmericaDoSul.Free;
end.

