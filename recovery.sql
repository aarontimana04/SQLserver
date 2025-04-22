-- A. Cambiar al modo de recuperación completo
ALTER DATABASE TravelSmart
SET RECOVERY FULL;
GO
-- Ver datos
SELECT *
FROM Pagos;

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
