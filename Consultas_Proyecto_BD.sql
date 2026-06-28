-- Consulta 1
EXPLAIN (ANALYZE, BUFFERS)
WITH consumo AS (
    SELECT c.id_cliente,
           c.nombre || ' ' || c.apellido AS cliente,
           COUNT(DISTINCT r.id_reserva)                                       AS reservas,
           COUNT(DISTINCT r.id_reserva) FILTER (WHERE r.estado = 'asistida')  AS asistidas,
           COALESCE(SUM(f.total), 0)                                          AS gasto
    FROM CLIENTE c
    JOIN RESERVA r       ON r.id_cliente = c.id_cliente
    LEFT JOIN PEDIDO p   ON p.id_mesa = r.id_mesa AND p.id_turno = r.id_turno
    LEFT JOIN FACTURA f  ON f.id_pedido = p.id_pedido
    GROUP BY c.id_cliente, cliente
)
SELECT id_cliente, cliente, reservas, asistidas, gasto,
       RANK()       OVER (ORDER BY gasto DESC)                         AS ranking,
       NTILE(4)     OVER (ORDER BY gasto DESC)                         AS cuartil,
       ROUND(PERCENT_RANK() OVER (ORDER BY gasto)::numeric, 3)         AS percentil,
       ROUND(gasto - AVG(gasto) OVER (), 2)                            AS dif_vs_promedio,
       ROUND(100.0 * gasto / NULLIF(SUM(gasto) OVER (), 0), 2)         AS pct_del_total
FROM consumo
WHERE gasto > 0
ORDER BY gasto DESC
LIMIT 50;

--Consulta 2
EXPLAIN ANALYZE
SELECT
    e.nombre AS experiencia,
    COUNT(DISTINCT mo.num_orden) AS momentos_definidos,
    COUNT(DISTINCT dp.num_orden) FILTER (WHERE dp.estado = 'servido') AS momentos_servidos_alguna_vez,
    COUNT(DISTINCT mo.num_orden)
        - COUNT(DISTINCT dp.num_orden) FILTER (WHERE dp.estado = 'servido') AS brecha_momentos_nunca_servidos
FROM experiencia e
JOIN momento mo ON mo.id_experiencia = e.id_experiencia
LEFT JOIN detalle_pedido dp
    ON dp.id_experiencia = mo.id_experiencia AND dp.num_orden = mo.num_orden
GROUP BY e.id_experiencia, e.nombre
ORDER BY brecha_momentos_nunca_servidos DESC;

--Consulta 3
EXPLAIN (ANALYZE, BUFFERS)
SELECT c.nombre || ' ' || c.apellido AS cliente,
       r.id_reserva,
       r.fecha,
       (SELECT COUNT(*)
        FROM RESERVA r2
        WHERE r2.id_cliente = r.id_cliente AND r2.fecha < r.fecha) AS visitas_previas,
       (SELECT COALESCE(SUM(f2.total), 0)
        FROM RESERVA r2
        JOIN PEDIDO  p2 ON p2.id_mesa = r2.id_mesa AND p2.id_turno = r2.id_turno
        JOIN FACTURA f2 ON f2.id_pedido = p2.id_pedido
        WHERE r2.id_cliente = r.id_cliente AND r2.fecha < r.fecha) AS gasto_previo
FROM RESERVA r
JOIN CLIENTE c ON c.id_cliente = r.id_cliente
ORDER BY cliente, r.fecha
LIMIT 100;

--Consulta 4
EXPLAIN (ANALYZE, BUFFERS)
SELECT em.nombre || ' ' || em.apellido AS mesero,
       p.id_pedido, p.fecha_hora_apertura,
       (SELECT COUNT(*)
        FROM PEDIDO p2
        WHERE p2.id_empleado = p.id_empleado
          AND p2.fecha_hora_apertura < p.fecha_hora_apertura) AS pedidos_previos
FROM PEDIDO p
JOIN EMPLEADO em ON em.id_empleado = p.id_empleado
ORDER BY p.id_empleado, p.fecha_hora_apertura
LIMIT 100;

--Consulta 5
EXPLAIN (ANALYZE, BUFFERS)
WITH visitas AS (
    SELECT r.id_cliente, r.fecha,
           LAG(r.fecha) OVER (PARTITION BY r.id_cliente ORDER BY r.fecha) AS visita_previa
    FROM RESERVA r
),
intervalos AS (
    SELECT id_cliente, (fecha - visita_previa) AS dias_entre
    FROM visitas
    WHERE visita_previa IS NOT NULL
)
SELECT c.nombre || ' ' || c.apellido AS cliente,
       COUNT(*)                                                  AS num_intervalos,
       ROUND(AVG(i.dias_entre), 1)                               AS prom_dias_entre_visitas,
       MIN(i.dias_entre) AS min_dias, MAX(i.dias_entre) AS max_dias,
       percentile_cont(0.5) WITHIN GROUP (ORDER BY i.dias_entre) AS mediana_dias
FROM intervalos i
JOIN CLIENTE c ON c.id_cliente = i.id_cliente
GROUP BY c.id_cliente, cliente
HAVING COUNT(*) >= 2
ORDER BY prom_dias_entre_visitas
LIMIT 50;