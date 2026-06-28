-- Q1: Reservas y prepago acumulado por cliente (LEFT JOIN + GROUP BY sobre toda RESERVA)
SELECT c.id_cliente, c.nombre, c.apellido,
       COUNT(r.id_reserva)            AS total_reservas,
       COALESCE(SUM(r.prepago), 0)    AS total_prepago
FROM CLIENTE c
LEFT JOIN RESERVA r ON r.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nombre, c.apellido
ORDER BY total_prepago DESC;

-- Q2: Ranking de bebidas mas vendidas (JOIN de 3 tablas + GROUP BY + HAVING)
SELECT b.id_bebida, b.nombre, b.tipo,
       SUM(db.cantidad)                       AS unidades_vendidas,
       SUM(db.cantidad * db.precio_unitario)  AS ingreso_total
FROM BEBIDA b
JOIN DETALLE_BEBIDA db ON db.id_bebida = b.id_bebida
JOIN PEDIDO p          ON p.id_pedido = db.id_pedido
WHERE p.estado = 'cerrado'
GROUP BY b.id_bebida, b.nombre, b.tipo
HAVING SUM(db.cantidad) > 5
ORDER BY unidades_vendidas DESC;

-- Q3: Ingresos por fecha y tipo de turno (FACTURA-PEDIDO-TURNO + GROUP BY)
SELECT t.fecha, t.tipo,
       COUNT(DISTINCT f.id_factura) AS num_facturas,
       SUM(f.total)                 AS ingreso_dia
FROM TURNO t
JOIN PEDIDO p  ON p.id_turno = t.id_turno
JOIN FACTURA f ON f.id_pedido = p.id_pedido
GROUP BY t.fecha, t.tipo
ORDER BY t.fecha, t.tipo;

-- Q4: Clientes que gastaron mas que el promedio (subconsulta correlacionada, se reevalua por fila)
SELECT c.id_cliente, c.nombre,
       (SELECT COALESCE(SUM(r.prepago), 0)
        FROM RESERVA r WHERE r.id_cliente = c.id_cliente) AS gasto
FROM CLIENTE c
WHERE (SELECT COALESCE(SUM(r.prepago), 0)
       FROM RESERVA r WHERE r.id_cliente = c.id_cliente)
      > (SELECT AVG(sub.g)
         FROM (SELECT SUM(prepago) AS g FROM RESERVA GROUP BY id_cliente) sub)
ORDER BY gasto DESC;

-- Q5: Resumen de pedidos con platos y bebidas (doble LEFT JOIN de tablas detalle = producto cartesiano por pedido)
SELECT p.id_pedido, m.numero AS mesa, e.nombre AS experiencia,
       emp.nombre AS mesero,
       COUNT(dp.num_linea)          AS platos,
       COUNT(DISTINCT db.num_linea) AS bebidas
FROM PEDIDO p
JOIN MESA m         ON m.id_mesa = p.id_mesa
JOIN EMPLEADO emp   ON emp.id_empleado = p.id_empleado
LEFT JOIN EXPERIENCIA e    ON e.id_experiencia = p.id_experiencia
LEFT JOIN DETALLE_PEDIDO dp ON dp.id_pedido = p.id_pedido
LEFT JOIN DETALLE_BEBIDA db ON db.id_pedido = p.id_pedido
GROUP BY p.id_pedido, m.numero, e.nombre, emp.nombre
ORDER BY platos DESC, bebidas DESC;
