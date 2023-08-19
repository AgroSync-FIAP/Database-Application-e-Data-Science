-- Gerado por Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   em:        2023-08-19 12:32:53 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE tb_as_analise (
    id_analise  NUMBER(5) NOT NULL,
    id_local    NUMBER(2) NOT NULL,
    id_status   NUMBER(5) NOT NULL,
    id_planta   NUMBER(5) NOT NULL,
    cm_imagem   VARCHAR2(75) NOT NULL,
    ds_problema VARCHAR2(200) NOT NULL,
    ds_solucao  VARCHAR2(200) NOT NULL,
    dt_registro DATE NOT NULL
);

COMMENT ON COLUMN tb_as_analise.id_analise IS
    'Este campo sera para armazenar o id da analise. Ele e obrigatorio e chave primaria.';

COMMENT ON COLUMN tb_as_analise.id_local IS
    'Este campo sera para armazenar o id do local. Ele e obrigatorio e chave estrageira.';

COMMENT ON COLUMN tb_as_analise.id_status IS
    'Este campo sera para armazenar o id do status. Ele e obrigatorio e chave estrageira.';

COMMENT ON COLUMN tb_as_analise.id_planta IS
    'Este campo sera para armazenar o id da planta. Ele e obrigatorio e chave estrageira.';

COMMENT ON COLUMN tb_as_analise.cm_imagem IS
    'Este campo sera para armazenar o caminho da imagem da analise. Ele e obrigatorio.';

COMMENT ON COLUMN tb_as_analise.ds_problema IS
    'Este campo sera para armazenar a descrição da analise. Ele e obrigatorio.';

COMMENT ON COLUMN tb_as_analise.ds_solucao IS
    'Este campo sera para armazenar a descrição da solucao. Ele e obrigatorio.';

COMMENT ON COLUMN tb_as_analise.dt_registro IS
    'Este campo sera para armazenar a data de registro da solucao. Ele e obrigatorio.';

ALTER TABLE tb_as_analise ADD CONSTRAINT tb_as_analises_pk PRIMARY KEY ( id_analise );

CREATE TABLE tb_as_local (
    id_local       NUMBER(2) NOT NULL,
    id_usuario     NUMBER(5) NOT NULL,
    nm_pais        VARCHAR2(75) NOT NULL,
    sg_estado      VARCHAR2(2) NOT NULL,
    nm_municipio   VARCHAR2(100) NOT NULL,
    nm_bairro      VARCHAR2(100) NOT NULL,
    nm_logradouro  VARCHAR2(100) NOT NULL,
    nr_logradouro  VARCHAR2(10) NOT NULL,
    nr_cep         VARCHAR2(8) NOT NULL,
    ds_complemento VARCHAR2(100)
);

COMMENT ON COLUMN tb_as_local.id_local IS
    'Este campo sera para armazenar o id do local. Ele e obrigatorio e chave primaria.';

COMMENT ON COLUMN tb_as_local.id_usuario IS
    'Este campo sera para armazenar o id do usuario. Ele e obrigatorio e chave estrangeira..';

COMMENT ON COLUMN tb_as_local.nm_pais IS
    'Este campo sera para armazenar o nome do pais do local. Ele e obrigatorio.';

COMMENT ON COLUMN tb_as_local.sg_estado IS
    'Este campo sera para armazenar a sigla do estado do local. Ele e obrigatorio.';

COMMENT ON COLUMN tb_as_local.nm_municipio IS
    'Este campo sera para armazenar o nome do municipio do local. Ele e obrigatorio.';

COMMENT ON COLUMN tb_as_local.nm_bairro IS
    'Este campo sera para armazenar o nome do bairro do local. Ele e obrigatorio.';

COMMENT ON COLUMN tb_as_local.nm_logradouro IS
    'Este campo sera para armazenar o nome do logradouro do local. Ele e obrigatorio.';

COMMENT ON COLUMN tb_as_local.nr_logradouro IS
    'Este campo sera para armazenar o numero do logradouro do local. Ele e obrigatorio.';

COMMENT ON COLUMN tb_as_local.nr_cep IS
    'Este campo sera para armazenar o cep do local. Ele e obrigatorio.';

COMMENT ON COLUMN tb_as_local.ds_complemento IS
    'Este campo sera para armazenar o complemento local. Ele e obrigatorio.';

ALTER TABLE tb_as_local ADD CONSTRAINT tb_as_local_pk PRIMARY KEY ( id_local );

CREATE TABLE tb_as_telefone (
    id_telefone NUMBER(5) NOT NULL,
    nr_ddi      NUMBER(2) NOT NULL,
    nr_ddd      NUMBER(2) NOT NULL,
    nr_telefone NUMBER(9) NOT NULL
);

COMMENT ON COLUMN tb_as_telefone.id_telefone IS
    'Este campo sera para armazenar o id do telefone. Ele e obrigatorio e chave primaria.';

COMMENT ON COLUMN tb_as_telefone.nr_ddi IS
    'Este campo sera para armazenar o ddi do telefone. Ele e obrigatorio';

COMMENT ON COLUMN tb_as_telefone.nr_ddd IS
    'Este campo sera para armazenar o ddd do telefone. Ele e obrigatorio.';

COMMENT ON COLUMN tb_as_telefone.nr_telefone IS
    'Este campo sera para armazenar o número do telefone. Ele e obrigatorio.';

