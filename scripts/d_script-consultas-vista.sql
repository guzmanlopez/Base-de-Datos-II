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
* c. Para todos los países que fueron destino de envíos, mostrar su nombre, su cantidad
* de envíos en los 20 primeros días de enero de 2016 y la fecha del último envío
* realizado, si algún país nunca fue destino de envíos igual debe mostrar su nombre.
*********************************************************************************************
*/


/*
*********************************************************************************************
* d. Mostrar los datos de los fabricantes que tengan envíos con más de 500 vehículos y
* que no tengan más de 3 envíos con menos de 100 vehículos.
*********************************************************************************************
*/


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

ALTER VIEW vista_codPais_cantVehiculos AS
SELECT P.nomPais AS País_de_fabricación, 
	   COUNT(DISTINCT(V.vin)) AS Cantidad_vehiculos_enviados
FROM Vehiculos V, Carga C, Envios E, Paises P
WHERE C.idEnvio = E.idEnvio
AND E.desEnvio <> V.codPais
AND V.codPais = P.codPais
GROUP BY P.nomPais;

-- Test
SELECT * FROM vista_codPais_cantVehiculos
ORDER BY Cantidad_vehiculos_enviados DESC;