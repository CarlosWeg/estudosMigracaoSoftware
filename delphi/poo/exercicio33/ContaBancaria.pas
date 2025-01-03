unit ContaBancaria;

interface

type
  Operacao = record
    tipo : string;
    valor : real;
  end;

type
  TContaBancaria = class
    private
      FNomeCliente : string;
      FDataCriacao : string;
      FSaldoInicial : real;
      FSaldoAtual : real;
      FOperacoes : array [1..10] of Operacao;
      FContOperacoes : integer;
    public
      procedure Sacar(const AValor : real);
      procedure Depositar(const AValor : real);
      procedure ExibeSaldo;
      procedure ExibeExtrato;
      constructor Create(ANomeCliente : string ; ADataCriacao : string; ASaldoInicial : real);

  end;

implementation

{ TContaBancaria }

constructor TContaBancaria.Create(ANomeCliente, ADataCriacao: string;
  ASaldoInicial: real);
begin

  FNomeCliente := ANomeCliente;
  FDataCriacao := ADataCriacao;
  FSaldoInicial := ASaldoInicial;
  FSaldoAtual := FSaldoInicial;

end;

procedure TContaBancaria.Depositar(const AValor: real);
begin

  FSaldoAtual := FSaldoAtual + AValor;
  FContOperacoes := FContOperacoes + 1;
  FOperacoes[FContOperacoes].tipo := 'Dep�sito';
  FOperacoes[FContOperacoes].valor := AValor;

end;

procedure TContaBancaria.ExibeExtrato;
var i : integer;
begin

  for i := 1 to FContOperacoes do
  begin
    writeln('Tipo : ' , FOperacoes[i].tipo);
    writeln('Valor : ' , FOperacoes[i].valor:0:2);
  end;

end;

procedure TContaBancaria.ExibeSaldo;
begin

  writeln('Saldo atual R$:' , FSaldoAtual:0:2);

end;

procedure TContaBancaria.Sacar(const AValor: real);
begin

  if FSaldoAtual >= AValor then
  begin
    FSaldoAtual := FSaldoAtual - AValor;
    FContOperacoes := FContOperacoes + 1;
    FOperacoes[FContOperacoes].tipo := 'Saque';
    FOperacoes[FContOperacoes].valor := AValor;
  end;

end;

end.
