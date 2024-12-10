-- Tabela com enum:

-- Crie uma tabela produtos com as seguintes colunas:

-- id_produto (chave primária, SERIAL).
-- nome_produto (texto, obrigatório).
-- preco (número decimal, obrigatório).
-- categoria (valor enumerado: 'Eletrônicos', 'Móveis', 'Roupas').

-- Relacionamento com pedidos:

-- Crie uma tabela itens_pedido para armazenar os produtos de cada pedido:
-- id_item (chave primária, SERIAL).
-- id_pedido (chave estrangeira para pedidos).
-- id_produto (chave estrangeira para produtos).
-- quantidade (inteiro, obrigatório, maior que zero).

-- Inserção de dados:

-- Adicione 3 produtos à tabela produtos.
-- Adicione itens para cada pedido na tabela itens_pedido.

-- Consultas complexas:

-- Liste os pedidos com os nomes dos produtos e a quantidade total de cada pedido.
-- Calcule o valor total de cada pedido (multiplicando o preço do produto pela quantidade).

CREATE TABLE tbprodutos(
	id_produto SERIAL PRIMARY KEY,
	nome_produto TEXT NOT NULL,
	preco DECIMAL(10,2) NOT NULL,
	categoria VARCHAR(50) CHECK (categoria IN ('Eletronicos','Móveis','Roupas'))
);

CREATE TABLE tbitens_pedido(
	id_item SERIAL PRIMARY KEY,
	id_pedido INT REFERENCES tbpedidos(id_pedido),
	id_produto INT REFERENCES tbprodutos(id_produto),
	quantidade INT NOT NULL CHECK (quantidade>0)
);

INSERT INTO tbprodutos
       (nome_produto,preco,categoria)
VALUES ('Casaco',180.00,'Roupas'),
       ('Tablet',1200.00,'Eletronicos'),
	   ('Guarda-roupas',500.00,'Móveis');

INSERT INTO tbitens_pedido
	   (id_pedido,id_produto,quantidade)
VALUES (3,1,5),
       (2,2,1),
	   (1,3,50);

SELECT ped.id_pedido,
       pro.nome_produto,
	   SUM(i.quantidade) AS quantidade_total_produto
 FROM tbpedidos ped
INNER JOIN tbitens_pedido i ON ped.id_pedido = i.id_pedido
INNER JOIN tbprodutos pro ON i.id_produto = pro.id_produto
GROUP BY ped.id_pedido,pro.nome_produto

SELECT ped.id_pedido,
       (i.quantidade * pro.preco) AS valor_total
  FROM tbpedidos ped
 INNER JOIN tbitens_pedido i ON ped.id_pedido = i.id_pedido
 INNER JOIN tbprodutos pro ON I.id_produto = pro.id_produto