program exercicio13;

//Crie uma classe chamada TContaBancaria com as seguintes propriedades:

//Titular (tipo string): deve permitir leitura e escrita.
//Saldo (tipo Double): deve permitir leitura e escrita, mas deve ser maior ou igual a 0.
//NumeroDeTransacoes (tipo Integer): deve ser apenas de leitura e incrementado automaticamente sempre que o saldo for alterado

type
  TContaBancaria = class

    private
      FTitular : string;
      FSaldo : double;
      FNumeroDeTransacoes : integer;
      function GetTitular : string;
      function GetSaldo : double;
      function GetNumeroDeTransacoes : integer;
      procedure SetTitular(ATitular : string);
      procedure SetSaldo(ASaldo : double);

    public
      property Titular : string read GetTitular write SetTitular;
      property Saldo : double read GetSaldo write SetSaldo;
      property NumeroDeTransacoes : integer read GetNumeroDeTransacoes;

  end;

{ TContaBancaria }

function TContaBancaria.GetNumeroDeTransacoes: integer;
begin

  Result := FNumeroDeTransacoes;

end;

function TContaBancaria.GetSaldo: double;
begin

  Result := FSaldo;

end;

function TContaBancaria.GetTitular: string;
begin

  Result := FTitular;

end;

procedure TContaBancaria.SetSaldo(ASaldo: double);
begin

  if (ASaldo >= 0) then
  begin
    FSaldo := ASaldo;
    FNumeroDeTransacoes := FNumeroDeTransacoes + 1;
  end;

end;

procedure TContaBancaria.SetTitular(ATitular: string);
begin

  FTitular := Atitular;

end;

var
  conta01 : TContaBancaria;

begin

  try
    conta01 := TContaBancaria.Create;
    conta01.Titular := 'Marcos';
    conta01.Saldo := 1800;
    conta01.Saldo := 3000;
    writeln('T�tular da conta: ' , conta01.Titular);
    writeln('Saldo da conta: ', conta01.Saldo:0:2);
    writeln('N�mero de transa��es: ' , conta01.NumeroDeTransacoes);
  finally
    conta01.Free;
  end;

  readln;

end.
