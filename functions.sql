SET SERVEROUTPUT ON;

-- Funcaoo para retornar o porcentual de analises com o valor do parametro passado
-- referente ao total de analises.

CREATE OR REPLACE FUNCTION FNC_PORCENT_ANALISES(
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
    
END;

-- Demonstracao

DECLARE

    v_resultado NUMBER;
    v_status VARCHAR2(50) := 'ANASANDO';

BEGIN

    v_resultado := FNC_PORCENT_ANALISES(v_status);
    DBMS_OUTPUT.PUT_LINE('A porcentagem de analises com o status ' || v_status || ' e: ' || v_resultado);

END;






-- Funcao para retornar uma solucação para o problema passado como parametro com base em palavra ou pequenas 
-- frases chaves.

CREATE OR REPLACE FUNCTION FNC_RETORNA_SOLUCAO(
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

END;

-- Demonstração

DECLARE

    v_resultado VARCHAR2(500);

BEGIN

    v_resultado := FNC_RETORNA_SOLUCAO('folha');
    DBMS_OUTPUT.PUT_LINE(v_resultado);

END;







