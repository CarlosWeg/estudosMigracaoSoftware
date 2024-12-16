-- Liste os números de contato (ctpnumero) e ramais (ctpramal) de todos os
-- contatos cadastrados. Caso o ramal seja nulo, substitua-o
-- pela string "SEM RAMAL".

SELECT pc.ctpnumero,
       COALESCE(pc.ctpramal::TEXT,'SEM RAMAL') AS ramal
  FROM treina.tbpessoacontato pc

-- Selecione o valor das taxas (taxvalor) para todas as taxas registradas.
-- Caso o valor seja 0, use a função NULLIF para retornar NULL

SELECT NULLIF(t.taxvalor,0) AS taxa_valor
  FROM treina.tbtaxa t
  
-- Liste os nomes das pessoas e seus tipos, substituindo:

-- 1 por "Física"
-- 2 por "Jurídica"

SELECT p.pesnome,
       CASE
	        WHEN p.pestipo = 1 THEN 'FISICA'
			WHEN p.pestipo = 2 THEN 'JURIDICA'
		END AS tipo_pessoa
  FROM treina.tbpessoa p


-- Liste os nomes das pessoas e, usando CASE, exiba "Homem" para pessexo = 1,
-- "Mulher" para pessexo = 2 e "Outro" para qualquer outro valor.

SELECT p.pesnome,
       CASE
	        WHEN p.pessexo = 1 THEN 'HOMEM'
			WHEN p.pessexo = 2 THEN 'MULHER'
			ELSE 'Outro'
	   END AS pessoa_sexo
  FROM treina.tbpessoa p

-- Recupere os códigos de pessoas (pescodigo) que estão tanto na
-- tabela TBPessoaImovel quanto na tabela TBTaxa.

SELECT p.pescodigo
  FROM treina.tbpessoa p

INTERSECT

SELECT t.pescodigo
  FROM treina.tbtaxa t

-- Liste os nomes das pessoas e os valores de suas taxas.
-- Caso não haja uma taxa associada, substitua o valor por "0.00".

SELECT p.pesnome,
       COALESCE(t.taxvalor,0.00)
  FROM treina.tbtaxa t
 INNER JOIN treina.tbpessoa p ON t.pescodigo = p.pescodigo
 ORDER BY p.pesnome 

-- Liste a descrição dos imóveis (imvdescricao) e crie uma coluna
-- adicional chamada "Tipo Imóvel", que classifica o imóvel como:

-- "Grande" se largura >= 10
-- "Pequeno" caso contrário

SELECT i.imvdescricao,
       CASE
	       WHEN i.imvlargura>=10 THEN 'GRANDE'
		   ELSE 'PEQUENO'
	   END AS tamanho_imovel
  FROM treina.tbimovel i

-- Liste os nomes das pessoas, a descrição dos imóveis e o valor das
-- taxas. Substitua o valor da taxa por "NÃO INFORMADO" caso seja nulo.

SELECT p.pesnome,
       i.imvdescricao,
	   COALESCE(t.taxvalor::TEXT,'NÃO INFORMADO') AS valor_taxa
  FROM treina.tbtaxa t
 INNER JOIN treina.tbpessoa p ON t.pescodigo = p.pescodigo
 INNER JOIN treina.tbimovel i ON t.imvcodigo = i.imvcodigo