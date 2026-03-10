-- insertar datos de prueba
:r ../data/seeds/deudores_prueba.sql

-- ver estado inicial
select * from deudores_corriente;
select * from deudores_atraso;
select * from deudores_criticos;

-- ejecutar procedimiento
EXEC sp_MoverDeudores;

-- verificar resultados
SELECT 'CORRIENTE' as tabla, cliente_id, monto_deuda, meses_sin_pagar FROM deudores_corriente
UNION ALL
SELECT 'ATRASO', cliente_id, monto_deuda, meses_sin_pagar FROM deudores_atraso
UNION ALL
SELECT 'CRITICOS', cliente_id, monto_deuda, meses_sin_pagar FROM deudores_criticos
ORDER BY tabla, cliente_id;