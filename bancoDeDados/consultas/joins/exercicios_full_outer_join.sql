-- Liste todos os logradouros e os imóveis registrados neles, incluindo logradouros sem imóveis e imóveis sem logradouros associados.
-- Exiba as colunas: logdescricao, imvdescricao.

SELECT l.logdescricao,
       i.imvdescricao
  FROM treina.tblogradouro l
  FULL OUTER JOIN treina.tbimovel i on l.logcodigo = i.logcodigo


-- Encontre todas as pessoas e seus contatos, incluindo pessoas sem contatos e contatos sem pessoas associadas.
-- Exiba as colunas: pesnome, ctpnumero.

SELECT p.pesnome,
       pc.ctpnumero
  FROM treina.tbpessoa p
  FULL OUTER JOIN treina.tbpessoacontato pc ON p.pescodigo = pc.pescodigo

-- Exiba todos os imóveis e suas taxas associadas, incluindo imóveis sem taxas e taxas não vinculadas a imóveis.
-- Exiba as colunas: imvdescricao, taxvalor.

SELECT i.imvdescricao,
       t.taxvalor
  FROM treina.tbimovel i
  FULL OUTER JOIN treina.tbtaxa t ON i.imvcodigo = t.imvcodigo

-- Mostre todos os logradouros, pessoas e imóveis, conectando-os quando possível, mas exibindo também os casos sem associação.
-- Exiba as colunas: logdescricao, pesnome, imvdescricao.

 SELECT l.logdescricao,
        p.pesnome,
		i.imvdescricao
  FROM treina.tblogradouro l
  FULL OUTER JOIN treina.tbpessoa p ON l.logcodigo = p.logcodigo
  FULL OUTER JOIN treina.tbimovel i ON l.logcodigo = i.logcodigo