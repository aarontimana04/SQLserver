-- Insertar personas (30 distintas)
-- CHECK
INSERT INTO Personas (dni, correo, telefono, nombre_persona, primer_apellido, segundo_apellido) VALUES
('12345678', 'juan.perez@gmail.com', 987654321, 'Juan', 'Perez', 'Lopez'),
('23456789', 'ana.garcia@hotmail.com', 987654322, 'Ana', 'Garcia', 'Mendez'),
('34567890', 'maria.lopez@gmail.com', 987654323, 'Maria', 'Lopez', 'Gonzalez'),
('45678901', 'pedro.sanchez@hotmail.com', 987654324, 'Pedro', 'Sanchez', 'Diaz'),
('56789012', 'luisa.martinez@gmail.com', 987654325, 'Luisa', 'Martinez', 'Romero'),
('07890123', 'ricardo.morales@hotmail.com', 987654326, 'Ricardo', 'Morales', 'Torres'),
('78901234', 'sofia.gonzalez@gmail.com', 987654327, 'Sofia', 'Gonzalez', 'Ruiz'),
('89012345', 'carlos.rodriguez@hotmail.com', 987654328, 'Carlos', 'Rodriguez', 'Martinez'),
('90123456', 'luz.perez@gmail.com', 987654329, 'Luz', 'Perez', 'Lopez'),
('22340123', 'rafael.martin@hotmail.com', 987654330, 'Rafael', 'Martin', 'Lopez'),
('43451234', 'marta.perez@gmail.com', 987654331, 'Marta', 'Perez', 'Castro'),
('84562345', 'ricardo.lopez@hotmail.com', 987654332, 'Ricardo', 'Lopez', 'Perez'),
('05673456', 'elena.garcia@gmail.com', 987654333, 'Elena', 'Garcia', 'Martinez'),
('06784567', 'eduardo.sanchez@hotmail.com', 987654334, 'Eduardo', 'Sanchez', 'Gomez'),
('17895678', 'patricia.martinez@gmail.com', 987654335, 'Patricia', 'Martinez', 'Morales'),
('18906789', 'manuel.rodriguez@hotmail.com', 987654336, 'Manuel', 'Rodriguez', 'Hernandez'),
('69017890', 'beatriz.perez@gmail.com', 987654337, 'Beatriz', 'Perez', 'Lopez'),
('70128901', 'gustavo.garcia@hotmail.com', 987654338, 'Gustavo', 'Garcia', 'Martinez'),
('42347890', 'carmen.morales@gmail.com', 987654339, 'Carmen', 'Morales', 'Gonzalez'),
('03458901', 'juanita.sanchez@hotmail.com', 987654340, 'Juanita', 'Sanchez', 'Martinez'),
('94569012', 'julio.rodriguez@gmail.com', 987654341, 'Julio', 'Rodriguez', 'Lopez'),
('85670123', 'rosa.morales@hotmail.com', 987654342, 'Rosa', 'Morales', 'Perez'),
('26781234', 'pedro.morales@gmail.com', 987654343, 'Pedro', 'Morales', 'Garcia'),
('27892345', 'liliana.garcia@hotmail.com', 987654344, 'Liliana', 'Garcia', 'Lopez'),
('38903456', 'victor.martinez@gmail.com', 987654345, 'Victor', 'Martinez', 'Lopez'),
('69014567', 'elizabeth.rodriguez@hotmail.com', 987654346, 'Elizabeth', 'Rodriguez', 'Martinez'),
('50125678', 'oscar.lopez@gmail.com', 987654347, 'Oscar', 'Lopez', 'Gonzalez'),
('52356789', 'veronica.morales@hotmail.com', 987654348, 'Veronica', 'Morales', 'Diaz');

INSERT INTO Personas 
VALUES ('02473219', 'jose.valdez@hotmail.com', 982365471, 'jose','valdez','aragon'),
        ('65739200', 'pedro.timana@gmail.com', 900455786, 'pedro','timana','ancajima');

