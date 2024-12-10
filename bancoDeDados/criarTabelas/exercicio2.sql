-- Criação de Tabelas com Restrições

-- Crie uma tabela chamada clientes com as seguintes características:

-- id (chave primária, gerado automaticamente).
-- nome (texto, obrigatório).
-- email (texto, único).
-- data_cadastro (data, valor padrão é a data atual).
-- telefone (texto, deve ter no máximo 15 caracteres).
-- Chave Estrangeira

-- Crie uma tabela chamada vendas para registrar vendas realizadas:

-- id (chave primária).
-- cliente_id (chave estrangeira referenciando a tabela clientes).
-- data_venda (data, padrão: data atual).
-- valor_total (decimal, deve ser maior ou igual a zero).

-- Restrições com CHECK
-- Adicione uma restrição na tabela vendas para que o campo valor_total não possa ser negativo.


CREATE TABLE tbclientes(
	id_cliente SERIAL PRIMARY KEY,
	email_cliente TEXT UNIQUE,
	data_cadastro DATE DEFAULT CURRENT_DATE,
	telefone VARCHAR(15)
);

CREATE TABLE tbvendas(
	id_venda SERIAL PRIMARY KEY,
	cliente_id INT REFERENCES tbclientes(id_cliente),
	data_venda DATE DEFAULT CURRENT_DATE,
	valor_total DECIMAL(10,2) CHECK (valor_total>=0)
);