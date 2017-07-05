/*
*********************************************************************************************
* Script con disparadores                                                                   *
*********************************************************************************************
*/

USE BD_VEHICULOS;

/*
*********************************************************************************************
* a. Crear un trigger que valide un n�mero de VIN al ingresar un nuevo veh�culo, debe
* utilizar la funci�n creada en el punto 4a.
*********************************************************************************************
*/

ALTER TRIGGER trigger_validar_vin_insert_vehiculo
ON Vehiculos 
INSTEAD OF INSERT
AS
BEGIN
DECLARE @vin CHARACTER(17)

SELECT @vin = dbo.funct_validar_digitoverificador_vin(I.vin) 
FROM inserted I 

IF (@vin <> 'OK')
	BEGIN
	INSERT INTO Vehiculos
	SELECT @vin, I.modelo, I.color, I.peso, I.caracteristicas, I.codPais, I.codFab
	FROM INSERTED I
	PRINT 'VEHICULO INGRESADO (VIN CORREGIDO!)'
	END
IF (@vin = 'OK')
	BEGIN
	INSERT INTO Vehiculos
	SELECT I.vin, I.modelo, I.color, I.peso, I.caracteristicas, I.codPais, I.codFab
	FROM INSERTED I
	PRINT 'VEHICULO INGRESADO (VIN OK)'
	END
END

-- Test vin OK
INSERT INTO Vehiculos 
VALUES
	('1M8GDM9AXKP042788', 'Twingo', 'verde', 1251, 'frenos ABS, AC, FULL', '4', 'VA')

-- Test vin CORREGIDO
INSERT INTO Vehiculos 
VALUES
	('1M8GDM9AXKP042789', 'Twingo', 'verde', 1251, 'frenos ABS, AC, FULL', '4', 'VA')

SELECT * FROM Vehiculos;

/*
*********************************************************************************************
* b. Crear un trigger al ingresar una l�nea de carga, ponga el peso correcto de acuerdo al
* peso del veh�culo mas el 5% de combustible y accesorios, tambi�n debe acumular el
* peso total del env�o.
*********************************************************************************************
*/


/*
*********************************************************************************************
* c. Definir un trigger que al ingresar un env�o, si el pa�s de origen es igual al pa�s de
* destino no procese la linea.
*********************************************************************************************
*/


/*
*********************************************************************************************
* d. Implementar un trigger que permita el borrado de uno o m�s env�os, para ello debe
* borrar en cascada todos los registros en las tablas relacionadas, se debe tener en
* cuenta los borrados m�ltiples.
*********************************************************************************************
*/






