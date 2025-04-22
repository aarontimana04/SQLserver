
ALTER DATABASE TravelSmart
SET RECOVERY FULL;
GO
ALTER DATABASE TravelSmart: Esta instrucción indica que se va a modificar la base de datos llamada TravelSmart.
SET RECOVERY FULL: Cambia el modelo de recuperación de la base de datos a "completo". Esto significa que se registrarán todas las transacciones y se podrán realizar copias de seguridad del log de transacciones, lo que permite una recuperación más granular.
GO: Indica el final de un lote de instrucciones en SQL Server. Es un comando que se utiliza para enviar el lote actual de instrucciones al servidor para su ejecución.

1. Respaldo completo (Semanal - Domingo 2:00 AM)

BACKUP DATABASE TravelSmart
TO DISK = 'C:\Backups\TravelSmart\TravelSmart_Full.bak'
WITH FORMAT,
     INIT,
     NAME = 'Respaldo Completo de TravelSmart',
     STATS = 10;
GO
BACKUP DATABASE TravelSmart: Inicia el proceso de respaldo de la base de datos TravelSmart.
TO DISK = 'C:\Backups\TravelSmart\TravelSmart_Full.bak': Especifica la ubicación y el nombre del archivo donde se guardará el respaldo completo.
WITH FORMAT: Indica que se debe formatear el medio de respaldo, es decir, se sobrescribirá cualquier respaldo existente en el archivo especificado.
INIT: Indica que se debe inicializar el archivo de respaldo, lo que significa que se eliminarán los respaldos anteriores en ese archivo.
NAME = 'Respaldo Completo de TravelSmart': Proporciona un nombre descriptivo para el respaldo, que se puede ver en el historial de respaldos.
STATS = 10: Muestra el progreso del respaldo cada 10% en la consola.
GO: Finaliza el lote de instrucciones.

2. Respaldo diferencial (Martes, Jueves, Sábado - 12:00 PM)

BACKUP DATABASE TravelSmart
TO DISK = 'C:\Backups\TravelSmart\TravelSmart_Diff.bak'
WITH DIFFERENTIAL,
     INIT,
     NAME = 'Respaldo Diferencial de TravelSmart',
     STATS = 10;
GO

BACKUP DATABASE TravelSmart: Inicia el proceso de respaldo de la base de datos TravelSmart.
TO DISK = 'C:\Backups\TravelSmart\TravelSmart_Diff.bak': Especifica la ubicación y el nombre del archivo para el respaldo diferencial.
WITH DIFFERENTIAL: Indica que se realizará un respaldo diferencial, que solo incluye los cambios realizados desde el último respaldo completo.
INIT: Inicializa el archivo de respaldo, eliminando cualquier respaldo anterior en ese archivo.
NAME = 'Respaldo Diferencial de TravelSmart': Proporciona un nombre descriptivo para el respaldo diferencial.
STATS = 10: Muestra el progreso del respaldo cada 10% en la consola.
GO: Finaliza el lote de instrucciones.


3. Respaldo del log de transacciones (Diario - 2:00 AM excepto domingo)


BACKUP LOG TravelSmart
TO DISK = 'C:\Backups\TravelSmart\TravelSmart_Log.trn'
WITH INIT,
     NAME = 'Respaldo del Log de Transacciones de TravelSmart',
     STATS = 10;
GO
BACKUP LOG TravelSmart: Inicia el proceso de respaldo del log de transacciones de la base de datos TravelSmart.
TO DISK = 'C:\Backups\TravelSmart\TravelSmart_Log.trn': Especifica la ubicación y el nombre del archivo donde se guardará el respaldo del log.
WITH INIT: Inicializa el archivo de respaldo, eliminando cualquier respaldo anterior en ese archivo.
NAME = 'Respaldo del Log de Transacciones de TravelSmart': Proporciona un nombre descriptivo para el respaldo del log.
STATS = 10: Muestra el progreso del respaldo cada 10% en la consola.
GO: Finaliza el lote de instrucciones.

4. LOG de trans
Los logs de transacciones en SQL Server son archivos que registran todas las transacciones y modificaciones realizadas en la base de datos. Estos logs son esenciales por varias razones:

Integridad de los datos: Permiten mantener la integridad de los datos al registrar cada cambio realizado, lo que ayuda a asegurar que la base de datos se mantenga en un estado consistente.
Recuperación: En caso de un fallo del sistema, un error o una pérdida de datos, los logs de transacciones permiten restaurar la base de datos a un estado anterior. Esto es especialmente útil para realizar recuperaciones a un punto en el tiempo.
Auditoría: Los logs pueden ser utilizados para auditar cambios en la base de datos, permitiendo a los administradores rastrear quién hizo qué y cuándo.
Soporte para transacciones: Los logs de transacciones son fundamentales para el manejo de transacciones en SQL Server, ya que permiten implementar características como el "rollback" (deshacer) y el "commit" (confirmar) de las transacciones.
En resumen, los logs de transacciones son una parte crítica de la arquitectura de bases de datos en SQL Server, ya que garantizan la seguridad, la recuperación y la integridad de los datos.
