unit Usuario;

interface

uses Pessoa;

  type TUsuario = class(TPessoa)
    NomeAcesso: string;
    Senha: string;
  end;


implementation

end.