-- Inserindo dados iniciais

INSERT INTO tb_as_telefone (ID_TELEFONE, NR_DDI, NR_DDD, NR_TELEFONE)
    VALUES (seq_id_telefone.NEXTVAL, 55, 11, 935684267);
INSERT INTO tb_as_telefone (ID_TELEFONE, NR_DDI, NR_DDD, NR_TELEFONE)
    VALUES (seq_id_telefone.NEXTVAL, 55, 21, 932689367);
INSERT INTO tb_as_telefone (ID_TELEFONE, NR_DDI, NR_DDD, NR_TELEFONE)
    VALUES (seq_id_telefone.NEXTVAL, 55, 31, 932974268);
INSERT INTO tb_as_telefone (ID_TELEFONE, NR_DDI, NR_DDD, NR_TELEFONE)
    VALUES (seq_id_telefone.NEXTVAL, 55, 41, 939286832);
INSERT INTO tb_as_telefone (ID_TELEFONE, NR_DDI, NR_DDD, NR_TELEFONE)
    VALUES (seq_id_telefone.NEXTVAL, 55, 41, 949382859);


INSERT INTO tb_as_usuario (ID_USUARIO, ID_TELEFONE, EMAIL, SENHA, NOME, CPF_CNPJ, GENERO, DT_NASCIMENTO, DT_REGISTRO)
    VALUES (seq_id_usuario.NEXTVAL, 1, 'vinicius@email.com', 'Vincius123', 'Vinicius de Oliveira', '03954810000135', 'M', TO_DATE('15/05/2003', 'DD-MM-YYYY'), SYSDATE);
INSERT INTO tb_as_usuario (ID_USUARIO, ID_TELEFONE, EMAIL, SENHA, NOME, CPF_CNPJ, GENERO, DT_NASCIMENTO, DT_REGISTRO)
    VALUES (seq_id_usuario.NEXTVAL, 2, 'maria@email.com', 'Maria123', 'Maria da Lima Silva', '26942875369', 'F', TO_DATE('21/03/1930', 'DD-MM-YYYY'), SYSDATE);
INSERT INTO tb_as_usuario (ID_USUARIO, ID_TELEFONE, EMAIL, SENHA, NOME, CPF_CNPJ, GENERO, DT_NASCIMENTO, DT_REGISTRO)
    VALUES (seq_id_usuario.NEXTVAL, 3, 'jose@email.com', 'Jose123', 'Jose Carlos Souza', '36256938000123', 'M', TO_DATE('30/09/1999', 'DD-MM-YYYY'), SYSDATE);
INSERT INTO tb_as_usuario (ID_USUARIO, ID_TELEFONE, EMAIL, SENHA, NOME, CPF_CNPJ, GENERO, DT_NASCIMENTO, DT_REGISTRO)
    VALUES (seq_id_usuario.NEXTVAL, 4, 'camila@email.com', 'Camila123', 'Camila da Silva de Souza', '39658423698', 'F', TO_DATE('29/07/2004', 'DD-MM-YYYY'), SYSDATE);
INSERT INTO tb_as_usuario (ID_USUARIO, ID_TELEFONE, EMAIL, SENHA, NOME, CPF_CNPJ, GENERO, DT_NASCIMENTO, DT_REGISTRO)
    VALUES (seq_id_usuario.NEXTVAL, 5, 'ricardo@email.com', 'Ricardo123', 'Ricardo dos Santos Cruz', '03954810000135', 'M', TO_DATE('01/03/1960', 'DD-MM-YYYY'), SYSDATE);


INSERT INTO tb_as_status (ID_STATUS, DS_STATUS)
    VALUES (seq_id_status.NEXTVAL, 'Morta');
INSERT INTO tb_as_status (ID_STATUS, DS_STATUS)
    VALUES (seq_id_status.NEXTVAL, 'Em progresso');
INSERT INTO tb_as_status (ID_STATUS, DS_STATUS)
    VALUES (seq_id_status.NEXTVAL, 'Em tratamento');
