-- Realize uma consulta que retorne apenas o “Nome da Pessoa”, o “Tipo do
-- Logradouro” e a “Descrição do Logradouro”, relacionando as tabelas com o JOIN.
-- Apresente apenas os logradouros que estão relacionados a pessoas.

SELECT p.pesnome,
       l.logtipo,
	   l.logdescricao
  FROM treina.tbpessoa p
 INNER JOIN treina.tblogradouro l ON p.logcodigo = l.logcodigo
 WHERE p.logcodigo = l.logcodigo