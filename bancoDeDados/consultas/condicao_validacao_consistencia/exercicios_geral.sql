-- Liste o nome das pessoas e os números de contato. Caso a descrição do
-- contato (ctpdescricao) seja nula, substitua por 'SEM DESCRIÇÃO'.

SELECT p.pesnome,
       COALESCE(pc.ctpdescricao,'Sem descrição') AS descricao_contato
  FROM treina.tbpessoacontato pc
 INNER JOIN treina.tbpessoa p ON pc.pescodigo = p.pescodigo

-- Crie uma lista com os nomes das pessoas e suas larguras de imóveis.
-- Se a largura for igual a 10, exiba NULL no lugar dela.

SELECT p.pesnome,
       NULLIF(i.imvlargura,10) AS imovel_largura
  FROM treina.tbpessoa p
 INNER JOIN treina.tbpessoaimovel pi ON p.pescodigo = pi.pescodigo
 INNER JOIN treina.tbimovel i ON pi.imvcodigo = i.imvcodigo


-- Liste os nomes das pessoas e substitua os valores nulos da coluna ramal por 0.

SELECT p.pesnome,
       COALESCE(pc.ctpramal,0) AS ramal
  FROM treina.tbpessoacontato pc
 INNER JOIN treina.tbpessoa p ON pc.pescodigo = p.pescodigo


-- Liste os nomes das pessoas e crie uma coluna chamada tipo_pessoa que exibe:

SELECT p.pesnome,
       CASE
	        WHEN p.pestipo = 1 THEN 'FISICA'
			WHEN p.pestipo = 2 THEN 'JURIDICA'
	   END AS tipo_pessoa
  FROM treina.tbpessoa p
  
-- Liste os nomes das pessoas e mostre se têm contato do tipo
-- 'FIXO' ou 'CELULAR'. Se não tiver descrição, exiba 'SEM CONTATO'.

SELECT p.pesnome,
       CASE
	        WHEN pc.ctpdescricao = 'FIXO' THEN 'FIXO'
			WHEN pc.ctpdescricao = 'CELULAR' THEN 'CELULAR'
			ELSE COALESCE (pc.ctpdescricao,'SEM CONTATO')
	    END AS tipo_contato
  FROM treina.tbpessoa p
 INNER JOIN treina.tbpessoacontato pc ON pc.pescodigo = p.pescodigo

-- Liste os imóveis e crie uma coluna categoria_imovel que exiba:

-- 'PEQUENO' para largura menor que 10.
-- 'MÉDIO' para largura entre 10 e 11.
-- 'GRANDE' para largura maior que 11.

SELECT i.imvdescricao,
       CASE
	        WHEN i.imvlargura < 10 THEN 'PEQUENO'
			WHEN i.imvlargura BETWEEN 10 AND 11 THEN 'MÉDIO'
			WHEN i.imvlargura > 11 THEN 'GRANDE'
	    END AS categoria_imovel
  FROM treina.tbimovel i

-- Liste os códigos das pessoas que possuem imóveis,
-- mas não possuem contato registrado.

SELECT pi.pescodigo
  FROM treina.tbpessoaimovel pi
  
 EXCEPT
 
SELECT pc.pescodigo
  FROM treina.tbpessoacontato pc

 -- Liste os códigos das pessoas que possuem imóveis
 -- e têm contatos registrados.

SELECT pi.pescodigo
  FROM treina.tbpessoaimovel pi
  
INTERSECT
 
SELECT pc.pescodigo
  FROM treina.tbpessoacontato pc


-- Liste os códigos dos imóveis cadastrados, mas que não estão
-- associados a pessoas.

SELECT i.imvcodigo
  FROM treina.tbimovel i

EXCEPT

SELECT i.imvcodigo
  FROM treina.tbpessoaimovel i
  
