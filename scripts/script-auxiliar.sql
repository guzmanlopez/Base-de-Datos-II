/*
*********************************************************************************************
* Script auxiliar con funciones para facilitar el ingreso de datos de prueba y tests
*********************************************************************************************
*/

/*
*********************************************************************************************
* Dado un nombre de país retornar su código
*********************************************************************************************
*/

CREATE FUNCTION funct_aux_nombre_codPais
(@nombre VARCHAR(30))
RETURNS CHARACTER(1)
BEGIN
DECLARE @ret CHARACTER(1)
IF(@nombre = 'Estados Unidos')
	BEGIN
	SET @ret = '1'
	END
IF(@nombre = 'Canadá')
	BEGIN
	SET @ret = '2'
	END
IF(@nombre = 'México')
	BEGIN
	SET @ret = '3'
	END
IF(@nombre = 'Argentina')
	BEGIN
	SET @ret = '4'
	END
IF(@nombre = 'Chile')
	BEGIN
	SET @ret = '5'
	END
IF(@nombre = 'Panamá')
	BEGIN
	SET @ret = '6'
	END
IF(@nombre = 'Pakistán')
	BEGIN
	SET @ret = '7'
	END
IF(@nombre = 'España')
	BEGIN
	SET @ret = '8'
	END
IF(@nombre = 'Brasil')
	BEGIN
	SET @ret = '9'
	END
IF(@nombre = 'Japón')
	BEGIN
	SET @ret = 'J'
	END
IF(@nombre = 'Korea')
	BEGIN
	SET @ret = 'K'
	END
IF(@nombre = 'Inglaterra')
	BEGIN
	SET @ret = 'S'
	END
IF(@nombre = 'Alemania')
	BEGIN
	SET @ret = 'W'
	END
IF(@nombre = 'Suecia')
	BEGIN
	SET @ret = 'Y'
	END
IF(@nombre = 'Italia')
	BEGIN
	SET @ret = 'Z'
	END
RETURN @ret
END;


-- Test
DECLARE @output CHARACTER(1)
SET @output = dbo.funct_aux_nombre_codPais('Alemania')
PRINT @output

DECLARE @output CHARACTER(1)
SET @output = dbo.funct_aux_nombre_codPais('Brasil')
PRINT @output

/*
*********************************************************************************************
* Dado un código de fabricante retornar su nombre
*********************************************************************************************
*/

CREATE FUNCTION funct_aux_codFab_nombre
(@codFab CHARACTER(2))
RETURNS VARCHAR(30)
BEGIN
DECLARE @ret VARCHAR(30)
DECLARE @codFabSinDiv CHARACTER(1)

SET @codFabSinDiv = SUBSTRING(@codFab,1,1)

IF(@codFabSinDiv = 'A')
	BEGIN
	SET @ret = 'Audi'
	END
IF(@codFabSinDiv = 'B')
	BEGIN
	SET @ret = 'Bmw'
	END
IF(@codFabSinDiv = 'C')
	BEGIN
	SET @ret = 'Chrysler'
	END
IF(@codFabSinDiv = 'D')
	BEGIN
	SET @ret = 'Mercedes Benz'
	END
IF(@codFabSinDiv = 'E')
	BEGIN
	SET @ret = 'Dodge'
	END
IF(@codFabSinDiv = 'F')
	BEGIN
	SET @ret = 'Ford'
	END
IF(@codFabSinDiv = 'G')
	BEGIN
	SET @ret = 'GM'
	END
IF(@codFabSinDiv = 'H')
	BEGIN
	SET @ret = 'Honda'
	END
IF(@codFabSinDiv = 'J')
	BEGIN
	SET @ret = 'Jaguar'
	END
IF(@codFabSinDiv = 'L')
	BEGIN
	SET @ret = 'Lincon'
	END
IF(@codFabSinDiv = 'M')
	BEGIN
	SET @ret = 'Mercury'
	END
IF(@codFabSinDiv = 'N')
	BEGIN
	SET @ret = 'Nissan'
	END
