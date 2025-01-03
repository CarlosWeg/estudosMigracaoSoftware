program exercicio22;

//Crie uma classe base chamada TAnimal com os atributos Nome (string) e Idade (inteiro),
//e os m�todos Comer e Dormir. Depois, crie uma classe derivada chamada TCachorro que adiciona o m�todo Latir.
//Implemente um programa que instancia um objeto de TCachorro e utilize seus m�todos.

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Animal in 'Animal.pas',
  Cachorro in 'Cachorro.pas';

var
  Cachorro : TCachorro;

begin

  try
    Cachorro := TCachorro.Create('Leopoldo',2);
    Cachorro.Comer;
    Cachorro.Dormir;
    Cachorro.Latir;
  finally
    Cachorro.Free;
  end;

  readln;

end.
