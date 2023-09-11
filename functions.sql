CREATE OR REPLACE FUNCTION FNC_QTD_ANALISES(
    p_status IN VARCHAR
)
RETURN NUMBER
IS

    resultado NUMBER;
    id_status NUMBER;

BEGIN

    IF UPPER(p_status) IN ('MORTA', 'EM PROGRESSO', 'EM TRATAMENTO', 'ANALISANDO', 'CURADA') THEN
    
        SELECT ID_STATUS
        INTO id_status
        FROM TB_AS_STATUS
        WHERE UPPER(DS_STATUS) = UPPER(p_status);
        
        DBMS_OUTPUT.PUT_LINE('ID do status: ' || id_status);
        DBMS_OUTPUT.PUT_LINE('Quantidade: ' || resultado);
        
        SELECT COUNT(*)
        INTO resultado
        FROM TB_AS_ANALISE
        WHERE ID_STATUS = TO_NUMBER(id_status);
        
        DBMS_OUTPUT.PUT_LINE('Quantidade: ' || resultado);

        IF resultado IS NULL THEN
           RAISE_APPLICATION_ERROR(-20003, 'Nenhuma análise encontrada para o valor: ' || p_status);
        ELSE
            RETURN resultado;
        END IF;
        
    ELSE
    
        RAISE_APPLICATION_ERROR(-20001, 'O valor deve ser um valor entre esses: Morta, Em progresso, Em tratamento, Analisando e Curada');
        
    end if;
        
EXCEPTION

  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ocorreu uma exceção: ' || SQLERRM);
    RETURN NULL;
    
END;

DECLARE

    v_resultado NUMBER;

BEGIN

    v_resultado := FNC_QTD_ANALISES('ANALISANDO');
    DBMS_OUTPUT.PUT_LINE(v_resultado);

END;

CREATE OR REPLACE FUNCTION FNC_RETORNA_SOLUCAO(
    p_problema IN VARCHAR2
)
RETURN VARCHAR2
IS
    
    v_retorno VARCHAR2(500);
    
BEGIN

    SELECT DS_SOLUCAO
    INTO v_retorno
    FROM TB_AS_ANALISE
    WHERE UPPER(DS_PROBLEMA) LIKE '%' || UPPER(p_problema) || '%';
    
    RETURN v_retorno;
    
EXCEPTION

    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Nenhuma solução encontrada para o problema: ' || p_problema);
      RETURN NULL;

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ocorreu uma exceção: ' || SQLERRM);
        RETURN NULL;

END;

DECLARE

    v_resultado VARCHAR2(500);

BEGIN

    v_resultado := FNC_RETORNA_SOLUCAO('banana');
    DBMS_OUTPUT.PUT_LINE(v_resultado);

END;




SELECT * FROM TB_AS_STATUS;
SELECT * FROM TB_AS_ANALISE;
desc TB_AS_ANALISE;

SELECT COUNT(*)
FROM TB_AS_ANALISE
WHERE ID_STATUS = 4;

SELECT DS_SOLUCAO
FROM TB_AS_ANALISE
WHERE DS_PROBLEMA LIKE '%' || 'murchas' || '%';


SET SERVEROUTPUT ON

