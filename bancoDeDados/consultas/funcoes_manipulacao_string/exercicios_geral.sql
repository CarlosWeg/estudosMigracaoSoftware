-- Selecione todos os nomes das pessoas em letras maiúsculas a partir
-- da tabela TBPessoa.

SELECT UPPER(p.pesnome)
  FROM treina.tbpessoa p

-- Liste os tipos de logradouro (coluna logtipo) em letras minúsculas.

SELECT UPPER(l.logtipo)
  FROM treina.tblogradouro l

-- Crie uma consulta que converta o nome de todos os contatos da tabela
-- TBPessoaContato para letras maiúsculas.  

SELECT UPPER(p.pesnome)
  FROM treina.tbpessoacontato pc
 INNER JOIN treina.tbpessoa p ON pc.pescodigo = p.pescodigo

-- Selecione as descrições de todos os imóveis na tabela TBImovel,
-- convertendo-as para letras minúsculas.

SELECT LOWER(i.imvdescricao)
  FROM treina.tbimovel i

-- Liste os nomes das pessoas removendo espaços em branco adicionais
-- no início e no final.

SELECT TRIM(p.pesnome)
  FROM treina.tbpessoa p
  
-- Selecione as descrições dos contatos removendo espaços apenas no início.

SELECT LTRIM(pc.ctpdescricao)
  FROM treina.tbpessoacontato pc

-- Liste as descrições dos imóveis removendo espaços apenas no final.

SELECT RTRIM(i.imvdescricao)
  FROM treina.tbimovel i

-- Corrija espaços no início ou no final de entradas na coluna ctpnumero
-- da tabela TBPessoaContato.

UPDATE treina.tbpessoacontato
   SET ctpnumero = TRIM(ctpnumero)
 WHERE ctpnumero LIKE ' %'
    OR ctpnumero LIKE'% '

-- Extraia os três primeiros caracteres do nome das pessoas na tabela TBPessoa.

SELECT SUBSTRING (p.pesnome FROM 1 FOR 3) AS primeiros_tres_caracteres
  FROM treina.tbpessoa p

-- Liste os dois últimos caracteres do número de contato

SELECT RIGHT (pc.ctpnumero,2) AS ultimos_dois_caracteres
  FROM treina.tbpessoacontato pc

-- Selecione o trecho entre o 4º e o 8º caractere de descrições dos
-- logradouros na tabela TBLogradouro.

SELECT SUBSTRING (l.logdescricao FROM 4 FOR 8) AS trecho_logradouro
  FROM treina.tblogradouro l
  
-- Exiba os cinco primeiros caracteres da descrição de cada imóvel

SELECT LEFT(i.imvdescricao,5)
  FROM treina.tbimovel i

-- Substitua "RUA" por "AV." nos tipos da tabela TBLogradouro.

SELECT REPLACE(l.logtipo,'RUA','AV') AS descricao_modificada
  FROM treina.tblogradouro l

-- Substitua todos os hifens por espaços em branco nos
-- números de contato

SELECT REPLACE (pc.ctpnumero,'-',' ') AS numero_modificado
  FROM treina.tbpessoacontato pc

-- Substitua todas as letras "A" por "X" nos nomes das pessoas

SELECT REPLACE (p.pesnome,'A','X')
  FROM treina.tbpessoa p

-- Substitua "CASA" por "RESIDÊNCIA" nas descrições de imóveis

SELECT REPLACE (i.imvdescricao,'CASA','RESIDENCIA')
  FROM treina.tbimovel i

-- Liste o código de área (primeira parte antes do hífen) dos números de contato
SELECT SPLIT_PART(pc.ctpnumero,'-',1) AS codigo_area
  FROM treina.tbpessoacontato pc

-- Extraia a segunda parte dos números de contato (após o primeiro hífen)

SELECT SPLIT_PART(pc.ctpnumero,'-',2) AS segunda_parte_numero
  FROM treina.tbpessoacontato pc

-- Divida as descrições dos logradouros pelo espaço e
-- liste apenas aprimeira palavra.

SELECT SPLIT_PART(l.logdescricao,' ',1) AS primeira_palavra_logradouro
  FROM treina.tblogradouro l

-- Selecione a terceira parte das descrições dos logradouros
-- dividindo por espaços.

SELECT SPLIT_PART(l.logdescricao,' ',3) AS terceira_parte_logradouros
  FROM treina.tblogradouro l

-- Concatene o nome das pessoas com o tipo de logradouro correspondente.

SELECT CONCAT(p.pesnome,'-',l.logtipo) AS pessoa_logradouro
  FROM treina.tbpessoa p
 INNER JOIN treina.tblogradouro l ON p.logcodigo = l.logcodigo
 
-- Concatene o número do contato com sua descrição na tabela TBPessoaContato, separando por um hífen.

SELECT CONCAT(pc.ctpnumero,'-',pc.ctpdescricao)
  FROM treina.tbpessoacontato pc

-- Liste os nomes das pessoas concatenados com "mora na" seguido da descrição do imóvel.

SELECT p.pesnome || ' MORA NA ' || i.imvdescricao AS pessoa_imovel
  FROM treina.tbpessoaimovel pi
 INNER JOIN treina.tbpessoa p ON pi.pescodigo = p.pescodigo
 INNER JOIN treina.tbimovel i ON pi.imvcodigo = i.imvcodigo

-- Concatene as descrições de logradouro com " - LOCAL".

SELECT l.logdescricao || ' - LOCAL' AS logradouro_local
  FROM treina.tblogradouro l