INSERT INTO tb_as_status (ID_STATUS, DS_STATUS)
    VALUES (seq_id_status.NEXTVAL, 'Analisando');
INSERT INTO tb_as_status (ID_STATUS, DS_STATUS)
    VALUES (seq_id_status.NEXTVAL, 'Curada');

INSERT INTO tb_as_planta (ID_PLANTA, NM_COMUM, NM_CIENTIFICO, DS_PLANTA, CUIDADOS_GERAIS)
    VALUES (seq_id_planta.NEXTVAL, 'Rosa', 'Rosa spp.', 'A rosa é uma planta conhecida por suas flores delicadas e perfumadas.', 'A rosa requer rega regular e luz solar direta para florescer bem.');
INSERT INTO tb_as_planta (ID_PLANTA, NM_COMUM, NM_CIENTIFICO, DS_PLANTA, CUIDADOS_GERAIS)
    VALUES (seq_id_planta.NEXTVAL, 'Lírio', 'Lilium spp.', 'O lírio é uma planta de flores vistosas e variadas cores.', 'Os lírios preferem solo bem drenado e devem ser regados regularmente.');
INSERT INTO tb_as_planta (ID_PLANTA, NM_COMUM, NM_CIENTIFICO, DS_PLANTA, CUIDADOS_GERAIS)
    VALUES (seq_id_planta.NEXTVAL, 'Cacto', 'Cactaceae', 'Os cactos são plantas suculentas conhecidas por sua resistência à seca.', 'Os cactos precisam de pouca água e luz solar direta.');
INSERT INTO tb_as_planta (ID_PLANTA, NM_COMUM, NM_CIENTIFICO, DS_PLANTA, CUIDADOS_GERAIS)
    VALUES (seq_id_planta.NEXTVAL, 'Orquídea', 'Orchidaceae', 'As orquídeas são conhecidas por suas flores elegantes e variadas.', 'As orquídeas necessitam de umidade constante e luz indireta.');
INSERT INTO tb_as_planta (ID_PLANTA, NM_COMUM, NM_CIENTIFICO, DS_PLANTA, CUIDADOS_GERAIS)
    VALUES (seq_id_planta.NEXTVAL, 'Samambaia', 'Nephrolepis exaltata', 'A samambaia é uma planta que gosta de ambientes úmidos e sombreados.', 'Mantenha o solo da samambaia sempre úmido e evite luz solar direta.');


INSERT INTO tb_as_local (ID_LOCAL, ID_USUARIO, NM_PAIS, SG_ESTADO, NM_MUNICIPIO, NM_BAIRRO, NM_LOGRADOURO, NR_LOGRADOURO, NR_CEP, DS_COMPLEMENTO)
    VALUES (seq_id_local.NEXTVAL, 1, 'Brasil', 'SP', 'São Paulo', 'Centro', 'Avenida Paulista', '123', '01234567', 'Apto 101');
INSERT INTO tb_as_local (ID_LOCAL, ID_USUARIO, NM_PAIS, SG_ESTADO, NM_MUNICIPIO, NM_BAIRRO, NM_LOGRADOURO, NR_LOGRADOURO, NR_CEP, DS_COMPLEMENTO)
    VALUES (seq_id_local.NEXTVAL, 2, 'Brasil', 'RJ', 'Rio de Janeiro', 'Copacabana', 'Rua Nossa Senhora de Copacabana', '456', '22334455', 'Casa 2A');
INSERT INTO tb_as_local (ID_LOCAL, ID_USUARIO, NM_PAIS, SG_ESTADO, NM_MUNICIPIO, NM_BAIRRO, NM_LOGRADOURO, NR_LOGRADOURO, NR_CEP, DS_COMPLEMENTO)
    VALUES (seq_id_local.NEXTVAL, 3, 'Brasil', 'MG', 'Belo Horizonte', 'Savassi', 'Avenida Getúlio Vargas', '789', '30123456', NULL);
