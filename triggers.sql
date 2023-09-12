SET SERVEROUTPUT ON;

-- Uma trigger para as principais tabelas do banco

CREATE OR REPLACE TRIGGER TRG_AUDITORIA_ANALISE
AFTER INSERT OR UPDATE OR DELETE ON tb_as_analise
FOR EACH ROW
DECLARE
    v_comando VARCHAR2(50);

    v_codigo_erro NUMBER;
    v_mensagem_erro VARCHAR2(250);
BEGIN

    IF INSERTING THEN
        v_comando := 'INSERT';
    ELSIF UPDATING THEN
        v_comando := 'UPDATE';
    ELSIF DELETING THEN
        v_comando := 'DELETE';
    END IF;

    INSERT INTO tb_as_auditoria (ID_REGISTRO, NM_USUARIO, DT_HORA, ACAO_REALIZADA, TABELA_AFETADA)
    VALUES (seq_id_registro.NEXTVAL, USER, SYSDATE, v_comando, 'TB_AS_ANALISE');

EXCEPTION

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ocorreu um erro: ' || SQLERRM);
        
        v_codigo_erro := SQLCODE;
        v_mensagem_erro := SQLERRM;
        
        INSERT INTO TB_AS_ERRO (ID_ERRO, CD_ERRO, NM_ERRO, DT_REGISTRO, USUARIO, PROCEDIMENTO)
        VALUES (seq_id_erro.NEXTVAL, v_codigo_erro, v_mensagem_erro, SYSDATE, USER, 'TRG_AUDITORIA_ANALISE');
END;

CREATE OR REPLACE TRIGGER TRG_AUDITORIA_LOCAL
AFTER INSERT OR UPDATE OR DELETE ON tb_as_local
FOR EACH ROW
DECLARE
    v_comando VARCHAR2(50);

    v_codigo_erro NUMBER;
    v_mensagem_erro VARCHAR2(250);
BEGIN

    IF INSERTING THEN
        v_comando := 'INSERT';
    ELSIF UPDATING THEN
        v_comando := 'UPDATE';
    ELSIF DELETING THEN
        v_comando := 'DELETE';
    END IF;

    INSERT INTO tb_as_auditoria (ID_REGISTRO, NM_USUARIO, DT_HORA, ACAO_REALIZADA, TABELA_AFETADA)
    VALUES (seq_id_registro.NEXTVAL, USER, SYSDATE, v_comando, 'TB_AS_ANALISE');

EXCEPTION

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ocorreu um erro: ' || SQLERRM);

        v_codigo_erro := SQLCODE;
        v_mensagem_erro := SQLERRM;
        
        INSERT INTO TB_AS_ERRO (ID_ERRO, CD_ERRO, NM_ERRO, DT_REGISTRO, USUARIO, PROCEDIMENTO)
        VALUES (seq_id_erro.NEXTVAL, v_codigo_erro, v_mensagem_erro, SYSDATE, USER, 'TRG_AUDITORIA_LOCAL');

END;

CREATE OR REPLACE TRIGGER TRG_AUDITORIA_USUARIO
AFTER INSERT OR UPDATE OR DELETE ON tb_as_usuario
FOR EACH ROW
DECLARE
    v_comando VARCHAR2(50);

    v_codigo_erro NUMBER;
    v_mensagem_erro VARCHAR2(250);
BEGIN

    IF INSERTING THEN
        v_comando := 'INSERT';
    ELSIF UPDATING THEN
        v_comando := 'UPDATE';
    ELSIF DELETING THEN
        v_comando := 'DELETE';
    END IF;

    INSERT INTO tb_as_auditoria (ID_REGISTRO, NM_USUARIO, DT_HORA, ACAO_REALIZADA, TABELA_AFETADA)
    VALUES (seq_id_registro.NEXTVAL, USER, SYSDATE, v_comando, 'TB_AS_ANALISE');

EXCEPTION

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ocorreu um erro: ' || SQLERRM);

        v_codigo_erro := SQLCODE;
        v_mensagem_erro := SQLERRM;
        
        INSERT INTO TB_AS_ERRO (ID_ERRO, CD_ERRO, NM_ERRO, DT_REGISTRO, USUARIO, PROCEDIMENTO)
        VALUES (seq_id_erro.NEXTVAL, v_codigo_erro, v_mensagem_erro, SYSDATE, USER, 'TRG_AUDITORIA_LOCAL');
        
END;