-- Insertar empresas (15 distintas)
-- CHECK
INSERT INTO Empresas (ruc, nombre_empresa) VALUES
('20432123456', 'Empresa A'),
('20654321321', 'Empresa B'),
('20765432123', 'Empresa C'),
('20123456789', 'Empresa D'),
('20987654321', 'Empresa E'),
('20876543210', 'Empresa F'),
('20765432321', 'Empresa G'),
('20543210987', 'Empresa H'),
('20234567890', 'Empresa I'),
('20456789012', 'Empresa J'),
('20765432112', 'Empresa K'),
('20876543230', 'Empresa L'),
('20987654343', 'Empresa M'),
('20654321432', 'Empresa N'),
('20123456765', 'Empresa O');

-- Insertar roles (2 tipos: asesor y supervisor)
-- CHECK
INSERT INTO Rol (nombre_rol, detalles) VALUES
('asesor', 'Asesor de clientes'),
('supervisor', 'Supervisor de operaciones');

-- Insertar clientes (15, con fechas de nacimiento hacia el 2000 o antes)
-- CHECK
INSERT INTO Clientes (dni, direccion, fecha_nacimiento) VALUES
('05673456', 'Lima, Av. Pardo', '1995-04-23'),
('03458901', 'Arequipa, Calle Junín', '1990-07-12'),
('06784567', 'Cusco, Av. Sol', '1992-02-15'),
('07890123', 'Trujillo, Calle Libertad', '1987-11-30'),
('12345678', 'Piura, Calle Grau', '1991-06-05'),
('17895678', 'Chiclayo, Av. Santa Rosa', '1993-12-17'),
('18906789', 'Lima, Calle Callao', '1989-01-25'),
('22340123', 'Arequipa, Calle San Martín', '1994-08-14'),
('23456789', 'Iquitos, Av. Comercio', '1986-03-19'),
('26781234', 'Huancayo, Calle Real', '1992-10-09'),
('27892345', 'Ayacucho, Av. Cusco', '1990-01-07'),
('34567890', 'Lima, Calle de la Colmena', '1988-12-23'),
('38903456', 'Tacna, Calle Zela', '1991-11-05'),
('42347890', 'Lima, Av. Pizarro', '1987-09-15'),
('43451234', 'Huánuco, Av. Dos de Mayo', '1990-05-30');

-- Insertar usuarios (15 distintos, ninguno repite cliente)
-- CHECK
INSERT INTO Usuarios (dni, id_empresa, id_rol, estado) VALUES
('45678901', 1, 1, 1),
('50125678', 2, 2, 1),
('52356789', 3, 1, 0),
('56789012', 4, 2, 1),
('69014567', 5, 1, 0),
('69017890', 6, 2, 1),
('70128901', 7, 1, 1),
('78901234', 8, 2, 1),
('84562345', 9, 1, 0),
('85670123', 10, 2, 1),
('89012345', 11, 1, 1),
('90123456', 12, 2, 0),
('94569012', 13, 1, 1),
('02473219', 14, 2, 0),
('65739200', 15, 1, 1);

-- Insertar estados (3 tipos)
-- CHECK
INSERT INTO Estados (nombre_estado) VALUES
('pendiente'),
('firmado'),
('rechazado');

-- Insertar grupos (15 distintos)
--CHECK
INSERT INTO Grupos (nombre_grupo) VALUES
('Grupo 1'),
('Grupo 2'),
('Grupo 3'),
('Grupo 4'),
('Grupo 5'),
('Grupo 6'),
('Grupo 7'),
('Grupo 8'),
('Grupo 9'),
('Grupo 10'),
('Grupo 11'),
('Grupo 12'),
('Grupo 13'),
('Grupo 14'),
('Grupo 15');

