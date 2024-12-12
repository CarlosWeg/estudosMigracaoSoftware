SELECT * FROM treina.tblogradouro
SELECT * FROM treina.tbpessoa
SELECT * FROM treina.tbpessoaimovel
SELECT * FROM treina.tbimovel
SELECT * FROM treina.tbpessoacontato
SELECT * FROM treina.tbtaxa

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
 WHERE pi.imvcodigo IS NULL