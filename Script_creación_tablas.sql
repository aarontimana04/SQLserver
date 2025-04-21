CREATE DATABASE TravelSmart;
GO

USE TravelSmart;
GO

CREATE TABLE Clientes
(
  idCliente INT NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  correo VARCHAR(100) NOT NULL,
  telefono CHAR(9) NOT NULL,
  dni CHAR(8) NOT NULL,
  PRIMARY KEY (idCliente)
);
GO

CREATE TABLE Hoteles
(
  idHotel INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  direccion VARCHAR(150) NOT NULL,
  PRIMARY KEY (idHotel)
);
GO

CREATE TABLE Reservas
(
  idReserva INT NOT NULL,
  fechaInicio DATE NOT NULL,
  fechaFin DATE NOT NULL,
  cantidadPersonas INT NOT NULL,
  idCliente INT NOT NULL,
  idHotel INT NOT NULL,
  PRIMARY KEY (idReserva),
  FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente),
  FOREIGN KEY (idHotel) REFERENCES Hoteles(idHotel)
);
GO

CREATE TABLE Pagos
(
  idPago INT NOT NULL,
  fechaPago DATE NOT NULL,
  monto FLOAT NOT NULL,
  idReserva INT NOT NULL,
  PRIMARY KEY (idPago),
  FOREIGN KEY (idReserva) REFERENCES Reservas(idReserva)
);
GO