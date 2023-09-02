DROP SEQUENCE seq_id_analise;
DROP SEQUENCE seq_id_local;
DROP SEQUENCE seq_id_telefone;
DROP SEQUENCE seq_id_usuario;
DROP SEQUENCE seq_id_planta;
DROP SEQUENCE seq_id_status;
DROP SEQUENCE seq_id_registro;

CREATE SEQUENCE seq_id_analise
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE seq_id_local
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE seq_id_telefone
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE seq_id_usuario
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE seq_id_planta
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE seq_id_status
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE seq_id_registro
    START WITH 1
    INCREMENT BY 1;