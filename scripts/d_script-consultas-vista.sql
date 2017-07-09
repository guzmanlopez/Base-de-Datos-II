/*
*********************************************************************************************
* Script con consultas y vista                                                              *
*********************************************************************************************
*/

USE BD_VEHICULOS;

/*
*********************************************************************************************
* a. Mostrar el mayor peso, el menor peso, la mayor fecha y la menor fecha de los env�os
* de los a�os 2015 y 2016.
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
* b. Mostrar para cada fabricante su nombre, la cantidad de veh�culos enviados y el peso
* total de los mismos en el a�o 2016 (ordenar los resultados de mayor peso a menor
* peso).
*********************************************************************************************
*/

-- Se devuelve la suma del peso de los vehiculos (incluye el peso de accesorios y combustible)
-- Se devuelve para cada nombre de fabricante no distinguiendo por su divisi�n de f�brica

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
* c. Para todos los pa�ses que fueron destino de env�os, mostrar su nombre, su cantidad
* de env�os en los 20 primeros d�as de enero de 2016 y la fecha del �ltimo env�o
* realizado, si alg�n pa�s nunca fue destino de env�os igual debe mostrar su nombre.
*********************************************************************************************
*/

-- En relaci�n a la fecha, la consulta devuelve la �ltima fecha de env�o para los env�os en los primeros 20 d�as del mes de Enero de 2016. Si se deseara obtener la �ltima fecha de env�o para ese pa�s (independiente de los d�as, el mes y el a�o) se debe modificar MAX(E2.fchEnvio) por MAX(E.fchEnvio)

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
* d. Mostrar los datos de los fabricantes que tengan env�os con m�s de 500 veh�culos y
* que no tengan m�s de 3 env�os con menos de 100 veh�culos.
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
* e. Obtener todos los datos de los veh�culos que fueron enviados en la fecha m�s
* reciente.
*********************************************************************************************
*/




/*
*********************************************************************************************
* f. Mostrar los datos de los fabricantes que no han hecho env�os en el primer semestre
* del 2016, registraron alg�n env�o en el 2017 y solo han hecho env�os con destino
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
* g. Para cada veh�culo con menos de 2.300 kg de peso, mostrar sus datos, la fecha del
* �ltimo env�o donde particip�, y el nombre del fabricante.
*********************************************************************************************
*/



/*
*********************************************************************************************
* h. Bajar el peso en un 5% a todos los veh�culos que no nunca fueron enviados pasado 1
* a�o de su fabricaci�n (puede utilizar la funci�n 4b).
*********************************************************************************************
*/


/*
*********************************************************************************************
* i. Obtener los datos de los fabricantes de Jap�n que en el 2016 hayan tenido en alg�n
* mes un env�o de cantidad total superior a 100 veh�culos y que tambi�n hayan tenido
* alg�n mes con una cantidad total inferior a 20.
*********************************************************************************************
*/


/*
*********************************************************************************************
* 7. Vistas:.
* Realizar una vista que muestre Pa�s de Fabricaci�n del veh�culo y cantidad de veh�culos
* enviados a Pa�ses diferentes a los de la f�brica
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