-- Insertar cliente-grupo (30, relaciones entre clientes y grupos)
-- CHECK
INSERT INTO ClienteGrupo (dni, id_grupo, fecha_creacion_grupo) VALUES
('03458901', 1, '2024-01-01'),
('05673456', 2, '2024-01-02'),
('06784567', 3, '2024-01-03'),
('07890123', 4, '2024-01-04'),
('12345678', 5, '2024-01-05'),
('17895678', 6, '2024-01-06'),
('18906789', 7, '2024-01-07'),
('22340123', 8, '2024-01-08'),
('23456789', 9, '2024-01-09'),
('26781234', 10, '2024-01-10'),
('27892345', 11, '2024-01-11'),
('34567890', 12, '2024-01-12'),
('38903456', 13, '2024-01-13'),
('42347890', 14, '2024-01-14'),
('43451234', 15, '2024-01-15'),
('03458901', 2, '2024-02-01'),
('05673456', 3, '2024-02-02'),
('06784567', 4, '2024-02-03'),
('07890123', 5, '2024-02-04'),
('12345678', 6, '2024-02-05'),
('17895678', 7, '2024-02-06'),
('18906789', 8, '2024-02-07'),
('22340123', 9, '2024-02-08'),
('23456789', 10, '2024-02-09'),
('26781234', 11, '2024-02-10'),
('27892345', 12, '2024-02-11'),
('34567890', 13, '2024-02-12'),
('38903456', 14, '2024-02-13'),
('42347890', 15, '2024-02-14'),
('43451234', 1, '2024-02-15');

-- Insertar contratos (15 contratos)
INSERT INTO Contratos (fecha_creacion_contrato, dni, id_empresa, id_estado) VALUES
('2024-01-01', '12345678', 1, 1),
('2024-01-02', '23456789', 2, 2),
('2024-01-03', '34567890', 3, 1),
('2024-01-04', '45678901', 4, 2),
('2024-01-05', '56789012', 5, 1),
('2024-01-06', '67890123', 6, 2),
('2024-01-07', '78901234', 7, 1),
('2024-01-08', '89012345', 8, 2),
('2024-01-09', '90123456', 9, 1),
('2024-01-10', '12340123', 10, 2),
('2024-01-11', '23451234', 11, 1),
('2024-01-12', '34562345', 12, 2),
('2024-01-13', '45673456', 13, 1),
('2024-01-14', '56784567', 14, 2),
('2024-01-15', '67895678', 15, 1);

-- Insertar documentos (15 documentos)
INSERT INTO Documentos (nombre_documento, id_contrato, ruta_documento, fecha_adjunto) VALUES
('documento1.pdf', 1, 'ruta/documento1.pdf', '2024-01-01'),
('documento2.pdf', 2, 'ruta/documento2.pdf', '2024-01-02'),
('documento3.pdf', 3, 'ruta/documento3.pdf', '2024-01-03'),
('documento4.pdf', 4, 'ruta/documento4.pdf', '2024-01-04'),
('documento5.pdf', 5, 'ruta/documento5.pdf', '2024-01-05'),
('documento6.pdf', 6, 'ruta/documento6.pdf', '2024-01-06'),
('documento7.pdf', 7, 'ruta/documento7.pdf', '2024-01-07'),
('documento8.pdf', 8, 'ruta/documento8.pdf', '2024-01-08'),
('documento9.pdf', 9, 'ruta/documento9.pdf', '2024-01-09'),
('documento10.pdf', 10, 'ruta/documento10.pdf', '2024-01-10'),
('documento11.pdf', 11, 'ruta/documento11.pdf', '2024-01-11'),
('documento12.pdf', 12, 'ruta/documento12.pdf', '2024-01-12'),
('documento13.pdf', 13, 'ruta/documento13.pdf', '2024-01-13'),
('documento14.pdf', 14, 'ruta/documento14.pdf', '2024-01-14'),
('documento15.pdf', 15, 'ruta/documento15.pdf', '2024-01-15');

