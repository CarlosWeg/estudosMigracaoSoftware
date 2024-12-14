-- Liste os logradouros que possuem pelo menos uma pessoa associada,
-- exibindo o código e a descrição do logradouro.

SELECT logcodigo,
       logtipo,
	   logdescricao
  FROM treina.tblogradouro
 WHERE logcodigo IN (SELECT logcodigo
                       FROM treina.tbpessoa)


-- Liste o nome das pessoas que possuem mais de um número
-- de contato registrado.

SELECT p.pesnome
  FROM treina.tbpessoa p
 WHERE p.pescodigo IN (SELECT pescodigo
                         FROM treina.tbpessoacontato
                        WHERE pescodigo = p.pescodigo
				        GROUP BY pescodigo
                       HAVING COUNT(ctpnumero) > 1)
					   
-- Encontre os imóveis que não estão associados a nenhuma pessoa,
-- exibindo o código e a descrição do imóvel.

SELECT imvcodigo,
       imvdescricao
  FROM treina.tbimovel
 WHERE imvcodigo NOT IN (SELECT imvcodigo
                           FROM treina.tbpessoaimovel)

-- Liste os imóveis cuja largura seja maior que a largura média de
-- todos os imóveis.

SELECT imvcodigo,
       imvdescricao
  FROM treina.tbimovel
 WHERE imvlargura > (SELECT AVG(imvlargura)
                       FROM treina.tbimovel)

-- Liste os nomes das pessoas (pesnome) que possuem pelo menos um imóvel
-- localizado em um logradouro do tipo "AVENIDA".

SELECT pesnome
  FROM treina.tbpessoa
 WHERE pescodigo IN(SELECT pescodigo
                      FROM treina.tbpessoaimovel
                     WHERE imvcodigo IN (SELECT imvcodigo
                                           FROM treina.tbimovel
					                      WHERE logcodigo IN (SELECT logcodigo
                                                               FROM treina.tblogradouro
                                                              WHERE logtipo = 'AVENIDA')))

-- Liste os nomes das pessoas (pesnome) que têm pelo menos um contato
-- do tipo "FIXO" e outro contato do tipo "CELULAR".

SELECT pesnome
  FROM treina.tbpessoa
 WHERE pescodigo IN (SELECT pc.pescodigo
                       FROM treina.tbpessoacontato pc
                      WHERE EXISTS(SELECT 1
                                     FROM treina.tbpessoacontato
				                    WHERE pescodigo = pc.pescodigo
				                      AND ctpdescricao = 'CELULAR')
                        AND EXISTS(SELECT 1
	                                 FROM treina.tbpessoacontato
				                    WHERE pescodigo = pc.pescodigo
				                      AND ctpdescricao = 'FIXO'))

-- Liste os logradouros (logdescricao) que possuem imóveis de
-- dois ou mais proprietários distintos.

SELECT logdescricao
  FROM treina.tblogradouro
 WHERE EXISTS (SELECT 1
                 FROM treina.tbpessoaimovel pi
				 INNER JOIN treina.tbimovel i ON pi.imvcodigo = i.imvcodigo
				 GROUP BY i.logcodigo
				HAVING COUNT(DISTINCT pi.pescodigo) > 1)
        
-- Liste o nome e o logradouro das pessoas que possuem imóveis cujo
-- tamanho (largura × comprimento) seja maior que a média de todos os imóveis.

SELECT logtipo,
       logdescricao
  FROM treina.tblogradouro
 WHERE logcodigo IN (SELECT logcodigo
                       FROM treina.tbimovel
                      WHERE (imvlargura*imvcomprimento) > (SELECT AVG(imvlargura*imvcomprimento)
                                                             FROM treina.tbimovel))
															 
-- Encontre o nome das pessoas que possuem mais de um imóvel registrado.

SELECT p.pesnome
  FROM treina.tbpessoa p
 WHERE p.pescodigo IN (SELECT pi.pescodigo
                         FROM treina.tbpessoaimovel pi
						 GROUP BY pi.pescodigo
						HAVING COUNT(pi.imvcodigo)>1)