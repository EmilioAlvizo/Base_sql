CREATE PROCEDURE sp_MoverDeudores
AS
BEGIN
    SET NOCOUNT ON;

    -- =============================================
    -- PASO 1: Corriente → Atraso (1-2 meses sin pagar)
    -- =============================================
    INSERT INTO deudores_atraso (cliente_id, monto_deuda, fecha_ultimo_pago, meses_sin_pagar)
    SELECT
        cliente_id,
        monto_deuda,
        fecha_ultimo_pago,
        DATEDIFF(month, fecha_ultimo_pago, GETDATE())
    FROM deudores_corriente
    WHERE DATEDIFF(month, fecha_ultimo_pago, GETDATE()) BETWEEN 1 AND 2;

    DELETE FROM deudores_corriente
    WHERE DATEDIFF(month, fecha_ultimo_pago, GETDATE()) BETWEEN 1 AND 2;

    -- =============================================
    -- PASO 2: Atraso → Críticos (3+ meses sin pagar)
    -- =============================================
    INSERT INTO deudores_criticos (cliente_id, monto_deuda, fecha_ultimo_pago, meses_sin_pagar)
    SELECT
        cliente_id,
        monto_deuda,
        fecha_ultimo_pago,
        DATEDIFF(month, fecha_ultimo_pago, GETDATE())
    FROM deudores_atraso
    WHERE DATEDIFF(month, fecha_ultimo_pago, GETDATE()) >= 3;

    DELETE FROM deudores_atraso
    WHERE DATEDIFF(month, fecha_ultimo_pago, GETDATE()) >= 3;

    -- =============================================
    -- PASO 3: Actualizar meses_sin_pagar en críticos
    -- =============================================
    UPDATE deudores_criticos
    SET meses_sin_pagar = DATEDIFF(month, fecha_ultimo_pago, GETDATE())
    WHERE fecha_ultimo_pago IS NOT NULL;

    -- =============================================
    -- PASO 4: Críticos → Corriente (si volvieron a pagar)
    -- =============================================
    INSERT INTO deudores_corriente (cliente_id, monto_deuda, fecha_ultimo_pago, meses_sin_pagar)
    SELECT cliente_id, monto_deuda, fecha_ultimo_pago, 0
    FROM deudores_criticos
    WHERE DATEDIFF(month, fecha_ultimo_pago, GETDATE()) = 0;

    DELETE FROM deudores_criticos
    WHERE DATEDIFF(month, fecha_ultimo_pago, GETDATE()) = 0;

    -- PASO 5: Atraso → Corriente (si volvieron a pagar)
    INSERT INTO deudores_corriente (cliente_id, monto_deuda, fecha_ultimo_pago, meses_sin_pagar)
    SELECT cliente_id, monto_deuda, fecha_ultimo_pago, 0
    FROM deudores_atraso
    WHERE DATEDIFF(month, fecha_ultimo_pago, GETDATE()) = 0;

    DELETE FROM deudores_atraso
    WHERE DATEDIFF(month, fecha_ultimo_pago, GETDATE()) = 0;

    PRINT 'Deudores actualizados correctamente: ' + CONVERT(varchar, GETDATE());
END;