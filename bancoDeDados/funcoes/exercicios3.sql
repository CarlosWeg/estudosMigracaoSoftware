-- Crie uma função chamada gera_tabela_numeros que receba dois parâmetros:

-- inicio (número inteiro inicial).
-- fim (número inteiro final).

-- A função deve retornar uma tabela com todos os números entre
-- inicio e fim, inclusive.

CREATE FUNCTION gera_tabela_numeros(inicio INTEGER, fim INTEGER)
RETURNS TABLE(numero INTEGER) AS $$
BEGIN

	RETURN QUERY
		SELECT generate_series(inicio,fim) AS numero;

END;
$$LANGUAGE plpgsql;

SELECT gera_tabela_numeros(1,10);

-- Crie uma função chamada calcula_total_vendas que receba o id de um
-- produto como entrada e retorne o total de vendas desse produto.
CREATE TABLE tbvendas(
	prodcodigo SERIAL PRIMARY KEY,
	prodqntvendida INTEGER DEFAULT 0,
	prodprecoun NUMERIC NOT NULL
);

INSERT INTO tbvendas
       (prodcodigo,prodqntvendida,prodprecoun)
VALUES (1,10,5),
       (2,3,50),
	   (3,10,2);

CREATE OR REPLACE FUNCTION calcula_total_vendas (id_produto INTEGER)
RETURNS NUMERIC AS $$
DECLARE
	total_vendido NUMERIC:=0;
BEGIN

	SELECT SUM(prodqntvendida * prodprecoun)
	  INTO total_vendido
	  FROM tbvendas
	 WHERE prodcodigo = id_produto;

	RETURN total_vendido;

END;
$$ LANGUAGE plpgsql;

SELECT calcula_total_vendas(2);

-- Crie uma função chamada classifica_idade que receba a idade de uma
-- pessoa como entrada e retorne:

-- 'Criança' se a idade for menor que 12.
-- 'Adolescente' se a idade for entre 12 e 17.
-- 'Adulto' se a idade for entre 18 e 64.
-- 'Idoso' se a idade for maior ou igual a 65.

CREATE FUNCTION classifica_idade (idade INTEGER)
RETURNS TEXT AS $$
BEGIN

	IF idade<12 THEN
		RETURN 'Criança';

	ELSEIF idade BETWEEN 12 AND 17 THEN
		RETURN 'Adolescente';

	ELSEIF idade BETWEEN 18 AND 64 THEN
		RETURN 'Adulto';

	ELSEIF idade>=65 THEN
		RETURN 'Idoso';

	END IF;
	
END;
$$ LANGUAGE plpgsql;

SELECT classifica_idade(70);

-- Verificar Estoque de um Produto
-- Crie uma função chamada verifica_estoque que receba o id
-- de um produto e retorne:

-- 'Estoque Baixo' se a quantidade for menor que 10.
-- 'Estoque Adequado' se a quantidade estiver entre 10 e 50.
-- 'Estoque Alto' se a quantidade for maior que 50.

CREATE table tbestoque(
	prodcodigo SERIAL PRIMARY KEY,
	prodqntd INTEGER DEFAULT 0
);

INSERT INTO tbestoque
       (prodqntd)
VALUES (1),
       (50),
	   (200);

CREATE FUNCTION verifica_estoque(id_produto INTEGER)
RETURNS TEXT AS $$
DECLARE
	estoque_atual INTEGER:=0;
BEGIN

	SELECT SUM(prodqntd)
	  INTO estoque_atual
	  FROM tbestoque
	 WHERE prodcodigo = id_produto;

	IF estoque_atual<10 THEN
		RETURN 'Estoque baixo';
		
	ELSEIF estoque_atual BETWEEN 10 AND 50 THEN
		RETURN 'Estoque adequado';

	ELSEIF estoque_atual>50 THEN
		RETURN 'Estoque alto';

	END IF;

END;
$$ LANGUAGE plpgsql;

SELECT verifica_estoque(1);

-- Crie uma função chamada maior_valor que receba três números como
-- parâmetros e retorne o maior valor entre eles.
CREATE FUNCTION maior_valor(a INTEGER,b INTEGER,c INTEGER)
RETURNS INTEGER AS $$
BEGIN

	RETURN GREATEST(a,b,c);

END;
$$ LANGUAGE plpgsql;

SELECT maior_valor(1,0,100);
