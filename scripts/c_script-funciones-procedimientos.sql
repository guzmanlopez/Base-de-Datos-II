/*
*********************************************************************************************
* Script con funciones y procedimientos                                                     *
*********************************************************************************************
*/

USE BD_VEHICULOS;

/*
*********************************************************************************************
* a. Crear una función almacenada que reciba como parámetro un número de VIN
* completo y valide el dígito verificador, si dicho dígito es correcto la función debe
* retornar el texto ‘OK’, si es incorrecto, debe retornar todo el número de VIN pero
* incluyendo el dígito verificador correcto.
*********************************************************************************************
*/

-- Función auxiliar: retorna el valor numérico asociado
CREATE FUNCTION funct_valor_num_asociado_vin
(@letravin CHARACTER(1))
RETURNS INT
AS
BEGIN
DECLARE @ret INT

IF(@letravin = 'A') 
	BEGIN
	SET @ret = 1
	END
ELSE IF(@letravin = 'B') 
	BEGIN
	SET @ret = 2
	END
ELSE IF(@letravin = 'C') 
	BEGIN
	SET @ret = 3
	END
ELSE IF(@letravin = 'D') 
	BEGIN
	SET @ret = 4
	END
ELSE IF(@letravin = 'E') 
	BEGIN
	SET @ret = 5
	END
ELSE IF(@letravin = 'F') 
	BEGIN
	SET @ret = 6
	END
ELSE IF(@letravin = 'G') 
	BEGIN
	SET @ret = 7
	END
ELSE IF(@letravin = 'H') 
	BEGIN
	SET @ret = 8
	END
ELSE IF(@letravin = 'J') 
	BEGIN
	SET @ret = 1
	END
ELSE IF(@letravin = 'K') 
	BEGIN
	SET @ret = 2
	END
ELSE IF(@letravin = 'L') 
	BEGIN
	SET @ret = 3
	END
ELSE IF(@letravin = 'M') 
	BEGIN
	SET @ret = 4
	END
ELSE IF(@letravin = 'N') 
	BEGIN
	SET @ret = 5
	END
ELSE IF(@letravin = 'P') 
	BEGIN
	SET @ret = 7
	END
ELSE IF(@letravin = 'R') 
	BEGIN
	SET @ret = 9
	END
ELSE IF(@letravin = 'S') 
	BEGIN
	SET @ret = 2
	END
ELSE IF(@letravin = 'T') 
	BEGIN
	SET @ret = 3
	END
ELSE IF(@letravin = 'U') 
	BEGIN
	SET @ret = 4
	END
ELSE IF(@letravin = 'V') 
	BEGIN
	SET @ret = 5
	END
ELSE IF(@letravin = 'W') 
	BEGIN
	SET @ret = 6
	END
ELSE IF(@letravin = 'X') 
	BEGIN
	SET @ret = 7
	END
ELSE IF(@letravin = 'Y') 
	BEGIN
	SET @ret = 8
	END
ELSE IF(@letravin = 'Z') 
	BEGIN
	SET @ret = 9
	END
ELSE
	BEGIN
	SET @ret = @letravin
	END
RETURN @ret
END;

-- Función auxiliar: retorna el factor multiplicador
CREATE FUNCTION funct_factor_multiplicador_vin
(@posicionvin INT)
RETURNS INT
AS
BEGIN
DECLARE @ret INT
IF(@posicionvin IN (1,11)) 
	BEGIN
	SET @ret = 8
	END
ELSE IF(@posicionvin IN (2,12)) 
	BEGIN
	SET @ret = 7
	END
ELSE IF(@posicionvin IN (3,13)) 
	BEGIN
	SET @ret = 6
	END
ELSE IF(@posicionvin IN (4,14)) 
	BEGIN
	SET @ret = 5
	END
ELSE IF(@posicionvin IN (5,15)) 
	BEGIN
	SET @ret = 4
	END
ELSE IF(@posicionvin IN (6,16)) 
	BEGIN
	SET @ret = 3
	END
ELSE IF(@posicionvin IN (7,17)) 
	BEGIN
	SET @ret = 2
	END
ELSE IF(@posicionvin = 8) 
	BEGIN
	SET @ret = 10
	END
ELSE IF(@posicionvin = 10) 
	BEGIN
	SET @ret = 9
	END
RETURN @ret
END;

-- Función principal: valida el dígito verificador
CREATE FUNCTION funct_validar_digitoverificador_vin
(@vin CHARACTER(17))
RETURNS CHARACTER(17)
AS
BEGIN
DECLARE @ret CHARACTER(17)
DECLARE @valAsociado INT
DECLARE @factMultiplicador INT
DECLARE @producto INT
DECLARE @sumaProductos INT
DECLARE @resto VARCHAR(2)
DECLARE @dv CHAR(1)
SET @sumaProductos = 0
SET @dv = SUBSTRING(@vin,9,1)
SET @ret = 'OK'

