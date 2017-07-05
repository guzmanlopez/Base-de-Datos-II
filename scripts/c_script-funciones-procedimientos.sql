/*
*********************************************************************************************
* Script con funciones y procedimientos                                                     *
*********************************************************************************************
*/
USE BD_VEHICULOS;
go
/*
*********************************************************************************************
* a. Crear una función almacenada que reciba como parámetro un número de VIN
* completo y valide el dígito verificador, si dicho dígito es correcto la función debe
* retornar el texto ‘OK’, si es incorrecto, debe retornar todo el número de VIN pero
* incluyendo el dígito verificador correcto.
*********************************************************************************************
*/

-- Funciones auxiliares
ALTER FUNCTION funct_valor_num_asociado_vin
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

ALTER FUNCTION funct_factor_multiplicador_vin
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

-- Función principal
ALTER FUNCTION funct_validar_digitoverificador_vin
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

-- Tests

-- Test OK
DECLARE @output CHARACTER(17)
SET @output = dbo.funct_validar_digitoverificador_vin('1M8GDM9AXKP042788');
PRINT @output

-- Test corregido
DECLARE @output CHARACTER(17)
SET @output = dbo.funct_validar_digitoverificador_vin('1M8GDM9A1KP042788');
PRINT @output

-- Test OK
DECLARE @output CHARACTER(17)
SET @output = dbo.funct_validar_digitoverificador_vin('JN8DF5MV0FT250272');
PRINT @output

-- Test corregido
DECLARE @output CHARACTER(17)
SET @output = dbo.funct_validar_digitoverificador_vin('JN8DF5MV1FT250272');
PRINT @output


/*
*********************************************************************************************
* b. Crear una función que reciba como parámetro un VIN y retorne el año del modelo de
* dicho vehículo.
*********************************************************************************************
*/





/*
*********************************************************************************************
* c. Dado un rango de fechas, retornar la cantidad de vehículos que recibió el país que
* más vehículos recibió en dicho rango.
*********************************************************************************************
*/


/*
*********************************************************************************************
* d. Mediante un procedimiento almacenado que reciba un rango de fechas de envío,
* cambiar el país de destino del envío a todos los vehículos cuyo país de fabricación del
* vehículo sea el mismo que el país de destino del envío, en ese caso crear un país de
* código ‘#’ que tenga como descripción ‘LOCAL’ y poner ese dato como destino.
*********************************************************************************************
*/


/*
*********************************************************************************************
* e. Dado un rango de fechas, implementar una función que retorne el nombre del país al
* cual se le envió la menor cantidad de vehículos en dicho rango.
*********************************************************************************************
*/


/*
*********************************************************************************************
* f. Realizar un procedimiento almacenado que reciba un código de fabricante y retorne
* con parámetro de salida la cantidad de plantas que tiene y la cantidad de modelos de
* vehículos diferentes que produce.
*********************************************************************************************
*/



