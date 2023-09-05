SELECT * FROM tb_as_analise;
SELECT * FROM tb_as_local; OK
SELECT * FROM tb_as_telefone; OK
SELECT * FROM tb_as_usuario; OK
SELECT * FROM tb_as_planta; OK
SELECT * FROM tb_as_status; OK

SELECT * FROM tb_as_auditoria;

Crie 5 inserts da seguinte tabela, onde onde o nome dela é tb_as_analise: 
Nome        Nulo?    Tipo          
----------- -------- ------------- 
ID_ANALISE  NOT NULL NUMBER(5)     
ID_LOCAL    NOT NULL NUMBER(2)     
ID_STATUS   NOT NULL NUMBER(5)     
ID_PLANTA   NOT NULL NUMBER(5)     
CM_IMAGEM   NOT NULL VARCHAR2(75)  
DS_PROBLEMA NOT NULL VARCHAR2(200) 
DS_SOLUCAO  NOT NULL VARCHAR2(200) 
DT_REGISTRO NOT NULL DATE          
Onde ID_ANALISE será o valor fixo seq_id_analise.NEXTVAL, ID_LOCAL irá começar com 1 e irá encrementando + 1, ID_STATUS será um valor aleatório entre 1 e 5, ID_PLANTA será um valor aleatório entre 1 e 5, CM_IMAGEM será o nome de uma imagem de uma planta com a extensão .png ou .jpg, DS_PROBLEMA será uma descrição sobre o problema em que a planta está enfrentando, DS_SOLUCAO será a solução para o problema, DT_REGISTRO será sysdate