-- Faça uma consulta que traga o nome das pessoas, o tipo de contato e número de
-- contato, de todas as pessoas que possuem celular com o DDD 47. Ordene pelo
-- nome das pessoas

SELECT p.pesnome,
       pc.ctpdescricao,
	   pc.ctpnumero
  FROM treina.tbpessoa p
 INNER JOIN treina.tbpessoacontato pc ON p.pescodigo = pc.pescodigo
 ORDER BY p.pesnome ASC