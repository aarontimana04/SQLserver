CREATE DATABASE CONTRATOS_DIGITALES;

USE CONTRATOS_DIGITALES;
CREATE TABLE Personas (
  dni CHAR(8),
  correo VARCHAR(25),
  telefono INT,
  nombre_persona VARCHAR(25),
  primer_apellido VARCHAR(15),
  segundo_apellido VARCHAR(15)
);

CREATE TABLE Empresas (
  id_empresa INT IDENTITY(1,1),
  ruc CHAR(11),
  nombre_empresa VARCHAR(15)
);

CREATE TABLE Rol (
  id_rol INT IDENTITY(1,1),
  nombre_rol VARCHAR(15),
  detalles VARCHAR(50)
);

CREATE TABLE Clientes (
  dni CHAR(8),
  direccion VARCHAR(25),
  fecha_nacimiento DATE
);

CREATE TABLE Usuarios (
  dni CHAR(8),
  id_empresa INT,
  id_rol INT,
  estado BIT
);

CREATE TABLE Estados (
  id_estado INT IDENTITY(1,1),
  nombre_estado VARCHAR(15)
);

CREATE TABLE Grupos (
  id_grupo INT IDENTITY(1,1),
  nombre_grupo VARCHAR(15)
);

CREATE TABLE ClienteGrupo (
  dni CHAR(8),
  id_grupo INT,
  fecha_creacion_grupo DATE
);

CREATE TABLE Contratos (
  id_contrato INT IDENTITY(1,1),
  fecha_creacion_contrato DATE,
  dni CHAR(8),
  id_empresa INT,
  id_estado INT
);

CREATE TABLE Documentos (
  nombre_documento VARCHAR(20),
  id_contrato INT,
  ruta_documento VARCHAR(50),
  fecha_adjunto DATE
);

CREATE TABLE ValidacionFacial (
  id_validacion INT IDENTITY(1,1),
  dni CHAR(8),
  id_estado INT,
  id_contrato INT
);

CREATE TABLE Imagenes (
  id_imagen INT IDENTITY(1,1),
  id_validacion INT,
  dni CHAR(8),
  id_estado INT,
  id_contrato INT,
  imagen VARCHAR(15),
  fecha_envio_imagen DATE
);

CREATE TABLE DetallesImagen (
  id_detalles_imagen INT IDENTITY(1,1),
  detalle_imagen VARCHAR(100),
  id_imagen INT,
  id_validacion INT,
  dni CHAR(8),
  id_estado INT,
  id_contrato INT
);

-- Agregar restricciones con ALTER TABLE

-- Personas
ALTER TABLE Personas
  ADD CONSTRAINT PK_Personas PRIMARY KEY (dni),
      CONSTRAINT NN_Personas_dni CHECK (dni IS NOT NULL),
      CONSTRAINT NN_Personas_correo CHECK (correo IS NOT NULL),
      CONSTRAINT NN_Personas_telefono CHECK (telefono IS NOT NULL),
      CONSTRAINT NN_Personas_nombre_persona CHECK (nombre_persona IS NOT NULL),
      CONSTRAINT NN_Personas_primer_apellido CHECK (primer_apellido IS NOT NULL),
      CONSTRAINT NN_Personas_segundo_apellido CHECK (segundo_apellido IS NOT NULL);

-- Empresas
ALTER TABLE Empresas
  ADD CONSTRAINT PK_Empresas PRIMARY KEY (id_empresa),
      CONSTRAINT NN_Empresas_ruc CHECK (ruc IS NOT NULL),
      CONSTRAINT NN_Empresas_nombre_empresa CHECK (nombre_empresa IS NOT NULL);

-- Rol
ALTER TABLE Rol
  ADD CONSTRAINT PK_Rol PRIMARY KEY (id_rol),
      CONSTRAINT NN_Rol_nombre_rol CHECK (nombre_rol IS NOT NULL),
      CONSTRAINT NN_Rol_detalles CHECK (detalles IS NOT NULL);

-- Clientes
ALTER TABLE Clientes
  ADD CONSTRAINT PK_Clientes PRIMARY KEY (dni),
      CONSTRAINT FK_Clientes_dni FOREIGN KEY (dni) REFERENCES Personas (dni),
      CONSTRAINT NN_Clientes_direccion CHECK (direccion IS NOT NULL),
      CONSTRAINT NN_Clientes_fecha_nacimiento CHECK (fecha_nacimiento IS NOT NULL);