-- Recorrer VIN 
DECLARE @ite INT
SET @ite = 1
WHILE (@ite < 18)
	BEGIN
		IF(@ite <> 9)
		BEGIN
		SET @valAsociado = dbo.funct_valor_num_asociado_vin(SUBSTRING(@vin,@ite,1))
		SET @factMultiplicador = dbo.funct_factor_multiplicador_vin(@ite)
		SET @producto = @valAsociado * @factMultiplicador
		SET @sumaProductos = @sumaProductos + @producto
		END
SET @ite = @ite + 1
	END	

-- Obtener dígito verificador
SET @resto = CAST(@sumaProductos % 11 AS VARCHAR(2))

-- Test
IF(@resto = '10' AND @dv <> 'X')
	BEGIN
	SET @ret = SUBSTRING(@vin,1,8) + 'X' + SUBSTRING(@vin,10,8)
	END
IF (@resto <> @dv AND @resto <> '10')
	BEGIN
	SET @ret = SUBSTRING(@vin,1,8) + @resto + SUBSTRING(@vin,10,8)
	END
RETURN @ret
END;

-- Test OK
DECLARE @output CHARACTER(17)
SET @output = dbo.funct_validar_digitoverificador_vin('1AAFE3203FAA10190');
PRINT @output

-- Test devuelve VIN corregido
DECLARE @output CHARACTER(17)
SET @output = dbo.funct_validar_digitoverificador_vin('1AAFE3209FAA10190');
PRINT @output

/*
*********************************************************************************************
* b. Crear una función que reciba como parámetro un VIN y retorne el año del modelo de
* dicho vehículo.
*********************************************************************************************
*/

-- Se asume que los autos transportados por la empresa ROVIA INC fueron modelos de autos que se hicieron a partir del año 2010.

CREATE FUNCTION funct_aniodelmodelo_vin
(@vin CHARACTER(17))
RETURNS INT
AS
BEGIN
DECLARE @ret INT
DECLARE @digitoAnio CHARACTER(1)

SET @digitoAnio = SUBSTRING(@vin,10,1)

IF(@digitoAnio = 'A')
	BEGIN
	SET @ret = 2010
	END
IF(@digitoAnio = 'B')
	BEGIN
	SET @ret = 2011
	END
IF(@digitoAnio = 'C')
	BEGIN
	SET @ret = 2012
	END
IF(@digitoAnio = 'D')
	BEGIN
	SET @ret = 2013
	END
IF(@digitoAnio = 'E')
	BEGIN
	SET @ret = 2014
	END
IF(@digitoAnio = 'F')
	BEGIN
	SET @ret = 2015
	END
IF(@digitoAnio = 'G')
	BEGIN
	SET @ret = 2016
	END
IF(@digitoAnio = 'H')
	BEGIN
	SET @ret = 2017
	END
IF(@digitoAnio = 'J')
	BEGIN
	SET @ret = 2018
	END
IF(@digitoAnio = 'K')
	BEGIN
	SET @ret = 2019
	END
IF(@digitoAnio = 'L')
	BEGIN
	SET @ret = 2020
	END
IF(@digitoAnio = 'M')
	BEGIN
	SET @ret = 2021
	END
IF(@digitoAnio = 'N')
	BEGIN
	SET @ret = 2022
	END
IF(@digitoAnio = 'P')
	BEGIN
	SET @ret = 2023
	END
IF(@digitoAnio = 'R')
	BEGIN
	SET @ret = 2024	
	END
IF(@digitoAnio = 'S')
	BEGIN
	SET @ret = 2025
	END
IF(@digitoAnio = 'T')
	BEGIN
	SET @ret = 2026
	END
IF(@digitoAnio = 'V')
	BEGIN
	SET @ret = 2027
	END
IF(@digitoAnio = 'W')
	BEGIN
	SET @ret = 2028
	END
IF(@digitoAnio = 'X')
	BEGIN
	SET @ret = 2029
	END
IF(@digitoAnio = 'Y')
	BEGIN
	SET @ret = 2030
	END
IF(@digitoAnio = '1')
	BEGIN
	SET @ret = 2031
	END
IF(@digitoAnio = '2')
	BEGIN
	SET @ret = 2032
	END
IF(@digitoAnio = '3')
	BEGIN
	SET @ret = 2033
	END