IF(@codFabSinDiv = 'P')
	BEGIN
	SET @ret = 'Plymounth'
	END
IF(@codFabSinDiv = 'R')
	BEGIN
	SET @ret = 'Renault'
	END
IF(@codFabSinDiv = 'S')
	BEGIN
	SET @ret = 'Saab'
	END
IF(@codFabSinDiv = 'T')
	BEGIN
	SET @ret = 'Toyota'
	END
IF(@codFabSinDiv = 'V')
	BEGIN
	SET @ret = 'Volkswagen'
	END
IF(@codFabSinDiv = '2' OR @codFabSinDiv = '5')
	BEGIN
	SET @ret = 'Pontiac'
	END
IF(@codFabSinDiv = '3')
	BEGIN
	SET @ret = 'Oldsmobile'
	END
IF(@codFabSinDiv = '4')
	BEGIN
	SET @ret = 'Buick'
	END
IF(@codFabSinDiv = '6')
	BEGIN
	SET @ret = 'Cadillac'
	END
IF(@codFabSinDiv = '7')
	BEGIN
	SET @ret = 'GM Canada'
	END
IF(@codFabSinDiv = '8')
	BEGIN
	SET @ret = 'Saturn'
	END
RETURN @ret
END

-- Test OK
DECLARE @output VARCHAR(30)
SET @output = dbo.funct_aux_codFab_nombre('A')
PRINT @output

DECLARE @output VARCHAR(30)
SET @output = dbo.funct_aux_codFab_nombre('5')
PRINT @output


/*
*********************************************************************************************
* Dado un nombre de fabricante retornar su código
*********************************************************************************************
*/

CREATE FUNCTION funct_aux_nombre_codFab
(@nomFab VARCHAR(30))
RETURNS CHARACTER(1)
BEGIN
DECLARE @ret CHARACTER(1)

IF(@nomFab = 'Audi')
	BEGIN
	SET @ret = 'A'
	END
IF(@nomFab = 'Bmw')
	BEGIN
	SET @ret = 'B'
	END
IF(@nomFab = 'Chrysler')
	BEGIN
	SET @ret = 'C'
	END
IF(@nomFab = 'Mercedes Benz')
	BEGIN
	SET @ret = 'D'
	END
IF(@nomFab = 'Dodge')
	BEGIN
	SET @ret = 'E'
	END
IF(@nomFab = 'Ford')
	BEGIN
	SET @ret = 'F'
	END
IF(@nomFab = 'GM')
	BEGIN
	SET @ret = 'G'
	END
IF(@nomFab = 'Honda')
	BEGIN
	SET @ret = 'H'
	END
IF(@nomFab = 'Jaguar')
	BEGIN
	SET @ret = 'J'
	END
IF(@nomFab = 'Lincon')
	BEGIN
	SET @ret = 'L'
	END
IF(@nomFab = 'Mercury')
	BEGIN
	SET @ret = 'M'
	END
IF(@nomFab = 'Nissan')
	BEGIN
	SET @ret = 'N'
	END
IF(@nomFab = 'Plymounth')
	BEGIN
	SET @ret = 'P'
	END
IF(@nomFab = 'Renault')
	BEGIN
	SET @ret = 'R'
	END
IF(@nomFab = 'Saab')
	BEGIN
	SET @ret = 'S'
	END
IF(@nomFab = 'Toyota')
	BEGIN
	SET @ret = 'T'
	END
IF(@nomFab = 'Volkswagen')
	BEGIN
	SET @ret = 'V'
	END
IF(@nomFab = 'Pontiac')
	BEGIN
	SET @ret = '2'
	END
IF(@nomFab = 'Oldsmobile')
	BEGIN
	SET @ret = '3'
	END
IF(@nomFab = 'Buick')
	BEGIN
	SET @ret = '4'
	END
IF(@nomFab = 'Cadillac')
	BEGIN
	SET @ret = '6'
	END
IF(@nomFab = 'GM Canada')
	BEGIN
	SET @ret = '7'
	END
IF(@nomFab = 'Saturn')
	BEGIN
	SET @ret = '8'
	END
