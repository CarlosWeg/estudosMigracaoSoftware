program exercicio29;

//Criar uma classe chamada Clientes

//a) Crie um objeto da classe Clientes.
//b) Atribua valores aos atributos da classe.
//c) Crie mais um objeto da classe Clientes.
//d) Chame o método exibir dos dois objetos e veja o resultado.
//e) Crie uma classe chamada ClienteFisica que estenda a classe Clientes.
//Adicione nesta classe o atributo $cpf;
//f) Crie uma classe chamada ClienteJuridica que estenda a classe Clientes.
//Adicione nesta classe o atributo $cnpj;
//g) Não esqueça de criar os setters e os getters em todas as classes.

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Cliente in 'Cliente.pas',
  ClienteFisica in 'ClienteFisica.pas',
  ClienteJuridico in 'ClienteJuridico.pas';

var
  CliFis : TClienteFisica;
  CliJuri : TClienteJuridico;

begin
  try

    CliFis := TClienteFisica.Create;
    CliFis.Nome := 'Carlos';
    CliFis.CPF := '000.222.444-66';

    CliJuri := TClienteJuridico.Create;
    CliJuri.Nome := 'Padaria';
    CliJuri.CNPJ := '00.111.222/0001-55';

    CliFis.Exibir;
    CliJuri.Exibir;

  finally
    CliFis.Free;
    CliJuri.Free;
  end;

  readln;

end.
