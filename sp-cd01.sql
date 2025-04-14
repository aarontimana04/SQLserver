-- pagoid, cliente, monto, fecha
CREATE TABLE Pagos (
    PagoID INT PRIMARY KEY, 
    Cliente VARCHAR(20),
    Monto INT,
    fecha DATE
);

INSERT INTO Pagos (PagoID, Cliente, Monto, fecha) VALUES (1, 'juan', 20, GETDATE());
INSERT INTO Pagos (PagoID, Cliente, Monto, fecha) VALUES (2, 'carlos', 20, GETDATE());
INSERT INTO Pagos (PagoID, Cliente, Monto, fecha) VALUES (3, 'alonso', 20, GETDATE());

SELECT *
FROM Pagos;

-- CORRECTO
BEGIN TRAN;
INSERT INTO Pagos (PagoID, Cliente, Monto, fecha) VALUES (4, 'aaron', 100, GETDATE());
SAVE TRAN punto_1;
COMMIT;

-- INCORRECTO
BEGIN TRAN;
INSERT INTO Pagos (PagoID, Cliente, Monto, fecha) VALUES (4, 'aaron', 100, GETDATE());
SAVE TRAN punto_1;
COMMIT;

-- VS
BEGIN TRAN;
INSERT INTO Pagos (PagoID, Cliente, Monto, fecha) VALUES (5, 'franco', 101, GETDATE());
SAVE TRAN punto_1;
INSERT INTO Pagos (PagoID, Cliente, Monto, fecha) VALUES (6, 'jefri', 101, GETDATE());
SAVE TRAN punto_2;
COMMIT;

-- REGRESAMOS A PUNTO SEGURO
BEGIN TRAN;
INSERT INTO Pagos (PagoID, Cliente, Monto, fecha) VALUES (7, 'sebas', 101, GETDATE());
SAVE TRAN punto_1;
INSERT INTO Pagos (PagoID, Cliente, Monto, fecha) VALUES (8, 'jose', 101, GETDATE());
SAVE TRAN punto_2;

ROLLBACK TRAN punto_1;
COMMIT;

-- 
BEGIN TRAN;
INSERT INTO Pagos (PagoID, Cliente, Monto, fecha) VALUES (8, 'bernal', 101, GETDATE());
SAVE TRAN punto_1;
INSERT INTO Pagos (PagoID, Cliente, Monto, fecha) VALUES (9, 'alvaro', 101, GETDATE());
SAVE TRAN punto_2;
INSERT INTO Pagos (PagoID, Cliente, Monto, fecha) VALUES (1, 'alvaro', 101, GETDATE());

ROLLBACK TRAN punto_2;
COMMIT;

-- STORE PRODUCERE
EXEC sp_help 'Pagos';
-- 
EXEC sp_depends 'Pagos';
-- CONSULTAS DINAMICAS
DECLARE @columna NVARCHAR(50) = 'Cliente';
DECLARE @valor NVARCHAR(50) = 'carlos';
DECLARE @sql NVARCHAR(MAX);

SET @sql = 'SELECT * FROM Pagos WHERE ' + @columna + ' = ''' + @valor + '''';

EXEC(@sql);

-- EQUIVALENTE
SELECT * FROM Pagos WHERE Cliente = 'carlos';

-- 
DECLARE @sql NVARCHAR(MAX);
DECLARE @valor NVARCHAR(50) = 'juan';

SET @sql = 'SELECT * FROM Pagos WHERE Cliente = @valor';

EXEC sp_executesql @sql, N'@valor NVARCHAR(50)', @valor = @valor;

