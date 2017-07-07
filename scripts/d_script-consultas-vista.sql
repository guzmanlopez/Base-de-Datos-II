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

SELECT F.codFab AS Codigo_Fabricante,
	   F.nomFab AS Nombre_Fabricante,
       COUNT(V.vin) AS Cant_vehiculos_env,
	   SUM(V.peso) AS Peso
FROM Fabricantes F, Vehiculos V, Carga C, Envios E
WHERE F.codFab = V.codFab
AND V.vin = C.vin
AND C.idEnvio = E.idEnvio
AND YEAR(E.fchEnvio) = 2016
GROUP BY F.codFab, F.nomFab
ORDER BY Peso DESC;


/*
*********************************************************************************************
* c. Para todos los pa�ses que fueron destino de env�os, mostrar su nombre, su cantidad
* de env�os en los 20 primeros d�as de enero de 2016 y la fecha del �ltimo env�o
* realizado, si alg�n pa�s nunca fue destino de env�os igual debe mostrar su nombre.
*********************************************************************************************
*/


/*
*********************************************************************************************
* d. Mostrar los datos de los fabricantes que tengan env�os con m�s de 500 veh�culos y
* que no tengan m�s de 3 env�os con menos de 100 veh�culos.
*********************************************************************************************
*/


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

ALTER VIEW vista_codPais_cantVehiculos AS
SELECT P.nomPais AS Pa�s_de_fabricaci�n, 
	   COUNT(DISTINCT(V.vin)) AS Cantidad_vehiculos_enviados
FROM Vehiculos V, Carga C, Envios E, Paises P
WHERE C.idEnvio = E.idEnvio
AND E.desEnvio <> V.codPais
AND V.codPais = P.codPais
GROUP BY P.nomPais;

-- Test
SELECT * FROM vista_codPais_cantVehiculos
ORDER BY Cantidad_vehiculos_enviados DESC;