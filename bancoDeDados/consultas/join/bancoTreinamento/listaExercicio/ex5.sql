-- Realize uma consulta que retorne o nome das pessoas e a quantidade de contatos
-- que cada uma possui (se não possuir contatos deve aparecer como 0).

SELECT p.pesnome,
       COUNT(pc.ctpnumero)
  FROM treina.tbpessoa p
  LEFT JOIN treina.tbpessoacontato pc ON p.pescodigo = pc.pescodigo
 GROUP BY p.pesnome