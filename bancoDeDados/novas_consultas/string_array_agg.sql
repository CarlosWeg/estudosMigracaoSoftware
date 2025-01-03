--Liste os nomes dos servidores agrupados por órgão. O resultado deve
--exibir o nome do órgão e os nomes dos servidores concatenados em uma
--única coluna, separados por vírgulas.

SELECT o.nome,
       STRING_AGG(s.nome,',') AS servidores
  FROM servidores s
  JOIN orgaos o ON s.id_orgao = o.id_orgao
 GROUP BY o.nome;

 --Crie uma consulta para agrupar todas as modalidades de licitação
 --presentes na tabela licitacoes em uma única linha,
 --separadas por ponto e vírgula.

SELECT STRING_AGG(l.modalidade,';') AS modalidades_licitacao
  FROM licitacoes l;

-- Liste todos os tipos de documento registrados na tabela
-- tipos_documento em formato de array.

SELECT ARRAY_AGG(td.nome) AS tipos_documento
  FROM tipos_documento td;

-- Liste os órgãos e as descrições de seus bens patrimoniais agrupadas em um array.
SELECT o.nome,
       ARRAY_AGG(bp.descricao) AS descricoes_bens_patrimoniais
  FROM orgaos o
 INNER JOIN bens_patrimoniais bp ON o.id_orgao = bp.id_orgao
 GROUP BY o.nome;

 --Crie uma consulta para exibir o nome dos produtos e suas movimentações (entrada e saída)
 --agrupadas em uma única linha, separadas por tipo de movimentação.
SELECT p.descricao,
       STRING_AGG(
	   	CASE
			WHEN me.tipo_movimentacao ILIKE 'Entrada' THEN 'Entrada: ' || me.quantidade
			WHEN me.tipo_movimentacao ILIKE 'Saída' THEN 'Saída: ' || me.quantidade
		END, ','
	   ) AS movimentacoes
  FROM produtos p
 INNER JOIN movimentacoes_estoque me ON p.id_produto = me.id_produto
 GROUP BY 1;

--Liste os fornecedores e seus contratos,
--agrupando os números dos contratos em um array.
SELECT f.cnpj,
       f.razao_social,
	   ARRAY_AGG(c.numero_contrato) AS numeros_contratos
  FROM fornecedores f
 INNER JOIN contratos c ON f.id_fornecedor = c.id_fornecedor
 GROUP BY 1,2;
