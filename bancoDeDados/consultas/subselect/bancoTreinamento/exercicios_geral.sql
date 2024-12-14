SELECT * FROM treina.tblogradouro
SELECT * FROM treina.tbpessoa
SELECT * FROM treina.tbpessoaimovel
SELECT * FROM treina.tbimovel
SELECT * FROM treina.tbpessoacontato
SELECT * FROM treina.tbtaxa

-- Liste os nomes das pessoas que possuem imóveis localizados no
-- logradouro com a descrição "UM".

SELECT p.pesnome
  FROM treina.tbpessoa p
 WHERE p.pescodigo IN( SELECT pi.pescodigo
                         FROM treina.tbpessoaimovel pi
                        INNER JOIN treina.tbimovel i ON pi.imvcodigo = i.imvcodigo
                        INNER JOIN treina.tblogradouro l ON i.logcodigo = l.logcodigo
                        WHERE l.logdescricao = 'UM')

-- Encontre o número de telefone de todas as pessoas que possuem mais de um
-- imóvel registrado em seu nome.

SELECT pc.ctpnumero
  FROM treina.tbpessoacontato pc
 WHERE pc.pescodigo IN(SELECT pi.pescodigo
                         FROM treina.tbpessoaimovel pi
                        INNER JOIN treina.tbimovel i ON pi.imvcodigo = i.imvcodigo
                        GROUP BY pi.pescodigo
                       HAVING SUM(i.imvcodigo) >1)

-- Liste a descrição dos imóveis que possuem taxas com valores
-- acima da média de todas as taxas registradas.

SELECT i.imvdescricao
  FROM treina.tbimovel i
 WHERE i.imvcodigo IN (SELECT i2.imvcodigo
                         FROM treina.tbimovel i2
                        INNER JOIN treina.tbtaxa t2 ON i2.imvcodigo = t2.imvcodigo
                        GROUP BY i2.imvcodigo
                       HAVING SUM(t2.taxvalor) > (SELECT AVG (taxvalor)
					                                FROM treina.tbtaxa))

-- Liste os logradouros que possuem pelo menos um imóvel cuja área 
-- é superior à área média de todos os imóveis do banco de dados.

SELECT l.logcodigo,
       l.logtipo,
	   l.logdescricao
  FROM treina.tblogradouro l
 INNER JOIN treina.tbimovel i ON l.logcodigo = i.logcodigo
 WHERE (i.imvcomprimento * i.imvlargura) > (SELECT AVG(imvcomprimento * imvlargura)
                                             FROM treina.tbimovel)
											 
-- Liste os nomes das pessoas que possuem imóveis, mas não possuem
-- nenhuma taxa registrada.

SELECT p.pesnome
  FROM treina.tbpessoa p
 WHERE p.pescodigo IN (SELECT pi.pescodigo
  FROM treina.tbpessoaimovel pi
 WHERE pi.pescodigo NOT IN(SELECT pescodigo
                             FROM treina.tbtaxa))

SELECT p.pesnome
  FROM treina.tbpessoa p
 WHERE p.pescodigo IN (SELECT pi.pescodigo
                         FROM treina.tbpessoaimovel pi
	                    WHERE NOT EXISTS(SELECT 1
	                     FROM treina.tbtaxa t
					    WHERE t.pescodigo = pi.pescodigo
					      AND t.imvcodigo = pi.imvcodigo))
						  
-- Liste os contatos das pessoas que possuem mais imóveis do que a
-- pessoa com o menor número de imóveis registrados.

SELECT pc.ctpnumero
  FROM treina.tbpessoacontato pc
 WHERE pc.pescodigo IN(SELECT pi.pescodigo
                        FROM treina.tbpessoaimovel pi
                       GROUP BY pi.pescodigo
                      HAVING COUNT(pi.imvcodigo) > (SELECT MIN(contador)
                                                      FROM(SELECT COUNT(pi.imvcodigo) AS contador
                                                      FROM treina.tbpessoaimovel pi
								                      GROUP BY pi.pescodigo)))

-- Encontre os logradouros (nomes) que possuem menos imóveis registrados
-- do que a média de imóveis por logradouro.

SELECT l.logdescricao
  FROM treina.tblogradouro l
 WHERE l.logcodigo IN(SELECT i.logcodigo
                        FROM treina.tbimovel i
                       GROUP BY i.logcodigo
                      HAVING COUNT(i.imvcodigo)<(SELECT AVG(imovel_count)
                                                   FROM (SELECT COUNT(i.imvcodigo) AS imovel_count
							                                FROM treina.tbimovel i
								                           GROUP BY i.logcodigo)))


