/*
*********************************************************************************************
* Script con consultas y vista                                                              *
*********************************************************************************************
*/

USE BD_VEHICULOS;

/*
*********************************************************************************************
* a. Mostrar el mayor peso, el menor peso, la mayor fecha y la menor fecha de los envíos
* de los años 2015 y 2016.
*********************************************************************************************
*/

SELECT YEAR(E.fchEnvio) AS Anio, 
	   MAX(E.pesoEnvio) AS Mayor_peso, 
	   MIN(E.pesoEnvio) AS Menor_peso, 
	   MAX(E.fchEnvio) AS Mayor_fecha, 
	   MIN(E.fchEnvio) AS Menor_fecha
FROM Envios E
WHERE YEAR(E.fchEnvio) = 2015 OR YEAR(E.fchEnvio) = 2016
GROUP BY YEAR(E.fchEnvio);

/*
*********************************************************************************************
* b. Mostrar para cada fabricante su nombre, la cantidad de vehículos enviados y el peso
* total de los mismos en el año 2016 (ordenar los resultados de mayor peso a menor
* peso).
*********************************************************************************************
*/

-- Se devuelve la suma del peso de los vehiculos (incluye el peso de accesorios y combustible)
-- Se devuelve para cada nombre de fabricante no distinguiendo por su división de fábrica

SELECT F.nomFab AS Nombre_Fabricante,
       COUNT(V.vin) AS Cant_vehiculos_env,
	   SUM(V.peso*1.05) AS Peso_Total
FROM Fabricantes F, Vehiculos V, Carga C, Envios E
WHERE F.codFab = V.codFab
AND V.vin = C.vin
AND C.idEnvio = E.idEnvio
AND YEAR(E.fchEnvio) = 2016
GROUP BY F.nomFab
ORDER BY Peso_Total DESC;

/*
*********************************************************************************************
* c. Para todos los países que fueron destino de envíos, mostrar su nombre, su cantidad
* de envíos en los 20 primeros días de enero de 2016 y la fecha del último envío
* realizado, si algún país nunca fue destino de envíos igual debe mostrar su nombre.
*********************************************************************************************
*/

-- En relación a la fecha, la consulta devuelve la última fecha de envío para los envíos en los primeros 20 días del mes de Enero de 2016. Si se deseara obtener la última fecha de envío para ese país (independiente de los días, el mes y el año) se debe modificar MAX(E2.fchEnvio) por MAX(E.fchEnvio)

SELECT P.nomPais AS Nombre_de_pais, 
	   COUNT(DISTINCT(E2.idEnvio)) AS Cantidad_de_envios,
	   MAX(E2.fchEnvio) AS Fecha_del_ultimo_envio	
FROM Paises P
LEFT JOIN Envios E
ON P.codPais = E.desEnvio
LEFT JOIN Envios E2
ON P.codPais = E2.desEnvio
AND E2.fchEnvio BETWEEN '20160101' AND '20160120'
GROUP BY P.nomPais;

/*
*********************************************************************************************
* d. Mostrar los datos de los fabricantes que tengan envíos con más de 500 vehículos y
* que no tengan más de 3 envíos con menos de 100 vehículos.
*********************************************************************************************
*/

SELECT F.codFab, F.nomFab, F.dirFab, F.mailFab
FROM Fabricantes F
WHERE F.codFab IN (SELECT F2.codFab
				   FROM Fabricantes F2, Vehiculos V, Carga C, Envios E
				   WHERE F2.codFab = V.codFab
				   AND V.vin = C.vin
				   AND C.idEnvio = E.idEnvio
				   GROUP BY F2.codFab, E.idEnvio
				   HAVING COUNT(C.idCarga) > 500)
AND F.codFab NOT IN (SELECT F3.codFab
					 FROM Fabricantes F3, Vehiculos V2, Carga C2, Envios E2
					 WHERE F3.codFab = V2.codFab
					 AND V2.vin = C2.vin
					 AND C2.idEnvio = E2.idEnvio
					 AND F3.codFab IN (SELECT F4.codFab
									   FROM Fabricantes F4, Vehiculos V3, Carga C3, Envios E3
					                   WHERE F4.codFab = V3.codFab
				                       AND V3.vin = C3.vin
				                       AND C3.idEnvio = E3.idEnvio
				                       GROUP BY F4.codFab, E3.idEnvio
				                       HAVING COUNT(C3.idCarga) < 100) 
					GROUP BY F3.codFab, E2.idEnvio
					HAVING COUNT(*) > 3);

/*
*********************************************************************************************
* e. Obtener todos los datos de los vehículos que fueron enviados en la fecha más
* reciente.
*********************************************************************************************
*/




/*
*********************************************************************************************
* f. Mostrar los datos de los fabricantes que no han hecho envíos en el primer semestre
* del 2016, registraron algún envío en el 2017 y solo han hecho envíos con destino
* Holanda.
*********************************************************************************************
*/

SELECT F.codFab, F.nomFab, F.dirFab, F.mailFab
FROM Fabricantes F
WHERE F.codFab NOT IN (SELECT F2.codFab
					   FROM Fabricantes F2, Vehiculos V, Carga C, Envios E
					   WHERE F2.codFab = V.codFab
					   AND V.vin = C.vin
					   AND C.idEnvio = E.idEnvio
					   AND E.fchEnvio BETWEEN '20160101' AND '20160630')
AND F.codFab IN (SELECT F3.codFab
			     FROM Fabricantes F3, Vehiculos V2, Carga C2, Envios E2
				 WHERE F3.codFab = V2.codFab
				 AND V2.vin = C2.vin
				 AND C2.idEnvio = E2.idEnvio
				 AND YEAR(E2.fchEnvio) = '2017')
AND F.codFab IN (SELECT F4.codFab
			     FROM Fabricantes F4, Vehiculos V3, Carga C3, Envios E3
				 WHERE F4.codFab = V3.codFab
				 AND V3.vin = C3.vin
				 AND C3.idEnvio = E3.idEnvio
				 AND E3.desEnvio = 'H')

/*
*********************************************************************************************
* g. Para cada vehículo con menos de 2.300 kg de peso, mostrar sus datos, la fecha del
* último envío donde participó, y el nombre del fabricante.
*********************************************************************************************
*/



/*
*********************************************************************************************
* h. Bajar el peso en un 5% a todos los vehículos que no nunca fueron enviados pasado 1
* año de su fabricación (puede utilizar la función 4b).
*********************************************************************************************
*/


/*
*********************************************************************************************
* i. Obtener los datos de los fabricantes de Japón que en el 2016 hayan tenido en algún
* mes un envío de cantidad total superior a 100 vehículos y que también hayan tenido
* algún mes con una cantidad total inferior a 20.
*********************************************************************************************
*/


/*
*********************************************************************************************
* 7. Vistas:.
* Realizar una vista que muestre País de Fabricación del vehículo y cantidad de vehículos
* enviados a Países diferentes a los de la fábrica
*********************************************************************************************
*/

CREATE VIEW vista_codPais_cantVehiculos AS
SELECT P.nomPais AS Pais_de_fabricacion, 
	   COUNT(DISTINCT(V.vin)) AS Cant_vehiculos_env
FROM Vehiculos V, Carga C, Envios E, Paises P
WHERE C.idEnvio = E.idEnvio
AND E.desEnvio <> V.codPais
AND V.codPais = P.codPais
GROUP BY P.nomPais;
go
-- Test
SELECT * FROM vista_codPais_cantVehiculos
ORDER BY Cant_vehiculos_env DESC;
go
