
USE universidade;

# Script para adicionar a coluna "capums" na tabela "alunos"

ALTER TABLE alunos ADD COLUMN capums VARCHAR(50);

# Popular a coluna "capums" com os dados correspondentes

UPDATE alunos SET capums = 'Goianesia' WHERE id IN (1, 2, 3, 4, 5);
UPDATE alunos SET capums = 'Anapolis' WHERE id IN (6, 7, 8, 9, 10);

# 01 Fragmentando campus

CREATE TABLE alunos_goianesia AS SELECT * FROM alunos WHERE capums = 'Goianesia';

CREATE TABLE alunos_anapolis AS SELECT * FROM alunos WHERE capums = 'Anapolis';

# 03 Criando uma  visão glogal dos fragmentos

CREATE VIEW alunos_global AS
SELECT * FROM alunos_goianesia
UNION ALL
SELECT * FROM alunos_anapolis;  

# 04 criando fragmento da tabela disciplinas

CREATE TABLE disciplinas_goianesia AS
SELECT DISTINCT d.*
FROM disciplinas d
JOIN matricula_disciplina md ON d.id = md.disciplina_id
JOIN matricula m ON md.matricula_id = m.id
JOIN alunos_goianesia a ON m.aluno_id = a.id;

CREATE TABLE disciplinas_anapolis AS
SELECT DISTINCT d.*
FROM disciplinas d
JOIN matricula_disciplina md ON d.id = md.disciplina_id
JOIN matricula m ON md.matricula_id = m.id
JOIN alunos_anapolis a ON m.aluno_id = a.id;

/* 05
A TABELA DISPLINAS PODE SER REPLICADA COMPLETAMENTE EM TODOS OS NÓS
CADA SERVIDOR POSSUI UMA CÓPIA COMPLETA DA TABELA DISCIPLINAS

UMA DAS VANTAGENS DE REPLICAÇÃO É QUE SE UM SERVIDOR FALHAR, OS
DADOS AINDA ESTARÃO DISPONÍVEIS NOS OUTROS SERVIDORES, 
GARANTINDO A CONTINUIDADE DO ACESSO ÀS INFORMAÇÕES. 

ALGUMAS DESVANTAGENS SÃO CONSTENCIA DE DADOS, SE ATUALIZAR UM NÓ PRECISA
ATUALIZAR TODOS OS OUTROS NÓS. CONFLITOS DE ATUALIZAÇÃO DOIS NÓS ALTERADOS
AO MESMO TEMPO, CUSTO DE MANUTENÇÃO, REPLICAÇÃO PODE AUMENTAR O CUSTO DE
MANUTENÇÃO DO SISTEMA.
*/



# TRANSAÇÃO DISTRIBUIDA 

# INSERIR MATRICULA

INSERT INTO matricula (aluno_id, curso_id, data_matricula, semestre) 
VALUES (10, 4, '2026-03-01', '2026.1');

# 06 INSERI DISCIPLINA
INSERT INTO matricula_disciplina (matricula_id, disciplina_id) VALUES (10, 1);

/* 07 FALHAS EM TRANSAÇÕES DISTRIBUÍDAS
POSSÍVEIS FALHAS E  IMPACTOS, FALHA DE NÓ, SE O NÓ QUE ESTÁ REALIZANDO 
A TRANSAÇÃO FALHAR, A TRANSAÇÃO PODE SER INTERROMPIDA E OS DADOS PODEM 
FICAR INCONSISTENTES.
FALHA DE COMUNICAÇÃO, SE HOUVER UM PROBLEMA DE COMUNICAÇÃO ENTRE OS NÓS
DURANTE A TRANSAÇÃO, OS DADOS PODEM FICAR INCONSISTENTES. 
FALHA DE CONCORRÊNCIA, SE VÁRIAS TRANSAÇÕES ESTIVEREM OCORRENDO AO MESMO 
TEMPO, PODE HAVER CONFLITOS DE ACESSO AOS DADOS, O QUE PODE LEVAR A INCONSISTÊNCIAS.
/*