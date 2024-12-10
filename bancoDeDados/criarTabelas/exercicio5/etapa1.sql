-- Criar tabelas simples:

-- Crie uma tabela clientes com as seguintes colunas:
-- id_cliente (chave primária, SERIAL).
-- nome (texto, obrigatório).
-- email (texto, único).
-- data_cadastro (data, padrão: data atual).

-- Inserir dados:

-- Insira 3 clientes fictícios na tabela clientes.

-- Atualizar dados:

-- Atualize o nome de um cliente específico para "João Silva".

CREATE TABLE tbclientes(
	id_cliente SERIAL PRIMARY KEY,
	nome_cliente TEXT UNIQUE,
	email TEXT UNIQUE,
	data_cadastro DATE DEFAULT CURRENT_DATE
);

INSERT INTO tbclientes
       (nome_cliente,email)
VALUES ('Jonas Ribeiro','jonasaugusto@gmail.com'),
	   ('Lucas Alberto','lucasalberto@yahoo.com'),
	   ('Leticia Dalfovo','leticiadalfovo@hotmail.com');

UPDATE tbclientes
   SET nome_cliente = 'João Silva'
 WHERE id_cliente = 1;

SELECT *
  FROM tbclientes