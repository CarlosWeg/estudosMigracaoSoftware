CREATE TABLE tbclientes(
	clicodigo SERIAL PRIMARY KEY,
	clinome VARCHAR(100),
	cliemail VARCHAR(100),
	clidatacad DATE,
	cliidade INTEGER
);

CREATE TABLE tbprodutos(
	procodigo SERIAL PRIMARY KEY,
	pronome VARCHAR(100),
	propreco DECIMAL(10,2),
	procategoria VARCHAR(50),
	proestoque INTEGER
);

CREATE TABLE tbvendas(
	vencodigo SERIAL PRIMARY KEY,
	clicodigo INTEGER REFERENCES tbclientes(clicodigo),
	vendata DATE,
	venvalortotal DECIMAL(10,2)
);

CREATE TABLE tbitensvenda(
	item SERIAL PRIMARY KEY,
	vencodigo INTEGER REFERENCES tbvendas(vencodigo),
	procodigo INTEGER REFERENCES tbprodutos(procodigo),
	itemqntd INTEGER,
	itempreco DECIMAL(10,2)
);

INSERT INTO tbclientes (clinome, cliemail, clidatacad, cliidade) VALUES
('João Silva', 'joao.silva@example.com', '2023-01-15', 30),
('Maria Souza', 'maria.souza@example.com', '2024-03-22', 25),
('Pedro Oliveira', 'pedro.oliveira@example.com', '2022-11-10', 35);

INSERT INTO tbprodutos (pronome, propreco, procategoria, proestoque) VALUES
('Notebook', 3500.00, 'Eletrônicos', 50),
('Smartphone', 1200.00, 'Eletrônicos', 150),
('Geladeira', 2500.00, 'Eletrodomésticos', 20);

INSERT INTO tbvendas (clicodigo, vendata, venvalortotal) VALUES
(1, '2024-12-01', 4700.00),
(2, '2024-12-02', 1200.00);

INSERT INTO tbitensvenda (vencodigo, procodigo, itemqntd, itempreco) VALUES
(1, 1, 1, 3500.00),
(1, 2, 1, 1200.00),
(2, 2, 1, 1200.00);

-- Desenvolva uma função que receba uma categoria de produto e
-- retorne um relatório com:
-- Total de produtos na categoria
-- Preço médio dos produtos
-- Valor total em estoque

CREATE OR REPLACE FUNCTION gerar_relatorio_categoria(p_procategoria VARCHAR(100))
RETURNS TABLE (total_produtos BIGINT,
               preco_medio_produtos DECIMAL(10,2),
			   valor_total_estoque DECIMAL(10,2)) AS $$
BEGIN

	RETURN QUERY
	SELECT COUNT(*),
	       ROUND(AVG(propreco),2),
		   ROUND(SUM(propreco * proestoque),2)
	  FROM tbprodutos
	 WHERE procategoria ILIKE '%' || p_procategoria || '%';
		   

END;
$$ LANGUAGE plpgsql;

SELECT * FROM gerar_relatorio_categoria('Eletrônicos');

-- Crie uma função que calcule o total de vendas de um cliente
-- específico por período:
-- Parâmetros: ID do cliente, data inicial e data final
-- Deve retornar: total de vendas e valor total

CREATE OR REPLACE FUNCTION total_vendas_periodo(p_clicodigo INTEGER,p_data_inicial TEXT,p_data_final TEXT)
RETURNS TABLE (total_vendas BIGINT,
               valor_total DECIMAL) AS $$
DECLARE
		v_data_inicial DATE;
		v_data_final DATE;
BEGIN

	v_data_inicial:= TO_DATE(p_data_inicial,'DD-MM-YYYY');
	v_data_final:= TO_DATE(p_data_final,'DD-MM-YYYY');

	RETURN QUERY
	SELECT COUNT(*),
	       SUM(venvalortotal)
	  FROM tbvendas
	 WHERE clicodigo = p_clicodigo
	   AND vendata BETWEEN v_data_inicial AND v_data_final;

END;
$$ LANGUAGE plpgsql;

SELECT *
  FROM total_vendas_periodo(1,'30/11/2024','30/12/2024');

-- Desenvolva uma função que identifique produtos com estoque baixo:
-- Parâmetro: quantidade mínima desejada em estoque
-- Deve retornar: lista de produtos abaixo deste limite

CREATE OR REPLACE FUNCTION produtos_estoque_abaixo(p_qntd_estoque INTEGER)
RETURNS TABLE (procodigo INT,
               pronome VARCHAR,
		       propreco DECIMAL,
		       procategoria VARCHAR,
		       proestoque INTEGER) AS $$
BEGIN

	RETURN QUERY
	SELECT p.procodigo,
	       p.pronome,
		   p.propreco,
		   p.procategoria,
		   p.proestoque
	  FROM tbprodutos p
	 WHERE p.proestoque < p_qntd_estoque;

END;
$$ LANGUAGE plpgsql;


SELECT *
  FROM produtos_estoque_abaixo(60);

-- Crie uma função que calcule o ranking de vendas dos produtos:
-- Deve mostrar os top N produtos mais vendidos
-- Incluir quantidade vendida e valor total
-- Permitir filtrar por período

CREATE OR REPLACE FUNCTION rank_venda_produtos(p_limite INTEGER, p_data_inicial TEXT, p_data_final TEXT)
RETURNS TABLE (posicao_rank BIGINT,
               quantidade_vendida BIGINT,
			   procodigo INTEGER,
			   pronome VARCHAR(50),
			   propreco DECIMAL(10,2),
			   procategoria VARCHAR(50),
			   proestoque INTEGER) AS $$
DECLARE
	v_data_inicial DATE;
	v_data_final DATE;
BEGIN

	v_data_inicial:= TO_DATE(p_data_inicial,'DD/MM/YYYY');
	v_data_final:=TO_DATE(p_data_final,'DD/MM/YYYY');

	RETURN QUERY
	SELECT RANK() OVER(ORDER BY SUM(i.itemqntd) DESC),
	       SUM(i.itemqntd),
		   p.procodigo,
		   p.pronome,
		   p.propreco,
		   p.procategoria,
		   p.proestoque
	  FROM tbvendas v
	 INNER JOIN tbitensvenda i ON v.vencodigo = i.vencodigo
	 INNER JOIN tbprodutos p ON i.procodigo = p.procodigo
	 WHERE v.vendata BETWEEN v_data_inicial AND v_data_final
	 GROUP BY 3,4,5,6,7
	 LIMIT p_limite;

END;
$$ LANGUAGE plpgsql;

SELECT *
  FROM rank_venda_produtos(2, '01/12/2024', '02/12/2024');