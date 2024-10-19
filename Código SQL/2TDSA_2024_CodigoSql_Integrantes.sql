-- INTEGRANTES
-- Leonardo Bruno de Sousa - RM552408
-- João Vito Santiago da Silva - RM86293
-- Marco Antônio de Araújo - RM550128
-- Vinicius Andrade Lopes - RM99343 
-- Renan Vieira de Jesus - RM551813

-- INTEGRANTES

set serveroutput on
set verify off

-- DROPS
drop table T_IS_TRIAGEM cascade constraints;
drop table T_IS_EXAME cascade constraints;
drop table T_IS_FUNCIONARIO cascade constraints;
drop table T_IS_UNID_HOSPITALAR cascade constraints;
drop table T_IS_PACIENTE cascade constraints;
drop table T_IS_USUARIO cascade constraints;
drop table T_IS_ENDERECO cascade constraints;
drop table T_IS_AUDITORIA cascade constraints;
-- DROPS

-- SEQUENCES
DROP SEQUENCE seq_usuario;
DROP SEQUENCE seq_unid_hospitalar;
DROP SEQUENCE seq_funcionario;
DROP SEQUENCE seq_paciente;
DROP SEQUENCE seq_endereco;
DROP SEQUENCE seq_triagem;
DROP SEQUENCE seq_exame;
DROP SEQUENCE seq_auditoria;

CREATE SEQUENCE seq_usuario
    start with 1
    increment by 1
    minvalue 1
    maxvalue 1000
    nocycle;
    
CREATE SEQUENCE seq_unid_hospitalar
    start with 1
    increment by 1
    minvalue 1
    maxvalue 1000
    nocycle;
    
CREATE SEQUENCE seq_funcionario
    start with 1
    increment by 1
    minvalue 1
    maxvalue 1000
    nocycle;

CREATE SEQUENCE seq_paciente
    start with 1
    increment by 1
    minvalue 1
    maxvalue 1000
    nocycle;
    
CREATE SEQUENCE seq_endereco
    start with 1
    increment by 1
    minvalue 1
    maxvalue 1000
    nocycle;
    
CREATE SEQUENCE seq_triagem
    start with 1
    increment by 1
    minvalue 1
    maxvalue 1000
    nocycle;
    
CREATE SEQUENCE seq_exame
    start with 1
    increment by 1
    minvalue 1
    maxvalue 1000
    nocycle;
    
CREATE SEQUENCE seq_auditoria
    start with 1
    increment by 1
    minvalue 1
    maxvalue 1000
    nocycle;
-- SEQUENCES

-- TABLES
create table T_IS_USUARIO(
    id_usuario char(9),
    cd_senha varchar(80) not null,
    cd_login varchar(80) not null,
    PRIMARY KEY (id_usuario)
);

create table T_IS_ENDERECO(
    id_endereco char(9),
    nm_estado varchar(80) not null,
    nm_municipio varchar(80) not null,
    nm_logradouro varchar(80) not null,
    nr_numero_residencial numeric(9) not null,
    ds_complemento varchar(80),
    nr_cep varchar(8) not null,
    PRIMARY KEY (id_endereco)
);

create table T_IS_UNID_HOSPITALAR(
    id_unid_hospitalar char(9),
    nr_cnpj numeric(14) not null,
    nm_razao_social varchar(80) not null,
    id_usuario char(9) not null,
    PRIMARY KEY (id_unid_hospitalar),
    FOREIGN KEY(id_usuario) REFERENCES T_IS_USUARIO(id_usuario)
);

create table T_IS_FUNCIONARIO(
    id_funcionario char(9),
    nm_funcionario varchar(80) not null,
    nr_cpf varchar(14) not null,
    ds_email varchar(80),
    id_unid_hospitalar char(9),
    primary key(id_funcionario),
    FOREIGN KEY(id_unid_hospitalar) REFERENCES T_IS_UNID_HOSPITALAR(id_unid_hospitalar)
);

