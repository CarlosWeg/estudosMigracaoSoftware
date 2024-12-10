-- Desafios

-- Validação de dados com CHECK:

-- Modifique a tabela clientes para incluir uma coluna idade (inteiro) e garanta que apenas clientes maiores de 18 anos possam ser cadastrados.

-- Gerenciamento de estoque:

-- Adicione uma coluna estoque na tabela produtos e garanta que o estoque nunca seja negativo.

-- Relatórios com consultas aninhadas:

-- Liste os clientes que fizeram pedidos cujo valor total ultrapassou R$ 1.000,00.
-- Encontre o produto mais vendido (baseado na quantidade total em todos os pedidos).

-- Remoção em cascata:

-- Configure as tabelas para que, ao excluir um cliente, todos os seus pedidos e itens relacionados sejam excluídos automaticamente.

ALTER TABLE tbclientes
	ADD COLUMN idade INT CHECK(idade>=18);


ALTER TABLE tbprodutos
	ADD COLUMN estoque INT CHECK(estoque>=0);


SELECT cli.id_cliente,
       cli.nome_cliente,
	   SUM(ped.valor_total)
 FROM tbpedidos ped
INNER JOIN tbclientes cli ON ped.id_cliente = cli.id_cliente
GROUP BY cli.id_cliente
HAVING SUM(ped.valor_total) > 000

SELECT pro.id_produto,
       pro.nome_produto,
	   SUM(i.quantidade)
  FROM tbprodutos pro
 INNER JOIN tbitens_pedido i ON pro.id_produto = i.id_produto
 GROUP BY pro.id_produto
 ORDER BY 3 DESC
 LIMIT 1