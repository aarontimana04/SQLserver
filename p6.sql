-- Operadores de comparación

-- 1. Igual `=`
SELECT * 
FROM Personas 
WHERE dni = '12345678';

-- 2. Distinto `<>`
SELECT * 
FROM Empresas 
WHERE ruc <> '20456789012';

-- 3. Mayor que `>`
SELECT * 
FROM Contratos 
WHERE id_contrato > 5;

-- 4. Mayor o igual que `>=`
SELECT * 
FROM Estados 
WHERE id_estado >= 3;

-- 5. Menor que `<`
SELECT * 
FROM Grupos 
WHERE id_grupo < 5;

-- 6. Menor o igual que `<=`
SELECT * 
FROM Usuarios 
WHERE id_rol <= 2;

-- 7. `BETWEEN ... AND ...`
SELECT * 
FROM ClienteGrupo 
WHERE fecha_creacion_grupo BETWEEN '2023-01-01' AND '2023-12-31';

-- 8. `IN (lista)`
SELECT * 
FROM Personas 
WHERE dni IN ('12345678', '87654321', '11223344');

-- 9. `IS NULL`
SELECT * 
FROM Documentos 
WHERE ruta_documento IS NULL;

-- 10. `LIKE` con `%`
SELECT * 
FROM Personas 
WHERE nombre_persona LIKE 'J%';

-- 11. `LIKE` con `_`
SELECT * 
FROM Personas 
WHERE nombre_persona LIKE 'M_ri%';

-- 12. `NOT` condición
SELECT * 
FROM Estados 
WHERE nombre_estado NOT LIKE 'Activo%';

-- Operadores Lógicos

-- 1. `AND`
SELECT * 
FROM Contratos 
WHERE dni = '12345678' AND id_estado = 1;

-- 2. `OR`
SELECT * 
FROM Clientes 
WHERE direccion = 'Lima' OR fechanacimiento < '2000-01-01';

-- 3. `NOT`
SELECT * 
FROM Usuarios 
WHERE NOT id_rol = 2;
