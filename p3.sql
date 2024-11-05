-- =====================================
-- 1. DDL - Crear una tabla llamada Clientes
-- =====================================
CREATE TABLE Clientes (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(50),
    Apellido NVARCHAR(50),
    FechaRegistro DATE,
    Edad INT,
    Email NVARCHAR(100)
);

-- =====================================
-- 2. DDL - Modificar la tabla Clientes
-- Agregar un valor por defecto para FechaRegistro
-- =====================================
ALTER TABLE Clientes
ADD CONSTRAINT DF_FechaRegistro DEFAULT GETDATE() FOR FechaRegistro;

-- =====================================
-- 3. DDL - Agregar una columna con un valor por defecto
-- =====================================
ALTER TABLE Clientes -- 
ADD Estado NVARCHAR(20) DEFAULT 'Activo';
ADD (NOMBRE DE LA COLUMNA) - TIPO DE DATO - POR DEFECTO (VALOR POR DEFECTO)

-- =====================================
-- 4. DDL - Modificar la tabla Clientes
-- Agregar una restricción CHECK para validar la Edad
-- =====================================
ALTER TABLE Clientes
ADD CONSTRAINT CHK_Edad CHECK (Edad >= 18 AND Edad <= 100);
-- ADD RESTRICCION (NOMBRE DE LA RESTRICCION) REVISION (VALOR A REVISAR)

-- ADD CONSTRAINT CHK_FECHA CHECK (FechaRegistro >= '01-01-2018');
-- =====================================
-- 5. DDL - Eliminar una columna
-- Eliminar la columna Estado de la tabla Clientes
-- =====================================
ALTER TABLE Clientes
DROP COLUMN Estado;

-- =====================================
-- 6. DML - Insertar datos en la tabla Clientes
-- Nota: FechaRegistro usará el valor por defecto si no se especifica.
-- =====================================
INSERT INTO Clientes (Nombre, Apellido, Edad, Email)
VALUES 
    ('Carlos', 'López', 30, 'carlos.lopez@email.com'),
    ('Ana', 'Martínez', 25, 'ana.martinez@email.com'),
    ('Luis', 'Gómez', 40, 'luis.gomez@email.com');

-- =====================================
-- 7. DML - Consultar todos los datos de Clientes
-- =====================================
SELECT * FROM Clientes;

-- =====================================
-- 8. DML - Actualizar el Email de un cliente específico
-- Cambiar el Email del cliente con Id = 1
-- =====================================
UPDATE Clientes
SET Email = 'c.lopez@nuevoemail.com'
WHERE Id = 1;

-- =====================================
-- 9. DML - Eliminar un cliente específico
-- Eliminar al cliente con Id = 2
-- =====================================
DELETE FROM Clientes
WHERE Id = 2;

-- =====================================
-- 10. DDL - Eliminar la restricción CHECK en Edad
-- =====================================
ALTER TABLE Clientes
DROP CONSTRAINT CHK_Edad;
-- ELIMINAR RESTRICCION CON EL NOMBRE (X)

-- =====================================
-- 11. DDL - Eliminar la tabla Clientes
-- =====================================
DROP TABLE Clientes;