RETURN @ret
END

-- Test OK
DECLARE @output CHARACTER(1)
SET @output = dbo.funct_aux_nombre_codFab('Audi')
PRINT @output

DECLARE @output CHARACTER(1)
SET @output = dbo.funct_aux_codFab_nombre('Saturn')
PRINT @output

/*
*********************************************************************************************
* Dado un año retornar código
*********************************************************************************************
*/

CREATE FUNCTION funct_anio_cod
(@anio INT)
RETURNS CHAR(1)
AS
BEGIN
DECLARE @ret CHAR(1)

IF(@anio = 2010)
	BEGIN
	SET @ret = 'A'
	END
IF(@anio = 2011)
	BEGIN
	SET @ret = 'B'
	END
IF(@anio = 2012)
	BEGIN
	SET @ret = 'C'
	END
IF(@anio = 2013)
	BEGIN
	SET @ret = 'D'
	END
IF(@anio = 2014)
	BEGIN
	SET @ret = 'E'
	END
IF(@anio = 2015)
	BEGIN
	SET @ret = 'F'
	END
IF(@anio = 2016)
	BEGIN
	SET @ret = 'G'
	END
IF(@anio = 2017)
	BEGIN
	SET @ret = 'H' 
	END
IF(@anio = 2018)
	BEGIN
	SET @ret = 'J'
	END
IF(@anio = 2019)
	BEGIN
	SET @ret = 'K'
	END
IF(@anio = 2020)
	BEGIN
	SET @ret = 'L'
	END
IF(@anio = 2021)
	BEGIN
	SET @ret = 'M'
	END
IF(@anio = 2022)
	BEGIN
	SET @ret = 'N'
	END
IF(@anio = 2023)
	BEGIN
	SET @ret = 'P'
	END
IF(@anio = 2024)
	BEGIN
	SET @ret = 'R'	
	END
IF(@anio = 2025)
	BEGIN
	SET @ret = 'S'
	END
IF(@anio = 2026)
	BEGIN
	SET @ret = 'T'
	END
IF(@anio = 2027)
	BEGIN
	SET @ret = 'V'
	END
IF(@anio = 2028)
	BEGIN
	SET @ret = 'W'
	END
IF(@anio = 2029)
	BEGIN
	SET @ret = 'X'
	END
IF(@anio = 2030)
	BEGIN
	SET @ret = 'Y'
	END
IF(@anio = 2031)
	BEGIN
	SET @ret = '1'
	END
IF(@anio = 2032)
	BEGIN
	SET @ret = '2'
	END
IF(@anio = 2033)
	BEGIN
	SET @ret = '3'
	END
IF(@anio = 2034)
	BEGIN
	SET @ret = '4'
	END
IF(@anio = 2035)
	BEGIN
	SET @ret = '5'
	END
IF(@anio = 2036)
	BEGIN
	SET @ret = '6'
	END
IF(@anio = 2037)
	BEGIN
	SET @ret = '7'
	END
IF(@anio = 2038)
	BEGIN
	SET @ret = '8'
	END
IF(@anio = 2039)
	BEGIN
	SET @ret = '9'
	END
RETURN @ret
END;

-- Test
DECLARE @output CHARACTER(1)
SET @output = dbo.funct_anio_cod(2010)
PRINT @output

DECLARE @output CHARACTER(1)
SET @output = dbo.funct_anio_cod(2023)
PRINT @output

/*
*********************************************************************************************
* Generador de VINs dado un codPais, codFab, tipoChasis, tipoMotor, Año 
*********************************************************************************************
*/

-- Funciones auxiliares a la función crear VIN

-- Crear WMI
CREATE FUNCTION funct_aux_crear_WMI
(@codPais CHARACTER(1), @codFab CHARACTER(2))
RETURNS CHARACTER(3)
BEGIN
DECLARE @ret CHARACTER(3)
SET @ret = @codPais + @codFab
RETURN @ret
END

-- Test
DECLARE @output CHARACTER(3)
SET @output = dbo.funct_aux_crear_WMI('1','AA')
PRINT @output

