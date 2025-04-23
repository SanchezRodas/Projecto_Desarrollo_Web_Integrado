-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS BD_PROJECT;
USE BD_PROJECT;

-- =======================
-- TABLA CLIENTE
-- =======================
CREATE TABLE Cliente (
    dni INT UNSIGNED PRIMARY KEY,
    nombre VARCHAR(100),
    direccion VARCHAR(150),
    telefono VARCHAR(20),
    correo VARCHAR(100)
);

-- =======================
-- TABLA HABITACION
-- =======================
CREATE TABLE Habitacion (
    cod VARCHAR(10) PRIMARY KEY,
    tip VARCHAR(30), -- Tipo de habitación
    pre DECIMAL(10,2), -- Precio por noche
    est VARCHAR(20), -- Estado (Disponible, Ocupada, etc.)
    descripcion TEXT
);

-- =======================
-- TABLA EMPLEADO
-- =======================
CREATE TABLE Empleado (
    cod VARCHAR(10) PRIMARY KEY,
    nom VARCHAR(100),
    tip VARCHAR(50), -- Tipo de empleado (Recepcionista, etc.)
    log VARCHAR(50), -- Usuario
    pas VARCHAR(50), -- Contraseña
    correo VARCHAR(100),
    telefono VARCHAR(20)
);

-- =======================
-- TABLA RESERVA
-- =======================
CREATE TABLE Reserva (
    cod VARCHAR(10) PRIMARY KEY,
    fec DATE,          -- Fecha de reserva
    feE DATE,          -- Fecha de entrada
    feS DATE,          -- Fecha de salida
    dias INT,          -- Cantidad de días
    tot DECIMAL(10,2), -- Total de la reserva
    codHab VARCHAR(10),
    dni INT UNSIGNED,
    FOREIGN KEY (codHab) REFERENCES Habitacion(cod),
    FOREIGN KEY (dni) REFERENCES Cliente(dni)
);

-- =======================
-- TABLA ALOJAMIENTO
-- =======================
CREATE TABLE Alojamiento (
    cod VARCHAR(10) PRIMARY KEY,
    fec DATE,              -- Fecha de inicio de alojamiento
    codRes VARCHAR(10),    -- Relacionado con reserva
    codEmp VARCHAR(10),    -- Empleado que lo registró
    FOREIGN KEY (codRes) REFERENCES Reserva(cod),
    FOREIGN KEY (codEmp) REFERENCES Empleado(cod)
);

-- =======================
-- TABLA SERVICIO
-- =======================
CREATE TABLE Servicio (
    codSer VARCHAR(10) PRIMARY KEY,
    pre DECIMAL(10,2),
    tipo VARCHAR(50),
    descripcion TEXT
);

-- =======================
-- TABLA CONSUMO
-- =======================
CREATE TABLE Consumo (
    cod VARCHAR(10) PRIMARY KEY,
    fec DATE,
    tot DECIMAL(10,2),
    codEmp VARCHAR(10),
    codAlo VARCHAR(10),
    observaciones TEXT,
    FOREIGN KEY (codEmp) REFERENCES Empleado(cod),
    FOREIGN KEY (codAlo) REFERENCES Alojamiento(cod)
);

-- =======================
-- TABLA DETALLE CONSUMO
-- =======================
CREATE TABLE DetalleConsumo (
    codCon VARCHAR(10),
    codSer VARCHAR(10),
    cant INT,
    PRIMARY KEY (codCon, codSer),
    FOREIGN KEY (codCon) REFERENCES Consumo(cod),
    FOREIGN KEY (codSer) REFERENCES Servicio(codSer)
);

-- =======================
-- TABLA FACTURA
-- =======================
CREATE TABLE Factura (
    numFa VARCHAR(10) PRIMARY KEY,
    fecFa DATE,
    total DECIMAL(10,2),
    codEmp VARCHAR(10),
    codAlo VARCHAR(10),
    metodoPago VARCHAR(50),
    FOREIGN KEY (codEmp) REFERENCES Empleado(cod),
    FOREIGN KEY (codAlo) REFERENCES Alojamiento(cod)
);
