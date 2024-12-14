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
                       HAVING COUNT(i.imvcodigo) >1)

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

-- Liste os nomes das pessoas que têm pelo menos uma taxa registrada
-- cujo valor é maior que a maior taxa de qualquer outro proprietário
-- de imóveis.


SELECT p.pesnome
  FROM treina.tbpessoa p
 WHERE p.pescodigo IN (SELECT t2.pescodigo
                         FROM treina.tbtaxa t2
                        WHERE t2.taxvalor> (SELECT MAX(taxvalor)
                                              FROM treina.tbtaxa t3
                                             WHERE t3.pescodigo <> t2.pescodigo))

-- Liste os nomes dos proprietários que possuem imóveis localizados
-- na "RUA UM" mas não possuem nenhum contato registrado.


SELECT pesnome
  FROM treina.tbpessoa
 WHERE pescodigo NOT IN (SELECT pescodigo
                           FROM treina.tbpessoacontato)
                            AND pescodigo IN (SELECT pescodigo
                                               FROM treina.tbpessoaimovel
                                              WHERE imvcodigo IN (SELECT imvcodigo
                                                                    FROM treina.tbimovel
                                                                   WHERE logcodigo IN (SELECT logcodigo
                                                                                         FROM treina.tblogradouro
                                                                                        WHERE logtipo = 'RUA'
                                                                                          AND logdescricao = 'UM')))
																						  
-- Liste os imóveis (nomes e descrições) localizados em ruas cujo tipo
-- de logradouro só aparece uma única vez no banco de dados.

SELECT imvdescricao
  FROM treina.tbimovel
 WHERE imvcodigo IN(SELECT imvcodigo
                      FROM treina.tbimovel
                     WHERE logcodigo IN(SELECT logcodigo
                                          FROM treina.tblogradouro
                                         WHERE logtipo = (SELECT logtipo
                                                            FROM treina.tblogradouro
                                                           GROUP BY logtipo
                                                          HAVING COUNT(logtipo) = 1)))

-- Liste os imóveis (nomes e descrições) cujas taxas estão abaixo da
-- média das taxas registradas para o mesmo proprietário.

SELECT imvdescricao
  FROM treina.tbimovel
 WHERE imvcodigo IN(SELECT imvcodigo
                      FROM treina.tbtaxa t
                     WHERE t.taxvalor< (SELECT AVG(taxvalor)
                                          FROM treina.tbtaxa
                                         WHERE pescodigo = t.pescodigo))

-- Liste os nomes das pessoas que possuem todos os seus imóveis
-- registrados exclusivamente na "RUA DOIS".

SELECT pesnome
  FROM treina.tbpessoa
 WHERE pescodigo IN (SELECT pescodigo
                       FROM treina.tbpessoaimovel
                      WHERE imvcodigo IN (SELECT imvcodigo
                                            FROM treina.tbimovel
                                           WHERE logcodigo IN(SELECT logcodigo
                                                                FROM treina.tblogradouro
                                                               WHERE logtipo = 'RUA'
                                                                 AND logdescricao = 'DOIS')))

-- Liste os imóveis (nomes e descrições) que não têm nenhuma taxa
-- registrada igual ao valor da maior taxa do mesmo logradouro.

SELECT i.imvdescricao
  FROM treina.tbimovel I
 WHERE i.imvcodigo NOT IN (SELECT imvcodigo
                             FROM treina.tbtaxa
                            WHERE taxvalor = (SELECT MAX(taxvalor)
                                                FROM treina.tbtaxa
                                               WHERE imvcodigo IN (SELECT imvcodigo
                                                                     FROM treina.tbimovel
					                                                WHERE logcodigo = i.logcodigo)))