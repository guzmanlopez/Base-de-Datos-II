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
DECLARE @codFabPais CHARACTER(2)

SET @codPais = ''
SET @codFab = ''
SET @codFabPais = ''

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

-- Check codPais y codFab
SELECT @codFabPais = (I.codFab) 
FROM inserted I, Plantas P
WHERE I.codFab = P.codFab
AND I.codPais = P.codPais

IF (@codPais = '')
	BEGIN
	PRINT 'No existe el [codPais] para el vehículo que se quiere ingresar' 
	END
ELSE IF (@codFab = '')
	BEGIN
	PRINT 'No existe el [codFab] para el vehículo que se quiere ingresar' 
	END
ELSE IF (@codFabPais = '')
	BEGIN
	PRINT 'No existe la planta para el vehículo que se quiere ingresar' 
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
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1M8GDM9AXKP042788', 'Twingo', 'verde', 1251, 'frenos ABS, AC, FULL', '1', 'RA')

-- Test OK, vin CORREGIDO
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab) 
VALUES ('1M8GDM9AXKP042789', 'Twingo', 'verde', 1251, 'frenos ABS, AC, FULL', '1', 'RA')

-- Test ERROR, no existe codPais
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab) 
VALUES ('1M8GDM9AXKP042787', 'Twingo', 'verde', 1251, 'frenos ABS, AC, FULL', 'O', 'RA')

-- Test ERROR, no existe codFab
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab) 
VALUES ('1M8GDM9AXKP042787', 'Twingo', 'verde', 1251, 'frenos ABS, AC, FULL', '1', 'RS')

-- Test ERROR, no existe la planta 
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab) 
VALUES ('1M8GDM9AXKP042787', 'Twingo', 'verde', 1251, 'frenos ABS, AC, FULL', '2', 'RA')

-- Ver Ingresos
SELECT * FROM Vehiculos;

DELETE FROM Vehiculos;

/*
*********************************************************************************************
* b. Crear un trigger al ingresar una línea de carga, ponga el peso correcto de acuerdo al
* peso del vehículo mas el 5% de combustible y accesorios, también debe acumular el
* peso total del envío.
*********************************************************************************************
*/

CREATE TRIGGER trigger_peso_insert_carga
ON Carga 
INSTEAD OF INSERT
AS
BEGIN
UPDATE Envios
SET pesoEnvio = pesoEnvio + (SELECT SUM(V.peso * 1.05)
							FROM inserted I, Vehiculos V, Envios E
							WHERE I.vin = V.vin
							AND I.idEnvio = E.idEnvio)
FROM inserted I2, Envios E2
WHERE E2.idEnvio = I2.idEnvio;

INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
SELECT I3.idEnvio, I3.idCarga, I3.vin, (SELECT SUM(V2.peso * 1.05)
							FROM inserted I3, Vehiculos V2
							WHERE I3.vin = V2.vin)
FROM inserted I3, Vehiculos V2
WHERE I3.vin = V2.vin
END;

-- Test OK
INSERT INTO Carga(idEnvio, idCarga, vin)
VALUES(1, 1, '1AAAL3201GAA1019')

INSERT INTO Carga(idEnvio, idCarga, vin)
VALUES(1, 2, '1AAAL3202AAA1019')

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

INSERT INTO Envios
VALUES(GETDATE(),1300,1,3);

INSERT INTO Envios
VALUES(GETDATE(),2300,2,3);

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

CREATE TRIGGER trigger_delete_envio
ON Envios 
INSTEAD OF DELETE
AS
BEGIN
-- Borrar de tabla Carga
DELETE FROM Carga
WHERE idEnvio IN (SELECT D.idEnvio FROM deleted D)
-- Borrar de tabla Envio
DELETE FROM Envios
WHERE idEnvio IN (SELECT D2.idEnvio FROM deleted D2)
END;


-- Test 
INSERT INTO Carga
VALUES(12, 4, '1AAAL3201GAA1019 ', 2000);

INSERT INTO Carga
VALUES(12, 7, '1AAAL3202AAA1019 ', 4000);

-- Test OK
DELETE FROM Envios
WHERE idEnvio = 5;

DELETE FROM Envios
WHERE idEnvio = 6;

-- Múltiple
DELETE FROM Envios
WHERE desEnvio = 2;

-- Ver tabla
SELECT * FROM Envios;
SELECT * FROM Carga;
