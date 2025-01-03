SELECT * FROM CONTRATOS
SELECT * FROM BENS_PATRIMONIAIS
SELECT * FROM CATEGORIAS_BENS
SELECT * FROM ORGAOS
SELECT * FROM MOVIMENTACOES_ESTOQUE
SELECT * FROM PRODUTOS
SELECT * FROM SERVIDORES
SELECT * FROM FOLHA_PAGAMENTO
SELECT * FROM CARGOS
SELECT * FROM DOCUMENTOS
SELECT * FROM TIPOS_DOCUMENTO
SELECT * FROM MUNICIPIOS
SELECT * from fornecedores
SELECT * FROM CONTRATOS

-- Exercício 1: Listar todos os servidores com seus respectivos órgãos e cargos, 
-- mostrando apenas os que foram admitidos em 2023

SELECT ser.nome,
       org.nome,
	   car.nome
  FROM servidores ser
 INNER JOIN orgaos org ON ser.id_orgao = org.id_orgao
 INNER JOIN cargos car ON ser.id_cargo = car.id_cargo
 WHERE EXTRACT(YEAR FROM ser.data_admissao) = 2023;

 -- Exercício 2: Mostrar todos os contratos e seus fornecedores, incluindo o valor 
-- total e a data de término, apenas para contratos ativos

SELECT con.id_contrato,
       con.numero_contrato,
	   forn.razao_social,
	   forn.cnpj,
       con.valor_total,
	   con.data_fim
  FROM contratos con
 INNER JOIN fornecedores forn ON con.id_fornecedor = forn.id_fornecedor
 WHERE con.status = 'ativo';

-- Exercício 3: Listar todos os bens patrimoniais com suas respectivas categorias 
-- e órgãos, mostrando apenas os que custaram mais de R$ 10.000

SELECT bens.descricao,
       org.nome,
	   cat.nome
  FROM bens_patrimoniais bens
 INNER JOIN orgaos org ON bens.id_orgao = org.id_orgao
 INNER JOIN categorias_bens cat ON cat.id_categoria = bens.id_categoria
 WHERE valor_aquisicao > 10000

-- Exercício 4: Listar todas as movimentações de estoque, mostrando o produto, 
-- categoria e órgão, apenas para movimentações do tipo 'SAIDA'
SELECT pro.descricao,
       cat.nome,
	   org.nome
  FROM movimentacoes_estoque mov
 INNER JOIN produtos pro ON mov.id_produto = pro.id_produto
 INNER JOIN categorias_bens cat ON pro.id_categoria_produto = cat.id_categoria
 INNER JOIN orgaos org ON mov.id_orgao = org.id_orgao
 WHERE mov.tipo_movimentacao ILIKE '%SAÍDA%';
 
-- Exercício 5: Mostrar a folha de pagamento do mês atual, incluindo servidor, 
-- cargo e órgão

SELECT fol.mes,
       fol.ano,
	   fol.salario_base,
	   fol.gratificacoes,
	   fol.descontos,
	   fol.valor_liquido,
	   fol.data_pagamento,
       ser.nome,
       car.nome,
	   org.nome
  FROM folha_pagamento fol
 INNER JOIN servidores ser ON fol.id_servidor = ser.id_servidor
 INNER JOIN cargos car ON ser.id_cargo = car.id_cargo
 INNER JOIN orgaos org ON ser.id_orgao = org.id_orgao
 WHERE EXTRACT (YEAR FROM fol.data_pagamento) = EXTRACT (YEAR FROM CURRENT_DATE)
   AND EXTRACT (MONTH FROM fol.data_pagamento) = EXTRACT (MONTH FROM CURRENT_DATE);

-- Exercício 6: Mostrar o estoque atual dos produtos por órgão
SELECT pro.codigo,
       pro.descricao,
	   org.sigla,
	   org.nome,
	   SUM(CASE
	       WHEN mov.tipo_movimentacao ILIKE '%ENTRADA%' THEN mov.quantidade
		   WHEN mov.tipo_movimentacao ILIKE '%SAÍDA%' THEN -mov.quantidade
		   END)
		   AS quantidade_atual
  FROM movimentacoes_estoque mov
 INNER JOIN produtos pro ON mov.id_produto = pro.id_produto
 INNER JOIN orgaos org ON mov.id_orgao = org.id_orgao
 GROUP BY 1,2,3,4;

-- Exercício 7: Listar documentos e seus prazos de resposta
SELECT doc.numero_protocolo,
       doc.assunto,
	   doc.prazo_resposta,
	   tpdoc.nome
  FROM documentos doc
 INNER JOIN tipos_documento tpdoc ON doc.id_tipo_documento = tpdoc.id_tipo_documento;

-- Exercício 8: Mostrar os municípios e seus órgãos ativos
SELECT mun.nome,
       mun.codigo_ibge,
	   org.nome
  FROM orgaos org
 INNER JOIN municipios mun ON org.id_municipio = mun.id_municipio
 WHERE org.ativo = TRUE;

-- Exercício 9: Mostrar total de servidores por cargo e órgão
SELECT COUNT(ser.id_servidor) AS total_servidores,
	   car.nome,
       org.nome
  FROM servidores ser
 INNER JOIN cargos car ON ser.id_cargo = car.id_cargo
 INNER JOIN orgaos org ON ser.id_orgao = org.id_orgao
 GROUP BY 2,3;

-- Exercício 10 Listar os 5 órgãos que têm o maior número de servidores, 
-- mostrando também a média salarial dos servidores de cada órgão
SELECT org.sigla,
       org.nome,
	   COUNT(ser.id_servidor) AS total_servidores,
	   ROUND(AVG(fol.salario_base),2) AS media_salarial
  FROM servidores ser
 INNER JOIN orgaos org ON ser.id_orgao = org.id_orgao
 INNER JOIN folha_pagamento fol ON ser.id_servidor = fol.id_servidor
 GROUP BY 1,2
 ORDER BY 3 DESC
 LIMIT 5

-- Exercício 11: Encontrar os produtos que nunca tiveram movimentação de saída
SELECT pro.codigo,
       pro.descricao
  FROM produtos pro
 WHERE NOT EXISTS(SELECT 1
                    FROM movimentacoes_estoque mov2
				   WHERE mov2.id_produto = pro.id_produto
				     AND mov2.tipo_movimentacao ILIKE 'SAÍDA');

-- Exercício 12: Listar os fornecedores que têm contratos com valor total
-- acima da média de todos os contratos

SELECT forn.razao_social,
       forn.nome_fantasia,
	   forn.cnpj
  FROM fornecedores forn
 INNER JOIN contratos con ON forn.id_fornecedor = con.id_fornecedor
 WHERE con.valor_total > (SELECT AVG(valor_total)
                            FROM contratos);