create table T_IS_PACIENTE(
    id_paciente char(9),
    nm_paciente varchar(80) not null,
    nr_cpf varchar(15) not null,
    ds_email varchar(80) not null,
    nr_rg numeric(9) not null,
    tp_sexo char(1) not null,
    nm_filiacao_paterna varchar(80),
    nm_filiacao_materna varchar(80) not null,
    id_usuario char(9) not null,
    id_endereco char(9) not null,
    primary key(id_paciente),
    FOREIGN KEY(id_usuario) REFERENCES T_IS_USUARIO(id_usuario),
    FOREIGN KEY(id_endereco) REFERENCES T_IS_ENDERECO(id_endereco)
);

create table T_IS_TRIAGEM(
    id_triagem char(9),
    dt_inicio date not null,
    dt_final date not null,
    st_triagem char(1) not null,
    ds_sintomas varchar(80) not null,
    id_paciente char(9) not null,
    primary key (id_triagem),
    FOREIGN KEY(id_paciente) REFERENCES T_IS_PACIENTE(id_paciente)
);

create table T_IS_EXAME(
    id_exame char(9),
    dt_exame date not null,
    ds_resultado varchar(220) not null,
    id_paciente char(9) not null,
    id_funcionario char(9) not null,
    primary key(id_exame),
    FOREIGN KEY(id_paciente) REFERENCES T_IS_PACIENTE(id_paciente),
    FOREIGN KEY(id_funcionario) REFERENCES T_IS_FUNCIONARIO(id_funcionario)
);

CREATE TABLE T_IS_AUDITORIA (
    ID_AUDITORIA NUMBER PRIMARY KEY,
    TABELA_AUDITADA VARCHAR2(50),
    OPERACAO VARCHAR2(10),
    USUARIO VARCHAR2(50),
    DATA_OPERACAO DATE,
    OLD_DATA VARCHAR2(250),
    NEW_DATA VARCHAR2(250)
);
--TABLES


-- Procedures INSERTS

-- USUARIO
CREATE OR REPLACE PROCEDURE insert_user(cd_senha in varchar, cd_login in varchar) IS
BEGIN 
    INSERT INTO T_IS_USUARIO (id_usuario, cd_senha, cd_login) VALUES (seq_usuario.nextval,cd_senha, cd_login);
    COMMIT;
END;


CREATE OR REPLACE PROCEDURE insert_user_sprint1 AS
BEGIN
    insert_user('senha123', 'usuario1');
    insert_user('senha456', 'usuario2');
    insert_user('senha789', 'usuario3');
    insert_user('senhaabc', 'usuario4');
    insert_user('senhadef', 'usuario5');
END;

-- USUARIO

-- ENDERECO
CREATE OR REPLACE PROCEDURE insert_endereco (nm_estado in varchar, nm_municipio in varchar, nm_logradouro in varchar, nr_numero_residencial in numeric, ds_complemento in varchar, nr_cep in varchar) 
IS
BEGIN
    INSERT INTO T_IS_ENDERECO (id_endereco, nm_estado, nm_municipio, nm_logradouro, nr_numero_residencial, ds_complemento, nr_cep)  VALUES (seq_endereco.nextval,nm_estado, nm_municipio, nm_logradouro, nr_numero_residencial, ds_complemento , nr_cep);
    COMMIT;
END;

CREATE OR REPLACE PROCEDURE insert_endereco_sprint1 AS
BEGIN
    insert_endereco('Estado1', 'Municipio1', 'Rua A', 123, 'Apto 101', '12345678');
    insert_endereco('Estado2', 'Municipio2', 'Rua B', 456, 'Casa 2', '87654321');
    insert_endereco('Estado3', 'Municipio3', 'Rua C', 789, NULL, '13579246');
    insert_endereco('Estado4', 'Municipio4', 'Rua D', 101112, 'Loja 5', '98765432');
    insert_endereco('Estado5', 'Municipio5', 'Rua E', 131415, 'Bloco B', '24681357');
END;


-- ENDERECO

-- UNIDADE HOSPITALAR
CREATE OR REPLACE PROCEDURE insert_unidade_hospitalar (nr_cnpj in numeric, nm_razao_social in varchar, id_usuario in char) 
IS
BEGIN
    INSERT INTO T_IS_UNID_HOSPITALAR (id_unid_hospitalar, nr_cnpj, nm_razao_social, id_usuario) VALUES (seq_unid_hospitalar.nextval,nr_cnpj, nm_razao_social, id_usuario);
    COMMIT;
