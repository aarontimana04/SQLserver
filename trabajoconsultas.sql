-- Selección de la cantidad de personas registradas en cada empresa, agrupado por nombre_empresa
SELECT E.nombre_empresa, COUNT(U.dni) AS cantidad_personas
FROM Empresas E
JOIN Usuarios U ON E.id_empresa = U.id_empresa
GROUP BY E.nombre_empresa;

-- Listado de estados de contrato con la cantidad de contratos en cada estado.
SELECT E.nombre_estado, COUNT(C.id_contrato) AS cantidad_contratos
FROM Estados E
JOIN Contratos C ON E.id_estado = C.id_estado
GROUP BY E.nombre_estado;

-- Listado de personas con más de un contrato registrado
SELECT P.nombre_persona, COUNT(C.id_contrato) AS contratos
FROM Personas P
JOIN Contratos C ON P.dni = C.dni
GROUP BY P.nombre_persona
HAVING COUNT(C.id_contrato) > 1;

-- Listado de empresas con más de un tipo de rol asignado en la tabla Usuarios
SELECT E.nombre_empresa, COUNT(DISTINCT U.id_rol) AS roles_asignados
FROM Empresas E
JOIN Usuarios U ON E.id_empresa = U.id_empresa
GROUP BY E.nombre_empresa
HAVING COUNT(DISTINCT U.id_rol) > 1;

-- Listado de grupos con más de 2 clientes asignados
SELECT G.nombre_grupo, COUNT(CG.dni) AS cantidad_clientes
FROM Grupos G
JOIN ClienteGrupo CG ON G.id_grupo = CG.id_grupo
GROUP BY G.nombre_grupo
HAVING COUNT(CG.dni) > 2;

-- Listado de contratos, con su empresa asociada, el estado y el grupo al que pertenece el cliente
SELECT C.id_contrato, E.nombre_empresa, EST.nombre_estado, G.nombre_grupo
FROM Contratos C
JOIN Empresas E ON C.id_empresa = E.id_empresa
JOIN Estados EST ON C.id_estado = EST.id_estado
JOIN ClienteGrupo CG ON C.dni = CG.dni
JOIN Grupos G ON CG.id_grupo = G.id_grupo;

-- Listado de los documentos adjuntos para cada contrato, junto con el cliente, la empresa, y el estado del contrato.
SELECT D.nombredocumento, C.id_contrato, P.nombre_persona, E.nombre_empresa, EST.nombre_estado
FROM Documentos D
JOIN Contratos C ON D.id_contrato = C.id_contrato
JOIN Personas P ON C.dni = P.dni
JOIN Empresas E ON C.id_empresa = E.id_empresa
JOIN Estados EST ON C.id_estado = EST.id_estado;

-- Listado de clientes y sus contratos, con la empresa y el grupo al que pertenece el cliente
SELECT P.nombre_persona, C.id_contrato, E.nombre_empresa, G.nombre_grupo
FROM Personas P
JOIN Contratos C ON P.dni = C.dni
JOIN Empresas E ON C.id_empresa = E.id_empresa
JOIN ClienteGrupo CG ON P.dni = CG.dni
JOIN Grupos G ON CG.id_grupo = G.id_grupo;

-- Promedio de contratos por empresa
SELECT E.nombre_empresa, AVG(contratos_por_empresa) AS promedio_contratos
FROM Empresas E
JOIN (
    SELECT id_empresa, COUNT(id_contrato) AS contratos_por_empresa
    FROM Contratos
    GROUP BY id_empresa
) AS subconsulta ON E.id_empresa = subconsulta.id_empresa
GROUP BY E.nombre_empresa;

-- Total de contratos en cada estado y cantidad de clientes únicos en dichos contratos
SELECT EST.nombre_estado, COUNT(C.id_contrato) AS total_contratos, COUNT(DISTINCT C.dni) AS cantidad_clientes
FROM Estados EST
JOIN Contratos C ON EST.id_estado = C.id_estado
JOIN Clientes CL ON C.dni = CL.dni
GROUP BY EST.nombre_estado;

-- INDICES
CREATE INDEX idx_usuarios_id_empresa ON Usuarios(id_empresa);

CREATE INDEX idx_contratos_id_estado ON Contratos(id_estado);

CREATE INDEX idx_contratos_dni ON Contratos(dni);

CREATE INDEX idx_usuarios_id_empresa_rol ON Usuarios(id_empresa, id_rol);

CREATE INDEX idx_clientes_dni_grupo ON ClienteGrupo(dni, id_grupo);

CREATE INDEX idx_contratos_dni_empresa_estado ON Contratos(dni, id_empresa, id_estado);

CREATE INDEX idx_clientes_dni_grupo ON ClienteGrupo(dni, id_grupo);

CREATE INDEX idx_documentos_id_contrato ON Documentos(id_contrato);

CREATE INDEX idx_contratos_dni_empresa_estado ON Contratos(dni, id_empresa, id_estado);

CREATE INDEX idx_clientes_dni_grupo ON ClienteGrupo(dni, id_grupo);

CREATE INDEX idx_contratos_dni_empresa ON Contratos(dni, id_empresa);

CREATE INDEX idx_contratos_id_empresa ON Contratos(id_empresa);

CREATE INDEX idx_contratos_id_estado_dni ON Contratos(id_estado, dni);

CREATE INDEX idx_clientes_dni ON Clientes(dni);

