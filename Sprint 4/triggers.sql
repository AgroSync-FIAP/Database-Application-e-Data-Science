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