END;

CREATE OR REPLACE PROCEDURE insert_unid_hospitalar_sprint1 AS
BEGIN
    insert_unidade_hospitalar(12345678901234, 'Razao Social 1', 1);
    insert_unidade_hospitalar(98765432109876, 'Razao Social 2', 2);
    insert_unidade_hospitalar(11112222333344, 'Razao Social 3', 3);
    insert_unidade_hospitalar(44443333222211, 'Razao Social 4', 4);
    insert_unidade_hospitalar(55556666777788, 'Razao Social 5', 5);
END;


-- Funcionário
CREATE OR REPLACE PROCEDURE insert_funcionario (nm_funcionario in varchar, nr_cpf in varchar, ds_email in varchar, id_unid_hospitalar in char) 
IS
BEGIN
    INSERT INTO T_IS_FUNCIONARIO (id_funcionario, nm_funcionario, nr_cpf, ds_email, id_unid_hospitalar) VALUES (seq_funcionario.nextval, nm_funcionario, nr_cpf, ds_email, id_unid_hospitalar);
    COMMIT;
END;

CREATE OR REPLACE PROCEDURE insert_funcionario_sprint1 AS
BEGIN
    insert_funcionario('Funcion?rio 1', 12345678901, 'funcionario1@example.com', 1);
    insert_funcionario('Funcion?rio 2', 23456789012, 'funcionario2@example.com', 2);
    insert_funcionario('Funcion?rio 3', 34567890123, 'funcionario3@example.com', 3);
    insert_funcionario('Funcion?rio 4', 45678901234, 'funcionario4@example.com', 4);
    insert_funcionario('Funcion?rio 5', 56789012345, 'funcionario5@example.com', 5);
END;

-- PACIENTE
CREATE OR REPLACE PROCEDURE insert_paciente (nm_paciente in varchar, nr_cpf in varchar, ds_email in varchar, nr_rg in numeric, tp_sexo in char, nm_filiacao_paterna in varchar, nm_filiacao_materna in varchar, id_usuario in char, id_endereco in char) 
IS
BEGIN
    IF NOT IS_EMAIL_VALID(ds_email) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Email inválido: ' || ds_email);
    END IF;
    INSERT INTO T_IS_PACIENTE (id_paciente, nm_paciente, nr_cpf, ds_email, nr_rg, tp_sexo, nm_filiacao_paterna, nm_filiacao_materna, id_usuario, id_endereco)
    VALUES (seq_paciente.nextval,nm_paciente, nr_cpf, ds_email, nr_rg, tp_sexo, nm_filiacao_paterna, nm_filiacao_materna, id_usuario, id_endereco);
    COMMIT;
END;

CREATE OR REPLACE PROCEDURE insert_paciente_sprint1 AS
BEGIN
    insert_paciente('Paciente 1', '12345678901', 'paciente1@example.com', 123456789, 'M', 'Pai Paciente 1', 'M?e Paciente 1', 1, 1);
    insert_paciente('Paciente 2', '12345678904', 'paciente2@example.com', 234567890, 'F', 'Pai Paciente 2', 'M?e Paciente 2', 2, 2);
    insert_paciente('Paciente 3', '12345678903', 'paciente3@example.com', 345678901, 'M', 'Pai Paciente 3', 'M?e Paciente 3', 3, 3);
    insert_paciente('Paciente 4', '12345678902', 'paciente4@example.com', 456789012, 'F', 'Pai Paciente 4', 'M?e Paciente 4', 4, 4);
    insert_paciente('Paciente 5', '12345678901', 'paciente5@example.com', 567890123, 'M', 'Pai Paciente 5', 'M?e Paciente 5', 5, 5);
END;
-- PACIENTE

--Triagem
CREATE OR REPLACE PROCEDURE insert_triagem (dt_inicio in varchar, dt_final in varchar, st_triagem in char, ds_sintomas in varchar, id_paciente in char) 
IS
BEGIN
    INSERT INTO T_IS_TRIAGEM (id_triagem, dt_inicio, dt_final, st_triagem, ds_sintomas, id_paciente) VALUES (seq_triagem.nextval,TO_DATE(dt_inicio, 'YYYY-MM-DD'), TO_DATE(dt_final, 'YYYY-MM-DD'), st_triagem, ds_sintomas, id_paciente);
    COMMIT;
