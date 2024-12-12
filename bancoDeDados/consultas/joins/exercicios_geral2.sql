SELECT * FROM treina.tblogradouro
SELECT * FROM treina.tbpessoa
SELECT * FROM treina.tbpessoaimovel
SELECT * FROM treina.tbimovel
SELECT * FROM treina.tbpessoacontato
SELECT * FROM treina.tbtaxa

-- Liste os nomes das pessoas que possuem imóveis. Para cada pessoa,
-- exiba a quantidade de imóveis que ela possui e a soma das
-- taxas associadas. Ordene os resultados pela soma das taxas em
-- ordem decrescente.

SELECT p.pesnome,
       COUNT(i.imvcodigo) AS quantidade_imoveis,
	   SUM(t.taxvalor) AS valor_taxas
  FROM treina.tbpessoa p
  INNER JOIN treina.tbpessoaimovel pi ON p.pescodigo = pi.pescodigo
  INNER JOIN treina.tbimovel i ON pi.imvcodigo = i.imvcodigo
  INNER JOIN treina.tbtaxa t ON i.imvcodigo = t.imvcodigo
  GROUP BY p.pesnome
  ORDER BY valor_taxas DESC

-- Mostre todos os logradouros que possuem imóveis registrados.
-- Para cada logradouro, exiba sua descrição, tipo e a média das
-- áreas dos imóveis (largura x comprimento) registrados nele. Ordene pela
-- média das áreas em ordem decrescente.

SELECT l.logdescricao,
       l.logtipo,
	   AVG(imvlargura * imvcomprimento) AS media_areas
  FROM treina.tblogradouro l
 INNER JOIN treina.tbimovel i ON i.logcodigo = l.logcodigo
 GROUP BY l.logdescricao,l.logtipo
 ORDER BY  media_areas DESC
 
-- Liste os imóveis com largura maior que a média das larguras de todos
-- os imóveis do mesmo logradouro. Para cada imóvel, mostre sua descrição,
-- largura, comprimento e a descrição do logradouro ao qual pertence.

SELECT i.imvdescricao,
       i.imvlargura,
	   i.imvcomprimento,
	   l.logdescricao
  FROM treina.tbimovel i
 INNER JOIN treina.tblogradouro l ON i.logcodigo = l.logcodigo
 WHERE i.imvlargura>(SELECT AVG(i2.imvlargura)
                       FROM treina.tbimovel i2
					  WHERE i2.logcodigo = i.logcodigo);