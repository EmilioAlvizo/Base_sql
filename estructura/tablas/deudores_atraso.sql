-- Tabla 2: Deudores con atraso leve (1-2 meses sin pagar)
CREATE TABLE deudores_atraso (
    deudor_id        int IDENTITY(1,1) PRIMARY KEY,
    cliente_id       int NOT NULL,
    monto_deuda      float         DEFAULT 0,
    fecha_ultimo_pago datetime     NULL,
    meses_sin_pagar  int           DEFAULT 0,
    fecha_registro   datetime      DEFAULT GETDATE(),
    CONSTRAINT FK_atraso_cliente
        FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);