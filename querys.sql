SELECT * FROM tb_as_analise;
SELECT * FROM tb_as_local;
SELECT * FROM tb_as_telefone;
SELECT * FROM tb_as_usuario;
SELECT * FROM tb_as_planta;
SELECT * FROM tb_as_status;

SELECT * FROM tb_as_auditoria;

select * from tb_as_usuario u inner join tb_as_telefone t on (u.id_telefone = t.id_telefone);

SELECT ID_STATUS, COUNT(*) FROM tb_as_analise GROUP BY ID_STATUS;

SELECT COUNT(*)
FROM TB_AS_ANALISE a 
INNER JOIN TB_AS_STATUS s ON (a.id_status = s.id_status)
WHERE UPPER(s.DS_STATUS) = UPPER('ANALISANDO');

SELECT DS_SOLUCAO
FROM TB_AS_ANALISE
WHERE DS_PROBLEMA LIKE '%' || 'murchas' || '%';