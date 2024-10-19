-- Crear tabla Clientes
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY,   -- Llave primaria
    Nombre NVARCHAR(100),
    Email NVARCHAR(100)
);

-- Crear tabla Productos
CREATE TABLE Productos (
    ProductoID INT PRIMARY KEY,  -- Llave primaria
    Nombre NVARCHAR(100),
    Precio DECIMAL(10, 2)
);

-- Crear tabla Compras
CREATE TABLE Compras (
    CompraID INT PRIMARY KEY,    -- Llave primaria
    ClienteID INT,               -- Llave foránea que se refiere a Clientes
    ProductoID INT,              -- Llave foránea que se refiere a Productos
    Fecha DATE,
    Cantidad INT,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID),
    FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);


-- Insertar datos en la tabla Clientes
INSERT INTO Clientes (ClienteID, Nombre, Email)
VALUES (1, 'Juan Perez', 'juan.perez@example.com'),
       (2, 'Maria Lopez', 'maria.lopez@example.com');

-- Insertar datos en la tabla Productos
INSERT INTO Productos (ProductoID, Nombre, Precio)
VALUES (1, 'Laptop', 999.99),
       (2, 'Mouse', 19.99);

-- Insertar datos en la tabla Compras
INSERT INTO Compras (CompraID, ClienteID, ProductoID, Fecha, Cantidad)
VALUES (1, 1, 1, '2024-10-19', 1),
       (2, 2, 2, '2024-10-18', 2);

SELECT *
FROM Clientes;
-- Actualizacion
UPDATE Clientes
SET Email = 'nuevo.email@example.com'
WHERE ClienteID = 1;

SELECT *
FROM Clientes;

ALTER TABLE Clientes
ADD Direccion NVARCHAR(200);

SELECT *
FROM Clientes;


UPDATE Clientes
SET Direccion = 'Calle Falsa 123'
WHERE ClienteID = 1;

SELECT *
FROM Clientes;



