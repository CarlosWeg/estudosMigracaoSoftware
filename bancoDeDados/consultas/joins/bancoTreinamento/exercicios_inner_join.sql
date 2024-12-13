-- Liste os nomes das pessoas que possuem imóveis localizados em logradouros cujo nome contenha a palavra "Avenida".
-- Exiba as colunas: pesnome, imvdescricao, logdescricao.

SELECT p.pesnome,
       i.imvdescricao,
	   l.logdescricao
  FROM treina.tbpessoa p
 INNER JOIN treina.tbpessoaimovel pi ON p.pescodigo = pi.pescodigo
 INNER JOIN treina.tbimovel i ON pi.imvcodigo = i.imvcodigo
 INNER JOIN treina.tblogradouro l ON  i.logcodigo = l.logcodigo
 WHERE l.logtipo ILIKE '%Avenida%';

-- Encontre os nomes das pessoas que possuem imóveis
-- e já pagaram taxas de valor superior a R$ 500,00.

SELECT p.pescodigo,
       p.pesnome,
	   t.taxvalor
  FROM treina.tbpessoa p
 INNER JOIN treina.tbtaxa t ON p.pescodigo = t.pescodigo
 WHERE t.taxvalor>500;

-- Liste os logradouros e a quantidade de imóveis registrados em cada um.
-- Exiba as colunas: logdescricao, quantidade_imoveis.

SELECT l.logdescricao,
       COUNT(i.imvcodigo) as quantidade_imoveis
  FROM treina.tblogradouro l
 INNER JOIN treina.tbimovel i ON l.logcodigo = i.logcodigo
 GROUP BY l.logdescricao;

-- Mostre as pessoas que possuem mais de um imóvel.
-- Exiba as colunas: pesnome, quantidade_imoveis.

SELECT p.pesnome,
       COUNT(i.imvcodigo) as quantidade_imoveis
  FROM treina.tbpessoa p
 INNER JOIN treina.tbpessoaimovel pi ON p.pescodigo = pi.pescodigo
 INNER JOIN treina.tbimovel i ON pi.imvcodigo = i.imvcodigo
 GROUP BY p.pesnome 
HAVING COUNT(i.imvcodigo)>1;