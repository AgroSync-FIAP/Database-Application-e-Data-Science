CREATE OR REPLACE FUNCTION FNC_GET(p_idStatus IN NUMBER)
RETURN NUMBER
IS

    v_quantidade NUMBER;

BEGIN

    v_quantidade := SELECT * FROM tb_as_status WHERE ID_STATUS = p_idStatus;
    
    RETURN v_quantidade;

END;