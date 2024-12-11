-- Crie um banco de dados para gerenciar o envolvimento de funcionários em projetos realizados por empresas parceiras.
-- Tarefas:

-- Crie as tabelas Funcionarios, Projetos, Empresas e uma tabela intermediária Participacoes.

-- Insira registros para 3 funcionários, 3 projetos e 2 empresas.

-- Relacione as participações, indicando qual funcionário participou de qual projeto para qual empresa.

-- Escreva consultas SQL para:
-- Listar todos os projetos em que um funcionário específico trabalhou.
-- Exibir quais empresas estão associadas a um projeto específico.
-- Listar todos os funcionários e os projetos em que participaram, agrupados por empresa.

CREATE TABLE tbfuncionarios(
	funcodigo SERIAL PRIMARY KEY,
	funnome TEXT NOT NULL
);

CREATE TABLE tbprojetos(
	procodigo SERIAL PRIMARY KEY,
	pronome TEXT NOT NULL
);

CREATE TABLE tbempresas(
	empcodigo SERIAL PRIMARY KEY,
	empnome TEXT NOT NULL
);

CREATE TABLE tbparticipacoes(
	parcodigo SERIAL PRIMARY KEY,
	funcodigo INT REFERENCES tbfuncionarios(funcodigo),
	procodigo INT REFERENCES tbprojetos(procodigo),
	empcodigo INT REFERENCES tbempresas(empcodigo)
);

INSERT INTO tbfuncionarios
       (funnome)
VALUES ('Carlos Henrique'),
       ('Ana Beatriz'),
       ('Marcos Vinícius');

INSERT INTO tbprojetos
       (pronome)
VALUES ('Desenvolvimento Web'),
       ('Sistema de Gestão'),
       ('Aplicativo Mobile');

INSERT INTO tbempresas
       (empnome)
VALUES ('Tech Solutions'),
       ('InovaTech');

INSERT INTO tbparticipacoes
      (funcodigo, procodigo, empcodigo)
VALUES
		(1, 1, 1),
		(2, 2, 1),
		(3, 3, 2),
		(1, 2, 2),
		(2, 3, 1);

SELECT fun.funnome,
       pro.procodigo,
       pro.pronome
  FROM tbprojetos pro
 INNER JOIN tbparticipacoes par ON pro.procodigo = par.procodigo
 INNER JOIN tbfuncionarios fun on par.funcodigo = fun.funcodigo
 WHERE fun.funnome ILIKE '%CARLOS%';

SELECT emp.empcodigo,
       emp.empnome,
	   pro.procodigo,
	   pro.pronome
 FROM tbparticipacoes par
INNER JOIN tbempresas emp ON par.empcodigo = emp.empcodigo
INNER JOIN tbprojetos pro ON par.procodigo = pro.procodigo

SELECT emp.empcodigo,
       emp.empnome,
       fun.funcodigo,
       fun.funnome,
	   pro.procodigo,
	   pro.pronome
  FROM tbparticipacoes par
 INNER JOIN tbempresas emp ON par.empcodigo = emp.empcodigo
 INNER JOIN tbprojetos pro ON par.procodigo = pro.procodigo
 INNER JOIN tbfuncionarios fun ON par.funcodigo = fun.funcodigo
 ORDER BY emp.empnome, fun.funnome, pro.pronome