-- Crie uma função chamada soma_pares_intervalo que receba dois números
-- inteiros como parâmetros (inicio e fim) e retorne a soma de todos os
-- números pares dentro desse intervalo.
CREATE FUNCTION soma_pares_intervalo(inicio INTEGER, fim INTEGER)
RETURNS INTEGER AS $$
DECLARE
	i INTEGER;
	resultado INTEGER:=0;
BEGIN

	FOR i IN inicio..fim LOOP
		IF i %2 = 0 THEN
			resultado:=resultado+i;
		END IF;
	END LOOP;

	RETURN resultado;

END;
$$ LANGUAGE plpgsql;

SELECT soma_pares_intervalo(1,10);

-- Crie uma função chamada datas_faltantes que receba um intervalo
-- de datas (data_inicio e data_fim) e retorne uma tabela com todas
-- as datas faltantes em uma tabela eventos.

CREATE TABLE eventos (
    data_evento DATE PRIMARY KEY
);

INSERT INTO eventos (data_evento) 
VALUES ('2024-06-01'),
       ('2024-06-03'),
	   ('2024-06-05');


CREATE OR REPLACE FUNCTION datas_faltantes(data_inicio DATE, data_fim DATE)
RETURNS TABLE(data_faltante DATE) AS $$
BEGIN

	RETURN QUERY
	SELECT d::DATE
	  FROM generate_series(data_inicio,data_fim,'1 day'::INTERVAL) d
	 WHERE d::DATE NOT IN (SELECT data_evento
	                         FROM eventos);

END;
$$ LANGUAGE plpgsql;

SELECT * FROM datas_faltantes('2024-06-01', '2024-06-05');