END;

CREATE OR REPLACE PROCEDURE insert_triagem_sprint1 AS
BEGIN
    insert_triagem('2024-04-13','2024-04-14', 'N', 'Febre, Dor de cabe?a', 1);
    insert_triagem('2024-04-13','2024-04-14','N', 'Tosse, Coriza', 2);
    insert_triagem('2024-04-13','2024-04-14','N', 'Dor de garganta, Dor no corpo', 3);
    insert_triagem('2024-04-13','2024-04-14','N', 'Dor abdominal, Diarreia', 4);
    insert_triagem('2024-04-13','2024-04-14','N', 'Dificuldade respirat?ria, Fadiga', 5);
END;  
--Triagem


-- EXAME
CREATE OR REPLACE PROCEDURE insert_exame(dt_exame in varchar, ds_resultado in varchar, id_paciente in char, id_funcionario in char) 
IS
BEGIN
    INSERT INTO T_IS_EXAME (id_exame, dt_exame, ds_resultado, id_paciente, id_funcionario) VALUES (seq_exame.nextval,TO_DATE(dt_exame, 'YYYY-MM-DD'), ds_resultado, id_paciente, id_funcionario);
    COMMIT;
END;

CREATE OR REPLACE PROCEDURE insert_exame_sprint1 AS
BEGIN
    insert_exame('2024-04-13','Pneumonia', 1, 1);
    insert_exame('2024-04-13','Covid', 2, 2);
    insert_exame('2024-04-13','Pneumonia', 3, 3);
    insert_exame('2024-04-13','Dispensado', 4, 4);
    insert_exame('2024-04-13','Dispensado', 5, 5);
END;
-- EXAME


-- Procedure que realiza todos os inserts
CREATE OR REPLACE PROCEDURE insert_todos_sprint1 AS
BEGIN
    -- Inserindo dados na tabela T_IS_USUARIO
    insert_user_sprint1;

    -- Inserindo dados na tabela T_IS_ENDERECO
    insert_endereco_sprint1;

    -- Inserindo dados na tabela T_IS_UNID_HOSPITALAR
    insert_unid_hospitalar_sprint1;

    -- Inserindo dados na tabela T_IS_FUNCIONARIO
    insert_funcionario_sprint1;

    -- Inserindo dados na tabela T_IS_PACIENTE
    insert_paciente_sprint1;

    -- Inserindo dados na tabela T_IS_TRIAGEM
    insert_triagem_sprint1;

    -- Inserindo dados na tabela T_IS_EXAME
    insert_exame_sprint1;
END;


BEGIN
    insert_todos_sprint1;
END;

select * from T_IS_USUARIO;
select * from T_IS_ENDERECO;
select * from T_IS_UNID_HOSPITALAR;
select * from T_IS_FUNCIONARIO;
select * from T_IS_PACIENTE;
select * from T_IS_TRIAGEM;
select * from T_IS_EXAME;

----------------------------------------------------------------------
                        --SPRINT 3
----------------------------------------------------------------------

-- FUNCTIONS

-- Paciente com triagem para json
CREATE OR REPLACE FUNCTION get_paciente_triagem_json_manual
RETURN CLOB IS
    v_json CLOB;
BEGIN
    v_json := '['; -- Inicia o array JSON
    FOR rec IN (
        SELECT p.id_paciente, p.nm_paciente, t.id_triagem, t.dt_inicio, t.dt_final, t.st_triagem, t.ds_sintomas
        FROM T_IS_PACIENTE p
        INNER JOIN T_IS_TRIAGEM t ON p.id_paciente = t.id_paciente
    ) LOOP
        v_json := v_json || '{' ||
                  '"id_paciente": "' || rec.id_paciente || '",' ||
                  '"nm_paciente": "' || rec.nm_paciente || '",' ||
                  '"triagem": {' ||
                  '"id_triagem": "' || rec.id_triagem || '",' ||
                  '"dt_inicio": "' || TO_CHAR(rec.dt_inicio, 'DD-MM-YYYY') || '",' ||
                  '"dt_final": "' || TO_CHAR(rec.dt_final, 'DD-MM-YYYY') || '",' ||
                  '"st_triagem": "' || rec.st_triagem || '",' ||
                  '"ds_sintomas": "' || rec.ds_sintomas || '"' ||
                  '}' ||
                  '},';
    END LOOP;
    -- Remove a última vírgula e fechar o array JSON
    v_json := RTRIM(v_json, ',') || ']';
    RETURN v_json;
