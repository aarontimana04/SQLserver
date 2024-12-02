- Listado de países que tienen un solo canal de la categoría "Variedades" pero del tipo "Normal", ordenado alfabéticamente por país
  
SELECT DISTINCT P.nombre AS Canal, COUNT(DISTINCT C.id_canal) as Cantidad
FROM L1_PAIS AS P
JOIN L1_CANAL AS C ON P.id_pais = C.id_pais
JOIN L1_CATEGORIA AS CA ON C.id_categoria = CA.id_categoria
JOIN L1_TIPOCANAL AS T ON C.id_tipocanal = T.id_tipocanal
WHERE CA.nombre = 'Variedades' AND T.descripcion = 'Normal'
GROUP BY P.nombre
HAVING COUNT(DISTINCT C.id_canal) = 1
ORDER BY P.nombre;

- Listado de los 10 programas con más emisiones el día 25 de noviembre pero que cuya emisión tenga un rating mayor o igual a 5, ordenado por la cantidad de veces emitida

SELECT TOP 10 P.id_programa AS Programa, P.titulo AS Nombre, COUNT(*) AS emisiones
FROM L1_PROGRAMA AS P
JOIN L1_PROGRAMACION AS PR ON P.id_programa = PR.id_programa
JOIN L1_RATING AS R ON PR.id_canal = R.id_canal AND PR.fechahorainicio = R.fechahorainicio
WHERE DATEPART(day, PR.fechahorainicio) = 25 AND DATEPART(month, PR.fechahorainicio) = 04 AND R.rating >= 5
GROUP BY P.id_programa, P.titulo
ORDER BY emisiones DESC;

- Listado de canales de tipo "Premium" que se encuentran en el paquete Estelar y no en el paquete Básico

SELECT DISTINCT C.nombre AS Canal, C.numero AS Numero
FROM L1_CANAL AS C
JOIN L1_CANALXPAQUETE AS CP ON C.id_canal = CP.id_canal
JOIN L1_PAQUETE AS PA ON CP.id_paquete = PA.id_paquete
JOIN L1_TIPOCANAL AS T ON C.id_tipocanal = T.id_tipocanal
WHERE T.descripcion = 'Premium' AND PA.nombre = 'Estelar'
EXCEPT
SELECT DISTINCT C.nombre AS Canal, C.numero AS Numero
FROM L1_CANAL AS C
JOIN L1_CANALXPAQUETE AS CP ON C.id_canal = CP.id_canal
JOIN L1_PAQUETE AS PA ON CP.id_paquete = PA.id_paquete
WHERE PA.nombre = 'Básico'
ORDER BY C.numero ASC;
