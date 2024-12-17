-- Crie uma função chamada soma_numeros que receba dois números inteiros
-- como entrada e retorne a soma deles.

CREATE FUNCTION soma_numeros (a INTEGER, b INTEGER)
RETURNS INTEGER AS $$
BEGIN
    RETURN a + b;
END;
$$ LANGUAGE plpgsql;

SELECT soma_numeros(7,5);

-- Crie uma função chamada multiplica que receba dois números
-- (do tipo numeric) e retorne o produto deles.

CREATE FUNCTION multiplica_numeros (a NUMERIC, b NUMERIC)
RETURNS NUMERIC AS $$
BEGIN
	RETURN a * b;
END;
$$ LANGUAGE plpgsql;

SELECT multiplica_numeros(3,2);

-- Crie uma função chamada verifica_paridade que receba um número inteiro
-- como parâmetro e retorne 'Par' ou 'Ímpar' conforme o valor.

CREATE FUNCTION verifica_paridade (a INTEGER)
RETURNS TEXT AS $$
BEGIN
	IF a % 2 = 0 THEN
		RETURN 'PAR';
	ELSE
		RETURN 'IMPAR';
	END IF;
END;
$$ LANGUAGE plpgsql;

SELECT verifica_paridade(5);

-- Crie uma função chamada concatena_nomes que receba dois parâmetros
-- do tipo text (por exemplo, nome e sobrenome) e retorne a concatenação
-- deles com um espaço no meio.

CREATE FUNCTION concatena_nomes (nome1 TEXT, nome2 TEXT)
RETURNS TEXT AS $$
BEGIN

	RETURN nome1 || ' ' || nome2;
	
END;
$$ LANGUAGE plpgsql;

SELECT concatena_nomes('Carlos','Henrique');

-- Crie uma função chamada calcula_desconto que receba dois parâmetros:
-- preco (do tipo numeric): preço original de um produto.
-- percentual (do tipo numeric): percentual de desconto a ser aplicado.
-- A função deve retornar o valor do preço com o desconto aplicado.

CREATE OR REPLACE FUNCTION calcula_desconto (preco NUMERIC,percentual NUMERIC)
RETURNS NUMERIC AS $$
BEGIN

	RETURN preco - preco * (percentual/100);

END;
$$ LANGUAGE plpgsql;

SELECT calcula_desconto(50.00,10);

-- Crie uma função chamada celsius_para_fahrenheit que receba uma
-- temperatura em graus Celsius (do tipo numeric) e retorne o valor
-- convertido para Fahrenheit.

CREATE FUNCTION celsius_para_fahrenheit (celsius NUMERIC)
RETURNS NUMERIC AS $$
BEGIN

	RETURN (celsius*9/5) + 32;
	
END;
$$ LANGUAGE plpgsql;

SELECT celsius_para_fahrenheit(30);

-- Crie uma função chamada conta_caracteres que receba uma string (text)
-- como parâmetro e retorne o número de caracteres presentes na string.
CREATE FUNCTION conta_caracteres (texto TEXT)
RETURNS INTEGER AS $$
BEGIN

	RETURN LENGTH(texto);

END;
$$ LANGUAGE plpgsql;

SELECT conta_caracteres('php');

-- Crie uma função chamada verifica_idade que receba um número inteiro
-- representando a idade e retorne:

-- 'Maior de idade' se a idade for 18 ou mais.
-- 'Menor de idade' caso contrário.

CREATE FUNCTION verifica_idade (idade INTEGER)
RETURNS TEXT AS $$
BEGIN

	IF idade > 18 THEN
		RETURN 'Maior de idade';
	ELSE
		RETURN 'Menor de idade';
	END IF;

END;	
$$ LANGUAGE plpgsql;

SELECT verifica_idade(23);

-- Crie uma função chamada calcula_area_circulo que receba o
-- raio de um círculo (do tipo numeric) e retorne a área dele.

CREATE FUNCTION calcula_area_circulo (raio NUMERIC)
RETURNS NUMERIC AS $$
BEGIN

	RETURN PI() * POWER(raio,2);
	
END;
$$ LANGUAGE plpgsql;

SELECT calcula_area_circulo(5);

-- Crie uma função chamada usuarios_padrao que retorne uma tabela com
-- duas colunas: id (integer) e nome (text). A tabela deve conter apenas
-- três linhas fictícias.

CREATE FUNCTION usuarios_padrao ()
RETURNS TABLE (id INTEGER, nome TEXT) AS $$
BEGIN

	RETURN QUERY
	SELECT 1 AS id, 'João Silva' AS nome
	UNION ALL
	SELECT 2, 'Maria Lima'
	UNION ALL
	SELECT 3, 'Carlos Soares';

END;
$$ LANGUAGE plpgsql;

SELECT usuarios_padrao();