-- =====================================
-- Crear tabla Users
-- =====================================
CREATE TABLE Users (
    id_user INT PRIMARY KEY IDENTITY(1,3), -- IDENTITY 
    nombre VARCHAR(10) NOT NULL, -- NOT NULL 
    apellido_p VARCHAR(10) NOT NULL,
    correo VARCHAR(50) NOT NULL
);
INSERT INTO Users (nombre, apellido_p, correo) VALUES ('aaron','timana','aaron.timana@utec.edu.pe');
select *
from Users;
-- =====================================
-- Modificar la tabla Users para agregar una restricción CHECK
-- para asegurar que el correo contenga '@'
-- =====================================
ALTER TABLE Users
ADD CONSTRAINT CHK_Correos CHECK (correo LIKE '%@antamina.pe%');
-- INSERT INTO Users (nombre,apellido_p,correo) VALUES ('ericka','rumiche','ericka@antamina.pe');

-- =====================================
-- Modificar la tabla Users para agregar una columna apellido_m
-- =====================================
ALTER TABLE Users
ADD apellido_m VARCHAR(10);

-- =====================================
-- Modificar la tabla Users para hacer NOT NULL la columna apellido_m
-- Nota: Antes de hacerla NOT NULL, asegúrate de que todos los registros actuales tengan un valor en esta columna.
-- =====================================
ALTER TABLE Users
ALTER COLUMN apellido_m VARCHAR(10) NOT NULL;
-- ALTERAR COLUMN (NOMBRE COLUMNA) TIPO DE DATO - QUE SEA NO NULO

-- =====================================
-- Crear tabla Cuentas
-- =====================================
CREATE TABLE Cuentas (
    id_cuenta INT PRIMARY KEY IDENTITY(1,1),
    id_user INT NOT NULL,
    saldo FLOAT NOT NULL DEFAULT 0,
    estado BIT NOT NULL,
    FOREIGN KEY (id_user) REFERENCES Users(id_user)
);

-- =====================================
-- Modificar la tabla Cuentas para agregar una restricción CHECK en estado
-- que asegure que no sea NULL
-- =====================================
ALTER TABLE Cuentas
ADD CONSTRAINT CHK_Estado CHECK (estado IN (0,1));
-- AGREGAMOS UNA RESTRICCION LLAMADA CHK_Estado Y VAMOS A REVISAR EL ATRIBUTO ESTADO
-- DONDE EL VALOR ESTE DENTRO DE 'IN'
-- =====================================
-- Cambiar el nombre de la columna correo en la tabla Users a email
-- =====================================
-- =====================================
-- Eliminar la restricción CHECK en la columna correo
-- =====================================
ALTER TABLE Users
DROP CONSTRAINT CHK_Correo;

-- =====================================
-- Cambiar el nombre de la columna correo a email
-- =====================================
EXEC sp_rename 'Users.correo', 'email', 'COLUMN';
-- EXEC sp_rename (UBICAR LA COLUMNA), (NOMBRE A ACTUALIZAR DE LA COLUMNA), (TIPO QUE VAMOS A ACTUALIZAR)
-- =====================================
-- Volver a agregar la restricción CHECK en la columna email
-- =====================================
ALTER TABLE Users
ADD CONSTRAINT CHK_Email CHECK (email LIKE '%@%');
