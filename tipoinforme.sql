-- muestra el número de contratos por estado y empresa, proporcionando una visión de cómo se distribuyen los contratos entre las empresas según el estado en el que se encuentran.
SELECT E.nombre_empresa, EST.nombre_estado, COUNT(C.id_contrato) AS cantidad_contratos
FROM Empresas E
JOIN Contratos C ON E.id_empresa = C.id_empresa
JOIN Estados EST ON C.id_estado = EST.id_estado
GROUP BY E.nombre_empresa, EST.nombre_estado
ORDER BY E.nombre_empresa, EST.nombre_estado;

-- lista los clientes junto con los contratos que tienen validados, mostrando el estado de validación facial y la empresa asociada
SELECT P.nombre_persona, C.id_contrato, E.nombre_empresa, EST.nombre_estado, VF.id_estado AS estado_validacion
FROM Clientes CL
JOIN Personas P ON CL.dni = P.dni
JOIN Contratos C ON CL.dni = C.dni
JOIN Empresas E ON C.id_empresa = E.id_empresa
JOIN Estados EST ON C.id_estado = EST.id_estado
JOIN ValidacionFacial VF ON C.id_contrato = VF.id_contrato
JOIN Estados VF_EST ON VF.id_estado = VF_EST.id_estado
WHERE VF_EST.nombre_estado = 'Aprobado' -- Filtra por validación facial aprobada
ORDER BY P.nombre_persona, C.id_contrato;

--muestra todos los documentos adjuntos a los contratos, indicando la persona asociada al contrato, la empresa y el estado del contrato
SELECT D.nombre_documento, D.ruta_documento, C.id_contrato, P.nombre_persona, E.nombre_empresa, EST.nombre_estado
FROM Documentos D
JOIN Contratos C ON D.id_contrato = C.id_contrato
JOIN Personas P ON C.dni = P.dni
JOIN Empresas E ON C.id_empresa = E.id_empresa
JOIN Estados EST ON C.id_estado = EST.id_estado
ORDER BY C.id_contrato, D.nombre_documento;


