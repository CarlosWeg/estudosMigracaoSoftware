-- Relacionar tabelas:

-- Crie uma tabela pedidos com as seguintes colunas:

-- id_pedido (chave primária, SERIAL).
-- id_cliente (chave estrangeira referenciando a tabela clientes).
-- data_pedido (data, padrão: data atual).
-- valor_total (número decimal, obrigatório).

-- Inserir dados com relacionamento:

-- Insira 3 pedidos para diferentes clientes na tabela pedidos.

-- Consultas com JOIN:

-- Liste todos os pedidos, incluindo o nome e o email dos clientes associados.

-- Restrições de integridade:

-- Adicione uma restrição para garantir que o valor_total dos pedidos seja sempre maior que zero.

CREATE TABLE tbpedidos(
	id_pedido SERIAL PRIMARY KEY,
	id_cliente INT REFERENCES tbclientes(id_cliente),
	data_pedido DATE DEFAULT CURRENT_DATE,
	valor_total DECIMAL(10,2) NOT NULL
);

INSERT INTO tbpedidos
       (id_cliente,valor_total)
VALUES (1,150.00),
       (2,270.00),
	   (3,75.50);

SELECT p.id_pedido,
       p.id_cliente,
	   p.data_pedido,
	   p.valor_total,
	   c.nome_cliente,
	   c.email
  FROM tbpedidos p
  JOIN tbclientes c ON p.id_cliente = c.id_cliente

ALTER TABLE tbpedidos
	ADD CONSTRAINT check_valor_total CHECK (valor_total>0);