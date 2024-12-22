unit Cliente;

interface

uses Pessoa;

  type
    TCliente = class (TPessoa)
    CNPJ: string;
    RazaoSocial: string;
  end;

implementation

end.
