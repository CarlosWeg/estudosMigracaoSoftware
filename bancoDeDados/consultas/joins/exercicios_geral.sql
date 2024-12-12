-- Liste os nomes das pessoas e o tipo de logradouro correspondente
-- aos imóveis que possuem largura maior que 10 metros.
-- Inclua apenas pessoas do tipo 1.

SELECT p.pesnome,
       l.logtipo
  FROM treina.tbpessoa p
 INNER JOIN treina.tbpessoaimovel pi ON p.pescodigo = pi.pescodigo
 INNER JOIN treina.tbimovel i ON pi.imvcodigo = i.imvcodigo
 INNER JOIN treina.tblogradouro l ON i.logcodigo = l.logcodigo
 WHERE i.imvlargura>10
   AND p.pestipo = 1;

-- Mostre os nomes das pessoas, os números de contato e a
-- descrição dos logradouros onde essas pessoaspossuem imóveis cadastrados.
-- Inclua pessoas que não têm contatos registrados.

SELECT p.pesnome,
       pc.ctpnumero,
	   l.logdescricao
  FROM treina.tbpessoa p
  LEFT JOIN treina.tbpessoacontato pc ON p.pescodigo = pc.pescodigo
  LEFT JOIN treina.tbpessoaimovel pi ON p.pescodigo = pi.pescodigo
  LEFT JOIN treina.tbimovel i ON pi.imvcodigo = i.imvcodigo
  LEFT JOIN treina.tblogradouro l ON i.logcodigo = l.logcodigo;

-- Exiba a soma total das taxas pagas por cada pessoa,
-- juntamente com seus nomes e a descrição do imóvel relacionado,
-- ordenados pelo maior valor total de taxas.

SELECT p.pesnome,
       i.imvdescricao,
	   SUM(t.taxvalor) as total_taxas
  FROM treina.tbpessoa p
 INNER JOIN treina.tbpessoaimovel pi ON pi.pescodigo = p.pescodigo
 INNER JOIN treina.tbimovel i ON pi.imvcodigo = i.imvcodigo
 INNER JOIN treina.tbtaxa t ON i.imvcodigo = t.imvcodigo
 GROUP BY p.pesnome,i.imvdescricao
 ORDER BY total_taxas DESC;

-- Liste todos os logradouros e, para cada um, mostre a quantidade total
-- de imóveis e pessoas registradas nesse logradouro.
-- Inclua logradouros sem registros de imóveis ou pessoas.

SELECT l.logcodigo,
       l.logtipo,
	   l.logdescricao,
	   SUM(i.imvcodigo) AS quantidade_imoveis,
	   SUM(p.pescodigo) AS quantidade_pessoas
  FROM treina.tblogradouro l
  LEFT JOIN treina.tbpessoa p ON l.logcodigo = p.logcodigo
  LEFT JOIN treina.tbimovel i ON l.logcodigo = i.logcodigo
 GROUP BY l.logcodigo,l.logtipo,l.logdescricao;

-- Mostre os nomes das pessoas que não possuem nenhum imóvel registrado.
-- Caso a pessoa tenha algum contato registrado,
-- mostre também o número desse contato.

SELECT p.pesnome,
       pc.ctpnumero
  FROM treina.tbpessoa p
  LEFT JOIN treina.tbpessoaimovel pi ON p.pescodigo = pi.pescodigo
  LEFT JOIN treina.tbimovel i ON pi.imvcodigo = i.imvcodigo
  LEFT JOIN treina.tbpessoacontato pc ON p.pescodigo = pc.pescodigo
 WHERE pi.imvcodigo IS NULL;

-- Para cada imóvel registrado, liste sua descrição, largura, comprimento,
-- e o nome da pessoa responsável (se houver). Caso o imóvel não esteja
-- associado a nenhuma pessoa, mostre "Sem responsável".

