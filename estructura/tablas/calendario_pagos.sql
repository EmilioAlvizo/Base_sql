-- Un registro por cada mensualidad esperada
CREATE TABLE calendario_pagos (
    pago_id           int IDENTITY(1,1) PRIMARY KEY,
    credito_id        int           NOT NULL,
    numero_pago       int           NOT NULL,   -- 1er mes, 2do mes...
    fecha_esperada    datetime      NOT NULL,   -- cuándo DEBÍA pagar
    monto_esperado    float         NOT NULL,   -- cuánto DEBÍA pagar
    fecha_real        datetime      NULL,       -- cuándo pagó realmente (NULL = no ha pagado)
    monto_pagado      float         DEFAULT 0,
    estatus           varchar(20)   DEFAULT 'pendiente', -- pendiente/pagado/vencido
    CONSTRAINT FK_calendario_credito
        FOREIGN KEY (credito_id) REFERENCES creditos(credito_id)
);