IF(@digitoAnio = '4')
	BEGIN
	SET @ret = 2034
	END
IF(@digitoAnio = '5')
	BEGIN
	SET @ret = 2035
	END
IF(@digitoAnio = '6')
	BEGIN
	SET @ret = 2036
	END
IF(@digitoAnio = '7')
	BEGIN
	SET @ret = 2037
	END
IF(@digitoAnio = '8')
	BEGIN
	SET @ret = 2038
	END
IF(@digitoAnio = '9')
	BEGIN
	SET @ret = 2039
	END
RETURN @ret
END;

-- Test 2015
DECLARE @output INT
SET @output = dbo.funct_aniodelmodelo_vin('1AAFE3203FAA10190');
PRINT @output

-- Test 2016
DECLARE @output INT
SET @output = dbo.funct_aniodelmodelo_vin('1AAFE3201GAA10190');
PRINT @output

/*
*********************************************************************************************
* c. Dado un rango de fechas, retornar la cantidad de vehículos que recibió el país que
* más vehículos recibió en dicho rango.
*********************************************************************************************
*/

CREATE FUNCTION funct_fechas_cantvehiculos_pais_maxcant
(@fchIni DATE, @fchFin DATE)
RETURNS INT
AS
BEGIN
DECLARE @ret INT
SELECT @ret = COUNT(V.vin)
FROM Vehiculos V, Envios E, Carga C
WHERE V.vin = C.vin
AND E.idEnvio = C.idEnvio
AND E.fchEnvio BETWEEN @fchIni AND @fchFin
GROUP BY E.desEnvio
HAVING COUNT(V.vin) >= ALL(SELECT COUNT(V2.vin)
						  FROM Vehiculos V2, Envios E2, Carga C2
						  WHERE V2.vin = C2.vin
						  AND E2.idEnvio = C2.idEnvio
						  AND E2.fchEnvio BETWEEN @fchIni AND @fchFin
						  GROUP BY E2.desEnvio)
RETURN @ret
END;

-- Test
DECLARE @fchIni DATE
DECLARE @fchFin DATE
DECLARE @output INT
SET @fchIni = '20150101' 
SET @fchFin = '20170620'
SET @output = dbo.funct_fechas_cantvehiculos_pais_maxcant(@fchIni, @fchFin)
PRINT @output

/*
*********************************************************************************************
* d. Mediante un procedimiento almacenado que reciba un rango de fechas de envío,
* cambiar el país de destino del envío a todos los vehículos cuyo país de fabricación del
* vehículo sea el mismo que el país de destino del envío, en ese caso crear un país de
* código ‘#’ que tenga como descripción ‘LOCAL’ y poner ese dato como destino.
*********************************************************************************************
*/

CREATE PROCEDURE sp_fechasenvio_cambiapaisdestino
@fchIni DATE,
@fchFin DATE
AS
BEGIN
UPDATE Envios
SET desEnvio = '#'
WHERE fchEnvio BETWEEN @fchIni AND @fchFin
AND desEnvio IN (SELECT E.desEnvio
				 FROM Vehiculos V, Carga C, Envios E
				 WHERE V.vin = C.vin
				 AND C.idEnvio = E.idEnvio
				 AND E.fchEnvio BETWEEN @fchIni AND @fchFin
				 AND V.codPais = E.desEnvio)
END;

-- Test procedure
-- Insertar país local en la tabla Paises
INSERT INTO Paises(codPais, nomPais)
VALUES('#', 'LOCAL');

-- Insertar un envío cuyo destino final sea el país que lo fabrico
DECLARE @pesoTot NUMERIC(12,2)
SELECT @pesoTot = peso*1.05 FROM Vehiculos WHERE vin = '16AFE3201F6A10190'

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20151008', @pesoTot, '2', '1');

-- Insertar Carga (1 auto para el envío creado)
DECLARE @pesoTot NUMERIC(12,2)
SELECT @pesoTot = peso*1.05 FROM Vehiculos WHERE vin = '16AFE3201F6A10190'

INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES((SELECT idEnvio FROM Envios
	    WHERE fchEnvio = '20151008'
	    AND oriEnvio = '2'
	    AND desEnvio = '1'), 1, '16AFE3201F6A10190', @pesoTot)

-- Ejecutar procedure sin cambios por no coincidir fechas
EXEC sp_fechasenvio_cambiapaisdestino '20170101', '20170105'  

SELECT * 
FROM Envios E
WHERE E.desEnvio = '#';

-- Ejecutar procedure con cambios
EXEC sp_fechasenvio_cambiapaisdestino '20150101', '20151231'  

SELECT * 
FROM Envios E
WHERE E.desEnvio = '#';

