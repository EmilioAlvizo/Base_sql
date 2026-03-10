INSERT INTO deudores_corriente (cliente_id, monto_deuda, fecha_ultimo_pago) VALUES
(1,15000,GETDATE()),
(2,32000,DATEADD(month,-1,GETDATE())),
(3,8500,DATEADD(month,-2,GETDATE())),
(4,47000,DATEADD(month,-3,GETDATE())),
(5,21000,DATEADD(month,-5,GETDATE()));