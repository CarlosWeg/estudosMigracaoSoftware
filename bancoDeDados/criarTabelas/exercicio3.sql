-- Tabela com Relacionamento
-- Crie um sistema de gerenciamento de cursos:

-- Tabela cursos com:
-- id (chave primária).
-- nome (texto, obrigatório).
-- carga_horaria (inteiro, obrigatório).
-- Tabela alunos com:
-- id (chave primária).
-- nome (texto, obrigatório).
-- email (texto, único).

-- Tabela matriculas para relacionar alunos e cursos:
-- id (chave primária).
-- aluno_id (chave estrangeira referenciando alunos).
-- curso_id (chave estrangeira referenciando cursos).
-- data_matricula (data, padrão: data atual).

-- Alterações em Massa
-- Após criar a tabela cursos, altere todas as seguintes características:

-- Adicione uma coluna ativo (booleano, padrão: TRUE).
-- Renomeie a coluna carga_horaria para duracao_horas.
-- Defina que nome deve ser único.

CREATE TABLE tbcursos(
	id_curso SERIAL PRIMARY KEY,
	nome_curso TEXT NOT NULL,
	carga_horaria INT NOT NULL
);

CREATE TABLE tbalunos(
	id_aluno SERIAL PRIMARY KEY,
	nome TEXT NOT NULL,
	email TEXT UNIQUE
);

CREATE TABLE tbmatriculas(
	id_matricula SERIAL PRIMARY KEY,
	id_aluno INT REFERENCES tbalunos(id_aluno),
	id_curso INT REFERENCES tbcursos(id_curso),
	data_matricula DATE DEFAULT CURRENT_DATE
);

ALTER TABLE tbcursos
	ADD COLUMN ativo BOOLEAN DEFAULT TRUE;

ALTER TABLE tbcursos
	RENAME carga_horaria TO duracao_horas;

ALTER TABLE tbcursos
	ADD CONSTRAINT unique_nome_curso UNIQUE(nome_curso);