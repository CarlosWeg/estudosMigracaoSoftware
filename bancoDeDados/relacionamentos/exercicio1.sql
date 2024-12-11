-- Relacionamentos Binários
-- Um-para-Muitos (1:N): Sistema de Compras

-- Crie um banco de dados para gerenciar as compras de clientes em uma loja.

-- Tarefas:
-- Crie as tabelas Clientes e Pedidos.

-- Relacione os clientes aos seus pedidos (um cliente pode ter vários pedidos, mas um pedido pertence a apenas um cliente).
-- Insira registros
-- Escreva uma consulta para listar os pedidos de um cliente específico.

CREATE TABLE tbclientes(
	clicodigo SERIAL PRIMARY KEY,
	clinome VARCHAR(100) NOT NULL
);

CREATE TABLE tbpedidos(
	pedcodigo SERIAL PRIMARY KEY,
	clicodigo INT REFERENCES tbclientes(clicodigo),
	peddata TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO tbclientes
       (clinome)
VALUES ('Jonas Alberto');

INSERT INTO tbpedidos
       (clicodigo)
VALUES (1);

SELECT *
 FROM tbpedidos
WHERE clicodigo = 1;