/*
*********************************************************************************************
* Script con funciones y procedimientos                                                     *
*********************************************************************************************
*/
USE BD_VEHICULOS;
go
/*
*********************************************************************************************
* a. Crear una funci�n almacenada que reciba como par�metro un n�mero de VIN
* completo y valide el d�gito verificador, si dicho d�gito es correcto la funci�n debe
* retornar el texto �OK�, si es incorrecto, debe retornar todo el n�mero de VIN pero
* incluyendo el d�gito verificador correcto.
*********************************************************************************************
*/

ALTER FUNCTION funct_valor_num_asociado_vin
(@letravin character(1))
RETURNS character(1)
AS
BEGIN
DECLARE @ret character(1)

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
	SET @ret = 0
	END

RETURN @ret
END;


ALTER FUNCTION funct_validar_digitoverificador_vin
(@vin character(17))
RETURNS character(17)
AS
BEGIN
DECLARE @ret character(17)
DECLARE @valAsociados varchar(17)

-- a. Encontrar el valor num�rico asociado a cada letra en el VIN (las letras I, O, Q y � no se permiten)
DECLARE @ite int
SET @ite = 1
WHILE (@ite < 18)
	BEGIN
		IF(@ite = 1)
			BEGIN
			SET @valAsociados = dbo.funct_valor_num_asociado_vin(SUBSTRING(@vin,1,1))
			END
		IF(@ite > 1)
			BEGIN
			DECLARE @valNum character(1)
			SET @valNum = dbo.funct_valor_num_asociado_vin(SUBSTRING(@vin,@ite,1))
			SET @valAsociados = @valAsociados + @valNum
			END
SET @ite = @ite + 1
	END
SET @ret = @valAsociados
RETURN @ret
END;


DECLARE @output character(17)
SET @output = dbo.funct_validar_digitoverificador_vin('ABCDEFGHJKLMNPRST');
PRINT @output


/*
*********************************************************************************************
* b. Crear una funci�n que reciba como par�metro un VIN y retorne el a�o del modelo de
* dicho veh�culo.
*********************************************************************************************
*/


/*
*********************************************************************************************
* c. Dado un rango de fechas, retornar la cantidad de veh�culos que recibi� el pa�s que
* m�s veh�culos recibi� en dicho rango.
*********************************************************************************************
*/


/*
*********************************************************************************************
* d. Mediante un procedimiento almacenado que reciba un rango de fechas de env�o,
* cambiar el pa�s de destino del env�o a todos los veh�culos cuyo pa�s de fabricaci�n del
* veh�culo sea el mismo que el pa�s de destino del env�o, en ese caso crear un pa�s de
* c�digo �#� que tenga como descripci�n �LOCAL� y poner ese dato como destino.
*********************************************************************************************
*/


/*
*********************************************************************************************
* e. Dado un rango de fechas, implementar una funci�n que retorne el nombre del pa�s al
* cual se le envi� la menor cantidad de veh�culos en dicho rango.
*********************************************************************************************
*/


/*
*********************************************************************************************
* f. Realizar un procedimiento almacenado que reciba un c�digo de fabricante y retorne
* con par�metro de salida la cantidad de plantas que tiene y la cantidad de modelos de
* veh�culos diferentes que produce.
*********************************************************************************************
*/



