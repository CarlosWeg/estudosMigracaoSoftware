program exercicio18;

//Crie uma classe base chamada TAnimal com o método EmitirSom. Crie duas classes derivadas, TCachorro e TGato,
//que sobrescrevam esse método para emitir os sons correspondentes ("Au au" e "Miau").

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Animal in 'Animal.pas',
  Cachorro in 'Cachorro.pas',
  Gato in 'Gato.pas';

var

  Gato : TGato;
  Cachorro : TCachorro;
  AnimalGenerico : TAnimal;

begin
  try
    Gato := TGato.Create;
    Cachorro := TCachorro.Create;
    AnimalGenerico := TAnimal.Create;
    writeln('Som do animal : ');
    AnimalGenerico.EmitirSom;
    writeln('Som do gato : ');
    Gato.EmitirSom;
    writeln('Som do cachorro : ');
    Cachorro.EmitirSom;
  finally
    Cachorro.Free;
    Gato.Free;
    AnimalGenerico.Free;
  end;

  readln;

end.
