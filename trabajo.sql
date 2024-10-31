create table empresa (
  id_empresa int primary key,
  nombre_empresa nvarchar(15),
  sector_industrial nvarchar(20)
);

create table proyecto (
  id_proyecto int,
  id_empresa int,
  nombre_proyecto nvarchar(15),
  ubicacion nvarchar(20), 
  estado bit,
  foreign key (id_empresa) references empresa(id_empresa),
  primary key (id_empresa, id_proyecto)
);

create table licitacion();

create table proveedor (
  
);
create table propuesta(
  id_propuesta int,
);
