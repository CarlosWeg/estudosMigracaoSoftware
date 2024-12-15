-- Liste os nomes de todas as pessoas agrupados por cada
-- tipo de logradouro , separando os nomes por vírgulas.

SELECT l.logtipo,
       STRING_AGG(p.pesnome,',') AS nomes
  FROM treina.tblogradouro l
 INNER JOIN treina.tbpessoa p ON l.logcodigo = p.logcodigo
 GROUP BY l.logtipo

-- Mostre os tipos de contato disponíveis
-- para cada pessoa, agrupando-os em uma string separada por
-- ponto-e-vírgula.

SELECT p.pesnome,
       STRING_AGG(pc.ctpdescricao,';') AS tipos_contato
  FROM treina.tbpessoacontato pc
 INNER JOIN treina.tbpessoa p ON pc.pescodigo = p.pescodigo
 GROUP BY 1

-- Liste as descrições dos imóveis agrupados por
-- logradouro , separando as descrições por
-- vírgulas.


SELECT l.logdescricao,
       STRING_AGG(i.imvdescricao,',') AS descricoes_imoveis
  FROM treina.tbimovel i
 INNER JOIN treina.tblogradouro l ON i.logcodigo = l.logcodigo
 GROUP BY 1

 -- Exiba os nomes das pessoas que possuem imóveis, agrupados por cada imóvel ,
 -- separados por um delimitador ;

 SELECT i.imvdescricao,
        STRING_AGG(p.pesnome,';') AS nomes
   FROM treina.tbpessoaimovel pi
  INNER JOIN treina.tbpessoa p ON pi.pescodigo = p.pescodigo
  INNER JOIN treina.tbimovel i ON pi.imvcodigo = i.imvcodigo
  GROUP BY 1

-- Liste as taxas pagas  por cada pessoa
-- , separando os valores por vírgula e
-- incluindo uma ordenação em ordem decrescente.

SELECT p.pesnome,
       STRING_AGG(t.taxvalor::TEXT, ',' ORDER BY t.taxvalor DESC) AS taxas
  FROM treina.tbtaxa t
 INNER JOIN treina.tbpessoa p ON t.pescodigo = p.pescodigo
 GROUP BY 1
  
-- Agrupe os tipos de logradouro distintos em uma única string, separados por vírgula.

SELECT STRING_AGG(DISTINCT l.logtipo, ',') AS tipos_logradouro
  FROM treina.tblogradouro l

-- Exiba uma lista dos nomes das pessoas jurídicas,
-- separados por ponto-e-vírgula.

SELECT STRING_AGG(p.pesnome,';') AS nomes_pessoas_juridicas
  FROM treina.tbpessoa p
 WHERE p.pestipo = 2

-- Mostre os nomes das pessoas físicas que possuem pelo menos um contato,
-- agrupando os nomes por logradouro.

SELECT l.logdescricao,
       STRING_AGG(p.pesnome,',') AS nomes_pessoas_fisicas
  FROM treina.tblogradouro l
 INNER JOIN treina.tbpessoa p ON l.logcodigo = p.logcodigo
 INNER JOIN treina.tbpessoacontato pc ON p.pescodigo = pc.pescodigo
 WHERE p.pestipo = 1
 GROUP BY 1

-- Apresente uma lista de descrições de logradouros
-- com imóveis registrados, separadas por um pipe (|).

SELECT STRING_AGG(DISTINCT l.logdescricao,'|') AS descricoes_logradouros
  FROM treina.tbimovel i 
 INNER JOIN treina.tblogradouro l ON i.logcodigo = l.logcodigo

-- Liste os nomes das pessoas agrupados por logradouro em formato de array.

SELECT l.logcodigo,
       ARRAY_AGG(p.pesnome) AS nomes
  FROM treina.tblogradouro l
 INNER JOIN treina.tbpessoa p ON l.logcodigo = p.pescodigo
 GROUP BY 1

-- Retorne um array com os números de contato 
-- de todas as pessoas físicas , ordenados de forma crescente.

SELECT ARRAY_AGG(pc.ctpnumero ORDER BY pc.ctpnumero ASC) AS contatos_pessoas_fisicas
  FROM treina.tbpessoacontato pc
 INNER JOIN treina.tbpessoa p ON pc.pescodigo = p.pescodigo
 WHERE p.pestipo = 1