SET SERVEROUTPUT ON;

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
BEGIN 

    idTelefone := seq_id_telefone.NEXTVAL;

    INSERT INTO tb_as_telefone (ID_TELEFONE, NR_DDI, NR_DDD, NR_TELEFONE)
    VALUES (idTelefone, p_nr_ddi, p_nr_ddd, p_nr_telefone);
    
    INSERT INTO tb_as_usuario (ID_USUARIO, ID_TELEFONE, EMAIL, SENHA, NOME, CPF_CNPJ, GENERO, DT_NASCIMENTO, CM_IMG_PERFIL, DT_REGISTRO)
    VALUES (seq_id_usuario.NEXTVAL, idTelefone, p_email, p_senha, p_nome, p_cpf_cnpj, p_genero, TO_DATE(p_dt_nascimento, 'DD-MM-YYYY'), p_cm_img_perfil, SYSDATE);

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

    INSERT INTO tb_as_local (ID_LOCAL, ID_USUARIO, NM_PAIS, SG_ESTADO, NM_MUNICIPIO, NM_BAIRRO, NM_LOGRADOURO, NR_LOGRADOURO, NR_CEP, DS_COMPLEMENTO)
    VALUES (seq_id_local.NEXTVAL, p_id_usuario, p_nm_pais, p_sg_estado, p_nm_municipio, p_nm_bairro, p_nm_logradouro, p_nr_logradouro, p_nr_cep, p_ds_complemento);

END;

CREATE OR REPLACE PROCEDURE PRC_CADASTRO_ANALISE (
    p_id_local IN NUMBER,
    p_id_status IN NUMBER,
    p_id_planta IN NUMBER,
    p_cm_imagem IN VARCHAR2,
    p_ds_problema IN VARCHAR2,
    p_ds_solucao IN VARCHAR2
) IS
BEGIN 

    INSERT INTO tb_as_analise (ID_ANALISE, ID_LOCAL, ID_STATUS, ID_PLANTA, CM_IMAGEM, DS_PROBLEMA, DS_SOLUCAO, DT_REGISTRO)
    VALUES (seq_id_analise.NEXTVAL, p_id_local, p_id_status, p_id_planta, p_cm_imagem, p_ds_problema, 
    p_ds_solucao, SYSDATE);

END;

-- Exemplos de inserções:
EXEC PRC_CADASTRO_USUARIO ('maria@gmail.com', 'maria123', 'Maria das Dores', '39536942831', 'F', '09/12/1910', 'foto_maria.png', 55, 11, 936271596);
EXEC PRC_CADASTRO_USUARIO ('joao@gmail.com', 'joao123', 'Joao Ricardo Oliveira', '39648271597', 'M', '30/07/2001', 'foto_joao.png', 55, 11, 963984628);

EXEC PRC_CADASTRO_LOCAL(5, 'Brasil', 'RJ', 'Rio de Janeiro', 'Barra da Tijuca', 'Rua das rosas', '89', '36125978', null);