-- Usuarios
ALTER TABLE Usuarios
  ADD CONSTRAINT PK_Usuarios PRIMARY KEY (dni),
      CONSTRAINT FK_Usuarios_dni FOREIGN KEY (dni) REFERENCES Personas (dni),
      CONSTRAINT FK_Usuarios_id_empresa FOREIGN KEY (id_empresa) REFERENCES Empresas (id_empresa),
      CONSTRAINT FK_Usuarios_id_rol FOREIGN KEY (id_rol) REFERENCES Rol (id_rol),
      CONSTRAINT NN_Usuarios_estado CHECK (estado IS NOT NULL);

-- Estados
ALTER TABLE Estados
  ADD CONSTRAINT PK_Estados PRIMARY KEY (id_estado),
      CONSTRAINT NN_Estados_nombre_estado CHECK (nombre_estado IS NOT NULL);

-- Grupos
ALTER TABLE Grupos
  ADD CONSTRAINT PK_Grupos PRIMARY KEY (id_grupo),
      CONSTRAINT NN_Grupos_nombre_grupo CHECK (nombre_grupo IS NOT NULL);

-- ClienteGrupo
ALTER TABLE ClienteGrupo
  ADD CONSTRAINT PK_ClienteGrupo PRIMARY KEY (dni, id_grupo),
      CONSTRAINT FK_ClienteGrupo_dni FOREIGN KEY (dni) REFERENCES Clientes (dni),
      CONSTRAINT FK_ClienteGrupo_id_grupo FOREIGN KEY (id_grupo) REFERENCES Grupos (id_grupo),
      CONSTRAINT NN_ClienteGrupo_fecha_creacion_grupo CHECK (fecha_creacion_grupo IS NOT NULL);

-- Contratos
ALTER TABLE Contratos
  ADD CONSTRAINT PK_Contratos PRIMARY KEY (id_contrato),
      CONSTRAINT FK_Contratos_dni FOREIGN KEY (dni) REFERENCES Usuarios (dni),
      CONSTRAINT FK_Contratos_id_empresa FOREIGN KEY (id_empresa) REFERENCES Empresas (id_empresa),
      CONSTRAINT FK_Contratos_id_estado FOREIGN KEY (id_estado) REFERENCES Estados (id_estado),
      CONSTRAINT NN_Contratos_fecha_creacion_contrato CHECK (fecha_creacion_contrato IS NOT NULL);

-- Documentos
ALTER TABLE Documentos
  ADD CONSTRAINT PK_Documentos PRIMARY KEY (nombre_documento, id_contrato),
      CONSTRAINT FK_Documentos_id_contrato FOREIGN KEY (id_contrato) REFERENCES Contratos (id_contrato),
      CONSTRAINT NN_Documentos_ruta_documento CHECK (ruta_documento IS NOT NULL),
      CONSTRAINT NN_Documentos_fecha_adjunto CHECK (fecha_adjunto IS NOT NULL);

-- ValidacionFacial
ALTER TABLE ValidacionFacial
  ADD CONSTRAINT PK_ValidacionFacial PRIMARY KEY (id_validacion, dni, id_estado, id_contrato),
      CONSTRAINT FK_ValidacionFacial_dni FOREIGN KEY (dni) REFERENCES Clientes (dni),
      CONSTRAINT FK_ValidacionFacial_id_estado FOREIGN KEY (id_estado) REFERENCES Estados (id_estado),
      CONSTRAINT FK_ValidacionFacial_id_contrato FOREIGN KEY (id_contrato) REFERENCES Contratos (id_contrato);

-- Imagenes
ALTER TABLE Imagenes
  ADD CONSTRAINT PK_Imagenes PRIMARY KEY (id_imagen, id_validacion, dni, id_estado, id_contrato),
      CONSTRAINT FK_Imagenes_validacion FOREIGN KEY (id_validacion, dni, id_estado, id_contrato) REFERENCES ValidacionFacial (id_validacion, dni, id_estado, id_contrato),
      CONSTRAINT NN_Imagenes_imagen CHECK (imagen IS NOT NULL),
      CONSTRAINT NN_Imagenes_fecha_envio_imagen CHECK (fecha_envio_imagen IS NOT NULL);

-- DetallesImagen
ALTER TABLE DetallesImagen
  ADD CONSTRAINT PK_DetallesImagen PRIMARY KEY (id_detalles_imagen, id_imagen, id_validacion, dni, id_estado, id_contrato),
      CONSTRAINT FK_DetallesImagen_imagen FOREIGN KEY (id_imagen, id_validacion, dni, id_estado, id_contrato) REFERENCES Imagenes (id_imagen, id_validacion, dni, id_estado, id_contrato),
      CONSTRAINT NN_DetallesImagen_detalle_imagen CHECK (detalle_imagen IS NOT NULL);
