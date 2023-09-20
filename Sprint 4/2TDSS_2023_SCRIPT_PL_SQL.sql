-- * INTEGRANTES DO GRUPO *
-- Marcos Bilobram  | RM: 94311
-- Nathália Maia | RM: 96320 
-- Rafaela da Silva | RM: 94972 
-- Vinicius de Oliveira | RM: 93613 


-- Criando o pacote

CREATE OR REPLACE PACKAGE RM93613_PKG_AGRO_SYNC AS

    PROCEDURE PRC_CADASTRO_USUARIO (p_email VARCHAR2, p_senha VARCHAR2, p_nome VARCHAR2, p_cpf_cnpj VARCHAR2, p_genero CHAR, p_dt_nascimento DATE, p_cm_img_perfil VARCHAR2, p_nr_ddi NUMBER, p_nr_ddd NUMBER, p_nr_telefone NUMBER );
    PROCEDURE PRC_CADASTRO_LOCAL ( p_id_usuario NUMBER, p_nm_pais VARCHAR2, p_sg_estado VARCHAR2, p_nm_municipio VARCHAR2, p_nm_bairro VARCHAR2, p_nm_logradouro VARCHAR2, p_nr_logradouro VARCHAR2, p_nr_cep VARCHAR2, p_ds_complemento VARCHAR2);
    PROCEDURE PRC_CADASTRO_ANALISE (p_id_local NUMBER, p_id_status NUMBER, p_id_planta NUMBER, p_cm_imagem VARCHAR2, p_ds_problema VARCHAR2, p_ds_solucao VARCHAR2);
    FUNCTION FNC_PORCENT_ANALISES (p_status VARCHAR) RETURN NUMBER;
    FUNCTION FNC_RETORNA_SOLUCAO (p_problema VARCHAR2) RETURN VARCHAR2;

END RM93613_PKG_AGRO_SYNC;


-- Criando o corpo do pacote

