DROP DATABASE IF EXISTS escola;
CREATE DATABASE escola;
\c escola;

DROP TABLE IF EXISTS aluno CASCADE;
DROP TABLE IF EXISTS professor CASCADE;
DROP TABLE IF EXISTS departamento CASCADE;
DROP TABLE IF EXISTS curso CASCADE;
DROP TABLE IF EXISTS matricula CASCADE;
DROP TABLE IF EXISTS disciplina CASCADE;
DROP TABLE IF EXISTS cursa CASCADE;
DROP TABLE IF EXISTS compoe CASCADE;
DROP TABLE IF EXISTS pre_req CASCADE;

-- Create tables

CREATE TABLE aluno(
	cpf varchar(15) NOT NULL,
	nome varchar(255) NOT NULL,
	endereco varchar(255) NOT NULL,
	telefone varchar(25),
	data_nasc date NOT NULL
);

CREATE TABLE professor(
	matricula varchar(50) NOT NULL,
	nome varchar(255) NOT NULL,
	endereco varchar(255) NOT NULL,
	telefone varchar(25),
	data_nasc date  NOT NULL,
	codigo_dpto varchar(20) NOT NULL,
	data_contratacao date NOT NULL
);

CREATE TABLE departamento(
	codigo varchar(20) NOT NULL,
	nome varchar(255) NOT NULL
);

CREATE TABLE curso(
	codigo varchar(20) NOT NULL,
	nome varchar(255) NOT NULL,
	descricao varchar(255) NOT NULL,
	codigo_dpto varchar(20) NOT NULL
);

CREATE TABLE matricula(
	codigo_curso varchar(20) NOT NULL,
	cpf_aluno varchar(15) NOT NULL,
	data_matricula date NOT NULL
);

CREATE TABLE disciplina(
	codigo varchar(20) NOT NULL,
	nome varchar(50) NOT NULL,
	qtde_creditos smallint NOT NULL,
	matricula_prof varchar(50) NOT NULL
);

CREATE TABLE cursa(
	cpf_aluno varchar(15) NOT NULL,
	codigo_disc varchar(20) NOT NULL		
);

CREATE TABLE compoe(
	codigo_curso varchar(20) NOT NULL,
	codigo_disc varchar(20) NOT NULL
);

CREATE TABLE pre_req(
	codigo_discp varchar(20) NOT NULL,
	codigo_discp_dependencia varchar(20) NOT NULL
);

-- Definir PK's e FK's
-- PK Tabela aluno
ALTER TABLE aluno
    ADD CONSTRAINT cpf_pk PRIMARY KEY (cpf);

-- PK Tabela departamento
ALTER TABLE departamento
    ADD CONSTRAINT codigo_dpto_pk PRIMARY KEY (codigo);

-- PK Tabela curso
ALTER TABLE curso
    ADD CONSTRAINT codigo_curso_pk PRIMARY KEY (codigo),
	ADD CONSTRAINT codigo_dpto_fk
		FOREIGN KEY (codigo_dpto)
			REFERENCES departamento(codigo)
				ON DELETE CASCADE;

-- PK Tabela professor
ALTER TABLE professor
    ADD CONSTRAINT matricula_pk PRIMARY KEY (matricula),
	ADD CONSTRAINT codigo_dpto_fk
		FOREIGN KEY (codigo_dpto)
			REFERENCES departamento(codigo)
				ON DELETE CASCADE;

-- PK Tabela disciplina
ALTER TABLE disciplina
    ADD CONSTRAINT codigo_disc_pk PRIMARY KEY (codigo);
		
-- FK's Tabela matricula
ALTER TABLE matricula
	ADD CONSTRAINT codigo_curso_fk 
		FOREIGN KEY (codigo_curso) 
			REFERENCES curso(codigo)
				ON DELETE CASCADE,
	ADD CONSTRAINT cpf_aluno_fk 
		FOREIGN KEY (cpf_aluno ) 
			REFERENCES aluno(cpf)
				ON DELETE CASCADE;

-- FK's Tabela cursa
ALTER TABLE cursa
	ADD CONSTRAINT cfp_aluno_fk
		FOREIGN KEY (cpf_aluno)
			REFERENCES aluno(cpf)
				ON DELETE CASCADE,
	ADD CONSTRAINT codigo_disc_fk
		FOREIGN KEY (codigo_disc)
			REFERENCES disciplina(codigo)
				ON DELETE CASCADE;
				
-- FK's Tabela compoe
ALTER TABLE compoe
	ADD CONSTRAINT codigo_curso_fk 
		FOREIGN KEY (codigo_curso) 
			REFERENCES curso(codigo)
				ON DELETE CASCADE,
	ADD CONSTRAINT codigo_disc_fk
		FOREIGN KEY (codigo_disc)
			REFERENCES disciplina(codigo)
				ON DELETE CASCADE;	
	
-- FK's Tabela pre-req
ALTER TABLE pre_req
	ADD CONSTRAINT codigo_curso_fk 
		FOREIGN KEY (codigo_discp) 
			REFERENCES disciplina(codigo)
				ON DELETE CASCADE,
	ADD CONSTRAINT codigo_discp_dependencia_fk
		FOREIGN KEY (codigo_discp_dependencia)
			REFERENCES disciplina(codigo)
				ON DELETE CASCADE;	
				
