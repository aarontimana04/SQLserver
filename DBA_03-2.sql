### 1. Creación de la Tabla `EmployeeReports`

```sql
CREATE TABLE EmployeeReports
(
    ReportID int IDENTITY (1,1) NOT NULL,
    ReportName varchar (100),
    ReportNumber varchar (20),
    ReportDescription varchar (max),
    CONSTRAINT EReport_PK PRIMARY KEY CLUSTERED (ReportID)
)
```

- **`CREATE TABLE EmployeeReports`**: Se crea una nueva tabla llamada `EmployeeReports`.
- **Columnas**:
  - `ReportID`: Un entero que se incrementa automáticamente (IDENTITY) comenzando desde 1. Es la clave primaria de la tabla.
  - `ReportName`: Un campo de texto de hasta 100 caracteres para el nombre del informe.
  - `ReportNumber`: Un campo de texto de hasta 20 caracteres para el número del informe.
  - `ReportDescription`: Un campo de texto que puede contener hasta 2 GB de datos (usando `varchar(max)`).
- **`CONSTRAINT EReport_PK PRIMARY KEY CLUSTERED (ReportID)`**: Define `ReportID` como la clave primaria de la tabla, lo que garantiza que cada valor en esta columna sea único y no nulo.

### 2. Inserción de Datos en `EmployeeReports`

```sql
DECLARE @i int
SET @i = 1

BEGIN TRAN
WHILE @i < 100000 
BEGIN
    INSERT INTO EmployeeReports
    (
        ReportName,
        ReportNumber,
        ReportDescription
    )
    VALUES
    (
        'ReportName',
        CONVERT (varchar (20), @i),
        REPLICATE ('Report', 1000)
    )
    SET @i = @i + 1
END
COMMIT TRAN
GO
```

- **Declaración de Variable**: Se declara una variable `@i` que se inicializa en 1.
- **`BEGIN TRAN` y `COMMIT TRAN`**: Se inicia una transacción para agrupar todas las inserciones. Esto asegura que todas las inserciones se realicen como una única operación atómica.
- **Bucle `WHILE`**: Se utiliza un bucle para insertar 99,999 registros en la tabla `EmployeeReports`.
  - En cada iteración, se inserta un nuevo registro con:
    - `ReportName`: Un valor fijo `'ReportName'`.
    - `ReportNumber`: El valor de `@i` convertido a `varchar(20)`.
    - `ReportDescription`: Una cadena que consiste en la palabra `'Report'` repetida 1000 veces (usando `REPLICATE`).
  - Se incrementa `@i` en 1 en cada iteración.

### 3. Selección de Datos de `EmployeeReports`

```sql
SELECT * FROM EmployeeReports
```

- Esta consulta selecciona y muestra todos los registros de la tabla `EmployeeReports`.

### 4. Creación de la Tabla `ReportsDesc`

```sql
CREATE TABLE ReportsDesc 
( 
    ReportID int FOREIGN KEY REFERENCES EmployeeReports (ReportID),
    ReportDescription varchar(max),
    CONSTRAINT PK_ReportDesc PRIMARY KEY CLUSTERED (ReportID)
)
```

- **`CREATE TABLE ReportsDesc`**: Se crea una nueva tabla llamada `ReportsDesc`.
- **Columnas**:
  - `ReportID`: Un entero que actúa como clave foránea que referencia a `ReportID` en la tabla `EmployeeReports`.
  - `ReportDescription`: Un campo de texto que puede contener hasta 2 GB de datos.
- **`CONSTRAINT PK_ReportDesc PRIMARY KEY CLUSTERED (ReportID)`**: Define `ReportID` como la clave primaria de la tabla `ReportsDesc`.

### 5. Creación de la Tabla `ReportsData`

```sql
CREATE TABLE ReportsData
(
    ReportID int NOT NULL,
    ReportName varchar (100),
    ReportNumber varchar (20),
    CONSTRAINT DReport_PK PRIMARY KEY CLUSTERED (ReportID)
)
```

- **`CREATE TABLE ReportsData`**: Se crea una nueva tabla llamada `ReportsData`.
- **Columnas**:
  - `ReportID`: Un entero que no puede ser nulo.
  - `ReportName`: Un campo de texto de hasta 100 caracteres.
  - `ReportNumber`: Un campo de texto de hasta 20 caracteres.
- **`CONSTRAINT DReport_PK PRIMARY KEY CLUSTERED (ReportID)`**: Define `ReportID` como la clave primaria de la tabla `ReportsData`.

### 6. Inserción de Datos en `ReportsData`

```sql
INSERT INTO dbo.ReportsData
(
    ReportID,
    ReportName,
    ReportNumber
)
SELECT er.ReportID, 
er.ReportName, 
er.ReportNumber 
FROM dbo.EmployeeReports er
