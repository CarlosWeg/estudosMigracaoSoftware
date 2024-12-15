 -- Liste os imóveis e numere-os sequencialmente dentro de cada tipo de
 -- logradouro, ordenados pela descrição do imóvel.


 SELECT l.logtipo,
        i.imvdescricao,
		ROW_NUMBER() OVER (PARTITION BY l.logtipo ORDER BY i.imvdescricao) AS imoveis
   FROM treina.tblogradouro l
  INNER JOIN treina.tbimovel i ON l.logcodigo = i.imvcodigo


-- Liste os contatos de pessoas e atribua um número sequencial para cada
-- contato dentro de cada logradouro

SELECT pc.ctpdescricao,
       l.logdescricao,
	   ROW_NUMBER() OVER (PARTITION BY l.logdescricao ORDER BY pc.ctpdescricao) AS numero_contato
  FROM treina.tbpessoacontato pc
 INNER JOIN treina.tbpessoa p ON pc.pescodigo = p.pescodigo
 INNER JOIN treina.tblogradouro l on p.logcodigo = l.logcodigo

-- Classifique os logradouros com base no número total de imóveis
-- registrados em cada logradouro, ordenados de forma decrescente.

SELECT l.logdescricao,
       COUNT(i.imvcodigo) AS total_imoveis,
	   RANK() OVER (ORDER BY COUNT(i.imvcodigo) DESC) AS classificacao
  FROM treina.tbimovel i
 INNER JOIN treina.tblogradouro l ON i.logcodigo = l.logcodigo
 GROUP BY 1

-- Liste as pessoas e classifique-as com base no total de taxas pagas
-- (soma de TBTaxa.taxvalor), agrupando por cada logradouro

SELECT l.logdescricao,
       p.pesnome,
       SUM(t.taxvalor) AS total_taxas,
	   RANK() OVER (PARTITION BY l.logdescricao ORDER BY SUM(t.taxvalor))
  FROM treina.tbtaxa t
 INNER JOIN treina.tbpessoa p ON t.pescodigo = p.pescodigo
 INNER JOIN treina.tblogradouro l ON p.logcodigo = l.logcodigo
 GROUP BY 1,2
 
-- Liste os tipos de contato e classifique-os com base no número de
-- contatos disponíveis, agrupando-os por cada pessoa

SELECT p.pesnome,
       pc.ctpdescricao,
	   DENSE_RANK() OVER (PARTITION BY p.pesnome ORDER BY pc.ctpnumero DESC)
 FROM treina.tbpessoacontato pc
INNER JOIN treina.tbpessoa p ON pc.pescodigo = p.pescodigo

-- Classifique os tipos de imóveis  por area, agrupando por cada tipo de
-- logradouro , e atribua classificações contínuas, mesmo em caso de
-- empates.

SELECT l.logcodigo,
       l.logtipo,
	   l.logdescricao,
	   (i.imvlargura * i.imvcomprimento) AS area,
	   DENSE_RANK() OVER (PARTITION BY l.logtipo ORDER BY (i.imvlargura * i.imvcomprimento) DESC)
  FROM treina.tblogradouro l
 INNER JOIN treina.tbimovel i ON l.logcodigo = i.logcodigo

-- Liste os contatos junto com o número de contato anterior (se existir),
-- para cada pessoa, ordenados pelo número do contato.

SELECT p.pesnome,
       pc.ctpnumero,
	   LAG(pc.ctpnumero) OVER (PARTITION BY p.pescodigo ORDER BY pc.ctpnumero) AS contato_anterior
  FROM treina.tbpessoa p
 INNER JOIN treina.tbpessoacontato pc ON p.pescodigo = pc.pescodigo

-- Liste as descrições dos imóveis junto com o imóvel seguinte de acordo
-- com a ordem alfabética das descrições.

SELECT i.imvdescricao,
       LEAD(i.imvdescricao) OVER (ORDER BY i.imvdescricao) AS imovel_seguinte
  FROM treina.tbimovel i
  
-- Divida os imóveis  em 4 grupos, com base no tamanho dos imóveis

SELECT i.imvdescricao,
       (i.imvlargura * i.imvcomprimento) AS area,
	   NTILE(4) OVER (ORDER BY (i.imvlargura * i.imvcomprimento) DESC) AS grupo_tamanho
  FROM treina.tbimovel i

-- Divida os contatos de pessoas em 3 grupos iguais (ou quase iguais) com
-- base no número total de contatos de cada pessoa.

SELECT p.pesnome,
       pc.ctpnumero,
	   NTILE(3) OVER (ORDER BY pc.ctpnumero DESC) AS grupo
  FROM treina.tbpessoacontato pc
 INNER JOIN treina.tbpessoa p ON pc.pescodigo = p.pescodigo