ALTER TABLE tb_as_telefone ADD CONSTRAINT tb_as_telefone_pk PRIMARY KEY ( id_telefone );

CREATE TABLE tb_as_usuario (
    id_usuario    NUMBER(5) NOT NULL,
    id_telefone   NUMBER(5) NOT NULL,
    email         VARCHAR2(100) NOT NULL,
    senha         VARCHAR2(50) NOT NULL,
    nome          VARCHAR2(100) NOT NULL,
    cpf_cnpj      VARCHAR2(14) NOT NULL,
    genero        CHAR(1) NOT NULL,
    dt_nascimento DATE NOT NULL,
    cm_img_perfil VARCHAR2(75),
    dt_registro   DATE NOT NULL
);

COMMENT ON COLUMN tb_as_usuario.id_usuario IS
    'Este campo sera para armazenar o id do usuário. Ele e obrigatorio e chave primaria.';

COMMENT ON COLUMN tb_as_usuario.id_telefone IS
    'Este campo sera para armazenar o id do telefone do usuario. Ele e obrigatorio e chave estrangeira.';

COMMENT ON COLUMN tb_as_usuario.email IS
    'Este campo sera para armazenar o email do usuario e sera usado como login. Ele e obrigatorio.';

COMMENT ON COLUMN tb_as_usuario.senha IS
    'Este campo sera para armazenar a senha do usuario e sera usado como senha para o  login. Ele e obrigatorio.';

COMMENT ON COLUMN tb_as_usuario.nome IS
    'Este campo sera para armazenar o nome do usuario. Ele e obrigatorio.';

COMMENT ON COLUMN tb_as_usuario.cpf_cnpj IS
    'Este campo sera para armazenar o cpd ou cnpj do usuario. Ele e obrigatorio.';

COMMENT ON COLUMN tb_as_usuario.genero IS
    'Este campo sera para armazenar o genero do usuario. Ele e obrigatorio.';

COMMENT ON COLUMN tb_as_usuario.dt_nascimento IS
    'Este campo sera para armazenar a data de nascimento do usuario. Ele e obrigatorio.';

COMMENT ON COLUMN tb_as_usuario.cm_img_perfil IS
    'Este campo sera para armazenar o caminho da foto de perfil do usuario.';

COMMENT ON COLUMN tb_as_usuario.dt_registro IS
    'Este campo sera para armazenar a data de registro do usuario. Ele e obrigatorio.';

ALTER TABLE tb_as_usuario ADD CONSTRAINT tb_as_usuario_pk PRIMARY KEY ( id_usuario );

CREATE TABLE tb_planta (
    id_planta       NUMBER(5) NOT NULL,
    nm_comum        VARCHAR2(50) NOT NULL,
    nm_cientifico   VARCHAR2(50),
    ds_planta       VARCHAR2(100),
    cuidados_gerais VARCHAR2(100)
);

COMMENT ON COLUMN tb_planta.id_planta IS
    'Este campo sera para armazenar o id da planta. Ele e obrigatorio e chave primaria.';

COMMENT ON COLUMN tb_planta.nm_comum IS
    'Este campo sera para armazenar o nome comum da planta.  Ele e obrigatorio';

COMMENT ON COLUMN tb_planta.nm_cientifico IS
    'Este campo sera para armazenar o nome cientifico da planta.';

COMMENT ON COLUMN tb_planta.ds_planta IS
    'Este campo sera para armazenar a descricao da planta.';

COMMENT ON COLUMN tb_planta.cuidados_gerais IS
    'Este campo sera para armazenar os cuidados gerais da planta.';

ALTER TABLE tb_planta ADD CONSTRAINT tb_plantas_pk PRIMARY KEY ( id_planta );

CREATE TABLE tb_status (
    id_status NUMBER(5) NOT NULL,
    ds_status VARCHAR2(20) NOT NULL
);

COMMENT ON COLUMN tb_status.id_status IS
    'Este campo sera para armazenar o id do status. Ele e obrigatorio e chave primaria.';

COMMENT ON COLUMN tb_status.ds_status IS
    'Este campo sera para armazenar a descricao do status. Ele e obrigatorio.';

ALTER TABLE tb_status ADD CONSTRAINT tb_status_pk PRIMARY KEY ( id_status );

ALTER TABLE tb_as_analise
    ADD CONSTRAINT tb_as_analises_tb_as_local_fk FOREIGN KEY ( id_local )
        REFERENCES tb_as_local ( id_local );

ALTER TABLE tb_as_analise
    ADD CONSTRAINT tb_as_analises_tb_plantas_fk FOREIGN KEY ( id_planta )
        REFERENCES tb_planta ( id_planta );

ALTER TABLE tb_as_analise
    ADD CONSTRAINT tb_as_analises_tb_status_fk FOREIGN KEY ( id_status )
        REFERENCES tb_status ( id_status );

ALTER TABLE tb_as_local
    ADD CONSTRAINT tb_as_local_tb_as_usuario_fk FOREIGN KEY ( id_usuario )
        REFERENCES tb_as_usuario ( id_usuario );

ALTER TABLE tb_as_usuario
    ADD CONSTRAINT tb_usuario_telefone_fk FOREIGN KEY ( id_telefone )
        REFERENCES tb_as_telefone ( id_telefone );



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             6
-- CREATE INDEX                             0
-- ALTER TABLE                             11
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
