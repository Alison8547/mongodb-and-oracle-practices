show databases; -- mostrar todos os databases
CREATE DATABASE universidade_u; -- criar um database

CREATE table ALUNO(
 nome varchar(25),
 idade int,
 sexo char(1),
 telefone varchar(20),
 endereco text,
 ativo_sn int,
 valor_pago_curso float(10,2),
 data_inscricao_curso date
); -- exemplo de criação de uma table

INSERT INTO ALUNO(nome,idade,sexo,telefone,endereco,ativo_sn,valor_pago_curso,data_inscricao_curso)
values('Alison',22,'M','81 99333-3422','rua do sol 334',1,433.22,'2018-12-11'); -- inserindo dados no banco


SELECT * FROM ALUNO a ;
SELECT nome,idade,sexo from ALUNO a ; -- selects basicos

SELECT nome,idade,sexo,valor_pago_curso from ALUNO a WHERE sexo = 'F' ; -- select com o where igual
SELECT nome,idade,sexo,valor_pago_curso from ALUNO a WHERE valor_pago_curso < 500.22 ; -- select com o where menor
SELECT nome,idade,sexo,valor_pago_curso from ALUNO a WHERE valor_pago_curso <= 500.22 ; -- select com o where menor igual
SELECT nome,idade,sexo,valor_pago_curso from ALUNO a WHERE valor_pago_curso > 2220.22 ; -- select com o where maior
SELECT nome,idade,sexo,valor_pago_curso from ALUNO a WHERE valor_pago_curso >= 2220.22 ; -- select com o where maior igual

-- operadores logicos AND, OR
SELECT nome,idade,sexo,valor_pago_curso,ativo_sn from ALUNO a WHERE sexo = 'F' AND ativo_sn = 1 AND idade > 25;
SELECT nome,idade,sexo,valor_pago_curso,ativo_sn from ALUNO a WHERE sexo = 'F' AND ativo_sn = 0;
SELECT nome,idade,sexo,valor_pago_curso,ativo_sn from ALUNO a WHERE sexo = 'F' OR idade > 34;

-- BETWEEN ENTRE OS VALORES PASSADOS. Mesma coisa que idade >= 20 AND idade <= 30
SELECT nome,idade,data_inscricao_curso FROM ALUNO a WHERE data_inscricao_curso BETWEEN '2018-12-01' AND  '2018-12-31';
SELECT nome,idade,data_inscricao_curso FROM ALUNO a WHERE idade BETWEEN 20 and 30;

SELECT * FROM ALUNO WHERE nome in('Valmir','Juri','Alison'); -- trás os valores correspodentes passados, podendo ser numero,string etc..Depende do valor da coluna
SELECT * FROM ALUNO WHERE nome not in('Valmir','Juri','Alison'); -- trás o valores não são esses passados no paramentro
SELECT * FROM ALUNO WHERE nome like('%a'); -- todos os nomes que termina com a
SELECT * FROM ALUNO WHERE nome like('j%'); -- todas os nomes que termina com j
SELECT * FROM ALUNO WHERE nome like('%lis%'); -- os nomes que contém lis na string
SELECT * FROM ALUNO WHERE nome like('g%a'); -- todas os nomes que começa com g e termina com a
-- undescore coringa dizendo uma posição especifica
SELECT * FROM ALUNO WHERE nome like('___i'); -- nome de tamanho 4 caracteres e no final i
SELECT * FROM ALUNO WHERE nome like('_lison'); 
SELECT * FROM ALUNO WHERE nome like('_l%'); -- 1 caractere na frente um l e depois não importando quantos tem no final
SELECT * FROM ALUNO WHERE nome like('__ri_'); -- 2 caractere e no 3 e 5 igual ri e no final 1 caractere

