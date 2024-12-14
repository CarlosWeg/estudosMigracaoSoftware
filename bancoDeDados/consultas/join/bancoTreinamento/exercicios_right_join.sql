-- Liste todas as taxas registradas e os imóveis correspondentes. Inclua taxas que não estejam associadas a nenhum imóvel.
-- Exiba as colunas: taxvalor, imvdescricao.

SELECT t.taxvalor,
       i.imvdescricao
  FROM treina.tbimovel i
 RIGHT JOIN treina.tbtaxa t ON i.imvcodigo = t.imvcodigo

-- Mostre as descrições de todos os imóveis e as pessoas associadas, incluindo imóveis que não possuem proprietário.
-- Exiba as colunas: imvdescricao, pesnome.

SELECT i.imvdescricao,
       p.pesnome
  FROM treina.tbpessoa p
 RIGHT JOIN treina.tbpessoaimovel pi ON p.pescodigo = pi.pescodigo
 RIGHT JOIN treina.tbimovel i ON pi.imvcodigo = i.imvcodigo

-- Encontre todos os logradouros e as pessoas associadas, mesmo que um logradouro não tenha pessoas vinculadas.
-- Exiba as colunas: logdescricao, pesnome.

SELECT l.logdescricao,
       p.pesnome
  FROM treina.tbpessoa p
 RIGHT JOIN treina.tblogradouro l ON  p.logcodigo = l.logcodigo

-- Liste todos os contatos registrados e as pessoas associadas, incluindo contatos sem um proprietário.
-- Exiba as colunas: ctpnumero, pesnome.

SELECT pc.ctpnumero,
       p.pesnome
  FROM treina.tbpessoa p
 RIGHT JOIN treina.tbpessoacontato pc ON p.pescodigo = pc.pescodigo