/*
*********************************************************************************************
* e. Dado un rango de fechas, implementar una función que retorne el nombre del país al
* cual se le envió la menor cantidad de vehículos en dicho rango.
*********************************************************************************************
*/

-- Nota: si hay más de un país con la menor cantidad de vehículos en dicho rango solo va a mostrar uno. 

CREATE FUNCTION funct_fechas_nompais_menorcantvehic
(@fchIni DATE, @fchFin DATE)
RETURNS VARCHAR(30)
AS
BEGIN
DECLARE @ret VARCHAR(30)
SELECT @ret = P.nomPais
FROM Paises P, Envios E
WHERE P.codPais = E.desEnvio 
AND E.fchEnvio BETWEEN @fchIni AND @fchFin
GROUP BY P.nomPais
HAVING COUNT(E.idEnvio) <=ALL(SELECT COUNT(E2.idEnvio)
							  FROM Paises P2, Envios E2
							  WHERE P2.codPais = E2.desEnvio 
							  AND E2.fchEnvio BETWEEN @fchIni AND @fchFin
							  GROUP BY P2.nomPais)
RETURN @ret
END;

-- Test 
DECLARE @output VARCHAR(30)
SET @output = dbo.funct_fechas_nompais_menorcantvehic('20100101',GETDATE())
PRINT @output

-- Durante 2015
DECLARE @output VARCHAR(30)
SET @output = dbo.funct_fechas_nompais_menorcantvehic('20150101','20151231')
PRINT @output

-- Durante 2016
DECLARE @output VARCHAR(30)
SET @output = dbo.funct_fechas_nompais_menorcantvehic('20160101','20161231')
PRINT @output

/*
*********************************************************************************************
* f. Realizar un procedimiento almacenado que reciba un código de fabricante y retorne
* con parámetro de salida la cantidad de plantas que tiene y la cantidad de modelos de
* vehículos diferentes que produce.
*********************************************************************************************
*/

-- Con el codFab
CREATE PROCEDURE sp_codfab_cantplantas_cantmodelosvehic
@codFab CHARACTER(2),
@cantPlantas INT OUTPUT,
@cantModelosVehic INT OUTPUT
AS
BEGIN
SELECT @cantPlantas = COUNT(DISTINCT(P.codPlan)), @cantModelosVehic = COUNT(DISTINCT(V.modelo))
FROM Fabricantes F, Plantas P, Vehiculos V
WHERE F.codFab = V.codFab
AND F.codFab = P.codFab
AND F.codFab = @codFab
GROUP BY F.codFab
END;

-- Test para codFab = AA
DECLARE @out1 INT
DECLARE @out2 INT
EXEC sp_codfab_cantplantas_cantmodelosvehic 'AA', @out1 OUTPUT, @out2 OUTPUT  
PRINT 'Cant_plantas: ' + CAST(@out1 AS CHARACTER(2)) + '| Cant_modelos: ' + CAST(@out2 AS CHARACTER(2))

-- Test para codFab = JA
DECLARE @out1 INT
DECLARE @out2 INT
EXEC sp_codfab_cantplantas_cantmodelosvehic 'JA', @out1 OUTPUT, @out2 OUTPUT  
PRINT 'Cant_plantas: ' + CAST(@out1 AS CHARACTER(2)) + '| Cant_modelos: ' + CAST(@out2 AS CHARACTER(2))

-- Misma función pero ingresando el nombre de un fabricante sin distinguir entre sus divisiones, para retornar la cantidad de plantas y la cantidad de modelos de la marce "Audi" por ejemplo:

-- Con el codFab
CREATE PROCEDURE sp_nomfab_cantplantas_cantmodelosvehic
@nomFab VARCHAR(30),
@cantPlantas INT OUTPUT,
@cantModelosVehic INT OUTPUT
AS
BEGIN
SELECT @cantPlantas = COUNT(DISTINCT(P.codPlan)), @cantModelosVehic = COUNT(DISTINCT(V.modelo))
FROM Fabricantes F, Plantas P, Vehiculos V
WHERE F.codFab = V.codFab
AND F.codFab = P.codFab
AND F.nomFab = @nomFab
GROUP BY F.nomFab
END;

-- Test para 'Audi'
DECLARE @out1 INT
DECLARE @out2 INT
EXEC sp_nomfab_cantplantas_cantmodelosvehic 'Audi', @out1 OUTPUT, @out2 OUTPUT  
PRINT 'Cant_plantas: ' + CAST(@out1 AS CHARACTER(2)) + '| Cant_modelos: ' + CAST(@out2 AS CHARACTER(2))

