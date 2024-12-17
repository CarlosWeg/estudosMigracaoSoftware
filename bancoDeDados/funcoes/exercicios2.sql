-- Crie uma função chamada calcula_fatorial que receba um número
-- inteiro positivo como entrada e retorne o seu fatorial.
CREATE FUNCTION calcula_fatorial(n INTEGER)
RETURNS integer AS $$
DECLARE
	resultado INTEGER:=1;
	i INTEGER;
BEGIN

	IF n<0 THEN
		RAISE EXCEPTION 'O número deve ser positivo';
	END IF;

	FOR i IN 1..n LOOP
		resultado:= resultado *i;
	END LOOP;

	RETURN resultado;
END;
$$ LANGUAGE plpgsql;

SELECT calcula_fatorial(5);

-- Crie uma função chamada nome_completo que receba o id de um usuário
-- como entrada e retorne o nome completo do usuário.

CREATE TABLE tbusuarios(
	id SERIAL PRIMARY KEY,
	primeiro_nome TEXT NOT NULL,
	ultimo_nome TEXT NOT NULL
);

INSERT INTO tbusuarios
       (primeiro_nome,ultimo_nome)
VALUES ('João','Silva'),
       ('Maria','Ribeiro'),
	   ('Augusto','Soares');

CREATE FUNCTION nome_completo(id_usuario INTEGER)
RETURNS TEXT AS $$
DECLARE
	nome_completo TEXT;
BEGIN
	SELECT CONCAT(primeiro_nome, ' ', ultimo_nome)
	  INTO nome_completo
	  FROM tbusuarios
	 WHERE id = id_usuario;

	 RETURN nome_completo;
END;
$$ LANGUAGE plpgsql;

SELECT nome_completo(1);

-- Crie uma função chamada verifica_primo que receba um número inteiro
-- como entrada e retorne 'Primo' se o número for primo, ou 'Não Primo'
-- caso contrário.

CREATE FUNCTION verifica_primo(n INTEGER)
RETURNS TEXT AS $$
DECLARE
	contador INTEGER:=0;
	i INTEGER;
BEGIN

	FOR i IN 1..N LOOP
		IF N % i = 0 THEN
			contador:=contador+1;
		END IF;
	END LOOP;

	IF contador <= 2 THEN
		RETURN 'É primo';
	ELSE
		RETURN 'Não é primo';
	END IF;

END;
$$ LANGUAGE plpgsql;

SELECT verifica_primo(3);

-- Crie uma função chamada calcula_media que receba o id de um aluno
-- como entrada e retorne a média das suas notas.

CREATE TABLE tbnotas(
	aluno_id INTEGER,
	nota NUMERIC
);

INSERT INTO tbnotas
       (aluno_id,nota)
VALUES (1,8),
       (1,9),
	   (1,4),
	   (2,10),
	   (2,10),
	   (2,10),
	   (3,1),
	   (3,3),
	   (3,4);

CREATE OR REPLACE FUNCTION calcula_media (id_aluno_media INTEGER)
RETURNS NUMERIC AS $$
DECLARE
	media NUMERIC:= 0;
BEGIN

	SELECT AVG(nota)
      INTO media
	  FROM tbnotas
	 WHERE aluno_id = id_aluno_media;

	 RETURN ROUND(media,2);

END;
$$LANGUAGE plpgsql;

SELECT calcula_media(2);
	 
-- Crie uma função chamada salario_anual que receba o id de um
-- funcionário e retorne o salário anual, calculado com base no salário
-- mensal armazenado no banco.

CREATE TABLE tbfuncionarios(
	funid SERIAL PRIMARY KEY,
	funnome TEXT NOT NULL,
	funsalmens NUMERIC NOT NULL
);

INSERT INTO tbfuncionarios
       (funnome,funsalmens)
VALUES ('Jonas',1900),
	   ('Lorraine',1460),
	   ('Carlos',5000);

CREATE FUNCTION salario_anual (id_funcionario INTEGER)
RETURNS NUMERIC AS $$
DECLARE
	salario_mensal NUMERIC;
BEGIN

	SELECT funsalmens
	  INTO salario_mensal
	  FROM tbfuncionarios
	 WHERE funid = id_funcionario;

	RETURN ROUND(salario_mensal*12,2);

END;
$$LANGUAGE plpgsql;

SELECT salario_anual(1);