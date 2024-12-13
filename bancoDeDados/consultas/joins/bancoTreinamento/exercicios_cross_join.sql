-- Gere todas as combinações possíveis de pessoas e logradouros.

SELECT p.pesnome,
       l.logdescricao
  FROM treina.tbpessoa p
 CROSS JOIN treina.tblogradouro l

-- Crie uma lista com todas as combinações possíveis de contatos
-- para pessoas diferentes.

SELECT c1.ctpnumero,
       c2.ctpnumero
   FROM treina.tbpessoacontato c1
  CROSS JOIN treina.tbpessoacontato c2
  WHERE c1.pescodigo <> c2.pescodigo

-- Liste todas as combinações possíveis de pessoas e imóveis,
-- independentemente de estarem relacionadas.

SELECT p.pesnome,
       i.imvdescricao
  FROM treina.tbpessoa p
 CROSS JOIN treina.tbimovel i

-- Combine todas as pessoas com todos os valores de taxa disponíveis.

SELECT p.pesnome,
       t.taxvalor
  FROM treina.tbpessoa p
 CROSS JOIN treina.tbtaxa t