CREATE OR REPLACE PACKAGE BODY RM93613_PKG_AGRO_SYNC AS

    PROCEDURE PRC_CADASTRO_USUARIO (
        p_email IN VARCHAR2,
        p_senha IN VARCHAR2,
        p_nome IN VARCHAR2,
        p_cpf_cnpj IN VARCHAR2,
        p_genero IN CHAR,
        p_dt_nascimento IN DATE,
        p_cm_img_perfil IN VARCHAR2,
        p_nr_ddi IN NUMBER,
        p_nr_ddd IN NUMBER,
        p_nr_telefone IN NUMBER
    ) IS

        idTelefone NUMBER;

        v_codigo_erro NUMBER;
        v_mensagem_erro VARCHAR2(250);

    BEGIN 


        IF INSTR(p_email, '@') = 0 THEN    
            RAISE_APPLICATION_ERROR(-20001, 'O email deve conter o caracter @.');
        END IF;

        IF LENGTH(p_cpf_cnpj) != 11 
        AND LENGTH(p_cpf_cnpj) != 14 THEN
            RAISE_APPLICATION_ERROR(-20002, 'O conteudo do CPF/CNPJ deve ter 11 ou 14 caracteres.');
        END IF;
        
        IF p_genero != 'M' 
        AND p_genero != 'F' THEN
            RAISE_APPLICATION_ERROR(-20003, 'O valor de genero deve ser M (Masculino) ou F (Feminino).');
        END IF;
        
        IF INSTR(UPPER(p_cm_img_perfil), '.PNG') = 0 
        AND INSTR(UPPER(p_cm_img_perfil), '.JPEG') = 0 THEN    
            RAISE_APPLICATION_ERROR(-20004, 'Os formatos de imagem permitos sao: png ou jpeg.');
        END IF;
        

        idTelefone := seq_id_telefone.NEXTVAL;

        INSERT INTO tb_as_telefone (ID_TELEFONE, NR_DDI, NR_DDD, NR_TELEFONE)
        VALUES (idTelefone, p_nr_ddi, p_nr_ddd, p_nr_telefone);
        
        INSERT INTO tb_as_usuario (ID_USUARIO, ID_TELEFONE, EMAIL, SENHA, NOME, CPF_CNPJ, GENERO, DT_NASCIMENTO, CM_IMG_PERFIL, DT_REGISTRO)
        VALUES (seq_id_usuario.NEXTVAL, idTelefone, p_email, p_senha, p_nome, p_cpf_cnpj, p_genero, TO_DATE(p_dt_nascimento, 'DD-MM-YYYY'), p_cm_img_perfil, SYSDATE);

    EXCEPTION

        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Valor duplicado em coluna unica.');

            v_codigo_erro := SQLCODE;
            v_mensagem_erro := SQLERRM;
            
            INSERT INTO TB_AS_ERRO (ID_ERRO, CD_ERRO, NM_ERRO, DT_REGISTRO, USUARIO, PROCEDIMENTO)
            VALUES (seq_id_erro.NEXTVAL, v_codigo_erro, v_mensagem_erro, SYSDATE, USER, 'PRC_CADASTRO_USUARIO');
            
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Chave estrangeira nao encontrada.');

            v_codigo_erro := SQLCODE;
            v_mensagem_erro := SQLERRM;
            
            INSERT INTO TB_AS_ERRO (ID_ERRO, CD_ERRO, NM_ERRO, DT_REGISTRO, USUARIO, PROCEDIMENTO)
            VALUES (seq_id_erro.NEXTVAL, v_codigo_erro, v_mensagem_erro, SYSDATE, USER, 'PRC_CADASTRO_USUARIO');
            
        WHEN VALUE_ERROR THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Violou a restricao de tamanho.');

            v_codigo_erro := SQLCODE;
            v_mensagem_erro := SQLERRM;
            
            INSERT INTO TB_AS_ERRO (ID_ERRO, CD_ERRO, NM_ERRO, DT_REGISTRO, USUARIO, PROCEDIMENTO)
            VALUES (seq_id_erro.NEXTVAL, v_codigo_erro, v_mensagem_erro, SYSDATE, USER, 'PRC_CADASTRO_USUARIO');

        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Ocorreu um erro: ' || SQLERRM);

            v_codigo_erro := SQLCODE;
            v_mensagem_erro := SQLERRM;
            
            INSERT INTO TB_AS_ERRO (ID_ERRO, CD_ERRO, NM_ERRO, DT_REGISTRO, USUARIO, PROCEDIMENTO)
            VALUES (seq_id_erro.NEXTVAL, v_codigo_erro, v_mensagem_erro, SYSDATE, USER, 'PRC_CADASTRO_USUARIO');
    END PRC_CADASTRO_USUARIO;

    PROCEDURE PRC_CADASTRO_LOCAL (
        p_id_usuario IN NUMBER,
        p_nm_pais IN VARCHAR2,
        p_sg_estado IN VARCHAR2,
        p_nm_municipio IN VARCHAR2,
        p_nm_bairro IN VARCHAR2,
        p_nm_logradouro IN VARCHAR2,
        p_nr_logradouro IN VARCHAR2,
        p_nr_cep IN VARCHAR2,
        p_ds_complemento IN VARCHAR2
    ) IS

        v_verificaUsuario NUMBER;

        v_codigo_erro NUMBER;
        v_mensagem_erro VARCHAR2(250);

    BEGIN 

        SELECT COUNT(*)
        INTO v_verificaUsuario
        FROM tb_as_usuario
        WHERE ID_USUARIO = p_id_usuario;
        
        IF v_verificaUsuario = 0 THEN
            RAISE_APPLICATION_ERROR(-20005, 'Usuario nao encontrado.');
        END IF;
            

        INSERT INTO tb_as_local (ID_LOCAL, ID_USUARIO, NM_PAIS, SG_ESTADO, NM_MUNICIPIO, NM_BAIRRO, NM_LOGRADOURO, NR_LOGRADOURO, NR_CEP, DS_COMPLEMENTO)
        VALUES (seq_id_local.NEXTVAL, p_id_usuario, p_nm_pais, p_sg_estado, p_nm_municipio, p_nm_bairro, p_nm_logradouro, p_nr_logradouro, p_nr_cep, p_ds_complemento);

    EXCEPTION

        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Valor duplicado em coluna unica.');

            v_codigo_erro := SQLCODE;
            v_mensagem_erro := SQLERRM;
            
            INSERT INTO TB_AS_ERRO (ID_ERRO, CD_ERRO, NM_ERRO, DT_REGISTRO, USUARIO, PROCEDIMENTO)
            VALUES (seq_id_erro.NEXTVAL, v_codigo_erro, v_mensagem_erro, SYSDATE, USER, 'PRC_CADASTRO_LOCAL');
            
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Chave estrangeira nao encontrada.');

            v_codigo_erro := SQLCODE;
            v_mensagem_erro := SQLERRM;
            
            INSERT INTO TB_AS_ERRO (ID_ERRO, CD_ERRO, NM_ERRO, DT_REGISTRO, USUARIO, PROCEDIMENTO)
            VALUES (seq_id_erro.NEXTVAL, v_codigo_erro, v_mensagem_erro, SYSDATE, USER, 'PRC_CADASTRO_LOCAL');
            
        WHEN VALUE_ERROR THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Violou a restricao de tamanho.');

            v_codigo_erro := SQLCODE;
            v_mensagem_erro := SQLERRM;
            
            INSERT INTO TB_AS_ERRO (ID_ERRO, CD_ERRO, NM_ERRO, DT_REGISTRO, USUARIO, PROCEDIMENTO)
            VALUES (seq_id_erro.NEXTVAL, v_codigo_erro, v_mensagem_erro, SYSDATE, USER, 'PRC_CADASTRO_LOCAL');

        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Ocorreu um erro: ' || SQLERRM);

            v_codigo_erro := SQLCODE;
            v_mensagem_erro := SQLERRM;
            
            INSERT INTO TB_AS_ERRO (ID_ERRO, CD_ERRO, NM_ERRO, DT_REGISTRO, USUARIO, PROCEDIMENTO)
            VALUES (seq_id_erro.NEXTVAL, v_codigo_erro, v_mensagem_erro, SYSDATE, USER, 'PRC_CADASTRO_LOCAL');
    END PRC_CADASTRO_LOCAL;

    PROCEDURE PRC_CADASTRO_ANALISE (
        p_id_local IN NUMBER,
        p_id_status IN NUMBER,
        p_id_planta IN NUMBER,
        p_cm_imagem IN VARCHAR2,
        p_ds_problema IN VARCHAR2,
        p_ds_solucao IN VARCHAR2
    ) IS

        v_verificaLocal NUMBER;
        v_verificaStatus NUMBER;
        v_verificaPlanta NUMBER;
        
        v_codigo_erro NUMBER;
        v_mensagem_erro VARCHAR2(250);
        
    BEGIN 

        SELECT COUNT(*)
        INTO v_verificaLocal
        FROM tb_as_local
        WHERE ID_LOCAL = p_id_local;
        
        IF v_verificaLocal = 0 THEN
            RAISE_APPLICATION_ERROR(-20006, 'Local nao encontrado.');
        END IF;
        
        
        SELECT COUNT(*)
        INTO v_verificaStatus
        FROM tb_as_status
        WHERE ID_STATUS = p_id_status;
        
        IF v_verificaStatus = 0 THEN
            RAISE_APPLICATION_ERROR(-20007, 'Status nao encontrado.');
        END IF;
        
        SELECT COUNT(*)
        INTO v_verificaPlanta
        FROM tb_as_planta
        WHERE ID_PLANTA = p_id_planta;
        
        IF v_verificaPlanta = 0 THEN
            RAISE_APPLICATION_ERROR(-20008, 'Planta nao encontrado.');
        END IF;
        
        
        IF INSTR(UPPER(p_cm_imagem), '.PNG') = 0 
        AND INSTR(UPPER(p_cm_imagem), '.JPEG') = 0 THEN    
            RAISE_APPLICATION_ERROR(-20009, 'Os formatos de imagem permitos s�o: png ou jpeg.');
        END IF;
            

        INSERT INTO tb_as_analise (ID_ANALISE, ID_LOCAL, ID_STATUS, ID_PLANTA, CM_IMAGEM, DS_PROBLEMA, DS_SOLUCAO, DT_REGISTRO)
        VALUES (seq_id_analise.NEXTVAL, p_id_local, p_id_status, p_id_planta, p_cm_imagem, p_ds_problema, 
        p_ds_solucao, SYSDATE);
        
    EXCEPTION

        

        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Valor duplicado em coluna unica.');
            
            v_codigo_erro := SQLCODE;
            v_mensagem_erro := SQLERRM;
            
            INSERT INTO TB_AS_ERRO (ID_ERRO, CD_ERRO, NM_ERRO, DT_REGISTRO, USUARIO, PROCEDIMENTO)
            VALUES (seq_id_erro.NEXTVAL, v_codigo_erro, v_mensagem_erro, SYSDATE, USER, 'PRC_CADASTRO_ANALISE');
            
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Chave estrangeira nao encontrada.');
            
            v_codigo_erro := SQLCODE;
            v_mensagem_erro := SQLERRM;
            
            INSERT INTO TB_AS_ERRO (ID_ERRO, CD_ERRO, NM_ERRO, DT_REGISTRO, USUARIO, PROCEDIMENTO)
            VALUES (seq_id_erro.NEXTVAL, v_codigo_erro, v_mensagem_erro, SYSDATE, USER, 'PRC_CADASTRO_ANALISE');
            
        WHEN VALUE_ERROR THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Violou a restricao de tamanho.');
            
            v_codigo_erro := SQLCODE;
            v_mensagem_erro := SQLERRM;
            
            INSERT INTO TB_AS_ERRO (ID_ERRO, CD_ERRO, NM_ERRO, DT_REGISTRO, USUARIO, PROCEDIMENTO)
            VALUES (seq_id_erro.NEXTVAL, v_codigo_erro, v_mensagem_erro, SYSDATE, USER, 'PRC_CADASTRO_ANALISE');

        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Ocorreu um erro: ' || SQLERRM);
            
            v_codigo_erro := SQLCODE;
            v_mensagem_erro := SQLERRM;
            
            INSERT INTO TB_AS_ERRO (ID_ERRO, CD_ERRO, NM_ERRO, DT_REGISTRO, USUARIO, PROCEDIMENTO)
            VALUES (seq_id_erro.NEXTVAL, v_codigo_erro, v_mensagem_erro, SYSDATE, USER, 'PRC_CADASTRO_ANALISE');

    END PRC_CADASTRO_ANALISE;

    FUNCTION FNC_PORCENT_ANALISES(
        p_status IN VARCHAR
    )
    RETURN NUMBER
    IS

        v_total NUMBER;
        v_porStatus NUMBER;
        v_resultado NUMBER;

        v_codigo_erro NUMBER;
        v_mensagem_erro VARCHAR2(250);

    BEGIN

        IF UPPER(p_status) IN ('MORTA', 'EM PROGRESSO', 'EM TRATAMENTO', 'ANALISANDO', 'CURADA') THEN
        
            SELECT COUNT(*)
            INTO v_total
            FROM TB_AS_ANALISE;
        
            SELECT COUNT(*)
            INTO v_porStatus
            FROM TB_AS_ANALISE a 
            INNER JOIN TB_AS_STATUS s ON (a.id_status = s.id_status)
            WHERE UPPER(s.DS_STATUS) = UPPER(p_status);
            
            v_resultado := (v_porStatus / v_total) * 100;

            RETURN v_resultado;
            
        ELSE
        
            RAISE_APPLICATION_ERROR(-20001, 'O valor deve ser um valor entre esses: Morta, Em progresso, Em tratamento, Analisando e Curada');
            
        end if;
            
    EXCEPTION

        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Nenhuma solucao encontrada para o problema: ' || p_status);

            v_codigo_erro := SQLCODE;
            v_mensagem_erro := SQLERRM;
            
            INSERT INTO TB_AS_ERRO (ID_ERRO, CD_ERRO, NM_ERRO, DT_REGISTRO, USUARIO, PROCEDIMENTO)
            VALUES (seq_id_erro.NEXTVAL, v_codigo_erro, v_mensagem_erro, SYSDATE, USER, 'FNC_PORCENT_ANALISES');

            RETURN 0;

        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Ocorreu um erro: ' || SQLERRM);

            v_codigo_erro := SQLCODE;
            v_mensagem_erro := SQLERRM;
            
            INSERT INTO TB_AS_ERRO (ID_ERRO, CD_ERRO, NM_ERRO, DT_REGISTRO, USUARIO, PROCEDIMENTO)
            VALUES (seq_id_erro.NEXTVAL, v_codigo_erro, v_mensagem_erro, SYSDATE, USER, 'FNC_PORCENT_ANALISES');

            RETURN NULL;
        
    END FNC_PORCENT_ANALISES;

    FUNCTION FNC_RETORNA_SOLUCAO(
        p_problema IN VARCHAR2
    )
    RETURN VARCHAR2
    IS
        
        v_retorno VARCHAR2(500);

        v_codigo_erro NUMBER;
        v_mensagem_erro VARCHAR2(250);
        
    BEGIN

        SELECT DS_SOLUCAO
        INTO v_retorno
        FROM TB_AS_ANALISE
        WHERE UPPER(DS_PROBLEMA) LIKE '%' || UPPER(p_problema) || '%'
        AND DT_REGISTRO = (SELECT MAX(DT_REGISTRO) FROM TB_AS_ANALISE)
        AND ROWNUM = 1;
        
        RETURN v_retorno;
        
    EXCEPTION

        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Nenhuma solucao encontrada para o problema: ' || p_problema);

            v_codigo_erro := SQLCODE;
            v_mensagem_erro := SQLERRM;
            
            INSERT INTO TB_AS_ERRO (ID_ERRO, CD_ERRO, NM_ERRO, DT_REGISTRO, USUARIO, PROCEDIMENTO)
            VALUES (seq_id_erro.NEXTVAL, v_codigo_erro, v_mensagem_erro, SYSDATE, USER, 'FNC_RETORNA_SOLUCAO');

            RETURN NULL;

        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Ocorreu um erro: ' || SQLERRM);

            v_codigo_erro := SQLCODE;
            v_mensagem_erro := SQLERRM;
            
            INSERT INTO TB_AS_ERRO (ID_ERRO, CD_ERRO, NM_ERRO, DT_REGISTRO, USUARIO, PROCEDIMENTO)
            VALUES (seq_id_erro.NEXTVAL, v_codigo_erro, v_mensagem_erro, SYSDATE, USER, 'FNC_RETORNA_SOLUCAO');

            RETURN NULL;

    END FNC_RETORNA_SOLUCAO;

