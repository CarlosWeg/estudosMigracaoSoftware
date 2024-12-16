-- 1. Liste os nomes das pessoas e os valores das taxas pagas nos imóveis.
-- Substitua valores de taxa iguais a 0 por 'ISENTO'.

SELECT p.pesnome,
       CASE
	        WHEN t.taxvalor = 0 THEN 'INSENTO'
			ELSE t.taxvalor::TEXT
	   END AS valor_taxa
  FROM treina.tbtaxa t
 INNER JOIN treina.tbpessoa p ON t.pescodigo = t.pescodigo

-- 2. Liste os imóveis que possuem largura menor que 10 e comprimento
-- maior que 12. Classifique-os como 'PEQUENO' ou 'MÉDIO' usando CASE.

SELECT i.imvdescricao,
       CASE
	        WHEN i.imvlargura < 10 THEN 'PEQUENO'
			WHEN i.imvlargura BETWEEN 10 AND 11 THEN 'MÉDIO'
		END AS classificacao
  FROM treina.tbimovel i
 WHERE i.imvlargura < 10
   AND i.imvcomprimento > 12

-- 3. Liste os logradouros onde existem imóveis associados,
-- mas nenhuma pessoa possui esses imóveis.
SELECT l.logcodigo,
       l.logtipo,
	   l.logdescricao
 FROM treina.tblogradouro l
INNER JOIN treina.tbimovel i ON l.logcodigo = i.logcodigo
WHERE i.imvcodigo NOT IN (SELECT imvcodigo
                            FROM treina.tbpessoaimovel)

-- 4. Liste os códigos das pessoas que possuem mais de um imóvel
-- registrado em seu nome.
SELECT pi.pescodigo,
       COUNT(pi.imvcodigo) AS quantidade_imoveis
  FROM treina.tbpessoaimovel pi
 GROUP BY pi.pescodigo
HAVING COUNT(pi.imvcodigo) > 1

-- 5. Liste os nomes das pessoas e a quantidade total de imóveis que
-- possuem. Exiba apenas pessoas que têm exatamente 2 imóveis.

SELECT p.pesnome,
       COUNT(pi.imvcodigo) AS quantidade_total_imoveis
  FROM treina.tbpessoaimovel pi
 INNER JOIN treina.tbpessoa p ON pi.pescodigo = p.pescodigo
 GROUP BY p.pesnome
HAVING COUNT(pi.imvcodigo) = 2

-- 6. Liste os nomes das pessoas que não possuem nenhum contato cadastrado.

SELECT p.pesnome
  FROM treina.tbpessoa p
 WHERE p.pescodigo NOT IN (SELECT pc.pescodigo
                             FROM treina.tbpessoacontato pc)

-- 7. Liste os nomes das pessoas e os logradouros onde moram.
-- Substitua os logradouros do tipo 'RUA' por 'VIA RESIDENCIAL'.

SELECT p.pesnome,
       CASE
	        WHEN l.logtipo = 'RUA' THEN 'VIA RESIDENCIAL'
			ELSE l.logtipo
	   END AS tipo_logradouro
  FROM treina.tbpessoa p
 INNER JOIN treina.tblogradouro l ON p.logcodigo = l.logcodigo

-- 8. Liste os imóveis que possuem largura igual ao comprimento.
-- Ordene os resultados pelo código do logradouro.

SELECT i.imvdescricao
  FROM treina.tbimovel i
 WHERE i.imvlargura = i.imvcomprimento
 ORDER BY i.logcodigo

 -- 9. Liste os valores totais das taxas pagas por cada pessoa.
 -- Exiba apenas aquelas que pagaram um valor total superior a 1000.
SELECT p.pesnome,
       SUM(t.taxvalor) AS total_taxa
  FROM treina.tbtaxa t
 INNER JOIN treina.tbpessoa p ON t.pescodigo = p.pescodigo
 GROUP BY p.pesnome
HAVING SUM(t.taxvalor) > 1000

-- 10. Liste o tipo e a descrição dos logradouros que não
-- possuem imóveis cadastrados.

SELECT l.logtipo,
       l.logdescricao
  FROM treina.tblogradouro l
 WHERE l.logcodigo NOT IN (SELECT i.logcodigo
                             FROM treina.tbimovel i)

-- 11. Liste os códigos das pessoas que possuem imóveis cadastrados,
-- mas não pagam nenhuma taxa.

SELECT pi.pescodigo
  FROM treina.tbpessoaimovel pi
 WHERE NOT EXISTS(SELECT 1
                    FROM treina.tbtaxa
				   WHERE pescodigo = pi.pescodigo
				     AND imvcodigo = pi.imvcodigo)


