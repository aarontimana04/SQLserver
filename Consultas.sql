-- �Cu�les son los cinco hoteles m�s reservados?
SELECT TOP 5
    r.idHotel      AS ID,
    h.nombre       AS Nombre,
    COUNT(r.idHotel) AS CantidadReservas
FROM reservas r
JOIN hoteles h
  ON r.idHotel = h.idHotel
GROUP BY
    r.idHotel,
    h.nombre
ORDER BY
    CantidadReservas DESC;
GO

-- �Cu�ntas reservas se realizaron en un mes espec�fico?
SELECT
    FORMAT(FechaInicio, 'MMMM', 'es-PE') AS Mes,
    YEAR(FechaInicio)                    AS A�o,
    COUNT(idReserva)                     AS CantidadReservas
FROM reservas
WHERE
    MONTH(FechaInicio) = 12
    AND YEAR(FechaInicio) = 2024
GROUP BY
    FORMAT(FechaInicio, 'MMMM', 'es-PE'),
    YEAR(FechaInicio);
GO

-- �Qui�n es el cliente que m�s ha gastado en reservas durante el �ltimo a�o?
SELECT TOP 1
    c.dni                 AS DNI,
    c.nombre              AS Nombre,
    c.apellido            AS Apellido,
    SUM(p.monto)          AS MontoTotalGastado
FROM pagos p
JOIN reservas r
  ON p.idReserva = r.idReserva
JOIN clientes c
  ON r.idCliente = c.idCliente
WHERE
    YEAR(FechaInicio) = 2024
GROUP BY
    c.dni,
    c.nombre,
    c.apellido
ORDER BY
    MontoTotalGastado DESC;
GO