-- Populate tabelas from csv files. Root -> C:\temp
-- Tabela aluno
COPY aluno(cpf, nome, endereco, telefone, data_nasc)
FROM 'C:\temp\aluno.csv'
ENCODING 'latin1'
DELIMITER ','
CSV HEADER;

-- Tabela departamento
COPY departamento(codigo, nome)
FROM 'C:\temp\departamento.csv'
ENCODING 'latin1'
DELIMITER ','
CSV HEADER;

-- Tabela professor
COPY professor(matricula, nome, endereco, telefone, data_nasc, codigo_dpto, data_contratacao)
FROM 'C:\temp\professor.csv'
ENCODING 'latin1'
DELIMITER ','
CSV HEADER;

-- Tabela curso
COPY curso(codigo, nome, descricao, codigo_dpto)
FROM 'C:\temp\curso.csv'
ENCODING 'latin1'
DELIMITER ','
CSV HEADER;

-- Tabela matricula
COPY matricula(codigo_curso, cpf_aluno, data_matricula)
FROM 'C:\temp\matricula_aluno.csv'
ENCODING 'latin1'
DELIMITER ','
CSV HEADER;

-- Tabela disciplina
COPY disciplina(codigo, nome, qtde_creditos, matricula_prof)
FROM 'C:\temp\disciplina.csv'
ENCODING 'latin1'
DELIMITER ','
CSV HEADER;

-- Tabela cursa
COPY cursa(cpf_aluno, codigo_disc)
FROM 'C:\temp\cursa_disc.csv'
ENCODING 'latin1'
DELIMITER ','
CSV HEADER;

-- Tabela compoe
COPY compoe(codigo_curso, codigo_disc)
FROM 'C:\temp\compoe_curso.csv'
ENCODING 'latin1'
DELIMITER ','
CSV HEADER;

-- Tabela pre_req
COPY pre_req(codigo_discp, codigo_discp_dependencia)
FROM 'C:\temp\pre_req.csv'
ENCODING 'latin1'
DELIMITER ','
CSV HEADER;


-- Comandos de inserção
-- Tabela aluno
INSERT INTO aluno(cpf, nome, endereco, telefone, data_nasc)
VALUES ('99887766551', 'Adam Smith', 'Rua De La Casa Grande, 123', '11-90000-8888', '2000-01-01');
/*
select * from aluno
where nome = 'Adam Smith';

update aluno
set telefone = '+55 11-44444-5555'
where nome = 'Adam Smith';

delete from aluno
where nome = 'Adam Smith';
*/

-- Tabela departamento
INSERT INTO departamento(codigo, nome)
VALUES ('88', 'Aeroespacial');
/*
select * from departamento;

delete from departamento
where codigo = '88'
*/

-- Tabela professor
INSERT INTO professor(matricula, nome, endereco, telefone, data_nasc, codigo_dpto, data_contratacao)
VALUES ('99', 'Mario Moreno Cantinflas', 'Rodrigues Pena 1080, Buenos Aires', '+54 11 33333-1010', '1960-08-20', '9', '2000-10-15');
/*
select * from professor
where matricula = '99';

delete from professor
where matricula = '99';
*/

-- Tabela curso
INSERT INTO curso(codigo, nome, descricao, codigo_dpto)
VALUES ('33', 'Ciência de dados', 'Análise de big data, machine learning, deep learning', '3');
/*
select * from curso
where codigo = '33';

delete from curso
where codigo = '33';
*/

-- Tabela matricula
INSERT INTO matricula(codigo_curso, cpf_aluno, data_matricula)
VALUES ('10', '05020555555', '2022-04-22');
/*
select * from matricula
where data_matricula = '2022-04-22';

delete from matricula
where data_matricula = '2022-04-22';
*/

-- Tabela disciplina
INSERT INTO disciplina(codigo, nome, qtde_creditos, matricula_prof)
VALUES ('50', 'Machine learning', '5', '3');
/*
select * from disciplina
where codigo = '50';

delete from disciplina
where codigo = '50';
*/

-- Tabela cursa
INSERT INTO cursa(cpf_aluno, codigo_disc)
VALUES ('05020555555', '32');
/*
select * from cursa
where cpf_aluno = '05020555555';

delete from cursa
where cpf_aluno = '05020555555' and codigo_disc = '32';
*/

-- Tabela compoe
INSERT INTO compoe(codigo_curso, codigo_disc)
VALUES ('10', '23' );
/*
select * from compoe
where codigo_curso = '10';

delete from compoe
where codigo_curso = '10' and codigo_disc = '23';
*/

-- Tabela pre_req
INSERT INTO pre_req(codigo_discp, codigo_discp_dependencia)
VALUES ('38', '35')
/*
select * from pre_req
where codigo_discp = '38';

delete from pre_req
where codigo_discp = '38' and codigo_discp_dependencia = '35';
*/