SELECT * FROM ALUNO a order by nome ASC ; -- do menor para o maior
SELECT * FROM ALUNO a order by nome DESC ; -- do maior para o menor
SELECT * FROM ALUNO a order by sexo ASC, idade DESC ;
-- Update
UPDATE ALUNO SET ativo_sn = 0 WHERE nome = 'Maria';
UPDATE ALUNO SET ativo_sn = 0,endereco = 'avenida mario gouveia' WHERE nome = 'Maria';
-- Delete
DELETE FROM ALUNO WHERE nome = 'Juri';
DELETE FROM ALUNO WHERE idade IN(20,16);

DESC ALUNO; -- nativa do mysql para ver as colunas
-- ADD
ALTER table ALUNO add cpf varchar(11);

ALTER table ALUNO add email varchar(150) after idade; -- adiciona a coluna email depois da coluna idade

-- MODIFY
ALTER table ALUNO MODIFY cpf varchar(14); -- modificar uma coluna já existente

-- DROP
ALTER table ALUNO DROP COLUMN cpf;

ALTER table ALUNO add cpf varchar(14) after email;

ALTER TABLE ALUNO add column idaluno int primary key auto_increment; -- adicionando uma chave primaria e dando um auto incremento

@ManyToOne == muitos telefones para um aluno, a carnialidade fica aqui. E na outra parte @OneToMany na table Aluno = Um aluno para muitos telefones
CREATE table TELEFONE(
	idtelefone int primary key auto_increment,
	numero varchar(20),
	tipo char(3),
	fk_idaluno int,
	FOREIGN KEY(fk_idaluno) REFERENCES ALUNO(idaluno) -- usando assim vc não dar nome a constraint e o banco de dados faz uma aleatorio
);

ALTER TABLE TELEFONE ADD CONSTRAINT fk_aluno_telefone
FOREIGN KEY(fk_idaluno) REFERENCES ALUNO(idAluno); -- usar melhor assim

CREATE TABLE CURSO(
 idcurso int primary key auto_increment,
 descricao varchar(50)
)
@ManyToMany
CREATE TABLE ALUNO_CURSO(
 id_alunocurso int auto_increment primary key,
 fk_idaluno int,
 fk_idcurso int
)

ALTER TABLE ALUNO_CURSO ADD CONSTRAINT fk_aluno_curso
FOREIGN KEY(fk_idaluno) REFERENCES ALUNO(idaluno);

ALTER TABLE ALUNO_CURSO ADD CONSTRAINT fk_curso_aluno
FOREIGN KEY(fk_idcurso) REFERENCES CURSO(idcurso);

-- tipos Enum fixos no sql
enum('cel','com','res') not null -- not null para não poder colocar valores null

ALTER TABLE ALUNO ADD CONSTRAINT uc_aluno_cpf UNIQUE(cpf); -- adicionando UNIQUE para dizer ao sql que não pode inserir valores repitidos

-- garantindo que minha carnalidade 1 para 1 não coloque valores repetidos, pq um aluno só pode ter um endereço
ALTER TABLE ENDERECO ADD CONSTRAINT uc_endereco_fkidaluno UNIQUE(fk_idaluno);

SELECT COUNT(*) FROM ALUNO a; -- count -> projeta o total de registros na tabela Aluno
SELECT COUNT(*) FROM ALUNO a WHERE sexo = 'F'; 
SELECT COUNT(DISTINCT sexo) FROM ALUNO a; -- distinct -> valores que não sejam iguais
SELECT MAX(valor_pago_curso) FROM ALUNO a; -- Maior valor dos valores de uma determinada coluna
SELECT MIN(valor_pago_curso) FROM ALUNO a; -- Menor valor dos valores de uma determinada coluna
SELECT AVG(valor_pago_curso) FROM ALUNO a; -- Média dos valores de uma determinada coluna
SELECT SUM(valor_pago_curso) FROM ALUNO a; -- Soma dos valores de uma determinada coluna

