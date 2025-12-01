-- DDL
CREATE PROCEDURE pa_inse_alum
    @Nombre VARCHAR(100),
    @Apellido VARCHAR(100),
    @FechaNacimiento DATE,
    @Genero CHAR(1),
    @Direccion VARCHAR(200)
AS
BEGIN
    INSERT INTO Alumnos (Nombre, Apellido, FechaNacimiento, Genero, Direccion)
    VALUES (@Nombre, @Apellido, @FechaNacimiento, @Genero, @Direccion);
END;
-- input
EXEC pa_inse_alum 'Aaron', 'Timana', '2003-10-04', 'M', 'Jiron X 746';
EXEC pa_inse_alum 'Fernando', 'Torres', '2000-07-17', 'M', 'Av. Brasil 123';

-- Consulta
SELECT TOP (2) *
FROM Alumnos
ORDER BY AlumnoID DESC;


-- DDL
CREATE PROCEDURE pa_actu_dire
    @AlumnoID INT,
    @NuevaDireccion VARCHAR(200)
AS
BEGIN
    UPDATE Alumnos
    SET Direccion = @NuevaDireccion
    WHERE AlumnoID = @AlumnoID;
END;
-- Consulta 1
SELECT * FROM Alumnos WHERE AlumnoID IN (1,4);
-- input
EXEC pa_actu_dire 1, 'Boulevard Reforma 101';
EXEC pa_actu_dire 4, 'Calle Messi 2022';
-- Consulta 2
SELECT * FROM Alumnos WHERE AlumnoID IN (1,4);

-- DDL
CREATE PROCEDURE pa_prof_curs
    @NombreCurso VARCHAR(100)
AS
BEGIN
    SELECT 
        c.NombreCurso,
        p.Nombre,
        p.Apellido
    FROM Cursos c
    INNER JOIN Profesores p
        ON c.ProfesorID = p.ProfesorID
    WHERE c.NombreCurso = @NombreCurso;
END;
-- input
EXEC pa_prof_curs 'Historia Mundial';

-- DCL
CREATE TABLE LogEliminaciones (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    Tabla NVARCHAR(50) DEFAULT 'Alumnos',
    IDEliminado INT,
    Nombre VARCHAR(100),
    Apellido VARCHAR(100),
    FechaNacimiento DATE,
    Genero CHAR(1),
    Direccion VARCHAR(200),
    Fecha DATETIME DEFAULT GETDATE()
);
-- DDL
CREATE TRIGGER trg_log_eli
ON Alumnos
FOR DELETE
AS
BEGIN
    INSERT INTO LogEliminaciones (IDEliminado, Nombre, Apellido, FechaNacimiento, Genero, Direccion)
    SELECT 
        d.AlumnoID,
        d.Nombre,
        d.Apellido,
        d.FechaNacimiento,
        d.Genero,
        d.Direccion
    FROM deleted d;
END;
-- 
DELETE FROM Alumnos
WHERE Nombre = 'Aaron' AND Apellido = 'Timana';
-- 
SELECT * FROM LogEliminaciones;

-- DDL
CREATE TABLE LogActualizaciones (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    Tabla NVARCHAR(50) DEFAULT 'Alumnos',
    IDEActualizado INT,
    Nombre VARCHAR(100),
    Apellido VARCHAR(100),
    FechaNacimiento DATE,
    Genero CHAR(1),
    Direccion VARCHAR(200),
    MovimientoDato VARCHAR(100),
    Fecha DATETIME DEFAULT GETDATE()
);
--
CREATE TRIGGER trg_log_act
ON Alumnos
FOR UPDATE
AS
BEGIN
    -- Datos antiguos
    INSERT INTO LogActualizaciones (IDEActualizado, Nombre, Apellido, FechaNacimiento, Genero, Direccion, MovimientoDato)
    SELECT 
        d.AlumnoID,
        d.Nombre,
        d.Apellido,
        d.FechaNacimiento,
        d.Genero,
        d.Direccion,
        'Dato Antiguo'
    FROM deleted d;

    -- Datos nuevos
    INSERT INTO LogActualizaciones (IDEActualizado, Nombre, Apellido, FechaNacimiento, Genero, Direccion, MovimientoDato)
    SELECT 
        i.AlumnoID,
        i.Nombre,
        i.Apellido,
        i.FechaNacimiento,
        i.Genero,
        i.Direccion,
        'Dato Nuevo'
    FROM inserted i;
END;

-- 
UPDATE Alumnos
SET Nombre = 'Catalino'
WHERE AlumnoID = 8;

--
SELECT * FROM LogActualizaciones;


