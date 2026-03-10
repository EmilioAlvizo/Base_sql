-- Tabla 1: Deudores al corriente (0 meses sin pagar)
CREATE TABLE deudores_corriente (
    deudor_id        int IDENTITY(1,1) PRIMARY KEY,
    cliente_id       int NOT NULL,
    monto_deuda      float         DEFAULT 0,
    fecha_ultimo_pago datetime     NULL,
    meses_sin_pagar  int           DEFAULT 0,
    fecha_registro   datetime      DEFAULT GETDATE(),
    CONSTRAINT FK_corriente_cliente
        FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);