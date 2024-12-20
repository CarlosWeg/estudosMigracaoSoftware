-- Crie um trigger que calcule e atualize automaticamente a média
-- do aluno sempre que uma nova nota for registrada.

CREATE TABLE alunos_notas (
    id SERIAL PRIMARY KEY,
    aluno_id INTEGER,
    disciplina_id INTEGER,
    media_atual DECIMAL(4,2)
);

CREATE TABLE notas (
    id SERIAL PRIMARY KEY,
    aluno_id INTEGER,
    disciplina_id INTEGER,
    nota DECIMAL(4,2),
    data_avaliacao DATE
);


CREATE OR REPLACE FUNCTION fn_atualizar_media()
RETURNS TRIGGER AS $$
DECLARE
	v_media DECIMAL(4,2);
BEGIN

	IF TG_OP = 'INSERT' THEN

		SELECT AVG(nota)
		  INTO v_media
		  FROM notas
		 WHERE aluno_id = NEW.aluno_id;

		UPDATE alunos_notas
		   SET media_atual = v_media
		 WHERE aluno_id = NEW.aluno_id;

	END IF;

	RETURN NEW;


END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_atualizar_media
	AFTER INSERT ON notas
	FOR EACH ROW EXECUTE FUNCTION fn_atualizar_media();

INSERT INTO alunos_notas (aluno_id, disciplina_id, media_atual) VALUES
(1, 101, 0),
(2, 102, 0),
(3, 103, 0);

-- Notas para o aluno 1 na disciplina 101
INSERT INTO notas (aluno_id, disciplina_id, nota, data_avaliacao) VALUES
(1, 101, 8.0, '2024-01-15'),
(1, 101, 7.5, '2024-02-15'),
(1, 101, 9.0, '2024-03-15');

-- Notas para o aluno 2 na disciplina 102
INSERT INTO notas (aluno_id, disciplina_id, nota, data_avaliacao) VALUES
(2, 102, 6.0, '2024-01-20'),
(2, 102, 5.5, '2024-02-20'),
(2, 102, 7.0, '2024-03-20');

-- Notas para o aluno 3 na disciplina 103
INSERT INTO notas (aluno_id, disciplina_id, nota, data_avaliacao) VALUES
(3, 103, 10.0, '2024-01-25'),
(3, 103, 9.5, '2024-02-25'),
(3, 103, 10.0, '2024-03-25');

SELECT *
  FROM alunos_notas;

-- Crie um trigger que, antes de excluir um funcionário,
-- guarde seus dados em uma tabela de funcionários desligados,
-- incluindo a data e motivo do desligamento.

CREATE TABLE funcionarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    cargo VARCHAR(50),
    salario DECIMAL(10,2),
    data_admissao DATE
);

CREATE TABLE funcionarios_desligados (
    id SERIAL PRIMARY KEY,
    funcionario_id INTEGER,
    nome VARCHAR(100),
    cargo VARCHAR(50),
    salario DECIMAL(10,2),
    data_admissao DATE,
    data_desligamento DATE,
    motivo_desligamento TEXT
);

CREATE OR REPLACE FUNCTION fn_salvar_funcionario_desligado()
RETURNS TRIGGER AS $$
BEGIN

	INSERT INTO funcionarios_desligados
	VALUES (DEFAULT,
	        OLD.id,
	        OLD.nome,
			OLD.cargo,
			OLD.salario,
			OLD.data_admissao,
			CURRENT_DATE,
			TG_ARGV[0]);

	RETURN OLD;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER tg_salvar_funcionario_desligado
	BEFORE DELETE ON funcionarios
	FOR EACH ROW EXECUTE FUNCTION fn_salvar_funcionario_desligado('Corte de gastos');

INSERT INTO funcionarios (nome, cargo, salario, data_admissao) VALUES
('João Silva', 'Analista', 4500.00, '2020-01-10'),
('Maria Oliveira', 'Gerente', 7500.00, '2018-06-15'),
('Pedro Santos', 'Desenvolvedor', 6000.00, '2019-03-22');

DELETE
  FROM funcionarios
 WHERE id = 1;

SELECT *
  FROM funcionarios_desligados;