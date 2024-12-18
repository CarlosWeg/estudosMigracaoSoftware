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
		IF i % 2 = 0 THEN
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


-- Crie uma função chamada parcelas_salario que receba:

-- Um salário total (salario_total NUMERIC),
-- O número de parcelas (num_parcelas INTEGER).
-- A função deve retornar uma tabela com o valor de cada parcela e
-- indicar se é a última parcela (que pode conter o ajuste de arredondamento).

CREATE OR REPLACE FUNCTION parcelas_salario(salario_total NUMERIC,num_parcelas INTEGER)
RETURNS TABLE (parcela INTEGER,
                  valor_parcela NUMERIC,
				  ultima_parcela BOOLEAN) AS $$
DECLARE
	valor_base NUMERIC;
	valor_ajuste NUMERIC;
	i INTEGER;
BEGIN

	valor_ajuste = ROUND(salario_total/num_parcelas,2);
	valor_base = (salario_total-valor_ajuste*(num_parcelas-1));

	FOR i IN 1..num_parcelas LOOP
		parcela:=i;
		
		IF i <> num_parcelas THEN
			valor_parcela:=valor_ajuste;
			ultima_parcela:=FALSE;
		ELSE
			valor_parcela:=valor_base;
			ultima_parcela:=TRUE;
		END IF;

		RETURN NEXT;

	END LOOP;

END;
$$ LANGUAGE plpgsql;

SELECT * FROM parcelas_salario(1943.98,4);

-- Crie uma função chamada ranking_vendas que retorne uma tabela com o
-- ranking dos produtos mais vendidos baseado em uma tabela vendas.

CREATE TABLE tbvendas(
	procodigo SERIAL PRIMARY KEY,
	proqntven INTEGER DEFAULT 0
);

INSERT INTO tbvendas
       (proqntven)
VALUES (3),
       (9),
	   (12);

CREATE OR REPLACE FUNCTION ranking_vendas()
RETURNS TABLE (proposrank BIGINT,
               produto_codigo INTEGER,
			   produto_qntd_vendida INTEGER) AS $$
BEGIN

	RETURN QUERY
	SELECT RANK()OVER(ORDER BY proqntven DESC),
	       procodigo,
		   proqntven
	  FROM tbvendas;

END;
$$ LANGUAGE plpgsql;

SELECT * FROM ranking_vendas();


-- Crie uma função chamada conta_caracteres que receba uma string e
-- um caractere específico e retorne o número de vezes que o caractere
-- aparece na string.
CREATE OR REPLACE FUNCTION conta_caracteres(texto TEXT,caractere TEXT)
RETURNS INTEGER AS $$
DECLARE
	contador INTEGER := 0;
	i INTEGER;
BEGIN

    FOR i IN 1..LENGTH(texto) LOOP

		IF SUBSTRING(texto FROM i FOR 1) = caractere THEN
			contador:=contador + 1;
		END IF;

	END LOOP;

	RETURN contador;

END;
$$ LANGUAGE plpgsql;

SELECT conta_caracteres('Eu adoro banco de dados','o');


-- Crie uma função chamada normaliza_nome que receba um nome como
-- entrada e retorne o nome no formato correto:
CREATE FUNCTION normaliza_nome(nome TEXT)
RETURNS TEXT AS $$
BEGIN

	RETURN INITCAP(nome);

END;
$$ LANGUAGE plpgsql;

SELECT normaliza_nome('jOÃO da silVA souza');

-- Crie uma função chamada produtos_sem_vendas que retorne uma lista de
-- produtos que não possuem vendas registradas.

CREATE TABLE tbprodutos(
       procodigo SERIAL PRIMARY KEY,
	   pronome TEXT NOT NULL
);

CREATE TABLE tbvendas(
       procodigo INTEGER REFERENCES tbprodutos(procodigo),
	   venqntd INTEGER DEFAULT 0
);

INSERT INTO tbprodutos (pronome) VALUES ('Produto A'), ('Produto B'), ('Produto C');
INSERT INTO tbvendas (procodigo, venqntd) VALUES (1, 10), (3, 5);

CREATE FUNCTION produtos_sem_vendas()
RETURNS TABLE (codigo_produto INTEGER,
               nome_produto TEXT) AS $$
BEGIN

	RETURN QUERY
	SELECT procodigo,
	       pronome
	  FROM tbprodutos
	 WHERE procodigo NOT IN(SELECT procodigo
	                          FROM tbvendas);

END;
$$ LANGUAGE plpgsql;

SELECT * FROM produtos_sem_vendas();