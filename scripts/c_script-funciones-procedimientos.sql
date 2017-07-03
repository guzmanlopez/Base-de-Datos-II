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



