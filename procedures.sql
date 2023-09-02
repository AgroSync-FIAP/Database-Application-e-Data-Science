SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE PRC_CADASTRO_USUARIO (
    p_email IN VARCHAR2,
    p_senha IN VARCHAR2,
    p_nome IN VARCHAR2,
    p_cpf_cnpj IN VARCHAR2,
    p_genero IN CHAR,
    p_dt_nascimento IN DATE,
    p_cm_img_perfil IN VARCHAR2,
    p_dt_registro IN DATE,
    p_nr_ddi IN NUMBER,
    p_nr_ddd IN NUMBER,
    p_nr_telefone IN NUMBER
) IS
BEGIN 

    DBMS_OUTPUT.PUT_LINE('Usuário cadastrado');

END;

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
BEGIN 

    DBMS_OUTPUT.PUT_LINE('Local cadastrado');

END;

CREATE OR REPLACE PROCEDURE PRC_CADASTRO_ANALISE (
    p_id_local IN NUMBER,
    p_id_local IN NUMBER,
    p_id_status IN NUMBER,
    p_id_planta IN NUMBER,
    p_cm_imagem IN VARCHAR2,
    p_ds_problema IN VARCHAR2,
    p_ds_solucao IN VARCHAR2,
    p_dt_registro IN DATE
) IS
BEGIN 

    DBMS_OUTPUT.PUT_LINE('Analise cadastrado');

END;