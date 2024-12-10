-- Criação Simples de Tabelas
-- Crie uma tabela chamada produtos com as seguintes colunas:

-- id (inteiro, chave primária, gerado automaticamente).
-- nome (texto, obrigatório).
-- preco (número decimal com 2 casas decimais, valor padrão 0.0).
-- estoque (inteiro, obrigatório).

-- Adicionando Colunas
-- Após criar a tabela produtos, adicione uma coluna categoria (texto) para categorizar os produtos.

-- Renomeando Colunas
-- Renomeie a coluna estoque para quantidade_em_estoque.

-- Alterando Tipos de Dados
-- Altere o tipo de dado da coluna preco para aceitar até 4 casas decimais.

-- Removendo Colunas
-- Remova a coluna categoria da tabela produtos.

CREATE TABLE tbprodutos(
	id_produto SERIAL PRIMARY KEY,
	nome TEXT NOT NULL,
	preco DECIMAL(10,2) DEFAULT 0.0,
	estoque INT NOT NULL
);

ALTER TABLE tbprodutos
	ADD COLUMN categoria TEXT;

ALTER TABLE tbprodutos
	RENAME COLUMN estoque TO quantidade_em_estoque;

ALTER TABLE tbprodutos
	ALTER COLUMN preco TYPE DECIMAL (10,4);

ALTER TABLE tbprodutos
	DROP COLUMN categoria