SELECT  -- pode ser feito assim também
  COUNT(*) as contagem, -- alias para renomear uma coluna na hora da visualização
	MAX(valor_pago_curso) as maior_valor,
	MIN(valor_pago_curso) as menor_valor,
	AVG(valor_pago_curso) as media,
	SUM(valor_pago_curso) as soma
		FROM ALUNO a WHERE ativo_sn != 0;		

SELECT valor_pago_curso as valor_pago,nome FROM ALUNO a;

-- arredonda pra cima
SELECT CEIL(17.25) as valor;

-- arredonda pra baixo
SELECT FLOOR(17.25) as valor;

-- trunca as casas decimas a partir do segundo parametro
SELECT TRUNCATE(24.3435677,2) as valor;

-- arredonda dependendo do: < 5 = para baixo e >= 5 para cima
SELECT ROUND(24.3475,2) as valor;

-- com as colunas
SELECT nome,CEIL(valor_pago_curso) as valor_pago FROM ALUNO a WHERE idaluno = 1;
SELECT ROUND(AVG(valor_pago_curso),2) as valor_pago FROM ALUNO a WHERE idaluno in(1,2,3,4,5);

-- agrupamento de registros

-- agrupando por sexo e a repeticão delas
SELECT 
	sexo,COUNT(*) as repeticao_por_agrupamento
FROM
	ALUNO a 
GROUP BY
	sexo;

-- agrupando por ativo_sn, sexo. E um count pra saber quanto temos
SELECT 
 ativo_sn,sexo,COUNT(*) as repeticao_por_agrupamento
FROM
 ALUNO a 
GROUP BY
	ativo_sn,sexo;

SELECT 
 ativo_sn,ROUND(AVG(valor_pago_curso),2) as media_por_agrupamento
FROM
 ALUNO a 
GROUP BY
	ativo_sn;

SELECT 
	sexo,FLOOR(AVG(idade)) as media_sexo_por_agrupamento
FROM
	ALUNO a 
GROUP BY
	sexo;

SELECT 
	sexo,MAX(idade) as maior_idade_por_agrupamento,MIN(idade) as menor_idade_por_agrupamento
FROM
	ALUNO a 
GROUP BY
	sexo;

SELECT 
	estado,COUNT(*) as repeticao_por_agrupamento
FROM
	ENDERECO e 
group by
    estado;
   
SELECT
 tipo, COUNT(*) as repeticao_por_agrupamento
FROM 
	TELEFONE t 
GROUP BY
 	tipo;
 	
 	CREATE TABLE GASTO(
	idgasto int primary key auto_increment,
	ano int not null,
	tipo enum('previsto','realizado') not null,
	jan float(10,2),
	fev float(10,2),
	mar float(10,2),
	abr float(10,2),
	mai float(10,2),
	jun float(10,2),
	jul float(10,2),
	ago float(10,2),
	`set` float(10,2), -- como set e out é uma palavra resevada do sgbd, utilizamos o crase pra ele saber q n é
	`out` float(10,2),
	nov float(10,2),
	dez float(10,2)
);

-- operações aritmeticas no sql
SELECT (544 + 100) as valor;
SELECT (544 - 100) as valor;
SELECT (544 * 100) as valor;
SELECT (544 / 100) as valor;

SELECT (jan + fev + mar + abr + mai + jun + jul + ago + `set` + `out`+  nov + dez) as total
FROM GASTO WHERE idgasto = 2;

SELECT TRUNCATE(((jan + fev + mar + abr + mai + jun + jul + ago + `set` + `out`+  nov + dez) / 12) , 2) as total
FROM GASTO WHERE idgasto = 2;


