-- Liste o nome das pessoas, a descrição dos imóveis que possuem e os logradouros onde os imóveis estão localizados. Inclua pessoas que não possuem imóveis.
-- Exiba as colunas: pesnome, imvdescricao, logdescricao.

SELECT p.pesnome,
       i.imvdescricao,
	   l.logdescricao
  FROM treina.tbpessoa p
  LEFT JOIN treina.tbpessoaimovel pi ON p.pescodigo = pi.pescodigo
  LEFT JOIN treina.tbimovel i ON pi.imvcodigo = i.imvcodigo
  LEFT JOIN treina.tblogradouro l ON i.logcodigo = l.logcodigo

-- Mostre os nomes das pessoas e os valores totais de taxas de seus imóveis, mesmo que não tenham taxas registradas.
-- Exiba as colunas: pesnome, total_taxas.

SELECT p.pesnome,
       SUM(t.taxvalor) AS total_taxas
  FROM treina.tbpessoa p
  LEFT JOIN treina.tbtaxa t ON p.pescodigo = t.pescodigo
 GROUP BY p.pesnome

-- Exiba os logradouros e a soma das taxas pagas pelos imóveis localizados neles, mesmo que não haja taxas associadas.
-- Exiba as colunas: logdescricao, soma_taxas.

SELECT l.logdescricao,
       SUM(t.taxvalor) as soma_taxas
  FROM treina.tblogradouro l
  LEFT JOIN treina.tbimovel i ON l.logcodigo = i.logcodigo
  LEFT JOIN treina.tbtaxa t ON i.imvcodigo = t.imvcodigo
 GROUP BY l.logdescricao