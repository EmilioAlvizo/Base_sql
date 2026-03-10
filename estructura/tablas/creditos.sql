CREATE TABLE creditos (
    credito_id        int IDENTITY(1,1) PRIMARY KEY,
    cliente_id        int           NOT NULL,
    monto_otorgado    float         NOT NULL,   -- cuánto se prestó
    saldo_pendiente   float         NOT NULL,   -- cuánto falta por pagar
    tasa_interes      float         DEFAULT 0,  -- % mensual
    plazo_meses       int           NOT NULL,   -- duración del crédito
    fecha_inicio      datetime      DEFAULT GETDATE(),
    fecha_vencimiento datetime      NOT NULL,   -- fecha límite total
    estatus           varchar(20)   DEFAULT 'activo', -- activo/liquidado/cancelado
    CONSTRAINT FK_credito_cliente
        FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);