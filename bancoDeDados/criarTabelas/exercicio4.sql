-- Criar um Banco de Dados Completo

-- Desenvolva um pequeno sistema de gestão de biblioteca com as seguintes tabelas:

-- livros:
-- id (chave primária).
-- titulo (texto, obrigatório).
-- autor (texto).
-- ano_publicacao (inteiro).
-- disponivel (booleano, padrão: TRUE).

-- usuarios:
-- id (chave primária).
-- nome (texto, obrigatório).
-- email (texto, único).

-- emprestimos:
-- id (chave primária).
-- usuario_id (chave estrangeira referenciando usuarios).
-- livro_id (chave estrangeira referenciando livros).
-- data_emprestimo (data, padrão: data atual).
-- data_devolucao (data).

-- Extras:
-- Adicione restrições para que o usuario_id e o livro_id sejam únicos na tabela emprestimos.
-- Insira dados de exemplo em cada tabela e execute consultas que verifiquem quais livros estão disponíveis.

CREATE TABLE tblivros(
	id_livro SERIAL PRIMARY KEY,
	titulo_livro TEXT NOT NULL,
	autor TEXT,
	ano_publicacao INT,
	disponivel BOOLEAN DEFAULT TRUE
);

CREATE TABLE tbusuarios(
	id_usuario SERIAL PRIMARY KEY,
	nome TEXT NOT NULL,
	email TEXT UNIQUE
);

CREATE TABLE tbemprestimos(
	id_emprestimo SERIAL PRIMARY KEY,
	id_usuario INT REFERENCES tbusuarios(id_usuario),
	id_livro INT REFERENCES tblivros(id_livro),
	data_emprestimo DATE DEFAULT CURRENT_DATE,
	data_devolucao DATE
);

ALTER TABLE tbemprestimos
	ADD CONSTRAINT unique_usuario_livro UNIQUE (id_usuario,id_livro);


INSERT INTO tblivros
	   (titulo_livro,autor,ano_publicacao,disponivel)
VALUES ('1984','George Orwell', 1949,TRUE);

INSERT INTO tbusuarios
	   (nome,email)
VALUES ('Carlos','carlos@gmail.com');

INSERT INTO tbemprestimos
	   (id_usuario,id_livro,data_emprestimo)
VALUES (1,1,'2024-12-20');