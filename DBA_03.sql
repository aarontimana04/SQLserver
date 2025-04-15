-- Creación de un Procedimiento Almacenado para Insertar un Nuevo Cliente
GO
CREATE PROCEDURE SP_INSERT_CUSTOMER
@FirstName NVARCHAR(80),
@LastName NVARCHAR(80),
@City NVARCHAR(80),
@Country NVARCHAR(80),
@Phone NVARCHAR(40)
AS
BEGIN
    INSERT INTO Customer (FirstName, LastName, City, Country, Phone)
        VALUES (@FirstName, @LastName, @City, @Country, @Phone)
END

-- Se define un procedimiento almacenado llamado `SP_INSERT_CUSTOMER` que permite insertar un nuevo cliente en la tabla `Customer`.

-- Ejecución del Procedimiento Almacenado
EXEC SP_INSERT_CUSTOMER 'Luis', 'Chang','Lima','Peru','(0511) 995690910';

-- Se ejecuta el procedimiento almacenado para insertar un nuevo cliente con los datos proporcionados.

-- Creación de una Tabla de Auditoría
CREATE TABLE dbo.Audit_Customer(	
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdCustomer] [int] NOT NULL,
	[FirstName] [nvarchar](40) NOT NULL,
	[LastName] [nvarchar](40) NOT NULL,
	[City] [nvarchar](40) NULL,
	[Country] [nvarchar](40) NULL,
	[Phone] [nvarchar](20) NULL,
	[ServerDate] [datetime] NULL
)

-- Se crea una tabla llamada `Audit_Customer` para registrar los datos de los clientes que son eliminados de la tabla `Customer`.

-- Creación de un Trigger para Auditoría
GO
CREATE TRIGGER TR_HCO_CUSTOMER
ON dbo.Customer
AFTER DELETE
AS
	INSERT INTO Audit_Customer (IdCustomer, FirstName, LastName, City, Country, Phone, ServerDate)
			SELECT Id, FirstName, LastName, City, Country, Phone, GETDATE() FROM deleted

-- Se define un trigger llamado `TR_HCO_CUSTOMER` que se activa después de que se elimina un registro de la tabla `Customer`. Inserta los datos del cliente eliminado en la tabla `Audit_Customer`.

-- Creación de un Trigger para Proteger Tablas
GO
CREATE TRIGGER TR_SEG_TABLES
ON DATABASE FOR DROP_TABLE, ALTER_TABLE
AS
BEGIN
	RAISERROR('Por motivos de seguridad, no se encuentra permitido eliminar ni alterar tablas',16,1);
	ROLLBACK TRANSACTION
END

-- Se crea un trigger que evita la eliminación o alteración de tablas en la base de datos, generando un error y deshaciendo la transacción.

-- Ejemplo de Uso de Transacciones y Savepoints
SET NOCOUNT ON -- activa la opcion de no mostrar la cantidad de filas afectadas

BEGIN TRAN	
INSERT INTO [Order] (OrderDate, OrderNumber, CustomerId, TotalAmount)
	VALUES (GETDATE(), 543208,1,160)
SAVE TRAN CABECERA
INSERT INTO [OrderItem] (OrderId,ProductId, Quantity,UnitPrice)		
	VALUES ((SELECT MAX(Id) FROM [Order]),1,10,4)
SAVE TRAN DETALLE1
INSERT INTO [OrderItem] (OrderId,ProductId, Quantity,UnitPrice)		
	VALUES ((SELECT MAX(Id) FROM [Order]),2,10,4)
SAVE TRAN DETALLE2
INSERT INTO [OrderItem] (OrderId,ProductId, Quantity,UnitPrice)		
	VALUES ((SELECT MAX(Id) FROM [Order]),3,10,4)
SAVE TRAN DETALLE3
INSERT INTO [OrderItem] (OrderId,ProductId, Quantity,UnitPrice)		
	VALUES ((SELECT MAX(Id) FROM [Order]),4,10,4)

SELECT * FROM [Order]     --SE VISUALIZAN LOS POSIBLES REGISTROS
SELECT * FROM [OrderItem] --SE VISUALIZAN LOS POSIBLES REGISTROS

ROLLBACK TRAN DETALLE2	--SE REGRESA A ESTE SAVEPOINT CON SOLO DOS REGISTROS EN EL DETALLE

COMMIT TRAN --COMITEA HASTA EL SAVEPOINT DETALLE 2 CON LOS DOS REGISTROS DETALLES

SELECT * FROM [Order]   -- SE VISUALIZA EL COMIT DE REGISTRO CABECERA
SELECT * FROM [OrderItem]-- SE VISUALIZA EL COMIT DE LOS DOS ⁄NICOS REGISTROS DETALLES
-- Se realiza un rollback hasta un savepoint específico, permitiendo que solo se mantengan ciertos registros en la base de datos.
