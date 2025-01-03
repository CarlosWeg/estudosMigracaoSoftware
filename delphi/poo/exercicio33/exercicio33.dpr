program exercicio33;

//Criar uma classe chamada ContaBancaria

//Atributos:

//Nome Cliente
//Data de cria��o;
//SaldoInicial;
//SaldoAtual;
//Operacoes: array de operacoes realizadas;

//M�todos:

//Sacar();
//Depositar();
//exibeSaldo();
//exibeExtrato();

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  ContaBancaria in 'ContaBancaria.pas';

var
  Conta01 : TContaBancaria;

begin
  try
    Conta01 := TContaBancaria.Create('Carlos','23/11/1921',500);
    Conta01.Sacar(500);
    Conta01.Depositar(1200);
    Conta01.ExibeSaldo;
    Conta01.ExibeExtrato;
  finally

    Conta01.Free;

  end;

    readln;

end.
