SET SERVEROUTPUT ON;

-- Procedure para cadastrar um usuario junto com o telefone dele

CREATE OR REPLACE PROCEDURE PRC_CADASTRO_USUARIO (
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
END;

-- Exemplos de insercoes:
EXEC PRC_CADASTRO_USUARIO ('maria@gmail.com', 'maria123', 'Maria das Dores', '39648271597638', 'F', '09/12/1910', 'foto_maria.pNG', 55, 11, 936271596);
EXEC PRC_CADASTRO_USUARIO ('joao@gmail.com', 'joao123', 'Joao Ricardo Oliveira', '39648271597', 'M', '30/07/2001', 'foto_joao.png', 55, 11, 963984628);



-- Procedure para cadastrar um local

CREATE OR REPLACE PROCEDURE PRC_CADASTRO_LOCAL (
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
END;

-- Exemplo

EXEC PRC_CADASTRO_LOCAL(5, 'Brasil', 'RJ', 'Rio de Janeiro', 'Barra da Tijuca', 'Rua das rosas', '89', '3612597008', null);
EXEC PRC_CADASTRO_LOCAL(5, 'Brasil', 'RJ', 'Rio de Janeiro', 'Barra da Tijuca', 'Rua das rosas', '89', '36125978', null);



-- Procedure para cadastrar uma analise

CREATE OR REPLACE PROCEDURE PRC_CADASTRO_ANALISE (
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

END;

-- Exemplo

EXEC PRC_CADASTRO_ANALISE(5, 5, 5, 'planta.png', 'A planta esta com folhas amareladas.', 'Para resolver folhas amareladas em uma planta, verifique a rega.');