SELECT i.imvdescricao,
       i.imvlargura,
	   i.imvcomprimento,
	   COALESCE(p.pesnome,'Sem responsável') AS responsavel
  FROM treina.tbimovel i
  LEFT JOIN treina.tbpessoaimovel pi ON i.imvcodigo = pi.imvcodigo
  LEFT JOIN treina.tbpessoa p ON pi.pescodigo = p.pescodigo;

-- Liste os nomes das pessoas e a quantidade de imóveis que possuem,
-- considerando também pessoas sem imóveis. Ordene pela quantidade de
-- imóveis em ordem decrescente.

SELECT p.pesnome,
       COUNT(i.imvcodigo) AS quantidade_imoveis
  FROM treina.tbpessoa p
  LEFT JOIN treina.tbpessoaimovel pi ON p.pescodigo = pi.pescodigo
  LEFT JOIN treina.tbimovel i ON pi.imvcodigo = i.imvcodigo
 GROUP BY p.pesnome
 ORDER BY quantidade_imoveis DESC;
	   
-- Mostre os nomes das pessoas, a descrição dos imóveis e o valor
-- total das taxas associadas a esses imóveis. Inclua imóveis que não têm
-- taxas associadas.

SELECT p.pesnome,
       i.imvdescricao,
	   SUM(t.taxvalor) AS total_taxas
  FROM treina.tbimovel i
  LEFT JOIN treina.tbtaxa t ON i.imvcodigo = t.imvcodigo
  LEFT JOIN treina.tbpessoa p ON t.pescodigo = p.pescodigo
 GROUP BY p.pesnome,i.imvdescricao;

-- Liste todos os contatos registrados, mostrando o nome da pessoa
-- associada, o número de contato e, caso a pessoa tenha algum imóvel,
-- o endereço do logradouro associado ao imóvel.
-- Inclua contatos de pessoas que não possuem imóveis.

SELECT p.pescodigo,
       p.pesnome,
	   pc.ctpnumero,
	   l.logcodigo,
	   l.logtipo,
	   l.logdescricao
  FROM treina.tbpessoacontato pc
  LEFT JOIN treina.tbpessoa p ON pc.pescodigo = p.pescodigo
  LEFT JOIN treina.tbpessoaimovel pi ON p.pescodigo = pi.pescodigo
  LEFT JOIN treina.tbimovel i ON pi.imvcodigo = i.imvcodigo
  LEFT JOIN treina.tblogradouro l ON i.logcodigo = l.logcodigo
	   
-- Liste todos os logradouros que não possuem nenhum imóvel registrado.
-- Inclua o tipo e a descrição do logradouro.

SELECT l.logtipo,
       l.logdescricao
  FROM treina.tblogradouro l
  LEFT JOIN treina.tbimovel i ON l.logcodigo = i.logcodigo
 WHERE i.imvcodigo IS NULL

 -- Mostre os nomes das pessoas e a descrição dos imóveis cujas taxas
 -- têm valor igual ou maior que a média das taxas pagas.
 -- Ordene pela descrição do imóvel em ordem alfabética.

SELECT p.pesnome,
       i.imvdescricao
  FROM treina.tbpessoa p
 INNER JOIN treina.tbpessoaimovel pi ON p.pescodigo = pi.pescodigo
 INNER JOIN treina.tbimovel i ON pi.imvcodigo = i.imvcodigo
 INNER JOIN treina.tbtaxa t ON i.imvcodigo = t.imvcodigo
 WHERE t.taxvalor>=(SELECT AVG(t.taxvalor) FROM treina.tbtaxa t)
 ORDER BY i.imvdescricao ASC

 -- Exiba a largura média e o comprimento médio de todos os imóveis
 -- de cada tipo de logradouro.Inclua tipos de logradouros que
 -- não possuem imóveis registrados.

 SELECT l.logtipo,
        AVG(i.imvlargura) AS media_largura,
		AVG(i.imvcomprimento) AS media_comprimento
   FROM treina.tblogradouro l
   LEFT JOIN treina.tbimovel i ON l.logcodigo = i.logcodigo
  GROUP BY l.logtipo