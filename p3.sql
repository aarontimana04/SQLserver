-- =====================================
-- 1. DDL - Crear una tabla llamada Clientes
-- =====================================
CREATE TABLE Clientes (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(50),
    Apellido NVARCHAR(50),
    FechaRegistro DATE
);

-- =====================================
-- 2. DDL - Modificar la tabla Clientes
-- Agregar una columna llamada Email
-- =====================================
ALTER TABLE Clientes
ADD Email NVARCHAR(100);

-- =====================================
-- 3. DML - Insertar datos en la tabla Clientes
-- =====================================
INSERT INTO Clientes (Nombre, Apellido, FechaRegistro, Email)
VALUES 
    ('Carlos', 'López', '2024-01-01', 'carlos.lopez@email.com'),
    ('Ana', 'Martínez', '2023-05-15', 'ana.martinez@email.com'),
    ('Luis', 'Gómez', '2022-08-30', 'luis.gomez@email.com');

-- =====================================
-- 4. DML - Consultar todos los datos de Clientes
-- =====================================
SELECT * FROM Clientes;

-- =====================================
-- 5. DML - Actualizar el Email de un cliente específico
-- Cambiar el Email del cliente con Id = 1
-- =====================================
UPDATE Clientes
SET Email = 'c.lopez@nuevoemail.com'
WHERE Id = 1;

-- =====================================
-- 6. DML - Eliminar un cliente específico
-- Eliminar al cliente con Id = 2
-- =====================================
DELETE FROM Clientes
WHERE Id = 2;

-- =====================================
-- 7. DDL - Eliminar la tabla Clientes
-- =====================================
DROP TABLE Clientes;
