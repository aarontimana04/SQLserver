-- BASE DE DATOS
-- Objetivo: Crear una API desde cero para sugerir peliculas basados en gustos
-- La idea es que el usuario ingrese sus preferencias y luego filtrar aquellas películas que cumplen esos gustos, 
-- sea por genero o porque le agrada las peliculas producidas por ciertas productoras
CREATE TABLE Usuarios(
  id_usuario INT PRIMARY KEY IDENTITY(1,1),
  username VARCHAR(20),
  correo VARCHAR(30),
  password VARCHAR(30)
);

CREATE TABLE Preferencias(
  id_preferencia INT PRIMARY KEY IDENTITY(1,1),
  nombre_preferencia VARCHAR(20)
);

CREATE TABLE Usuario-Preferencias(
  id_usuario INT, 
  id_preferencia INT,
  FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
  FOREIGN KEY (id_preferencia) REFERENCES Preferencias(id_preferencia)
);

CREATE TABLE Peliculas(
  id_pelicula INT PRIMARY KEY IDENTITY(1,1),
  nombre_pelicula VARCHAR(30),
  genero VARCHAR(15)
);

CREATE TABLE Productoras(
  id_productora INT PRIMARY KEY IDENTITY(1,1),
  nombre_productora VARCHAR(30)
);

CREATE TABLE Produce(
  id_pelicula INT,
  id_productora INT,
  FOREIGN KEY (id_pelicula) REFERENCES Peliculas (id_pelicula),
  FOREIGN KEY (id_productora) REFERENCES Productoras (id_productora)
);

-- Consultas para extraer las peliculas que cumplan con los gustos
SELECT P.nombre_pelicula
FROM Peliculas AS P
JOIN Preferencias AS PF
ON P.genero = PF.nombre_preferencia
JOIN Productoras AS PT
ON PT.nombre_productora = PF.nombre_preferencia
JOIN Usuario-Preferencia AS U
ON U.id_preferencia = PF.id_preferencia
WHERE U.id_usuario = id_user;

-- funcion de llamado
CREATE OR REPLACE FUNCTION list_pref(INT id_user)
AS BEGIN
  SELECT P.nombre_pelicula
  FROM Peliculas AS P
  JOIN Preferencias AS PF
  ON P.genero = PF.nombre_preferencia
  JOIN Productoras AS PT
  ON PT.nombre_productora = PF.nombre_preferencia
  JOIN Usuario-Preferencia AS U
  ON U.id_preferencia = PF.id_preferencia
  WHERE U.id_usuario = id_user;
END;









