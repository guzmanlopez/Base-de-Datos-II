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
CREATE FUNCTION funct_validar_digitoverificador_vin
(@vin character(17))
RETURNS character(17)
AS
BEGIN
DECLARE @ret character(17)


RETURN @ret
END;


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