END RM93613_PKG_AGRO_SYNC;

-- Criando tabela de auditoria para ser alimentada pela trigger TRG_INSERT_USUARIO

CREATE SEQUENCE seq_id_audit_usuario
    START WITH 1
    INCREMENT BY 1;

CREATE TABLE tb_as_audit_usuario (
    id_audit_usuario NUMBER(5) NOT NULL,
    usuario VARCHAR2(30) NOT NULL,
    data_registro DATE NOT NULL,
    id_usuario_inserido NUMBER(5) NOT NULL
);

ALTER TABLE tb_as_audit_usuario ADD CONSTRAINT tb_as_audit_usuario_pk PRIMARY KEY ( id_audit_usuario );

-- Criando Trigger que audite as opecoes de INSERT na tabela tb_as_usuario.

CREATE OR REPLACE TRIGGER TRG_INSERT_USUARIO
AFTER INSERT ON tb_as_usuario
FOR EACH ROW
BEGIN

    INSERT INTO tb_as_audit_usuario (id_audit_usuario, usuario, data_registro, id_usuario_inserido)
    VALUES (seq_id_audit_usuario.NEXTVAL, USER, SYSDATE, :NEW.id_usuario);

EXCEPTION

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ocorreu um erro: ' || SQLERRM);

END;

-- Criando trigger para caso seja inserido dados na tabela tb_as_analise sem o ID, pegue o proximo numero da sequence seq_id_analise

CREATE OR REPLACE TRIGGER TRG_INSERT_ANALISE
BEFORE INSERT ON tb_as_analise
FOR EACH ROW
BEGIN

    IF :NEW.ID_ANALISE IS NULL THEN
        :NEW.ID_ANALISE := seq_id_analise.NEXTVAL;
    END IF;

EXCEPTION

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ocorreu um erro: ' || SQLERRM);

END;