EXCEPTION -- Três exceptions
    WHEN NO_DATA_FOUND THEN
        RETURN '[]'; -- Se não houver dados, retorna um array JSON vazio
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Erro de valor ao gerar a string JSON');
    WHEN OTHERS THEN
        RETURN '{"erro": "' || SQLERRM || '"}'; -- Em caso de erro, retorna um JSON com a mensagem de erro
END;

select get_paciente_triagem_json_manual from dual;

-- Verificar complexidade da senha 
CREATE OR REPLACE FUNCTION verificar_forca_senha(senha IN VARCHAR2)
RETURN VARCHAR2 IS
    v_tem_maiuscula BOOLEAN := FALSE;
    v_tem_minuscula BOOLEAN := FALSE;
    v_tem_numero BOOLEAN := FALSE;
    v_tem_caractere_especial BOOLEAN := FALSE;
    v_comprimento INTEGER := LENGTH(senha);
    
    -- Definição das exceções
    ex_senha_nula EXCEPTION;
    ex_senha_curta EXCEPTION;
    ex_senha_sem_letras_numeros EXCEPTION;    
BEGIN
    -- Verificar se a senha é nula ou vazia
    IF senha IS NULL OR LENGTH(senha) = 0 THEN
        RAISE ex_senha_nula;
    END IF;    
    -- Verificar comprimento mínimo da senha
    IF v_comprimento < 5 THEN
        RAISE ex_senha_curta;
    END IF;
    -- Verificar se a senha contém pelo menos letras ou números
    IF NOT (REGEXP_LIKE(senha, '[A-Za-z]') OR REGEXP_LIKE(senha, '[0-9]')) THEN
        RAISE ex_senha_sem_letras_numeros;
    END IF;
    -- Verificar os critérios de senha forte
    FOR i IN 1..v_comprimento LOOP
        IF substr(senha, i, 1) BETWEEN 'A' AND 'Z' THEN
            v_tem_maiuscula := TRUE;
        ELSIF substr(senha, i, 1) BETWEEN 'a' AND 'z' THEN
            v_tem_minuscula := TRUE;
        ELSIF substr(senha, i, 1) BETWEEN '0' AND '9' THEN
            v_tem_numero := TRUE;
        ELSIF instr('!@#$%^&*()-_=+[]{}|;:,.<>?/`~', substr(senha, i, 1)) > 0 THEN
            v_tem_caractere_especial := TRUE;
        END IF;
    END LOOP;
    -- Se todos os critérios forem atendidos, a senha é forte
    IF v_tem_maiuscula AND v_tem_minuscula AND v_tem_numero AND v_tem_caractere_especial THEN
        RETURN 'Forte';
    ELSE
        RETURN 'Fraca';
    END IF;
-- Tratamento das exceções
EXCEPTION
    WHEN ex_senha_nula THEN
        RETURN 'Erro: A senha não pode ser nula ou vazia.';
    WHEN ex_senha_curta THEN
        RETURN 'Erro: A senha deve ter pelo menos 5 caracteres.';
    WHEN ex_senha_sem_letras_numeros THEN
        RETURN 'Erro: A senha deve conter pelo menos uma letra ou um número.';
END;


SELECT verificar_forca_senha('SenhaFort3!') FROM dual;
SELECT verificar_forca_senha('senhafraca') FROM dual;




-- PROCEDURES

-- Mostrar pacientes com triagem em json
CREATE OR REPLACE PROCEDURE mostrar_paciente_triagem_json
IS
    v_json CLOB; -- Variável para armazenar o JSON
    -- Definição das exceções
    ex_json_vazio EXCEPTION;
    ex_erro_geracao_json EXCEPTION;
    ex_erro_desconhecido EXCEPTION;