INSERT INTO tb_as_local (ID_LOCAL, ID_USUARIO, NM_PAIS, SG_ESTADO, NM_MUNICIPIO, NM_BAIRRO, NM_LOGRADOURO, NR_LOGRADOURO, NR_CEP, DS_COMPLEMENTO)
    VALUES (seq_id_local.NEXTVAL, 4, 'Brasil', 'RS', 'Porto Alegre', 'Moinhos de Vento', 'Rua Padre Chagas', '101', '90450123', 'Sala 3');
INSERT INTO tb_as_local (ID_LOCAL, ID_USUARIO, NM_PAIS, SG_ESTADO, NM_MUNICIPIO, NM_BAIRRO, NM_LOGRADOURO, NR_LOGRADOURO, NR_CEP, DS_COMPLEMENTO)
    VALUES (seq_id_local.NEXTVAL, 5, 'Brasil', 'DF', 'Brasília', 'Asa Norte', 'Quadra 102', 'Apto 501', '70000123', 'Bloco B');


INSERT INTO tb_as_analise (ID_ANALISE, ID_LOCAL, ID_STATUS, ID_PLANTA, CM_IMAGEM, DS_PROBLEMA, DS_SOLUCAO, DT_REGISTRO)
    VALUES (seq_id_analise.NEXTVAL, 1, ROUND(DBMS_RANDOM.VALUE(1, 5)), ROUND(DBMS_RANDOM.VALUE(1, 5)), 'planta1.jpg', 'A planta apresenta folhas murchas.', 'Aumentar a rega e verificar a exposição solar.', SYSDATE);
INSERT INTO tb_as_analise (ID_ANALISE, ID_LOCAL, ID_STATUS, ID_PLANTA, CM_IMAGEM, DS_PROBLEMA, DS_SOLUCAO, DT_REGISTRO)
    VALUES (seq_id_analise.NEXTVAL, 2, ROUND(DBMS_RANDOM.VALUE(1, 5)), ROUND(DBMS_RANDOM.VALUE(1, 5)), 'planta2.png', 'A planta está com folhas amareladas.', 'Adicionar fertilizante e ajustar a rega.', SYSDATE);
INSERT INTO tb_as_analise (ID_ANALISE, ID_LOCAL, ID_STATUS, ID_PLANTA, CM_IMAGEM, DS_PROBLEMA, DS_SOLUCAO, DT_REGISTRO)
    VALUES (seq_id_analise.NEXTVAL, 3, ROUND(DBMS_RANDOM.VALUE(1, 5)), ROUND(DBMS_RANDOM.VALUE(1, 5)), 'planta3.jpg', 'A planta possui pragas nas folhas.', 'Usar inseticida e remover as folhas afetadas.', SYSDATE);
INSERT INTO tb_as_analise (ID_ANALISE, ID_LOCAL, ID_STATUS, ID_PLANTA, CM_IMAGEM, DS_PROBLEMA, DS_SOLUCAO, DT_REGISTRO)
    VALUES (seq_id_analise.NEXTVAL, 4, ROUND(DBMS_RANDOM.VALUE(1, 5)), ROUND(DBMS_RANDOM.VALUE(1, 5)), 'planta4.jpg', 'A planta está com excesso de água.', 'Reduzir a rega e melhorar a drenagem do solo.', SYSDATE);
INSERT INTO tb_as_analise (ID_ANALISE, ID_LOCAL, ID_STATUS, ID_PLANTA, CM_IMAGEM, DS_PROBLEMA, DS_SOLUCAO, DT_REGISTRO)
    VALUES (seq_id_analise.NEXTVAL, 5, ROUND(DBMS_RANDOM.VALUE(1, 5)), ROUND(DBMS_RANDOM.VALUE(1, 5)), 'planta5.png', 'A planta está com manchas nas folhas.', 'Identificar a causa das manchas e tratá-las.', SYSDATE);

COMMIT;

-- Realizando updates

UPDATE tb_as_analise 
    SET CM_IMAGEM = 'nova_imagem_planta.png'
    WHERE ID_ANALISE = 3;

UPDATE tb_as_telefone
    SET NR_TELEFONE = '966309946'
    WHERE ID_TELEFONE = 2;

COMMIT;