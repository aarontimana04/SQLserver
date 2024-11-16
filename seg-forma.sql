SELECT E.nombre_empresa, COUNT(COALESCE(U.dni, NULL)) AS cantidad_personas
FROM Empresas E
LEFT JOIN Usuarios U ON E.id_empresa = U.id_empresa
GROUP BY E.nombre_empresa;

SELECT nombre_estado, 
       (SELECT COUNT(*) FROM Contratos C WHERE C.id_estado = E.id_estado) AS cantidad_contratos
FROM Estados E;

SELECT nombre_persona, contratos
FROM (
    SELECT P.nombre_persona, COUNT(C.id_contrato) AS contratos
    FROM Personas P
    JOIN Contratos C ON P.dni = C.dni
    GROUP BY P.nombre_persona
) AS subconsulta
WHERE contratos > 1;


SELECT nombre_empresa, roles_asignados
FROM (
    SELECT E.nombre_empresa, COUNT(DISTINCT U.id_rol) AS roles_asignados
    FROM Empresas E
    JOIN Usuarios U ON E.id_empresa = U.id_empresa
    GROUP BY E.nombre_empresa
) AS subconsulta
WHERE roles_asignados > 1;


SELECT G.nombre_grupo, COUNT(CG.dni) AS cantidad_clientes
FROM Grupos G
JOIN ClienteGrupo CG ON G.id_grupo = CG.id_grupo
GROUP BY G.nombre_grupo
HAVING COUNT(*) > 2;


SELECT C.id_contrato, E.nombre_empresa, EST.nombre_estado, 
       (SELECT G.nombre_grupo FROM Grupos G JOIN ClienteGrupo CG ON G.id_grupo = CG.id_grupo WHERE CG.dni = C.dni) AS nombre_grupo
FROM Contratos C
JOIN Empresas E ON C.id_empresa = E.id_empresa
JOIN Estados EST ON C.id_estado = EST.id_estado;



SELECT D.nombre_documento, C.id_contrato, P.nombre_persona, E.nombre_empresa, EST.nombre_estado
FROM Documentos D
INNER JOIN Contratos C ON D.id_contrato = C.id_contrato
INNER JOIN Personas P ON C.dni = P.dni
INNER JOIN Empresas E ON C.id_empresa = E.id_empresa
INNER JOIN Estados EST ON C.id_estado = EST.id_estado;


SELECT P.nombre_persona, C.id_contrato, E.nombre_empresa, G.nombre_grupo
FROM Personas P
INNER JOIN Contratos C ON P.dni = C.dni
INNER JOIN Empresas E ON C.id_empresa = E.id_empresa
INNER JOIN ClienteGrupo CG ON P.dni = CG.dni
INNER JOIN Grupos G ON CG.id_grupo = G.id_grupo;


WITH ContratosPorEmpresa AS (
    SELECT id_empresa, COUNT(id_contrato) AS contratos_por_empresa
    FROM Contratos
    GROUP BY id_empresa
)
SELECT E.nombre_empresa, AVG(CPE.contratos_por_empresa) AS promedio_contratos
FROM Empresas E
JOIN ContratosPorEmpresa CPE ON E.id_empresa = CPE.id_empresa
GROUP BY E.nombre_empresa;

SELECT EST.nombre_estado, 
       (SELECT COUNT(*) FROM Contratos C WHERE C.id_estado = EST.id_estado) AS total_contratos,
       (SELECT COUNT(DISTINCT C.dni) FROM Contratos C WHERE C.id_estado = EST.id_estado) AS cantidad_clientes
FROM Estados EST;

