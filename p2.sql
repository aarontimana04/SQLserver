CREATE TABLE Cliente (
  id_cliente int primary key,
  nombre NVARCHAR(15),
  calle NVARCHAR(20),
  ciudad NVARCHAR(10)
);

CREATE TABLE Servicio (
  id_cliente int,
  id_banquero int,
  foreign key (id_cliente) references Cliente (id_cliente),
  primary key (id_cliente, id_banquero)
);

CREATE TABLE Sucursal (
  id_sucursal int primary key,
  activo BIT,
  ciudad_sucursal NVARCHAR(15)
);

CREATE TABLE Deposito (
  id_cuenta int primary key,
  id_cliente int,
  id_sucursal int,
  saldo int,
  foreign key (id_cliente) references Cliente(id_cliente),
  foreign key (id_sucursal) references Sucursal(id_sucursal)
);

CREATE TABLE Prestamo (
  id_prestamo int primary key,
  id_cliente int,
  id_sucursal int, 
  cantidad int,
  foreign key (id_cliente) references Cliente(id_cliente),
  foreign key (id_sucursal) references Sucursal(id_sucursal)
);


-- población de datos

-- Datos para la tabla Cliente
INSERT INTO Cliente (id_cliente, nombre, calle, ciudad) VALUES
(1, 'Juan', 'Av. Principal 123', 'Lima'),
(2, 'Ana', 'Calle 45', 'Cusco'),
(3, 'Luis', 'Av. Sur', 'Arequipa'),
(4, 'Marta', 'Calle Norte', 'Trujillo'),
(5, 'Carlos', 'Av. Este', 'Piura');

-- Datos para la tabla Sucursal
INSERT INTO Sucursal (id_sucursal, activo, ciudad_sucursal) VALUES
(1, 1, 'Lima'),
(2, 1, 'Cusco'),
(3, 0, 'Arequipa'),
(4, 1, 'Trujillo'),
(5, 0, 'Piura');

-- Datos para la tabla Servicio
INSERT INTO Servicio (id_cliente, id_banquero) VALUES
(1, 101),
(2, 102),
(3, 103),
(4, 104),
(5, 105);

-- Datos para la tabla Deposito
INSERT INTO Deposito (id_cuenta, id_cliente, id_sucursal, saldo) VALUES
(1001, 1, 1, 5000),
(1002, 2, 2, 3000),
(1003, 3, 3, 2000),
(1004, 4, 4, 4500),
(1005, 5, 5, 6000);

-- Datos para la tabla Prestamo
INSERT INTO Prestamo (id_prestamo, id_cliente, id_sucursal, cantidad) VALUES
(2001, 1, 1, 10000),
(2002, 2, 2, 15000),
(2003, 3, 3, 12000),
(2004, 4, 4, 18000),
(2005, 5, 5, 14000);

INSERT INTO Prestamo (id_prestamo, id_cliente, id_sucursal, cantidad) VALUES 
(2010, 2, 3, 5000);

-- consultas

select C.id_cliente, C.nombre
from Cliente as C
join Deposito as D
ON C.id_cliente = D.id_cliente
where D.id_sucursal = 5
union -- except or intersect
select C.id_cliente, C.nombre
from Cliente as C
join Prestamo as P
ON C.id_cliente = P.id_cliente
where P.id_sucursal = 5

-- Obtener el nombre de los clientes y la cantidad de saldo en sus cuentas de depósito.

select C.nombre, D.saldo
from Cliente as C
join Deposito as D
on C.id_cliente = D.id_cliente

-- Listar las sucursales activas junto con el nombre de los clientes que tienen 
-- un depósito en esas sucursales.

select C.id_cliente,C.nombre, S.id_sucursal 
from Deposito as D
join Sucursal as S
on S.id_sucursal = D.id_sucursal
join Cliente as C
on D.id_cliente = C.id_cliente
where activo = 1;

-- Obtener la cantidad total de préstamos que se ha dado en cada sucursal, 
-- agrupando por la sucursal.

select S.id_sucursal, count(P.cantidad) as n_prestamos, sum(P.cantidad) as total_prestamos
from Sucursal as S
join Prestamo as P
on S.id_sucursal = P.id_sucursal
group by S.id_sucursal

-- Listar los nombres de los clientes que han recibido préstamos mayores a 15,000.
select C.id_cliente, C.nombre, R.n_prestamos, R.total_prestado
from Cliente as C
join (
select C.id_cliente, count(P.cantidad) as n_prestamos, sum(P.cantidad) as total_prestado
from Cliente as C
join Prestamo as P
on C.id_cliente = P.id_cliente
group by C.id_cliente
having sum(P.cantidad)>15000 ) as R
on C.id_cliente = R.id_cliente
