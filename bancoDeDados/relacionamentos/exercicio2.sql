-- Muitos-para-Muitos (M:N): Biblioteca

-- Crie um banco de dados para gerenciar os livros emprestados a leitores em uma biblioteca.
-- Tarefas:

-- Crie as tabelas Leitores, Livros e uma tabela intermediária Emprestimos.

-- Insira registros
-- Registre quais leitores emprestaram quais livros.

-- Escreva consultas SQL para:
-- Listar todos os livros emprestados por um leitor específico.
-- Listar todos os leitores que emprestaram um determinado livro.


CREATE TABLE tbleitores(
	leicodigo SERIAL PRIMARY KEY,
	leinome TEXT NOT NULL,
	leiemail TEXT NOT NULL
);

CREATE TABLE tblivros(
	livcodigo SERIAL PRIMARY KEY,
	livnome TEXT NOT NULL,
	livautor TEXT NOT NULL
);

CREATE TABLE tbemprestimos(
	empcodigo SERIAL PRIMARY KEY,
	livcodigo INT REFERENCES tblivros(livcodigo),
	leicodigo INT REFERENCES tbleitores(leicodigo),
	empdata DATE DEFAULT CURRENT_DATE NOT NULL
);

INSERT INTO tbleitores
       (leinome,leiemail)
VALUES ('Carlos','carlos@gmail.com'),
	   ('Maria','maria@gmail.com');


INSERT INTO tblivros
       (livnome,livautor)
VALUES ('O pequeno princeso','Jonas Augusto'),
	   ('A volta dos que não foram','Carlos Mirnx');

INSERT INTO tbemprestimos
       (livcodigo,leicodigo)
VALUES (1,2),
       (2,1);


SELECT li.livcodigo,
       li.livnome,
	   li.livautor,
	   le.leinome
  FROM tblivros li
 INNER JOIN tbemprestimos em ON li.livcodigo = em.livcodigo
 INNER JOIN tbleitores le ON em.leicodigo = le.leicodigo
 WHERE le.leinome ILIKE '%Carlos%';

SELECT le.leicodigo,
       le.leinome,
       le.leiemail,
       li.livnome
  FROM tbleitores le
 INNER JOIN tbemprestimos em ON le.leicodigo = em.leicodigo
 INNER JOIN tblivros li ON em.livcodigo = li.livcodigo
 WHERE li.livnome ILIKE '%O pequeno princeso%';