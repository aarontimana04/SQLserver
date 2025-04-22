-- A. Cambiar al modo de recuperación completo
ALTER DATABASE TravelSmart
SET RECOVERY FULL;
GO
-- Ver datos
SELECT *
FROM Pagos;

SELECT *
FROM Reservas;

INSERT INTO Pagos (idPago, fechaPago, monto, idReserva) VALUES (104, '2025-03-22',101, 97);

-- B. RESPALDO COMPLETO (Semanal - Domingo 2:00 AM)
BACKUP DATABASE TravelSmart
TO DISK = '/var/opt/mssql/backups/TravelSmart_Full.bak'
WITH FORMAT,
     INIT,
     NAME = 'Respaldo Completo de TravelSmart',
     STATS = 10;
GO

-- C. Simular una destruccion de tabla accidental
DROP TABLE Pagos;

-- D. Recovery
-- 1. Usamos la Base de datos de Master para la recuperacion
USE master;
GO

-- 2. Forzar cierre de conexiones
ALTER DATABASE TravelSmart SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

-- 3. Restaurar desde el backup
RESTORE DATABASE TravelSmart
FROM DISK = '/var/opt/mssql/backups/TravelSmart_Full.bak'
WITH REPLACE;
GO

RESTORE DATABASE TravelSmart
FROM DISK = '/var/opt/mssql/backups/TravelSmart_Diff.bak'
WITH REPLACE;
GO
-- 4. Comprobamos la restauracion, regresamos a la base de datos de TS
USE TravelSmart;
GO

SELECT * FROM Pagos;

-- RESPALDO DIFERENCIAL (Martes, Jueves, Sábado - 12:00 PM)
BACKUP DATABASE TravelSmart
TO DISK = '/var/opt/mssql/backups/TravelSmart_Diff.bak'
WITH DIFFERENTIAL,
     INIT,
     NAME = 'Respaldo Diferencial de TravelSmart',
     STATS = 10;
GO

-- RESPALDO DEL LOG DE TRANSACCIONES (Diario - 2:00 AM excepto domingo)
BACKUP LOG TravelSmart
TO DISK = '/var/opt/mssql/backups/TravelSmart_Log.trn'
WITH INIT,
     NAME = 'Respaldo del Log de Transacciones de TravelSmart',
     STATS = 10;
GO

-- VERIFICACIÓN DEL RESPALDO COMPLETO (opcional)
RESTORE VERIFYONLY
FROM DISK = '/var/opt/mssql/backups/TravelSmart_Full.bak';
GO

-- EJERCICIO DE RECOVERY FULL AND DIFERENTIAL

-- A. Cambiar al modo de recuperación completo
ALTER DATABASE TravelSmart
SET RECOVERY FULL;
GO

-- B. Ver datos (opcional)
SELECT * FROM Pagos;
SELECT * FROM Reservas;

-- C. Insertar un nuevo pago (opcional, para simular cambios antes del backup)
INSERT INTO Pagos (idPago, fechaPago, monto, idReserva) VALUES (104, '2025-03-22',101, 97);

-- D. Realizar respaldo completo (Domingo)
BACKUP DATABASE TravelSmart
TO DISK = '/var/opt/mssql/backups/TravelSmart_Full.bak'
WITH FORMAT,
     INIT,
     NAME = 'Respaldo Completo de TravelSmart',
     STATS = 10;
GO

-- E. Simular más cambios (para que el diferencial tenga sentido)
INSERT INTO Pagos (idPago, fechaPago, monto, idReserva) VALUES (105, '2025-03-23',99.5, 97);

-- F. Realizar respaldo diferencial (Martes, Jueves, Sábado)
BACKUP DATABASE TravelSmart
TO DISK = '/var/opt/mssql/backups/TravelSmart_Diff.bak'
WITH DIFFERENTIAL,
     INIT,
     NAME = 'Respaldo Diferencial de TravelSmart',
     STATS = 10;
GO

-- G. Simular destrucción
DROP TABLE Pagos;
GO

-- H. Restauración
USE master;
GO

-- 1. Forzar cierre de conexiones
ALTER DATABASE TravelSmart SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

-- 2. Restaurar backup completo (DEJANDO BASE ABIERTA)
RESTORE DATABASE TravelSmart
FROM DISK = '/var/opt/mssql/backups/TravelSmart_Full.bak'
WITH NORECOVERY,
     REPLACE;
GO

-- 3. Restaurar backup diferencial (CIERRA Y HABILITA BASE)
RESTORE DATABASE TravelSmart
FROM DISK = '/var/opt/mssql/backups/TravelSmart_Diff.bak'
WITH RECOVERY;
GO

-- 4. Comprobar recuperación
USE TravelSmart;
GO

SELECT * FROM Pagos;
GO
