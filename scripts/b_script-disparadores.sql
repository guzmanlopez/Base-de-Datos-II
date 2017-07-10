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

-- Función auxiliar: impide VIN con caracteres I, O, Q o Ñ
CREATE FUNCTION funct_impedir_caracteres_vin
(@vin CHARACTER(17))
RETURNS BIT
AS
BEGIN
DECLARE @ret BIT
SET @ret = 1
-- Recorrer VIN 
DECLARE @ite INT
SET @ite = 1
WHILE (@ite < 18 AND @ret = 1)
	BEGIN
	IF(SUBSTRING(@vin,@ite,1) IN ('I','O','Q','Ñ'))
	BEGIN
	SET @ret = 0
	END	
SET @ite = @ite + 1
	END	
RETURN @ret
END;

-- Trigger
CREATE TRIGGER trigger_validar_vin_insert_vehiculo
ON Vehiculos 
INSTEAD OF INSERT
AS
BEGIN
DECLARE @vin CHARACTER(17)
DECLARE @codPais CHARACTER(1)
DECLARE @codFab CHARACTER(2)
DECLARE @codFabPais CHARACTER(2)
DECLARE @caracteres BIT
SET @codPais = ''
SET @codFab = ''
SET @codFabPais = ''
SET @caracteres = 1
-- Validar caracteres no permitidos
SELECT @caracteres = dbo.funct_impedir_caracteres_vin(I.vin)
FROM inserted I
IF(@caracteres = 1)
BEGIN
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
ELSE
	BEGIN
	PRINT 'CARACTERES EN vin NO PERMITIDOS'
	END
END;

-- Test OK, vin OK
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1AAAL3205EAA10190', 'A4', 'gris', 2500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'AA')

-- Test OK, vin CORREGIDO
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1AAAL3205EAA10190', 'A4', 'gris', 2500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'AA')

-- Test ERROR, caracter no permitido I
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1AIAL3205EAA10190', 'A4', 'gris', 2500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'AA')

-- Test ERROR, caracter no permitido O
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1AOAL3205EAA10190', 'A4', 'gris', 2500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'AA')

-- Test ERROR, caracter no permitido Q
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1AQAL3205EAA10190', 'A4', 'gris', 2500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'AA')

-- Test ERROR, caracter no permitido Ñ
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1AÑAL3205EAA10190', 'A4', 'gris', 2500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'AA')

-- Test ERROR, no existe codPais
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab) 
VALUES ('XAAAL3204EAA10190', 'A4', 'verde', 2500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'X', 'AA')

-- Test ERROR, no existe codFab
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab) 
VALUES ('XAAAL3204EAA10190', 'A4', 'verde', 2500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'AC')

-- Test ERROR, no existe codFab para el codPais (no existe la planta)
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab) 
VALUES ('XAAAL3204EAA10190', 'A4', 'verde', 2500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '2', 'AA')

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
VALUES(1, 2, '16AFE3201F6A10190')

INSERT INTO Carga(idEnvio, idCarga, vin)
VALUES(2, 2, '16AFE3208H6A10190')

-- Test OK, ingresar 3 cargas más al idEnvio = 52
INSERT INTO Carga(idEnvio, idCarga, vin)
VALUES(52, 2, 'ZJAFE320XGJA10190')

INSERT INTO Carga(idEnvio, idCarga, vin)
VALUES(52, 3, 'ZJAFE320XGJA10190')

INSERT INTO Carga(idEnvio, idCarga, vin)
VALUES(52, 4, 'ZJAFE320XGJA10190')

-- Ver cargas del idEnvio = 52
SELECT *
FROM Carga
WHERE idEnvio = 52;

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
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20150315', 3990, '1', 'Z');

-- Test no procesa línea
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20150315', 3990, '1', '1');

-- Ver tabla (el idEnvio = 55 corresponde a la inserción Test OK)
SELECT * 
FROM Envios
WHERE fchEnvio = '20150315';

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

-- Test OK
DELETE FROM Envios
WHERE idEnvio = 1;

SELECT * 
FROM Envios
WHERE idEnvio = 1;

-- Múltiple (borra las cuatro cargas del idEnvio = 52 en la tabla Carga y el propio idEnvio = 52 en la tabla Envios)
DELETE FROM Envios
WHERE idEnvio = 52;

-- Ver cargas del idEnvio = 52
SELECT *
FROM Carga
WHERE idEnvio = 52;

-- Ver idEnvio = 52
SELECT *
FROM Envios
WHERE idEnvio = 52;