SELECT idgasto FROM GASTO g WHERE ano = 2019 AND tipo = 'previsto';
SELECT idgasto FROM GASTO g WHERE ano = 2019 AND tipo = 'realizado';
-- subquerys -> primeiro resolve as subquerys depois a de fora. geralmente colocamos subquerys no select e no where
SELECT
	(SELECT jan FROM GASTO g WHERE idgasto = (SELECT idgasto FROM GASTO g WHERE ano = 2019 AND tipo = 'previsto')) -
	(SELECT jan FROM GASTO g WHERE idgasto = (SELECT idgasto FROM GASTO g WHERE ano = 2019 AND tipo = 'realizado')) as resultado_jan,
	(SELECT fev FROM GASTO g WHERE idgasto = (SELECT idgasto FROM GASTO g WHERE ano = 2019 AND tipo = 'previsto')) -
	(SELECT fev FROM GASTO g WHERE idgasto = (SELECT idgasto FROM GASTO g WHERE ano = 2019 AND tipo = 'realizado')) as resultado_fev;
	
SELECT CURDATE(); 
SELECT CURTIME();
SELECT NOW();
SELECT DATE_FORMAT(CURDATE(),'%d/%m/%Y')

/* extrair parte de data */
SELECT EXTRACT(MONTH from '1993-12-11') as extract_date;
/* day, month ou year */

/* adicionando intervalos de tempo as datas */
SELECT DATE_ADD('1993-12-11', INTERVAL 4 DAY) as data_formatada; 
/* second, minute, hour, day, month, year */

SELECT NOW() as data_atual, DATE_ADD(NOW(), INTERVAL 10 YEAR) as data_formatada; 


/* calculo de dias entre datas */
SELECT '1998-05-11' as data_nascimento,CURDATE() as data_atual,
DATEDIFF(CURDATE(),'1998-05-11') as diferencia_dias,
FLOOR(DATEDIFF(CURDATE(),'1998-05-11') / 365) as anos_aproximadamente;

/* calculo de meses entre datas */
select period_diff('199504', '199402') as diferenca_meses;
    
/* dia do ano */
select dayofyear('2024-09-02') as dia_do_ano;

SELECT data_nascimento,CURDATE() as data_atual, timestampdiff(YEAR,data_nascimento ,CURDATE()) as idade
FROM ALUNO a; 

ALTER table ALUNO drop idade;

SELECT * FROM ALUNO a ;

UPDATE ALUNO SET data_nascimento = '2002-09-02' WHERE idaluno = 1;

-- pegar os alunos que esta fazendo aniversário
SELECT 
	idaluno,
	nome,
	data_nascimento,
	EXTRACT(DAY from data_nascimento) as data_nascimento_day,
	EXTRACT(MONTH from data_nascimento) as data_nascimento_month,
	DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Sao_Paulo')) as data_atual, -- horario do brasil
	EXTRACT(DAY from DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Sao_Paulo'))) as data_atual_day,
	EXTRACT(MONTH from DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Sao_Paulo'))) as data_atual_month,
	timestampdiff(YEAR,data_nascimento ,DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Sao_Paulo'))) as idade
FROM ALUNO a 
WHERE EXTRACT(DAY from data_nascimento) = EXTRACT(DAY from DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Sao_Paulo')))
	AND EXTRACT(MONTH from data_nascimento) = EXTRACT(MONTH from DATE(CONVERT_TZ(NOW(), @@session.time_zone, 'America/Sao_Paulo')));

ALTER TABLE ALUNO_CURSO ADD data_inscricao_curso date;
ALTER TABLE ALUNO_CURSO ADD valor_pago_curso float(10,2);

SELECT * FROM ALUNO_CURSO ac ;

UPDATE 
	ALUNO_CURSO 
SET
	data_inscricao_curso = (SELECT data_inscricao_curso FROM ALUNO WHERE idaluno = 5), -- subquery pra pegar os valores do aluno e passar certinho para a outra tabela
	valor_pago_curso = (SELECT valor_pago_curso FROM ALUNO WHERE idaluno = 5)
WHERE
 fk_idaluno = 5;

ALTER table ALUNO drop column data_inscricao_curso;
ALTER table ALUNO drop column valor_pago_curso;
