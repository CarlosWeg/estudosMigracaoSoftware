program exercicio07;

  type
  TContaBancaria = class
    private
      FNumero: string;
      FSaldo: real;

    public
      procedure SetDados(ANumero: string; ASaldo: real);
      procedure Depositar(AValor: real);
      procedure ExibirSaldo;

  end;

{ TContaBancaria }

procedure TContaBancaria.Depositar(AValor: real);
begin

  if (AValor > 0) then
  begin
    FSaldo:=FSaldo+AValor;
  end;

end;

procedure TContaBancaria.ExibirSaldo;
begin

  writeln('Saldo da conta: ',FNumero,' é: ',FSaldo:0:2);

end;

procedure TContaBancaria.SetDados(ANumero: string; ASaldo: real);
begin

  FNumero:=ANumero;
  FSaldo:=ASaldo;

end;

var
  conta01 : TContaBancaria;

begin

  conta01:=TContaBancaria.create;
  try
    conta01.SetDados('2313',0);
    conta01.Depositar(-50);
    conta01.Depositar(100);
    conta01.ExibirSaldo;
  finally
    conta01.Free;
  end;

  readln;

end.
