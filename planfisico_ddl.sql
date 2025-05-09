CREATE DATABASE CONTRATOS_DIGITALES;
-- 
CREATE TABLE Personas (
  dni CHAR(8) PRIMARY KEY NOT NULL,
  correo VARCHAR(40) NOT NULL,
  telefono INT NOT NULL,
  nombre_persona VARCHAR(25) NOT NULL,
  primer_apellido VARCHAR(15) NOT NULL,
  segundo_apellido VARCHAR(15) NOT NULL
);
--
CREATE TABLE Empresas (
  id_empresa INT PRIMARY KEY IDENTITY(1,1),
  ruc CHAR(11) NOT NULL,
  nombre_empresa VARCHAR(15) NOT NULL
);
--
CREATE TABLE Rol (
  id_rol INT PRIMARY KEY IDENTITY(1,1),
  nombre_rol VARCHAR(15) NOT NULL,
  detalles VARCHAR(50) NOT NULL
);
-- 
CREATE TABLE Clientes (
  dni CHAR(8) NOT NULL,
  direccion VARCHAR(40) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  FOREIGN KEY (dni) REFERENCES Personas(dni),
  PRIMARY KEY (dni)
);
-- 
CREATE TABLE Usuarios (
  dni CHAR(8) NOT NULL,
  id_empresa INT NOT NULL,
  id_rol INT NOT NULL,
  estado BIT NOT NULL,
  FOREIGN KEY (dni) REFERENCES Personas (dni),
  FOREIGN KEY (id_empresa) REFERENCES Empresas (id_empresa),
  FOREIGN KEY (id_rol) REFERENCES Rol (id_rol),
  PRIMARY KEY (dni) 
);
--
CREATE TABLE Estados (
  id_estado INT PRIMARY KEY IDENTITY(1,1),
  nombre_estado VARCHAR(15) NOT NULL
);
--
CREATE TABLE Grupos (
  id_grupo INT PRIMARY KEY IDENTITY(1,1),
  nombre_grupo VARCHAR(15) NOT NULL
);
-- 
CREATE TABLE ClienteGrupo (
  dni CHAR(8) NOT NULL,
  id_grupo INT NOT NULL,
  fecha_creacion_grupo DATE NOT NULL,
  FOREIGN KEY (dni) REFERENCES Clientes (dni),
  FOREIGN KEY (id_grupo) REFERENCES Grupos (id_grupo),
  PRIMARY KEY (dni, id_grupo)
);
-- 
CREATE TABLE Contratos (
  id_contrato INT PRIMARY KEY IDENTITY(1,1),
  fecha_creacion_contrato DATE NOT NULL,
  dni CHAR(8) NOT NULL,
  id_empresa INT NOT NULL,
  id_estado INT NOT NULL,
  FOREIGN KEY (id_empresa) REFERENCES Empresas (id_empresa),
  FOREIGN KEY (id_estado) REFERENCES Estados (id_estado),
  FOREIGN KEY (dni) REFERENCES Usuarios (dni)
);
-- 
CREATE TABLE Documentos (
  nombre_documento VARCHAR(20) NOT NULL,
  id_contrato INT NOT NULL,
  ruta_documento VARCHAR(50) NOT NULL,
  fecha_adjunto DATE NOT NULL,
  FOREIGN KEY (id_contrato) REFERENCES Contratos (id_contrato),
  PRIMARY KEY (nombre_documento, id_contrato)
);
-- 
CREATE TABLE ValidacionFacial (
  id_validacion INT IDENTITY(1,1) NOT NULL,
  dni CHAR(8) NOT NULL,
  id_estado INT NOT NULL,
  id_contrato INT NOT NULL,
  FOREIGN KEY (dni) REFERENCES Clientes(dni),
  FOREIGN KEY (id_estado) REFERENCES Estados (id_estado),
  FOREIGN KEY (id_contrato) REFERENCES Contratos (id_contrato),
  PRIMARY KEY (id_validacion, dni, id_estado, id_contrato)
);
--
CREATE TABLE Imagenes (
  id_imagen INT IDENTITY(1,1) NOT NULL,
  id_validacion INT NOT NULL,
  dni CHAR(8) NOT NULL,
  id_estado INT NOT NULL,
  id_contrato INT NOT NULL,
  imagen VARCHAR(15) NOT NULL,
  fecha_envio_imagen DATE NOT NULL,
  FOREIGN KEY (id_validacion, dni, id_estado, id_contrato) REFERENCES ValidacionFacial (id_validacion, dni, id_estado, id_contrato),
  PRIMARY KEY (id_imagen, id_validacion, dni, id_estado, id_contrato)
);
--
CREATE TABLE DetallesImagen (
  id_detalles_imagen INT IDENTITY(1,1) NOT NULL,
  detalle_imagen VARCHAR(100) NOT NULL,
  id_imagen INT NOT NULL,
  id_validacion INT NOT NULL,
  dni CHAR(8) NOT NULL,
  id_estado INT NOT NULL,
  id_contrato INT NOT NULL,
  FOREIGN KEY (id_imagen, id_validacion, dni, id_estado, id_contrato) REFERENCES Imagenes (id_imagen, id_validacion, dni, id_estado, id_contrato),
  PRIMARY KEY (id_detalles_imagen, id_imagen, id_validacion, dni, id_estado, id_contrato)
);
