-- Sistema de Prescrições Médicas


-- Crie um banco de dados para gerenciar prescrições de medicamentos, considerando médicos, pacientes e medicamentos.

-- Tarefas:

-- Crie as tabelas Medicos, Pacientes, Medicamentos e uma tabela intermediária Prescricoes.

-- Insira registros


CREATE TABLE tbmedicos(
	medcodigo SERIAL PRIMARY KEY,
	mednome TEXT NOT NULL,
	medcrm VARCHAR NOT NULL
);

CREATE TABLE tbpacientes(
	paccodigo SERIAL PRIMARY KEY,
	pacnome TEXT NOT NULL,
	pactelefone VARCHAR NOT NULL
);

CREATE TABLE tbremedios(
	remcodigo SERIAL PRIMARY KEY,
	remnome TEXT NOT NULL
);

CREATE TABLE tbprescricoes(
	prescodigo SERIAL PRIMARY KEY,
	medcodigo INT REFERENCES tbmedicos(medcodigo),
	paccodigo INT REFERENCES tbpacientes(paccodigo),
	remcodigo INT REFERENCES tbremedios(remcodigo),
	data_prescricao DATE NOT NULL DEFAULT CURRENT_DATE
);

INSERT INTO tbpacientes
	   (pacnome,pactelefone)
VALUES ('Lucas','479924121');

INSERT INTO tbmedicos
       (mednome,medcrm)
VALUES ('Augusto','231321'),
	   ('Jonas','312313');

INSERT INTO tbremedios
	   (remnome)
VALUES ('Paracetamol'),
       ('Dipirona');

INSERT INTO tbprescricoes
	   (medcodigo,paccodigo,remcodigo)
VALUES (2,1,2);