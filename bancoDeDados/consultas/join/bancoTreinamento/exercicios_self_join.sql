-- Liste todos os logradouros que têm nomes semelhantes ao ponto de
-- diferir apenas no tipo (por exemplo, "RUA UM" e "AVENIDA UM").

SELECT l1.logcodigo,
       l1.logdescricao,
	   l2.logcodigo,
	   l2.logdescricao
  FROM treina.tblogradouro l1
 INNER JOIN treina.tblogradouro l2 ON l1.logdescricao = l2.logdescricao
       AND l1.logcodigo<>l2.logcodigo


-- Encontre pares de pessoas que compartilham o mesmo logradouro.

SELECT p1.pescodigo,
       p1.pesnome,
	   p2.pescodigo,
	   p2.pesnome,
	   l.logdescricao
  FROM treina.tbpessoa p1
 INNER JOIN treina.tbpessoa p2 ON p1.logcodigo = p2.logcodigo AND p1.pescodigo <> p2.pescodigo
 INNER JOIN treina.tblogradouro l ON p1.logcodigo = l.logcodigo

-- Identifique imóveis cadastrados no mesmo logradouro.
SELECT i1.imvdescricao,
       i2.imvdescricao,
	   l.logdescricao
  FROM treina.tbimovel i1
 INNER JOIN treina.tbimovel i2 ON i1.imvcodigo <>i2.imvcodigo AND i1.logcodigo = i2.logcodigo
 INNER JOIN treina.tblogradouro l ON i1.logcodigo = l.logcodigo
