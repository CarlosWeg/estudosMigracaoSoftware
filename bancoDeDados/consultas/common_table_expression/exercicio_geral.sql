SELECT * FROM TREINA.TBTAXA
SELECT * FROM TREINA.TBPESSOAIMOVEL
SELECT * FROM TREINA.TBIMOVEL
SELECT * FROM TREINA.TBPESSOA


-- Utilize uma CTE para calcular quantos imóveis cada pessoa possui e
-- selecione apenas aquelas com mais de um imóveis registrados.

WITH imoveis_por_pessoa AS(
	SELECT pi.pescodigo,
	       COUNT(pi.imvcodigo) AS quantidade_imoveis
	  FROM treina.tbpessoaimovel pi
	 GROUP BY pi.pescodigo
)

SELECT p.pesnome
  FROM cte_imoveis_por_pessoa ip
 INNER JOIN treina.tbpessoa p ON ip.pescodigo = p.pescodigo
 WHERE ip.quantidade_imoveis > 1

-- Crie uma CTE para calcular a área de todos os imóveis 
-- e selecione apenas aqueles cuja área seja maior que 100 m².

WITH area_imoveis AS (
	SELECT (imvcomprimento * imvlargura) AS area
	  FROM treina.tbimovel
)

SELECT *
  FROM area_imoveis
 WHERE area>100;

 -- Use uma CTE para listar o nome das pessoas que possuem
 -- mais de um contato cadastrado na tabela TBPessoaContato.
 
WITH contatos_por_pessoa AS(
	SELECT pescodigo,
	       COUNT(ctpnumero) AS quantidade_contatos
	  FROM treina.tbpessoacontato
	 GROUP BY pescodigo
)

SELECT p.pesnome
  FROM contatos_por_pessoa cp
 INNER JOIN treina.tbpessoa p ON  cp.pescodigo = p.pescodigo
 WHERE cp.quantidade_contatos > 1
 
-- Crie uma CTE que calcule a soma total das taxas (taxvalor) para cada
-- imóvel e retorne o código do imóvel e o valor total.

WITH soma_total_taxas_imovel AS (
	SELECT imvcodigo,
	       SUM(taxvalor) AS soma_total_taxas
	  FROM treina.tbtaxa
	  GROUP BY 1
)

SELECT i.imvcodigo,i.imvdescricao,st.soma_total_taxas
  FROM soma_total_taxas_imovel st
 INNER JOIN treina.tbimovel i ON st.imvcodigo = i.imvcodigo
 ORDER BY 3 DESC

-- Crie uma CTE que retorne as pessoas (nome e código) que não
-- possuem taxas cadastradas na tabela TBTaxa.


WITH pessoas_sem_taxas_join AS (
	SELECT p.pescodigo,
	       p.pesnome
	  FROM treina.tbpessoa p
	  LEFT JOIN treina.tbtaxa t ON p.pescodigo = t.pescodigo
	 WHERE t.pescodigo IS NULL
)

WITH pessoas_sem_taxas_subselect AS (
	SELECT p.pescodigo,
	       p.pesnome
      FROM treina.tbpessoa p
	 WHERE p.pescodigo NOT IN(SELECT pescodigo
	                            FROM treina.tbtaxa)
)

SELECT *
  FROM pessoas_sem_taxas_subselect

-- Crie uma CTE que calcule a média das taxas pagas por cada pessoa
-- e retorne o código e nome da pessoa junto com o valor da média.

WITH media_taxas AS(
	SELECT pescodigo,
	       AVG(taxvalor) AS media_taxas_pessoa
	  FROM treina.tbtaxa
	 GROUP BY pescodigo
)

SELECT mt.pescodigo,
       p.pesnome,
	   mt.media_taxas_pessoa
  FROM media_taxas mt
 INNER JOIN treina.tbpessoa p ON mt.pescodigo = p.pescodigo
 
-- Crie uma CTE que conte a quantidade de pessoas residentes em
-- cada logradouro. Liste o tipo e descrição do logradouro junto com a contagem.

WITH quantidade_residentes_logradouro AS (
	SELECT logcodigo,
	       COUNT(logcodigo) AS quantidade
	  FROM treina.tbpessoa
	 GROUP BY logcodigo
)

SELECT l.logtipo,
       l.logdescricao,
	   ql.quantidade
  FROM quantidade_residentes_logradouro ql
 INNER JOIN treina.tblogradouro l ON ql.logcodigo = l.logcodigo

-- Crie uma CTE que calcule a área de cada imóvel e liste os códigos,
-- descrições e áreas dos imóveis, ordenados em ordem decrescente de área.

WITH area_por_imovel AS (
	SELECT imvcodigo,
	       (imvlargura * imvcomprimento) AS area
	  FROM treina.tbimovel
)

SELECT i.imvdescricao, 
       i.imvcodigo,
	   ai.area
  FROM area_por_imovel ai
 INNER JOIN treina.tbimovel i ON ai.imvcodigo = i.imvcodigo
 ORDER BY 3 DESC

-- Crie uma CTE que relacione o nome das pessoas, a descrição dos
-- imóveis e o valor das taxas. Filtre apenas os registros onde o valor
-- da taxa seja maior que 200.

WITH pessoas_imoveis_taxas AS (

	SELECT p.pesnome,
	       i.imvdescricao,
		   t.taxvalor
	  FROM treina.tbtaxa t
	 INNER JOIN treina.tbpessoa p ON t.pescodigo = p.pescodigo
	 INNER JOIN treina.tbimovel i ON t.imvcodigo = i.imvcodigo
	 WHERE t.taxvalor>200
)

SELECT *
  FROM pessoas_imoveis_taxas