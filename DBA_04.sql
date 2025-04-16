### 3. Crear la tabla "Alumno" sin llave primaria
```sql
CREATE TABLE dbo.Alumno
(
    Codigo INT,
    Nombre VARCHAR(50) NOT NULL,
    Genero VARCHAR(20) NOT NULL,
    FechaNacimiento DATETIME NOT NULL,
    NotaFinal DECIMAL(18,2) NOT NULL,
    Ciudad VARCHAR(50) NOT NULL
)
GO
```
- **CREATE TABLE dbo.Alumno**: Crea una tabla llamada "Alumno" en el esquema "dbo".
- Se definen varias columnas: `Codigo`, `Nombre`, `Genero`, `FechaNacimiento`, `NotaFinal`, y `Ciudad`. 
- **NOT NULL**: Indica que las columnas no pueden tener valores nulos.

### 4. Realizar una consulta
```sql
SELECT * FROM Alumno
GO
```
- **SELECT * FROM Alumno**: Realiza una consulta para seleccionar todos los registros de la tabla "Alumno". Como no hay registros aún, no se devolverá nada.

### 5. Borrar la tabla "Alumno"
```sql
DROP TABLE dbo.Alumno
GO
```
- **DROP TABLE dbo.Alumno**: Elimina la tabla "Alumno" de la base de datos.

### 6. Crear la tabla "Alumno" con llave primaria
```sql
CREATE TABLE dbo.Alumno
(
    Codigo INT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Genero VARCHAR(20) NOT NULL,
    FechaNacimiento DATETIME NOT NULL,
    NotaFinal DECIMAL(18,2) NOT NULL,
    Ciudad VARCHAR(50) NOT NULL
)
GO
```
- Se vuelve a crear la tabla "Alumno", pero esta vez se define `Codigo` como la **llave primaria**. Esto significa que cada valor en esta columna debe ser único y no nulo.

### 7. Consultar la tabla y verificar índices
```sql
SELECT * FROM Alumno;
EXECUTE sp_helpindex Alumno
```
- **SELECT * FROM Alumno**: Realiza una consulta para seleccionar todos los registros de la tabla "Alumno".
- **EXECUTE sp_helpindex Alumno**: Muestra información sobre los índices de la tabla "Alumno".

### 8. Insertar datos en la tabla
```sql
INSERT INTO Alumno (Codigo, Nombre, Genero, FechaNacimiento, NotaFinal, Ciudad)
VALUES 
(4,'CAMILA','FEMENINO','1998-12-23',16.20,'Lima'),
(7,'SEBASTIAN','MASCULINO','1995-04-07',14.50,'Arequipa'),
(9,'JOSE','MASCULINO','1999-07-13',11.30,'Chiclayo'),
(2,'ELENA','FEMENINO','1993-09-11',17.20,'Cuzco'),
(1,'LUIS','MASCULINO','1994-07-29',18.00,'Trujillo'),
(5,'PEDRO','MASCULINO','2001-03-30',13.00,'Tarapoto'),
(8,'RITA','FEMENINO','1989-04-14',15.50,'Iquitos'),
(3,'ROBERTO','MASCULINO','1988-09-05',14.50,'Lima'),
(6,'TERESA','FEMENINO','1999-05-30',15.00,'Tacna')
```
- Se insertan varios registros en la tabla "Alumno". A pesar de que el `Codigo` no es autoincremental, se insertan valores en un orden específico.

### 9. Consultar para verificar el orden
```sql
SELECT * FROM Alumno
```
- Se consulta nuevamente la tabla "Alumno" para verificar que los datos se han insertado correctamente.

### 10. Crear un índice agrupado personalizado
```sql
CREATE CLUSTERED INDEX IX_tbAlumno_Genero_Nota
ON Alumno(Genero ASC, NotaFinal DESC)
```
- Se crea un índice agrupado llamado `IX_tbAlumno_Genero_Nota` en la tabla "Alumno", que organiza los datos primero por `Genero` en orden ascendente y luego por `NotaFinal` en orden descendente.

### 11. Consultar índices de la tabla
```sql
EXECUTE sp_helpindex Alumno
```
- Se ejecuta el procedimiento almacenado para obtener información sobre los índices de la tabla "Alumno", mostrando detalles sobre el índice recién creado.

### 12. Crear un índice no agrupado
```sql
CREATE NONCLUSTERED INDEX IX_tbAlumno_Nombre
ON Alumno(Nombre ASC)
```
- Se crea un índice no agrupado llamado `IX_tbAlumno_Nombre` en la columna `Nombre`, que permite búsquedas más rápidas basadas en esta columna sin afectar el orden físico de los datos en la tabla.

### 13. Reorganizar índices
```sql
ALTER INDEX IX_tbAlumno_Genero_Nota 
  ON Alumno  
REORGANIZE;   
```
- Se reorganiza el índice `IX_tbAlumno_Genero_Nota`, lo que mejora su eficiencia sin bloquear la tabla.

### 14. Reorganizar todos los índices de la tabla
```sql
ALTER INDEX ALL ON Alumno  
REORGANIZE;   
```
- Se reorganizan todos los índices de la tabla "Alumno" para optimizar su rendimiento.

### 15. Reconstruir un índice específico
```sql
ALTER INDEX IX_tbAlumno_Genero_Nota 
  ON Alumno  
REBUILD;
```
- Se reconstruye el índice `IX_tbAlumno_Genero_Nota`, lo que puede ser necesario si el índice está muy fragmentado.

### 16. Reconstruir todos los índices de la tabla
```sql
ALTER INDEX ALL ON Alumno
REBUILD WITH (FILLFACTOR = 80, SORT_IN_TEMPDB = ON,
              STATISTICS_NORECOMPUTE = ON);
```
- Se reconstruyen todos los índices de la tabla "Alumno" con opciones específicas, como un `FILLFACTOR` del 80%, que determina cuánto espacio se deja libre en las páginas de índice.
