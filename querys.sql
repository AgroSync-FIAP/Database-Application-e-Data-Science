SELECT * FROM tb_as_analise;
SELECT * FROM tb_as_local;
SELECT * FROM tb_as_telefone;
SELECT * FROM tb_as_usuario;
SELECT * FROM tb_as_planta;
SELECT * FROM tb_as_status;

SELECT * FROM tb_as_auditoria;

select * from tb_as_usuario u inner join tb_as_telefone t on (u.id_telefone = t.id_telefone);
SELECT ID_STATUS, COUNT(*) FROM tb_as_analise GROUP BY ID_STATUS;