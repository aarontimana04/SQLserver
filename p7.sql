-- SESION 10E (ejemplo faltante)
-- CREACION DE TABLA PERSONA PARA EJEMPLO
CREATE TABLE Personas (
    id_persona INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(20),
    apellido VARCHAR(20),
    fecha_nacimiento DATE,
    direccion VARCHAR(50)
);

CREATE TABLE Empleados (
    id_empleado INT PRIMARY KEY IDENTITY(1,1),
    id_persona INT,
    nombre VARCHAR(20),
    apellido VARCHAR(20),
    fecha_ingreso DATE,
    puesto VARCHAR(30),
    FOREIGN KEY (id_persona) REFERENCES Personas(id_persona)
);

-- INSERCION DE DATOS EN LA TABLA PERSONAS
INSERT INTO Personas (nombre, apellido, fecha_nacimiento, direccion)
VALUES 
('Juan', 'Perez', '1985-07-15', 'Av. Principal 123'),
('Maria', 'Lopez', '1990-03-22', 'Calle Secundaria 456'),
('Carlos', 'Gomez', '1975-10-30', 'Jr. Los Robles 789'),
('Ana', 'Martinez', '2001-05-12', 'Av. Las Flores 101'),
('Luis', 'Diaz', '1995-11-01', 'Calle Las Palmas 202'),
('Paula', 'Torres', '1998-08-23', 'Jr. Los Sauces 303'),
('Jorge', 'Ramirez', '1983-04-16', 'Av. El Sol 404'),
('Lucia', 'Castro', '1970-12-20', 'Calle La Paz 505'),
('Raul', 'Reyes', '1988-09-25', 'Jr. Los Pinos 606'),
('Sofia', 'Mendoza', '2002-02-14', 'Av. Libertad 707');

-- VERIFICAR DATA EN TABLA PERSONAS
SELECT *
FROM Personas;

-- USO DE INSERT TO + SELECT
-- CASO 1
INSERT INTO Empleados (id_persona, nombre, apellido, fecha_ingreso, puesto)
SELECT P.id_persona, P.nombre, P.apellido, GETDATE(), 'administrador'
FROM Personas as P
WHERE id_persona = 4;
-- CASO 2
INSERT INTO Empleados (id_persona, nombre, apellido, fecha_ingreso, puesto)
SELECT P.id_persona, P.nombre, P.apellido, GETDATE(), 'operarios'
FROM Personas as P
WHERE P.fecha_nacimiento BETWEEN '1988-01-01' AND '1990-12-31';

-- VERIFICAR DATA EN TABLA EMPLEADOS
SELECT *
FROM Empleados;

DELETE FROM Empleados
WHERE id_empleado BETWEEN 1 AND 4; 

-- SESION 11
-- GROUP BY + HAVING, ORDER BY, FUNCIONES DE AGREGACION
-- CREACION DE TABLA VENTAS 
CREATE TABLE Ventas (
    id_venta INT PRIMARY KEY,
    vendedor VARCHAR(50),
    producto VARCHAR(50),
    cantidad INT,
    precio_unitario DECIMAL(10, 2),
    fecha_venta DATE
);
-- INSERCION DE DATOS
INSERT INTO Ventas (id_venta, vendedor, producto, cantidad, precio_unitario, fecha_venta)
VALUES
(1, 'Carlos', 'Laptop', 5, 800.00, '2024-01-10'),
(2, 'Carlos', 'Teclado', 10, 20.00, '2024-01-15'),
(3, 'Maria', 'Laptop', 2, 850.00, '2024-02-05'),
(4, 'Luis', 'Mouse', 15, 10.00, '2024-02-10'),
(5, 'Ana', 'Monitor', 3, 150.00, '2024-02-15'),
(6, 'Carlos', 'Laptop', 1, 800.00, '2024-03-01'),
(7, 'Maria', 'Monitor', 5, 145.00, '2024-03-10'),
(8, 'Luis', 'Teclado', 8, 22.00, '2024-03-15'),
(9, 'Ana', 'Laptop', 3, 800.00, '2024-03-20'),
(10, 'Luis', 'Monitor', 7, 140.00, '2024-03-25');
-- VERIFICAR DATA
SELECT *
FROM Ventas;

-- GROUP BY + HAVING
-- Supongamos que queremos ver cuántas veces cada vendedor ha vendido "Laptops" 
-- y queremos mostrar solo aquellos vendedores que han vendido más de 2 laptops en total

SELECT vendedor, COUNT(*) AS total_ventas_laptop
FROM Ventas
WHERE producto = 'Laptop'
GROUP BY vendedor
HAVING COUNT(*) > 1;

-- ORDER BY
SELECT id_venta, vendedor, producto, cantidad, precio_unitario, fecha_venta
FROM Ventas
ORDER BY vendedor ASC, fecha_venta DESC;

-- E AIX
CREATE TABLE Compras (
    id_compra INT PRIMARY KEY,
    cliente VARCHAR(50),
    producto VARCHAR(50),
    cantidad INT,
    precio_unitario DECIMAL(10, 2),
    fecha_compra DATE
);

INSERT INTO Compras (id_compra, cliente, producto, cantidad, precio_unitario, fecha_compra)
VALUES
(1, 'Juan', 'Tablet', 2, 300.00, '2024-01-10'),
(2, 'Juan', 'Smartphone', 1, 500.00, '2024-01-15'),
(3, 'Maria', 'Laptop', 1, 800.00, '2024-02-05'),
(4, 'Carlos', 'Tablet', 3, 300.00, '2024-02-10'),
(5, 'Ana', 'Smartwatch', 2, 150.00, '2024-02-15'),
(6, 'Juan', 'Laptop', 1, 850.00, '2024-03-01'),
(7, 'Maria', 'Smartphone', 2, 550.00, '2024-03-10'),
(8, 'Carlos', 'Tablet', 1, 310.00, '2024-03-15'),
(9, 'Ana', 'Laptop', 1, 820.00, '2024-03-20'),
(10, 'Carlos', 'Smartwatch', 4, 140.00, '2024-03-25');

-- 
SELECT cliente, SUM(cantidad) AS total_productos
FROM Compras
GROUP BY cliente
HAVING SUM(cantidad) > 3;

-- e1
CREATE TABLE Empleados (
    id_empleado INT PRIMARY KEY,
    nombre VARCHAR(50),
    departamento VARCHAR(50),
    salario DECIMAL(10, 2),
    fecha_contratacion DATE
);

INSERT INTO Empleados (id_empleado, nombre, departamento, salario, fecha_contratacion)
VALUES
(1, 'Carlos', 'Ventas', 3000.00, '2022-05-10'),
(2, 'Ana', 'Marketing', 4000.00, '2020-08-15'),
(3, 'Luis', 'Ventas', 3200.00, '2023-02-01'),
(4, 'Maria', 'Finanzas', 5000.00, '2021-11-20'),
(5, 'Pedro', 'Ventas', 3100.00, '2022-07-25');

-- 
SELECT nombre, departamento, salario, fecha_contratacion
FROM Empleados
ORDER BY departamento ASC, salario DESC;

