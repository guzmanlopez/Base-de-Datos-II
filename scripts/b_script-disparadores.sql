/*
*********************************************************************************************
* Script con disparadores                                                                   *
*********************************************************************************************
*/

USE BD_VEHICULOS;

/*
*********************************************************************************************
* a. Crear un trigger que valide un número de VIN al ingresar un nuevo vehículo, debe
* utilizar la función creada en el punto 4a.
*********************************************************************************************
*/

ALTER TRIGGER trigger_validar_vin_insert_vehiculo
ON Vehiculos 
INSTEAD OF INSERT
AS
BEGIN
DECLARE @vin CHARACTER(17)
DECLARE @codPais CHARACTER(1)
DECLARE @codFab CHARACTER(2)

SET @codPais = ''
SET @codFab = ''

SELECT @vin = dbo.funct_validar_digitoverificador_vin(I.vin) 
FROM inserted I 

-- Check codPais
SELECT @codPais = (I.codPais) 
FROM inserted I, Paises P
WHERE I.codPais = P.codPais 

-- Check codFab
SELECT @codFab = (I.codFab) 
FROM inserted I, Fabricantes F
WHERE I.codFab = F.codFab

IF (@codPais = '')
	BEGIN
	PRINT 'No existe el [codPais] para el vehículo que se quiere ingresar' 
	END
ELSE IF (@codFab = '')
	BEGIN
	PRINT 'No existe el [codFab] para el vehículo que se quiere ingresar' 
	END
ELSE IF (@vin <> 'OK')
	BEGIN
	INSERT INTO Vehiculos
	SELECT @vin, I.modelo, I.color, I.peso, I.caracteristicas, I.codPais, I.codFab
	FROM INSERTED I
	PRINT 'VEHICULO INGRESADO (VIN CORREGIDO!)'
	END
ELSE IF (@vin = 'OK')
	BEGIN
	INSERT INTO Vehiculos
	SELECT I.vin, I.modelo, I.color, I.peso, I.caracteristicas, I.codPais, I.codFab
	FROM INSERTED I
	PRINT 'VEHICULO INGRESADO (VIN OK)'
	END
END

-- Test OK, vin OK
INSERT INTO Vehiculos 
VALUES ('1M8GDM9AXKP042788', 'Twingo', 'verde', 1251, 'frenos ABS, AC, FULL', '1', 'HA')

-- Test OK, vin CORREGIDO
INSERT INTO Vehiculos 
VALUES ('1M8GDM9AXKP042789', 'Twingo', 'verde', 1251, 'frenos ABS, AC, FULL', '4', 'VA')

-- Test ERROR, no existe codPais
INSERT INTO Vehiculos 
VALUES ('1M8GDM9AXKP042787', 'Twingo', 'verde', 1251, 'frenos ABS, AC, FULL', 'l', 'VA')

-- Test ERROR, no existe codFab
INSERT INTO Vehiculos 
VALUES ('1M8GDM9AXKP042787', 'Twingo', 'verde', 1251, 'frenos ABS, AC, FULL', '1', 'JC')

-- Ver Ingresos
SELECT * FROM Vehiculos;


/*
*********************************************************************************************
* b. Crear un trigger al ingresar una línea de carga, ponga el peso correcto de acuerdo al
* peso del vehículo mas el 5% de combustible y accesorios, también debe acumular el
* peso total del envío.
*********************************************************************************************
*/






/*
*********************************************************************************************
* c. Definir un trigger que al ingresar un envío, si el país de origen es igual al país de
* destino no procese la linea.
*********************************************************************************************
*/

CREATE TRIGGER trigger_validar_origendestino_insert_envio
ON Envios 
INSTEAD OF INSERT
AS
BEGIN
INSERT INTO Envios
SELECT I.fchEnvio, I.pesoEnvio, I.oriEnvio, I.desEnvio
FROM inserted I, inserted I2
WHERE I.idEnvio = I2.idEnvio 
AND I.oriEnvio <> I2.desEnvio
END

-- Test OK
INSERT INTO Envios
VALUES(GETDATE(),1200,1,2);

-- Test no procesa línea
INSERT INTO Envios
VALUES(GETDATE(),1200,1,1);

-- Ver tabla
SELECT * FROM Envios;

-- Eliminar todo
DELETE FROM Envios;

/*
*********************************************************************************************
* d. Implementar un trigger que permita el borrado de uno o más envíos, para ello debe
* borrar en cascada todos los registros en las tablas relacionadas, se debe tener en
* cuenta los borrados múltiples.
*********************************************************************************************
*/