-- Crear VDS
CREATE FUNCTION funct_aux_crear_VDS
(@tipoChasis VARCHAR(30), @modeloMotor VARCHAR(30))
RETURNS CHARACTER(6)
BEGIN
DECLARE @ret CHARACTER(6)
DECLARE @codChasis CHARACTER(2)
DECLARE @codMotor CHARACTER(2)
DECLARE @rand1 CHARACTER(1)
DECLARE @rand2 CHARACTER(1)

IF(@tipoChasis = 'Aluminio')
	BEGIN
	SET @codChasis = 'AL'
	END
IF(@tipoChasis = 'Hierro')
	BEGIN
	SET @codChasis = 'FE'
	END

IF(@modeloMotor = '1.0')
	BEGIN
	SET @codMotor = '10'
	END
IF(@modeloMotor = '1.5')
	BEGIN
	SET @codMotor = '15'
	END
IF(@modeloMotor = '2.0')
	BEGIN
	SET @codMotor = '20'
	END

SET @rand1 = '3'
SET @rand2 = '4'
SET @ret = @codChasis + @rand1 + @codMotor + @rand2

RETURN @ret
END

-- Test
DECLARE @output CHARACTER(6)
SET @output = dbo.funct_aux_crear_VDS('Aluminio','2.0')
PRINT @output

DECLARE @output CHARACTER(6)
SET @output = dbo.funct_aux_crear_VDS('Hierro','1.0')
PRINT @output

-- Crear VIS
CREATE FUNCTION funct_aux_crear_VIS
(@anio INT, @codFab CHARACTER(2))
RETURNS CHARACTER(8)
BEGIN
DECLARE @ret CHARACTER(8)
DECLARE @codAnio CHARACTER(1)
DECLARE @codCifras CHARACTER(4)

SET @codAnio = dbo.funct_anio_cod(@anio)

IF(@anio BETWEEN 2010 AND 2019)
	BEGIN
	SET @codCifras = '1019'
	END
IF(@anio BETWEEN 2019 AND 2020)
	BEGIN
	SET @codCifras = '1920'
	END
IF(@anio BETWEEN 2020 AND 2029)
	BEGIN
	SET @codCifras = '2029'
	END
IF(@anio BETWEEN 2029 AND 2039)
	BEGIN
	SET @codCifras = '2939'
	END

SET @ret = @codAnio + @codFab + @codCifras

RETURN @ret
END

-- Test
DECLARE @output CHARACTER(8)
SET @output = dbo.funct_aux_crear_VIS(2010,'AA')
PRINT @output

DECLARE @output CHARACTER(8)
SET @output = dbo.funct_aux_crear_VIS(2019,'AB')
PRINT @output

DECLARE @output CHARACTER(8)
SET @output = dbo.funct_aux_crear_VIS(2025,'BS')
PRINT @output

-- Crear VIN generator (sin verificar el dígito verificador en la posición 9)
CREATE FUNCTION funct_aux_VIN_generator
(@codPais CHARACTER(1), @codFab CHARACTER(2), @tipoChasis VARCHAR(30), @tipoMotor VARCHAR(30), @Anio INT)
RETURNS CHARACTER(17)
BEGIN
DECLARE @ret CHARACTER(17)
DECLARE @WMI CHARACTER(3)
DECLARE @VDS CHARACTER(6)
DECLARE @VIS CHARACTER(8)

SET @WMI = dbo.funct_aux_crear_WMI(@codPais, @codFab)
SET @VDS = dbo.funct_aux_crear_VDS(@tipoChasis, @tipoMotor)
SET @VIS = dbo.funct_aux_crear_VIS(@Anio, @codFab)
SET @ret = @WMI + @VDS + @VIS

RETURN @ret
END

-- Test
DECLARE @output CHARACTER(17)
SET @output = dbo.funct_aux_VIN_generator('1','AA','Aluminio','2.0',2025)
PRINT @output

DECLARE @output CHARACTER(17)
SET @output = dbo.funct_aux_VIN_generator('1','BS','Hierro','1.0',2015)
PRINT @output
