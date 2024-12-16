-- Crie uma view para listar os nomes das pessoas, o tamanho total dos
-- imóveis associados a elas (área), e os logradouros dos imóveis.

CREATE VIEW pessoa_imovel_area AS
SELECT p.pesnome,
       (i.imvlargura * i.imvcomprimento) AS area,
	   l.logdescricao
  FROM treina.tbpessoaimovel pi
 INNER JOIN treina.tbimovel i ON pi.imvcodigo = i.imvcodigo
 INNER JOIN treina.tbpessoa p ON pi.pescodigo = p.pescodigo
 INNER JOIN treina.tblogradouro l ON i.logcodigo = l.logcodigo

 SELECT * FROM pessoa_imovel_area

-- Crie uma view que liste o total de taxas pagas por cada pessoa.

CREATE VIEW vw_total_taxas_pessoa AS
SELECT p.pesnome,
       SUM(t.taxvalor) AS total_taxas
  FROM treina.tbtaxa t
 INNER JOIN treina.tbpessoa p ON t.pescodigo = p.pescodigo
 GROUP BY p.pesnome

-- Crie uma view que liste os nomes das pessoas que têm mais de um contato.

CREATE VIEW vw_lista_pessoas_mais_um_contato AS
SELECT p.pesnome,
       COUNT(pc.ctpnumero)
  FROM treina.tbpessoacontato pc
 INNER JOIN treina.tbpessoa p ON pc.pescodigo = p.pescodigo
 GROUP BY p.pesnome
HAVING COUNT(pc.ctpnumero) > 1

-- Crie uma view que mostre todos os logradouros com o total de
-- imóveis em cada um deles.

CREATE VIEW vw_total_imoveis_logradouro AS
SELECT l.logcodigo,
       l.logtipo,
	   l.logdescricao,
	   COUNT(i.imvcodigo) AS total_imovevis
  FROM treina.tbimovel i
 INNER JOIN treina.tblogradouro l ON i.logcodigo = l.logcodigo
 GROUP BY 1,2,3

-- Crie uma view para listar as pessoas físicas com imóveis cuja
-- área seja maior que 100 m².

CREATE VIEW vw_pessoas_fisicas_area_100 AS
SELECT p.pesnome,
       p.pestipo,
	   (i.imvlargura * i.imvcomprimento) AS area
  FROM treina.tbpessoaimovel pi
 INNER JOIN treina.tbpessoa p ON pi.pescodigo = p.pescodigo
 INNER JOIN treina.tbimovel i ON pi.imvcodigo = i.imvcodigo
 WHERE (i.imvlargura * i.imvcomprimento) > 100

-- Crie uma view que mostre os nomes das pessoas e a soma das taxas
-- associadas aos imóveis que possuem.

CREATE VIEW vw_pessoas_soma_taxas AS
SELECT p.pescodigo,
       p.pesnome,
	   SUM(t.taxvalor) AS total_taxas
  FROM treina.tbtaxa t
 INNER JOIN treina.tbpessoa p ON t.pescodigo = p.pescodigo
 GROUP BY 1,2
 ORDER BY 1

-- Crie uma view para listar os logradouros que possuem apenas um
-- tipo de imóvel.

CREATE VIEW vw_logradouro_um_tipo_imovel AS
SELECT l.logcodigo,
       l.logtipo,
	   l.logdescricao,
	   COUNT(DISTINCT i.imvdescricao) AS total_tipo_imovel
  FROM treina.tblogradouro l
 INNER JOIN treina.tbimovel i ON l.logcodigo = i.logcodigo
 GROUP BY 1,2,3
HAVING COUNT(DISTINCT i.imvdescricao) = 1
