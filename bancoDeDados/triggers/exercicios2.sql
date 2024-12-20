-- Crie um trigger que valide os seguintes campos antes de inserir
-- um novo funcionário:
-- Email não pode ser vazio
-- Salário não pode ser negativo
-- Data de admissão não pode ser futura

CREATE TABLE funcionarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    salario DECIMAL(10,2),
    data_admissao DATE
);


CREATE FUNCTION fn_validar_funcionario()
RETURNS TRIGGER AS $$
BEGIN

	IF TG_OP = 'INSERT' THEN

		IF NEW.email IS NULL OR NEW.email = '' THEN
			RAISE EXCEPTION 'E-mail não pode ser vazio!';
			
		ELSEIF NEW.salario<0 THEN
			RAISE EXCEPTION 'Salário não pode ser negativo!';

		ELSEIF NEW.data_admissao>CURRENT_DATE THEN
			RAISE EXCEPTION 'Data de admissão não pode ser futura!';

		END IF;

	RETURN NEW;
		
	END IF;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER tg_validar_funcionario
	AFTER INSERT ON funcionarios
	FOR EACH ROW EXECUTE FUNCTION fn_validar_funcionario();

INSERT INTO funcionarios
VALUES (DEFAULT,'Carlos','carlos@gmail.com',2000,CURRENT_DATE);

-- Crie um trigger que atualize automaticamente o estoque de produtos
-- quando uma venda for registrada.

CREATE TABLE produtos_estoque (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    quantidade INTEGER
);

CREATE TABLE vendas (
    id SERIAL PRIMARY KEY,
    produto_id INTEGER,
    quantidade INTEGER,
    data_venda TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION fn_atualizar_estoque()
RETURNS TRIGGER AS $$
DECLARE
	v_estoque_atual INTEGER;
BEGIN

	SELECT quantidade
	  INTO v_estoque_atual
	  FROM produtos_estoque
	 WHERE id = NEW.produto_id;

	IF v_estoque_atual<NEW.quantidade THEN
		RAISE EXCEPTION 'Estoque insuficiente';
	END IF;

	UPDATE produtos_estoque
	   SET quantidade = quantidade - NEW.quantidade
	WHERE id = NEW.produto_id;

	RETURN NEW;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER tg_atualizar_estoque
	BEFORE INSERT ON vendas
	FOR EACH ROW EXECUTE FUNCTION fn_atualizar_estoque();

INSERT INTO produtos_estoque (nome, quantidade) VALUES
('Produto A', 100),
('Produto B', 200),
('Produto C', 150);

-- Venda: 10 unidades de Produto A
INSERT INTO vendas (produto_id, quantidade) VALUES (1, 10);

-- Venda: 50 unidades de Produto B
INSERT INTO vendas (produto_id, quantidade) VALUES (2, 50);

-- (deve falhar)
INSERT INTO vendas (produto_id, quantidade) VALUES (3, 200);

SELECT *
  FROM produtos_estoque;

SELECT *
  FROM vendas;
  
-- Crie um trigger que mantenha automaticamente a data da última modificação
-- de um registro de cliente e qual usuário fez a modificação.

CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    ultima_modificacao TIMESTAMP,
    modificado_por VARCHAR(50)
);

CREATE OR REPLACE FUNCTION fn_guardar_ultima_modificacao()
RETURNS TRIGGER AS $$
BEGIN

	NEW.ultima_modificacao:=CURRENT_TIMESTAMP;
	NEW.modificado_por:=CURRENT_USER;

	RETURN NEW;
	
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE TRIGGER tg_guardar_ultima_modificacao
	BEFORE INSERT OR UPDATE ON clientes
	EXECUTE FUNCTION fn_guardar_ultima_modificacao();
	
INSERT INTO clientes (nome, email) VALUES ('Alice Silva', 'alice.silva@example.com');

UPDATE clientes
   SET email = 'alice.nova@example.com'
 WHERE nome = 'Alice Silva';

SELECT *
 FROM clientes;