-- Crear tabla de departamentos
CREATE TABLE departamentos (
    id_departamento INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Crear tabla de empleados
CREATE TABLE empleados (
    id_empleado INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    cargo VARCHAR(50),
    salario DECIMAL(10, 2),
    id_departamento INT,
    FOREIGN KEY (id_departamento) REFERENCES departamentos(id_departamento)
);

-- Insertar datos en departamentos
INSERT INTO departamentos (id_departamento, nombre) VALUES 
(1, 'Recursos Humanos'),
(2, 'Marketing'),
(3, 'Ventas');

-- Insertar datos en empleados
INSERT INTO empleados (id_empleado, nombre, cargo, salario, id_departamento) VALUES 
(1, 'Ana', 'Gerente', 5000.00, 1),
(2, 'Luis', 'Analista', 3000.00, 2),
(3, 'Marta', 'Vendedor', 2500.00, 3),
(4, 'Carlos', 'Asistente', 1500.00, 1);

-- Subconsulta para obtener empleados con salario superior al promedio de su departamento
SELECT nombre 
FROM empleados 
WHERE salario > (
    SELECT AVG(salario) 
    FROM empleados 
    WHERE id_departamento = 2
);

-- Crear un índice único en la columna nombre
CREATE UNIQUE INDEX idx_nombre_unico ON empleados(nombre);

-- Crear un índice de clave principal (ya existe en id_empleado, pero aquí mostramos el concepto)
CREATE INDEX idx_id_empleado ON empleados(id_empleado);

-- Crear un índice agrupado en la columna salario
CREATE CLUSTERED INDEX idx_salario ON empleados(salario);

-- Crear una vista para empleados del departamento de Marketing con salario mayor a 2000
CREATE VIEW vista_empleados_marketing AS
SELECT nombre, cargo, salario 
FROM empleados 
WHERE id_departamento = 2 AND salario > 2000;

-- Usar la vista para consultar empleados de Marketing con salario superior a 2000
SELECT * FROM vista_empleados_marketing;

-- SINONIMOS
-- Crear un sinónimo para la tabla departamentos
CREATE SYNONYM deptos FOR departamentos;

-- Consultar usando el sinónimo
SELECT * FROM deptos;

-- Eliminar el sinónimo si ya no es necesario
DROP SYNONYM deptos;
