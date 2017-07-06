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
	PRINT 'No existe el [codPais] para el veh�culo que se quiere ingresar' 
	END
ELSE IF (@codFab = '')
	BEGIN
	PRINT 'No existe el [codFab] para el veh�culo que se quiere ingresar' 
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
* b. Crear un trigger al ingresar una l�nea de carga, ponga el peso correcto de acuerdo al
* peso del veh�culo mas el 5% de combustible y accesorios, tambi�n debe acumular el
* peso total del env�o.
*********************************************************************************************
*/

ALTER TRIGGER trigger_peso_insert_carga
ON Carga 
INSTEAD OF INSERT
AS
BEGIN
UPDATE Envios
SET pesoEnvio = pesoEnvio + SELECT SUM(V.peso * 1.05) 
FROM inserted I, Vehiculos V
WHERE I.vin = V.vin
AND I.idEnvio = I1.envio
END

/*
*********************************************************************************************
* c. Definir un trigger que al ingresar un env�o, si el pa�s de origen es igual al pa�s de
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

-- Test no procesa l�nea
INSERT INTO Envios
VALUES(GETDATE(),1200,1,1);

-- Ver tabla
SELECT * FROM Envios;

-- Eliminar todo
DELETE FROM Envios;

/*
*********************************************************************************************
* d. Implementar un trigger que permita el borrado de uno o m�s env�os, para ello debe
* borrar en cascada todos los registros en las tablas relacionadas, se debe tener en
* cuenta los borrados m�ltiples.
*********************************************************************************************
*/

ALTER TRIGGER trigger_delete_envio
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

END

-- Test 
INSERT INTO Carga
VALUES(12, 4, '1M8GDM9A1KP042789', 2000);

INSERT INTO Carga
VALUES(12, 7, '1M8GDM9AXKP042788', 4000);


-- Test OK
DELETE FROM Envios
WHERE idEnvio = 5;

DELETE FROM Envios
WHERE idEnvio = 6;

-- M�ltiple
DELETE FROM Envios
WHERE desEnvio = 2;

-- Ver tabla
SELECT * FROM Envios;
SELECT * FROM Carga;
