-- Crie uma tabela de clientes e uma tabela de auditoria. 
-- Desenvolva um trigger que registre todas as alterações (INSERT, UPDATE, DELETE) 
-- na tabela de clientes, guardando o tipo de operação, usuário e timestamp.

-- Tabelas necessárias
CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    telefone VARCHAR(20)
);

CREATE TABLE auditoria_clientes (
    id SERIAL PRIMARY KEY,
    operacao CHAR(1), -- I, U, ou D
    data_operacao TIMESTAMP,
    usuario VARCHAR(50),
    tabela_afetada VARCHAR(50),
    id_registro INTEGER,
    dados_antigos JSONB,
    dados_novos JSONB
);

CREATE OR REPLACE FUNCTION fn_auditar_clientes()
RETURNS TRIGGER AS $$
BEGIN

	IF TG_OP = 'INSERT' THEN

		INSERT INTO auditoria_clientes
		       VALUES(DEFAULT,'I',CURRENT_TIMESTAMP,CURRENT_USER,TG_TABLE_NAME,NEW.id,NULL,TO_JSONB(NEW));

			   RETURN NEW;
	
	ELSEIF TG_OP = 'UPDATE' THEN

		INSERT INTO auditoria_clientes
		       VALUES(DEFAULT,'U',CURRENT_TIMESTAMP,CURRENT_USER,TG_TABLE_NAME,NEW.id,TO_JSONB(OLD),TO_JSONB(NEW));

			   RETURN NEW;

	ELSEIF TG_OP = 'DELETE' THEN

		INSERT INTO auditoria_clientes
		       VALUES (DEFAULT,'D',CURRENT_TIMESTAMP,CURRENT_USER,TG_TABLE_NAME,NEW.id,TO_JSONB(OLD),NULL);
		RETURN OLD;

	END IF;
	RETURN NULL;
	
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_auditar_clientes
AFTER INSERT OR UPDATE OR DELETE ON clientes
FOR EACH ROW EXECUTE FUNCTION fn_auditar_clientes();

 INSERT INTO clientes (nome, email, telefone) VALUES
('Alice Silva', 'alice.silva@example.com', '(11) 91234-5678'),
('Bruno Oliveira', 'bruno.oliveira@example.com', '(21) 98765-4321'),
('Carla Santos', 'carla.santos@example.com', '(31) 99876-5432'),
('Diego Pereira', 'diego.pereira@example.com', '(41) 91234-8765');

UPDATE clientes
   SET telefone = '(11) 92345-6789'
 WHERE nome = 'Alice Silva';

DELETE FROM clientes
 WHERE nome = 'Diego Pereira';

SELECT *
  FROM auditoria_clientes;

--  Crie uma tabela de produtos e um trigger que valide as seguintes regras
-- antes de qualquer inserção ou atualização:
-- Preço não pode ser negativo
-- Nome do produto não pode ser vazio
-- Estoque mínimo não pode ser maior que estoque máximo

CREATE TABLE tbproduto(
	procodigo SERIAL PRIMARY KEY,
	pronome VARCHAR(100),
	propreco DECIMAL(10,2),
	proestoque INTEGER
);

CREATE OR REPLACE FUNCTION fn_verificar_produto()
RETURNS TRIGGER AS $$
DECLARE
	v_estoque_maximo INTEGER:= 100;
BEGIN

	IF NEW.pronome IS NULL OR LENGTH(NEW.pronome) = 0 THEN
		RAISE EXCEPTION 'Nome inválido';
		
	ELSEIF NEW.propreco <=0 THEN
		RAISE EXCEPTION 'O preço não pode ser negativo';

	ELSEIF NEW.proestoque>v_estoque_maximo THEN
		RAISE EXCEPTION 'Estoque excede o estoque máximo';

	END IF;

	RETURN NEW;
	
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_verificar_produto
	BEFORE INSERT OR UPDATE ON tbproduto
	FOR EACH ROW EXECUTE FUNCTION fn_verificar_produto();

-- Inserir produtos válidos
INSERT INTO tbproduto (pronome, propreco, proestoque) VALUES
('Produto A', 50.00, 10),
('Produto B', 30.00, 20),
('Produto C', 100.00, 5);

-- Atualizar estoque de Produto A
UPDATE tbproduto
   SET proestoque = 15
 WHERE pronome = 'Produto A';

-- Atualizar o preço de Produto B
UPDATE tbproduto
   SET propreco = 35.00
 WHERE pronome = 'Produto B';

-- Tentar inserir um produto com preço negativo
INSERT INTO tbproduto (pronome, propreco, proestoque) VALUES
('Produto D', -10.00, 10);

-- Tentar inserir um produto com nome vazio
INSERT INTO tbproduto (pronome, propreco, proestoque) VALUES
('', 25.00, 10);

-- Tentar atualizar o estoque de Produto C para acima do limite
UPDATE tbproduto
   SET proestoque = 150
 WHERE pronome = 'Produto C';

-- Modifique a tabela de produtos para manter um histórico de todas as
-- alterações de preço, incluindo data da alteração e
-- usuário que fez a mudança.

-- Sua tarefa: Criar a função e trigger para manter o histórico

CREATE TABLE tbhisproduto(
	hiscodigo SERIAL PRIMARY KEY,
	procodigo INTEGER REFERENCES tbproduto(procodigo),
	proprecoantigo DECIMAL(10,2) NOT NULL,
	propreconovo DECIMAL(10,2) NOT NULL,
	prodataalteracao TIMESTAMP,
	prousuario VARCHAR(50)
);

CREATE OR REPLACE FUNCTION fn_guardar_historico()
RETURNS TRIGGER AS $$
BEGIN

	INSERT INTO tbhisproduto
	VALUES (DEFAULT,
	        NEW.procodigo,
			OLD.propreco,
			NEW.propreco,
			CURRENT_TIMESTAMP,
			CURRENT_USER);

	RETURN NEW;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER tg_guardar_historico
	BEFORE UPDATE ON tbproduto
	FOR EACH ROW EXECUTE FUNCTION fn_guardar_historico();

INSERT INTO tbproduto (pronome, propreco, proestoque) VALUES
('Produto A', 50.00, 10),
('Produto B', 30.00, 20);

UPDATE tbproduto
   SET propreco = 55.00
 WHERE pronome = 'Produto A';

UPDATE tbproduto
   SET propreco = 35.00
 WHERE pronome = 'Produto B';

SELECT *
  FROM tbhisproduto