BEGIN
    -- Chama a função que gera o JSON a partir do join entre as tabelas de pacientes e triagens
    v_json := get_paciente_triagem_json_manual;
    -- Verifica se o JSON retornado está vazio
    IF v_json = '[]' THEN
        RAISE ex_json_vazio;
    END IF;
    -- Exibe o JSON no console
    DBMS_OUTPUT.PUT_LINE(v_json);
EXCEPTION
    WHEN ex_json_vazio THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Nenhum dado encontrado para gerar o JSON.');
    WHEN ex_erro_geracao_json THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Falha ao gerar o JSON.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro desconhecido: ' || SQLERRM);
END;

exec mostrar_paciente_triagem_json;

-- Mostrar os pacientes da table
CREATE OR REPLACE PROCEDURE mostrar_cpf IS
    -- Definição das exceções
    ex_sem_dados EXCEPTION;
    ex_erro_query EXCEPTION;
    ex_erro_desconhecido EXCEPTION;
BEGIN
    DBMS_OUTPUT.PUT_LINE('ID Funcionario | Nome Funcionario | Anterior | Atual | Proximo');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------');   
    FOR rec IN (
        SELECT 
            id_funcionario,
            nm_funcionario,
            COALESCE(LAG(nr_cpf) OVER (ORDER BY id_funcionario), 'Vazio') AS Anterior,
            nr_cpf AS Atual,
            COALESCE(LEAD(nr_cpf) OVER (ORDER BY id_funcionario), 'Vazio') AS Proximo
        FROM 
            T_IS_FUNCIONARIO
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(
            rec.id_funcionario || ' | ' ||
            rec.nm_funcionario || ' | ' ||
            rec.Anterior || ' | ' ||
            rec.Atual || ' | ' ||
            rec.Proximo
        );
    END LOOP;
    -- Verifica se a query retornou algum dado
    IF SQL%ROWCOUNT = 0 THEN
        RAISE ex_sem_dados;
    END IF;
EXCEPTION
    WHEN ex_sem_dados THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Nenhum dado encontrado.');
    WHEN ex_erro_query THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Falha ao executar a consulta.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro desconhecido: ' || SQLERRM);
END;

exec mostrar_cpf;


-- TRIGGER
CREATE OR REPLACE TRIGGER trg_audit_funcionario
AFTER INSERT OR UPDATE OR DELETE ON T_IS_FUNCIONARIO
FOR EACH ROW
DECLARE
    v_operacao VARCHAR2(10);
    v_old_data VARCHAR2(250);
    v_new_data VARCHAR2(250);
BEGIN
    -- Determina o tipo de operação
    IF INSERTING THEN
        v_operacao := 'INSERT';
        v_new_data := 'ID_FUNCIONARIO=' || :NEW.id_funcionario || ', NM_FUNCIONARIO=' || :NEW.nm_funcionario || ', NR_CPF=' || :NEW.nr_cpf || ', DS_EMAIL=' || :NEW.ds_email || ', ID_UNID_HOSPITALAR=' || :NEW.id_unid_hospitalar;
    ELSIF UPDATING THEN
        v_operacao := 'UPDATE';
        v_old_data := 'ID_FUNCIONARIO=' || :OLD.id_funcionario || ', NM_FUNCIONARIO=' || :OLD.nm_funcionario || ', NR_CPF=' || :OLD.nr_cpf || ', DS_EMAIL=' || :OLD.ds_email || ', ID_UNID_HOSPITALAR=' || :OLD.id_unid_hospitalar;
        v_new_data := 'ID_FUNCIONARIO=' || :NEW.id_funcionario || ', NM_FUNCIONARIO=' || :NEW.nm_funcionario || ', NR_CPF=' || :NEW.nr_cpf || ', DS_EMAIL=' || :NEW.ds_email || ', ID_UNID_HOSPITALAR=' || :NEW.id_unid_hospitalar;
    ELSIF DELETING THEN
        v_operacao := 'DELETE';
        v_old_data := 'ID_FUNCIONARIO=' || :OLD.id_funcionario || ', NM_FUNCIONARIO=' || :OLD.nm_funcionario || ', NR_CPF=' || :OLD.nr_cpf || ', DS_EMAIL=' || :OLD.ds_email || ', ID_UNID_HOSPITALAR=' || :OLD.id_unid_hospitalar;
    END IF;

    -- Insere os dados na tabela de auditoria
    INSERT INTO T_IS_AUDITORIA (ID_AUDITORIA, TABELA_AUDITADA, OPERACAO, USUARIO, DATA_OPERACAO, OLD_DATA, NEW_DATA)
    VALUES (SEQ_AUDITORIA.NEXTVAL, 'T_IS_FUNCIONARIO', v_operacao, USER, SYSDATE, v_old_data, v_new_data);
END;


INSERT INTO T_IS_FUNCIONARIO (
    id_funcionario, nm_funcionario, nr_cpf, ds_email, id_unid_hospitalar
) VALUES (
    seq_funcionario.nextval, 'João Silva', '12345678901', 'joao.silva@example.com', '1'
);
select * from t_is_auditoria;

UPDATE T_IS_FUNCIONARIO
SET nm_funcionario = 'João Silva Atualizado', ds_email = 'joao.silva.atualizado@example.com'
WHERE id_funcionario = 6;
select * from t_is_auditoria;


DELETE FROM T_IS_FUNCIONARIO WHERE id_funcionario = 6;
select * from t_is_auditoria;


-- CAUSAR EXCEPTIONS --

-- Procedure mostrar_paciente_triagem_json
CREATE OR REPLACE FUNCTION get_paciente_triagem_json_manual
RETURN CLOB IS
BEGIN
    -- Simula um JSON vazio para causar a exceção ex_json_vazio
    RETURN '[]';
END;

CREATE OR REPLACE PROCEDURE mostrar_paciente_triagem_json
IS
    v_json CLOB; -- Variável para armazenar o JSON
    -- Definição das exceções
    ex_json_vazio EXCEPTION;
    ex_erro_geracao_json EXCEPTION;
    ex_erro_desconhecido EXCEPTION;

BEGIN
    -- Chama a função que gera o JSON a partir do join entre as tabelas de pacientes e triagens
    v_json := get_paciente_triagem_json_manual;
    -- Verifica se o JSON retornado está vazio
    IF v_json = '[]' THEN
        RAISE ex_json_vazio;
    END IF;
    -- Exibe o JSON no console
    DBMS_OUTPUT.PUT_LINE(v_json);
EXCEPTION
    WHEN ex_json_vazio THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Nenhum dado encontrado para gerar o JSON.');
    WHEN ex_erro_geracao_json THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Falha ao gerar o JSON.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro desconhecido: ' || SQLERRM);
END;

exec mostrar_paciente_triagem_json;


-- Procedure mostrar_cpf
-- Exemplo de ajuste na consulta para não retornar dados
CREATE OR REPLACE PROCEDURE mostrar_cpf IS
    -- Definição das exceções
    ex_sem_dados EXCEPTION;
    ex_erro_query EXCEPTION;
    ex_erro_desconhecido EXCEPTION;
BEGIN
    DECLARE
        v_test NUMBER;
    BEGIN
        v_test := 1 / 0; -- Gera um erro de divisão por zero
    END;
    DBMS_OUTPUT.PUT_LINE('ID Funcionario | Nome Funcionario | Anterior | Atual | Proximo');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------');   
    FOR rec IN (
        SELECT 
            id_funcionario,
            nm_funcionario,
            COALESCE(LAG(nr_cpf) OVER (ORDER BY id_funcionario), 'Vazio') AS Anterior,
            nr_cpf AS Atual,
            COALESCE(LEAD(nr_cpf) OVER (ORDER BY id_funcionario), 'Vazio') AS Proximo
        FROM 
            T_IS_FUNCIONARIO
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(
            rec.id_funcionario || ' | ' ||
            rec.nm_funcionario || ' | ' ||
            rec.Anterior || ' | ' ||
            rec.Atual || ' | ' ||
            rec.Proximo
        );
    END LOOP;
    IF SQL%ROWCOUNT = 0 THEN
        RAISE ex_sem_dados;
    END IF;
EXCEPTION
    WHEN ex_sem_dados THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Nenhum dado encontrado.');
    WHEN ex_erro_query THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Falha ao executar a consulta.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro desconhecido: ' || SQLERRM);
END;
exec mostrar_cpf;


-- Function verificar_forca_senha

SELECT verificar_forca_senha('') FROM dual;