-- Insertar validaciones faciales (15 validaciones)
INSERT INTO ValidacionFacial (dni, id_estado, id_contrato) VALUES
('12345678', 1, 1),
('23456789', 2, 2),
('34567890', 1, 3),
('45678901', 2, 4),
('56789012', 1, 5),
('67890123', 2, 6),
('78901234', 1, 7),
('89012345', 2, 8),
('90123456', 1, 9),
('12340123', 2, 10),
('23451234', 1, 11),
('34562345', 2, 12),
('45673456', 1, 13),
('56784567', 2, 14),
('67895678', 1, 15);

-- Insertar imágenes (15 imágenes) --
INSERT INTO Imagenes (id_validacion, dni, id_estado, id_contrato, imagen, fecha_envio_imagen) VALUES
(1, '12345678', 1, 1, 'imagen1.jpg', '2024-01-01'),
(2, '23456789', 2, 2, 'imagen2.jpg', '2024-01-02'),
(3, '34567890', 1, 3, 'imagen3.jpg', '2024-01-03'),
(4, '45678901', 2, 4, 'imagen4.jpg', '2024-01-04'),
(5, '56789012', 1, 5, 'imagen5.jpg', '2024-01-05'),
(6, '67890123', 2, 6, 'imagen6.jpg', '2024-01-06'),
(7, '78901234', 1, 7, 'imagen7.jpg', '2024-01-07'),
(8, '89012345', 2, 8, 'imagen8.jpg', '2024-01-08'),
(9, '90123456', 1, 9, 'imagen9.jpg', '2024-01-09'),
(10, '12340123', 2, 10, 'imagen10.jpg', '2024-01-10'),
(11, '23451234', 1, 11, 'imagen11.jpg', '2024-01-11'),
(12, '34562345', 2, 12, 'imagen12.jpg', '2024-01-12'),
(13, '45673456', 1, 13, 'imagen13.jpg', '2024-01-13'),
(14, '56784567', 2, 14, 'imagen14.jpg', '2024-01-14'),
(15, '67895678', 1, 15, 'imagen15.jpg', '2024-01-15');

-- Insertar detalles de imágenes (15 detalles de imágenes)
INSERT INTO DetallesImagenes (detalle_imagen, id_imagen, id_validacion, dni, id_estado, id_contrato) VALUES
('Foto principal del documento',1,1, '12345678', 1, 1, 'imagen1.jpg', '2024-01-01'),
('Foto secundaria del documento',2,2, '23456789', 2, 2, 'imagen2.jpg', '2024-01-02'),
('Foto completa de la persona',3, 3, '34567890', 1, 3, 'imagen3.jpg', '2024-01-03'),
('Foto para verificación de rostro', 4, 4, '45678901', 2, 4, 'imagen4.jpg', '2024-01-04'),
('Foto de perfil', 5, 5, '56789012', 1, 5, 'imagen5.jpg', '2024-01-05'),
('Foto de seguridad', 6, 6, '67890123', 2, 6, 'imagen6.jpg', '2024-01-06'),
('Foto nítida del rostro', 7, 7, '78901234', 1, 7, 'imagen7.jpg', '2024-01-07'),
('Foto complementaria', 8, 8, '89012345', 2, 8, 'imagen8.jpg', '2024-01-08'),
('Foto de confirmación', 9, 9, '90123456', 1, 9, 'imagen9.jpg', '2024-01-09'),
('Foto de autenticación',10, 10, '12340123', 2, 10, 'imagen10.jpg', '2024-01-10'),
('Foto clara de la identificación', 11, 11, '23451234', 1, 11, 'imagen11.jpg', '2024-01-11'),
('Foto tomada en el sitio', 12, 12, '34562345', 2, 12, 'imagen12.jpg', '2024-01-12'),
('Foto para validación facial', 13, 13, '45673456', 1, 13, 'imagen13.jpg', '2024-01-13'),
('Foto oficial de registro', 14, 14, '56784567', 2, 14, 'imagen14.jpg', '2024-01-14'),
('Foto digitalizada para comparación', 15, 15, '67895678', 1, 15, 'imagen15.jpg', '2024-01-15');
