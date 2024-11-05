-- =====================================
-- Crear tabla Users
-- =====================================
CREATE TABLE Users (
    id_user INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(10) NOT NULL,
    apellido_p VARCHAR(10) NOT NULL,
    correo VARCHAR(50) NOT NULL
);

-- =====================================
-- Modificar la tabla Users para agregar una restricción CHECK
-- para asegurar que el correo contenga '@'
-- =====================================
ALTER TABLE Users
ADD CONSTRAINT CHK_Correo CHECK (correo LIKE '%@%');

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
ADD CONSTRAINT CHK_Estado CHECK (estado IN (0, 1));

-- =====================================
-- Cambiar el nombre de la columna correo en la tabla Users a email
-- =====================================
EXEC sp_rename 'Users.correo', 'email', 'COLUMN';
