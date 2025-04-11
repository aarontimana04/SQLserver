-- CREACION DE TABLA
CREATE TABLE Estudiantes (
    EstudianteID INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Apellido VARCHAR(100),
    Edad INT,
    Promedio DECIMAL(5,2)
);
-- VALORES INSERTADOS EN LA TABLA
INSERT INTO Estudiantes (EstudianteID, Nombre, Apellido, Edad, Promedio)
VALUES (1, 'Lucía', 'Ramírez', 17, 18.50);

INSERT INTO Estudiantes (EstudianteID, Nombre, Apellido, Edad, Promedio)
VALUES (2, 'Carlos', 'Sánchez', 18, 16.75);

INSERT INTO Estudiantes (EstudianteID, Nombre, Apellido, Edad, Promedio)
VALUES (3, 'María', 'Fernández', 17, 19.00);

INSERT INTO Estudiantes (EstudianteID, Nombre, Apellido, Edad, Promedio)
VALUES (4, 'José', 'Pérez', 16, 15.20);

INSERT INTO Estudiantes (EstudianteID, Nombre, Apellido, Edad, Promedio)
VALUES (5, 'Ana', 'Torres', 18, 17.30);

SELECT *
FROM Estudiantes;


-- CREACION DE ROLES: Los roles debemos verlos como cargos y capacidades
CREATE ROLE admi;
CREATE ROLE profesor;
CREATE ROLE estudiante;

-- Crear el LOGIN a nivel de servidor
CREATE LOGIN admin_login WITH PASSWORD = 'TuPassword123!';
CREATE LOGIN profesor_login WITH PASSWORD = 'TuPassword456!';
CREATE LOGIN estudiante_login WITH PASSWORD = 'TuPassword789!';


-- CREACION DE USUARIOS: Debemos verlos como perfiles
-- Logica: Crear [nombre del perfil] cuando nos logeemos como [x_login]
CREATE USER admin_user FOR LOGIN admin_login;
CREATE USER profesor_user FOR LOGIN profesor_login;
CREATE USER estudiante_user FOR LOGIN estudiante_login;

-- USO DE GRANT, DENY y REVOKE

-- Concedemos a quien tenga el rol de ADMI las capacidades SELECT, INSERT, 
-- UPDATE Y DELETE sobre la tabla ESTUDIANTES
GRANT SELECT, INSERT, UPDATE, DELETE ON Estudiantes TO admi;
EXEC sp_addrolemember 'admi', 'admin_user'; -- Asignamos a un perfil un rol

-- Conceder permisos al rol 'profesor'
GRANT SELECT ON Estudiantes TO profesor;
EXEC sp_addrolemember 'profesor', 'profesor_user';

-- Cambias al usuario profesor_user
EXECUTE AS USER = 'profesor_user';
SELECT * FROM Estudiantes;
REVERT; -- volver al usuario original

-- Asignar el rol 'estudiante' sin permisos (por ahora)
EXEC sp_addrolemember 'estudiante', 'estudiante_user';

EXECUTE AS USER = 'estudiante_user';
SELECT *
FROM Estudiantes;
REVERT;

GRANT SELECT ON Estudiantes TO estudiante;

REVOKE SELECT ON Estudiantes TO estudiante;

-- Negar permisos de UPDATE al rol 'profesor'
DENY UPDATE ON Estudiantes TO profesor;

-- Revocar el permiso de INSERT al rol 'admin' (por ejemplo, si queremos quitarlo)
REVOKE INSERT ON Estudiantes TO admin;
