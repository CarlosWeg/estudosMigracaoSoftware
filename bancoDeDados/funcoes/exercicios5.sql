-- Crie uma função chamada gerar_calendario que receba um ano (INTEGER)
-- e um mês (INTEGER) e retorne todas as datas do mês em questão, indicando
-- também o dia da semana.

CREATE OR REPLACE FUNCTION gerar_calendario(ano INTEGER,mes INTEGER)
RETURNS TABLE (data DATE,
                  dia_semana TEXT) AS $$
BEGIN

	RETURN QUERY
	SELECT data_serie::DATE,
	       TO_CHAR(data_serie,'TMDay') AS dia_da_semana
	  FROM generate_series(
		   make_date(ano,mes,1),
		   make_date(ano,mes,1) + INTERVAL '1 month' - INTERVAL '1 day',
		   INTERVAL '1 day'
	  ) AS data_serie;

END;
$$ LANGUAGE plpgsql;

SELECT gerar_calendario(2024,12);

-- Crie uma função que:
-- a) Receba o ID do departamento como parâmetro
-- b) Retorne o salário médio, menor salário e maior salário do departamento
-- c) Inclua o número de funcionários no departamento
-- d) Retorne NULL se o departamento não existir

CREATE TABLE tbdepartamentos(
	depcodigo SERIAL PRIMARY KEY,
	depnome VARCHAR(50),
	deporcamento DECIMAL (12,2)
);

CREATE TABLE tbfuncionarios(
	funcodigo SERIAL PRIMARY KEY,
	funnome VARCHAR(100),
	funsalario DECIMAL(10,2),
	depcodigo INTEGER,
	FOREIGN KEY (depcodigo) REFERENCES tbdepartamentos(depcodigo)
);
INSERT INTO tbdepartamentos (depnome, deporcamento) VALUES
('Recursos Humanos', 50000.00),
('Tecnologia da Informação', 150000.00),
('Financeiro', 80000.00);

INSERT INTO tbfuncionarios (funnome, funsalario, depcodigo) VALUES
('Ana Silva', 4500.00, 1),
('Carlos Souza', 6000.00, 2),
('Mariana Oliveira', 5200.00, 3),
('Pedro Santos', 7000.00, 2);


CREATE OR REPLACE FUNCTION exibir_dados_salario(id_departamento INTEGER)
RETURNS TABLE (salario_medio NUMERIC,
               salario_menor NUMERIC,
			   salario_maior NUMERIC,
			   contar_funcionarios BIGINT) AS $$
BEGIN

	IF id_departamento NOT IN (SELECT depcodigo FROM tbdepartamentos) THEN
		RETURN;
	END IF;

	RETURN QUERY
	SELECT ROUND(AVG(funsalario),2) AS media_salario,
	       MIN(funsalario) AS minimo_salario,
		   MAX(funsalario) AS maximo_salaroo,
		   COUNT(f.funcodigo) AS numero_funcionarios
	  FROM tbdepartamentos d
	 INNER JOIN tbfuncionarios f ON d.depcodigo = f.depcodigo
	 WHERE d.depcodigo = id_departamento;

END;
$$ LANGUAGE plpgsql;

SELECT * 
  FROM exibir_dados_salario(2);

-- Desenvolva uma função que:
-- a) Registre uma nova venda
-- b) Verifique se há estoque suficiente
-- c) Atualize o estoque automaticamente
-- d) Faça rollback se não houver estoque suficiente
-- e) Retorne o valor total da venda ou uma mensagem de erro

CREATE TABLE tbprodutos(
	procodigo SERIAL PRIMARY KEY,
	pronome VARCHAR(100),
	propreco DECIMAL(10,2) NOT NULL,
	proestoque INTEGER DEFAULT 0
);

CREATE TABLE tbvendas(
	vencodigo SERIAL PRIMARY KEY,
	procodigo INTEGER,
	venqntd INTEGER,
	ventotal DECIMAL(10,2),
	data_venda DATE DEFAULT CURRENT_DATE,
	FOREIGN KEY (procodigo) REFERENCES tbprodutos(procodigo)
);

INSERT INTO tbprodutos (pronome, propreco, proestoque)
VALUES
('Produto A',2.50, 100),
('Produto B',30.00, 200),
('Produto C',2000, 3);

CREATE OR REPLACE FUNCTION gerenciar_vendas(p_procodigo INTEGER,v_venqntd DECIMAL)
RETURNS DECIMAL(10,2) AS $$
DECLARE
	v_estoque INTEGER;
	v_valor_total DECIMAL(10,2);
	v_pro_preco DECIMAL(10,2);
BEGIN

	SELECT proestoque
	  INTO v_estoque
	  FROM tbprodutos
	 WHERE procodigo = p_procodigo;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Produto não encontrado';
	END IF;

	IF v_estoque < v_venqntd THEN
		RAISE EXCEPTION 'Estoque do produto insuficiente';
	END IF;

	SELECT propreco
	  INTO v_pro_preco
	  FROM tbprodutos
	 WHERE procodigo = p_procodigo;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Produto sem preço';
	END IF;


	v_valor_total:=v_venqntd * v_pro_preco;

	BEGIN

		INSERT INTO tbvendas
		       (procodigo,venqntd,ventotal)
		VALUES (p_procodigo,v_venqntd,v_valor_total);

		UPDATE tbprodutos
		   SET proestoque = proestoque - v_venqntd
		 WHERE procodigo = p_procodigo;

		RETURN v_valor_total;

	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Erro ao registrar venda.';
	END;
END;
$$ LANGUAGE plpgsql;


SELECT gerenciar_vendas(1,3);
SELECT gerenciar_vendas(2,10);

SELECT *
  FROM tbvendas;