/*
*********************************************************************************************
* Script con las restricciones de integridad creadas sobre el script de creación de tablas, *
* índices, y el ingreso de datos de prueba.                                                 *
*********************************************************************************************
*/

USE BD_VEHICULOS;

/*
*********************************************************************************************
* Creación de Restricciones de Integridad
*********************************************************************************************
*/

-- Tabla Paises
ALTER TABLE Paises
ADD CONSTRAINT const_Paises_pk_codPais 
PRIMARY KEY(codPais);

ALTER TABLE Paises
ADD CONSTRAINT const_Paises_uniq_nomPais 
UNIQUE(nomPais);

-- Tabla Fabricantes
ALTER TABLE Fabricantes
ADD CONSTRAINT const_Fabricantes_pk_codFab 
PRIMARY KEY(codFab);

ALTER TABLE Fabricantes
ADD CONSTRAINT const_Fabricantes_uniq_mailFab 
UNIQUE(mailFab);

ALTER TABLE Fabricantes
ADD cantEmp INT NOT NULL;

ALTER TABLE Fabricantes
ADD CONSTRAINT const_Fabricantes_chk_cantEmp 
CHECK (cantEmp > 0);

-- Tabla Plantas
ALTER TABLE Plantas
ADD CONSTRAINT const_Plantas_pk_codPlan_codFab 
PRIMARY KEY(codPlan, codFab);

ALTER TABLE Plantas
ADD CONSTRAINT const_Plantas_fk_codFab 
FOREIGN KEY(codFab) REFERENCES Fabricantes(codFab);

ALTER TABLE Plantas
ADD CONSTRAINT const_Plantas_fk_codPais 
FOREIGN KEY(codPais) REFERENCES Paises(codPais);

ALTER TABLE Plantas
ADD CONSTRAINT const_Plantas_uniq_mailPlan 
UNIQUE(mailPlan);

-- Tabla Vehiculos
ALTER TABLE Vehiculos
ADD CONSTRAINT const_Vehiculos_pk_vin 
PRIMARY KEY(vin);

ALTER TABLE Vehiculos
ADD CONSTRAINT const_Vehiculos_fk_codPais 
FOREIGN KEY(codPais) REFERENCES Paises(codPais);

ALTER TABLE Vehiculos
ADD CONSTRAINT const_Vehiculos_fk_codFab
FOREIGN KEY(codFab) REFERENCES Fabricantes(codFab);

-- Tabla Envios
ALTER TABLE Envios
ADD CONSTRAINT const_Envios_pk_idEnvio 
PRIMARY KEY(idEnvio);

ALTER TABLE Envios
ADD CONSTRAINT const_Envios_fk_oriEnvio 
FOREIGN KEY(oriEnvio) REFERENCES Paises(codPais);

ALTER TABLE Envios
ADD CONSTRAINT const_Envios_fk_desEnvio 
FOREIGN KEY(desEnvio) REFERENCES Paises(codPais);

-- Tabla Carga
ALTER TABLE Carga
ADD CONSTRAINT const_Carga_pk_idEnvio_idCarga 
PRIMARY KEY(idEnvio, idCarga);

ALTER TABLE Carga
ADD CONSTRAINT const_Carga_fk_idEnvio 
FOREIGN KEY(idEnvio) REFERENCES Envios(idEnvio);

ALTER TABLE Carga
ADD CONSTRAINT const_Carga_fk_vin 
FOREIGN KEY(vin) REFERENCES Vehiculos(vin);

/*
*********************************************************************************************
* Creación de Índices
*********************************************************************************************
*/

-- Tabla Plantas
CREATE INDEX idx_Plantas_codFab
ON Plantas(codFab); 

CREATE INDEX idx_Plantas_codPais
ON Plantas(codPais); 

-- Tabla Vehiculos
CREATE INDEX idx_Vehiculos_codPais
ON Vehiculos(codPais); 

CREATE INDEX idx_Vehiculos_codFab
ON Vehiculos(codFab); 

-- Tabla Envios
CREATE INDEX idx_Envios_oriEnvio
ON Envios(oriEnvio); 

CREATE INDEX idx_Envios_desEnvio
ON Envios(desEnvio); 

-- Tabla Carga
CREATE INDEX idx_Carga_vin
ON Carga(vin); 

/*
*********************************************************************************************
* Ingreso de datos de prueba: OK
*********************************************************************************************
*/

-- *****************
-- Tabla Paises 
-- *****************

DECLARE @codPais CHARACTER(1)
DECLARE @nomPais VARCHAR(30)
SET @nomPais = 'Estados Unidos'
SET @codPais = dbo.funct_aux_nombre_codPais(@nomPais)
INSERT INTO Paises(codPais, nomPais)
VALUES(@codPais, @nomPais);

DECLARE @codPais CHARACTER(1)
DECLARE @nomPais VARCHAR(30)
SET @nomPais = 'Canadá'
SET @codPais = dbo.funct_aux_nombre_codPais(@nomPais)
INSERT INTO Paises(codPais, nomPais)
VALUES(@codPais, @nomPais);

DECLARE @codPais CHARACTER(1)
DECLARE @nomPais VARCHAR(30)
SET @nomPais = 'México'
SET @codPais = dbo.funct_aux_nombre_codPais(@nomPais)
INSERT INTO Paises(codPais, nomPais)
VALUES(@codPais, @nomPais);

DECLARE @codPais CHARACTER(1)
DECLARE @nomPais VARCHAR(30)
SET @nomPais = 'Argentina'
SET @codPais = dbo.funct_aux_nombre_codPais(@nomPais)
INSERT INTO Paises(codPais, nomPais)
VALUES(@codPais, @nomPais);

DECLARE @codPais CHARACTER(1)
DECLARE @nomPais VARCHAR(30)
SET @nomPais = 'Chile'
SET @codPais = dbo.funct_aux_nombre_codPais(@nomPais)
INSERT INTO Paises(codPais, nomPais)
VALUES(@codPais, @nomPais);

DECLARE @codPais CHARACTER(1)
DECLARE @nomPais VARCHAR(30)
SET @nomPais = 'Panamá'
SET @codPais = dbo.funct_aux_nombre_codPais(@nomPais)
INSERT INTO Paises(codPais, nomPais)
VALUES(@codPais, @nomPais);

DECLARE @codPais CHARACTER(1)
DECLARE @nomPais VARCHAR(30)
SET @nomPais = 'Pakistán'
SET @codPais = dbo.funct_aux_nombre_codPais(@nomPais)
INSERT INTO Paises(codPais, nomPais)
VALUES(@codPais, @nomPais);

DECLARE @codPais CHARACTER(1)
DECLARE @nomPais VARCHAR(30)
SET @nomPais = 'España'
SET @codPais = dbo.funct_aux_nombre_codPais(@nomPais)
INSERT INTO Paises(codPais, nomPais)
VALUES(@codPais, @nomPais);

DECLARE @codPais CHARACTER(1)
DECLARE @nomPais VARCHAR(30)
SET @nomPais = 'Brasil'
SET @codPais = dbo.funct_aux_nombre_codPais(@nomPais)
INSERT INTO Paises(codPais, nomPais)
VALUES(@codPais, @nomPais);

DECLARE @codPais CHARACTER(1)
DECLARE @nomPais VARCHAR(30)
SET @nomPais = 'Japón'
SET @codPais = dbo.funct_aux_nombre_codPais(@nomPais)
INSERT INTO Paises(codPais, nomPais)
VALUES(@codPais, @nomPais);

DECLARE @codPais CHARACTER(1)
DECLARE @nomPais VARCHAR(30)
SET @nomPais = 'Korea'
SET @codPais = dbo.funct_aux_nombre_codPais(@nomPais)
INSERT INTO Paises(codPais, nomPais)
VALUES(@codPais, @nomPais);

DECLARE @codPais CHARACTER(1)
DECLARE @nomPais VARCHAR(30)
SET @nomPais = 'Inglaterra'
SET @codPais = dbo.funct_aux_nombre_codPais(@nomPais)
INSERT INTO Paises(codPais, nomPais)
VALUES(@codPais, @nomPais);

DECLARE @codPais CHARACTER(1)
DECLARE @nomPais VARCHAR(30)
SET @nomPais = 'Alemania'
SET @codPais = dbo.funct_aux_nombre_codPais(@nomPais)
INSERT INTO Paises(codPais, nomPais)
VALUES(@codPais, @nomPais);

DECLARE @codPais CHARACTER(1)
DECLARE @nomPais VARCHAR(30)
SET @nomPais = 'Suecia'
SET @codPais = dbo.funct_aux_nombre_codPais(@nomPais)
INSERT INTO Paises(codPais, nomPais)
VALUES(@codPais, @nomPais);

DECLARE @codPais CHARACTER(1)
DECLARE @nomPais VARCHAR(30)
SET @nomPais = 'Italia'
SET @codPais = dbo.funct_aux_nombre_codPais(@nomPais)
INSERT INTO Paises(codPais, nomPais)
VALUES(@codPais, @nomPais);

-- *****************
-- Tabla Fabricantes
-- *****************

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('AA', 'Audi', '12 The Horseshoes, IP31', 'audi_factory1@audi.com', 120);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('AB', 'Audi', '14 The Horseshoes, IP31', 'audi_factory2@audi.com', 120);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('BA', 'Bmw', '7 Copley St, Batley WF17 8JA', 'bmw_factory1@bmw.com', 100);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('BS', 'Bmw', '8 Copley St, Batley WF17 8JA', 'bmw_factory2@bmw.com', 100);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('CA', 'Chrysler', '36 Trewsbury Rd, 5DN', 'chrysler_factory1@chrysler.com', 140);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('CB', 'Chrysler', '38 Trewsbury Rd, 5DN', 'chrysler_factory2@chrysler.com', 140);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('DA', 'Mercedes Benz', '44 Jean Armour Dr, 2SD', 'mercedesbenz_factory1@mercedesbenz.com', 570);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('DB', 'Mercedes Benz', '46 Jean Armour Dr, 2SD', 'mercedesbenz_factory2@mercedesbenz.com', 570);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('EA', 'Dodge', '4 Lon Ger-Y-Coed, Ammanford 18', 'dodge_factory1@dodge.com', 80);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('ES', 'Dodge', '3 Lon Ger-Y-Coed, Ammanford 18', 'dodge_factory2@dodge.com', 80);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('FA', 'Ford', '2 Boston End, Thetford IP24', 'ford_factory1@ford.com', 160);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('GA', 'GM', '1-4 Smithy Row, NG1', 'gm_factory1@gm.com', 450);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('HA', 'Honda', '26A Station St, 5HJ', 'honda_factory1@honda.com', 320);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('JS', 'Jaguar', '15 Sutton Ave, 3JY', 'jaguar_factory1@jaguar.com', 620);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('LA', 'Lincon', '9-15 Queen St, Cardiff CF10', 'lincon_factory1@lincon.com', 220);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('MA', 'Mercury', '375 Lonsdale Rd, 9PY', 'mercury_factory1@mercury.com', 460);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('NA', 'Nissan', 'Saltcoats, 1YZ', 'nissan_factory1@nissan.com', 340);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('PA', 'Plymounth', '21 Station Rd Blvd, 5SN', 'plymounth_factory1@plymounth.com', 380);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('RA', 'Renault', '16 Station Rd Blvd, 60N', 'renault_factory1@renault.com', 280);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('SA', 'Saab', 'A9, Bridge of Allan, FK9', 'saab_factory1@saab.com', 180);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('TA', 'Toyota', '12 Tayside Dr, Edgward 8RD', 'toyota_factory1@toyota.com', 240);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('VA', 'Volkswagen', '21 Lon Tyr Haul, 9SF', 'volkswagen_factory1@volkswagen.com', 570);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('2A', 'Pontiac', '9 Kingsgate St, 9PD', 'pontiac_factory1@pontiac.com', 250);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('3A', 'Oldsmobile', '38 Queens Rd, 2ET', 'oldsmobile_factory1@oldsmobile.com', 440);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('4A', 'Buick', '13 Beckett Cl, London SW16 1AN', 'buick_factory1@buick.com', 80);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('6A', 'Cadillac', '145 Sandringham Rd, Cleeth 9BP', 'cadillac_factory1@cadillac.com', 60);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('7A', 'GM Canada', '40 Springfield Rd, 3DU', 'gmcanada_factory1@gm.com', 250);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('8A', 'Saturn', '42 Church St, 7AS', 'saturn_factory1@saturn.com', 190);


-- *****************
-- Tabla Plantas
-- *****************

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'AA', 'Northland Auto Supply', '2335 Canton Hwy #6 Windsor', 'northlandas@nas.com', '1');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'AA', 'Southland Auto Supply', '7564 N Academy Ave', 'southlandas@sas.com', '2');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('3', 'AA', 'Centerland Auto Supply', '88 E Saint Elmo Rd', 'centerlandas@cas.com', '3');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('4', 'AB', 'Centerland Motor Supply', 'Saint Elmo Rd', 'centerlandmotor@cms.com', '4');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'BA', 'Perfection Automotive Inc', '6 Arch St #9757 Alcida', 'pai@pai.com', '1');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'BA', 'Luxury Automotive Inc', '75 Westchester Ave', 'luxury@luxury.com', '2');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('3', 'BS', 'Luxury Automotive Inc', '80 Westchester Ave', 'luxuryb@luxury.com', 'Z');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'BS', 'Tailor Made Products Inc', '47 Garfield Ave Swift', 'tailor@tailor.com', 'W');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'BS', 'Heador Made Products Inc', '202 Madison Ave', 'heador@heador.com', 'Y');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'CA', 'Kalaber Creations', '447 Commercial St Se Lile', 'kalaber@kalaber.com', 'S');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'CA', 'Kalaber Designs', '765 Rock Island Rd', 'kalaber@designs.com', 'W');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('3', 'CA', 'Kalaber Designs B', '8 Rock Island Rd', 'kalaber2@designs.com', 'J');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'DA', 'Benz Designs', '9 So Ilhung Island Rd', 'benz@designs.com', 'J');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'FA', 'Valley Propane Inc', '3 Mill Rd Baker Brook', 'valleyprop@valleyprop.com', 'K');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'FA', 'Valley Buthane Inc', '56 Corporate Dr Becancour', 'valleybuth@valleybuth.com', '3');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'GA', 'Ep Systems', '37 Us Highway 12e', 'epsystems@epsystems.com', 'W');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'GA', 'Eq Systems', '1 Vernon Blvd', 'eqsystems@eqsystems.com', '2');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'HA', 'Campbell Auto', '2859 Dorsett Rd', 'campbell@campbell.com', 'Y');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'HA', 'Campbell Motors Inc', '4936 Walcott Rd', 'campbell@motorsinc.com', '1');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('3', 'HA', 'Campbell Motors Co', '6760 E Fayette St', 'campbell@motorsco.com', '2');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('4', 'HA', 'Campbell Auto Co', '5 Secaucus Rd', 'campbell@autoco.com', '3');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('5', 'HA', 'Campbell Motors', '38 Douglas Rd', 'campbell@motors.com', '4');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'RA', 'French Motors', '48 Saint Bois Rd', 'french@fmotors.com', '1');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', '4A', 'Druid Auto', '9547 Belmont Rd #21', 'druid@auto.com', '4');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', '4A', 'Arduid Auto', '1 Norris Ave #4095', 'arduid@arduid.com', '5');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('3', '4A', 'Ar Auto', '3 Norris Ave #4095', 'arduid2@arduid.com', 'Z');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', '6A', 'Automotive Consultants', '73 Pittsford Victor Rd', 'autoconsu@autoconsu.com', '4');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', '6A', 'Butomot Consultants', '5174 Interstate 45 N', 'butomotconsu@butomotconsu.com', 'J');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', '7A', 'General White', '136 W Grand Ave #3', 'generalwhite@generalwhite.com', '1');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', '7A', 'General Black', '7 Tomahawk Dr Richmond', 'generalblack@generalblack.com', 'W');


-- *****************
-- Tabla Vehiculos
-- *****************

-- Nota: para insertar estos datos es imprescindible haber ejecutado antes: 
-- b_script de funciones y triggers
-- script-auxiliar de funciones auxiliares

DECLARE @vin CHARACTER(17)
DECLARE @codPais CHARACTER(1)
DECLARE @codFab CHARACTER(2)
SET @codPais = dbo.funct_aux_nombre_codPais('Estados Unidos')
SET @codFab = 'AA'
SET @vin = dbo.funct_aux_VIN_generator(@codPais,@codFab,'Aluminio','2.0',2015)
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES (@vin, 'A4', 'gris', 1500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', @codPais, @codFab)

DECLARE @vin CHARACTER(17)
DECLARE @codPais CHARACTER(1)
DECLARE @codFab CHARACTER(2)
SET @codPais = dbo.funct_aux_nombre_codPais('Estados Unidos')
SET @codFab = 'AA'
SET @vin = dbo.funct_aux_VIN_generator(@codPais,@codFab,'Aluminio','2.0',2015)
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES (@vin, 'A4', 'gris', 1500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', @codPais, @codFab)

DECLARE @vin CHARACTER(17)
DECLARE @codPais CHARACTER(1)
DECLARE @codFab CHARACTER(2)
SET @codPais = dbo.funct_aux_nombre_codPais('Estados Unidos')
SET @codFab = 'AA'
SET @vin = dbo.funct_aux_VIN_generator(@codPais,@codFab,'Aluminio','2.0',2016)
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES (@vin, 'A4', 'gris', 1500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', @codPais, @codFab)

DECLARE @vin CHARACTER(17)
DECLARE @codPais CHARACTER(1)
DECLARE @codFab CHARACTER(2)
SET @codPais = dbo.funct_aux_nombre_codPais('Estados Unidos')
SET @codFab = 'AA'
SET @vin = dbo.funct_aux_VIN_generator(@codPais,@codFab,'Hierro','2.0',2015)
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES (@vin, 'A4', 'gris', 1500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', @codPais, @codFab)

DECLARE @vin CHARACTER(17)
DECLARE @codPais CHARACTER(1)
DECLARE @codFab CHARACTER(2)
SET @codPais = dbo.funct_aux_nombre_codPais('Estados Unidos')
SET @codFab = 'AA'
SET @vin = dbo.funct_aux_VIN_generator(@codPais,@codFab,'Hierro','2.0',2016)
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES (@vin, 'A4', 'gris', 1500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', @codPais, @codFab)

DECLARE @vin CHARACTER(17)
DECLARE @codPais CHARACTER(1)
DECLARE @codFab CHARACTER(2)
SET @codPais = dbo.funct_aux_nombre_codPais('Canadá')
SET @codFab = 'AA'
SET @vin = dbo.funct_aux_VIN_generator(@codPais,@codFab,'Hierro','2.0',2015)
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES (@vin, 'A4', 'gris', 1500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', @codPais, @codFab)

DECLARE @vin CHARACTER(17)
DECLARE @codPais CHARACTER(1)
DECLARE @codFab CHARACTER(2)
SET @codPais = dbo.funct_aux_nombre_codPais('Canadá')
SET @codFab = 'AA'
SET @vin = dbo.funct_aux_VIN_generator(@codPais,@codFab,'Hierro','2.0',2016)
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES (@vin, 'A4', 'gris', 1500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', @codPais, @codFab)

DECLARE @vin CHARACTER(17)
DECLARE @codPais CHARACTER(1)
DECLARE @codFab CHARACTER(2)
SET @codPais = dbo.funct_aux_nombre_codPais('Estados Unidos')
SET @codFab = 'BA'
SET @vin = dbo.funct_aux_VIN_generator(@codPais,@codFab,'Hierro','1.5',2016)
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES (@vin, 'Z3', 'negro', 1200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', @codPais, @codFab)

DECLARE @vin CHARACTER(17)
DECLARE @codPais CHARACTER(1)
DECLARE @codFab CHARACTER(2)
SET @codPais = dbo.funct_aux_nombre_codPais('Estados Unidos')
SET @codFab = 'BA'
SET @vin = dbo.funct_aux_VIN_generator(@codPais,@codFab,'Hierro','1.5',2015)
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES (@vin, 'Z3', 'negro', 1200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', @codPais, @codFab)

DECLARE @vin CHARACTER(17)
DECLARE @codPais CHARACTER(1)
DECLARE @codFab CHARACTER(2)
SET @codPais = dbo.funct_aux_nombre_codPais('Estados Unidos')
SET @codFab = 'BA'
SET @vin = dbo.funct_aux_VIN_generator(@codPais,@codFab,'Hierro','1.5',2017)
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES (@vin, 'Z3', 'negro', 1200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', @codPais, @codFab)

DECLARE @vin CHARACTER(17)
DECLARE @codPais CHARACTER(1)
DECLARE @codFab CHARACTER(2)
SET @codPais = dbo.funct_aux_nombre_codPais('Italia')
SET @codFab = 'BS'
SET @vin = dbo.funct_aux_VIN_generator(@codPais,@codFab,'Hierro','1.5',2017)
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES (@vin, 'Z3', 'negro', 1200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', @codPais, @codFab)

DECLARE @vin CHARACTER(17)
DECLARE @codPais CHARACTER(1)
DECLARE @codFab CHARACTER(2)
SET @codPais = dbo.funct_aux_nombre_codPais('Italia')
SET @codFab = 'BS'
SET @vin = dbo.funct_aux_VIN_generator(@codPais,@codFab,'Hierro','1.5',2016)
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES (@vin, 'Z3', 'negro', 1200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', @codPais, @codFab)

DECLARE @vin CHARACTER(17)
DECLARE @codPais CHARACTER(1)
DECLARE @codFab CHARACTER(2)
SET @codPais = dbo.funct_aux_nombre_codPais('Italia')
SET @codFab = 'BS'
SET @vin = dbo.funct_aux_VIN_generator(@codPais,@codFab,'Hierro','1.5',2015)
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES (@vin, 'Z3', 'negro', 1200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', @codPais, @codFab)

DECLARE @vin CHARACTER(17)
DECLARE @codPais CHARACTER(1)
DECLARE @codFab CHARACTER(2)
SET @codPais = dbo.funct_aux_nombre_codPais('Japón')
SET @codFab = 'CA'
SET @vin = dbo.funct_aux_VIN_generator(@codPais,@codFab,'Hierro','1.5',2015)
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES (@vin, 'Venture', 'caqui', 1200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', @codPais, @codFab)

DECLARE @vin CHARACTER(17)
DECLARE @codPais CHARACTER(1)
DECLARE @codFab CHARACTER(2)
SET @codPais = dbo.funct_aux_nombre_codPais('Japón')
SET @codFab = 'CA'
SET @vin = dbo.funct_aux_VIN_generator(@codPais,@codFab,'Hierro','1.5',2016)
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES (@vin, 'Venture', 'caqui', 1200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', @codPais, @codFab)

DECLARE @vin CHARACTER(17)
DECLARE @codPais CHARACTER(1)
DECLARE @codFab CHARACTER(2)
SET @codPais = dbo.funct_aux_nombre_codPais('Japón')
SET @codFab = 'CA'
SET @vin = dbo.funct_aux_VIN_generator(@codPais,@codFab,'Hierro','2.0',2016)
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES (@vin, 'Venture', 'caqui', 1200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', @codPais, @codFab)

DECLARE @vin CHARACTER(17)
DECLARE @codPais CHARACTER(1)
DECLARE @codFab CHARACTER(2)
SET @codPais = dbo.funct_aux_nombre_codPais('Alemania')
SET @codFab = 'CA'
SET @vin = dbo.funct_aux_VIN_generator(@codPais,@codFab,'Hierro','2.0',2016)
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES (@vin, 'Venture', 'caqui', 1200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', @codPais, @codFab)

DECLARE @vin CHARACTER(17)
DECLARE @codPais CHARACTER(1)
DECLARE @codFab CHARACTER(2)
SET @codPais = dbo.funct_aux_nombre_codPais('Japón')
SET @codFab = 'DA'
SET @vin = dbo.funct_aux_VIN_generator(@codPais,@codFab,'Hierro','2.0',2015)
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES (@vin, 'Spider', 'Blanco', 1400, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', @codPais, @codFab)

DECLARE @vin CHARACTER(17)
DECLARE @codPais CHARACTER(1)
DECLARE @codFab CHARACTER(2)
SET @codPais = dbo.funct_aux_nombre_codPais('Japón')
SET @codFab = 'DA'
SET @vin = dbo.funct_aux_VIN_generator(@codPais,@codFab,'Hierro','2.0',2016)
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES (@vin, 'Spider', 'Blanco', 1400, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', @codPais, @codFab)

DECLARE @vin CHARACTER(17)
DECLARE @codPais CHARACTER(1)
DECLARE @codFab CHARACTER(2)
SET @codPais = dbo.funct_aux_nombre_codPais('Japón')
SET @codFab = 'DA'
SET @vin = dbo.funct_aux_VIN_generator(@codPais,@codFab,'Aluminio','2.0',2017)
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES (@vin, 'Spider', 'Blanco', 1400, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', @codPais, @codFab)

-- *****************
-- Tabla Envios
-- *****************

DECLARE @origen CHARACTER(1)
DECLARE @destino CHARACTER(1)
SET @origen = dbo.funct_aux_nombre_codPais('Japón')
SET @destino = dbo.funct_aux_nombre_codPais('Alemania')
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160315', 3000, @origen, @destino)

DECLARE @origen CHARACTER(1)
DECLARE @destino CHARACTER(1)
SET @origen = dbo.funct_aux_nombre_codPais('Japón')
SET @destino = dbo.funct_aux_nombre_codPais('Argentina')
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20150615', 4000, @origen, @destino)

DECLARE @origen CHARACTER(1)
DECLARE @destino CHARACTER(1)
SET @origen = dbo.funct_aux_nombre_codPais('Japón')
SET @destino = dbo.funct_aux_nombre_codPais('Estados Unidos')
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160815', 3000, @origen, @destino)

DECLARE @origen CHARACTER(1)
DECLARE @destino CHARACTER(1)
SET @origen = dbo.funct_aux_nombre_codPais('Alemania')
SET @destino = dbo.funct_aux_nombre_codPais('Estados Unidos')
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160815', 3000, @origen, @destino)

DECLARE @origen CHARACTER(1)
DECLARE @destino CHARACTER(1)
SET @origen = dbo.funct_aux_nombre_codPais('Italia')
SET @destino = dbo.funct_aux_nombre_codPais('Canadá')
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20150415', 2000, @origen, @destino)

DECLARE @origen CHARACTER(1)
DECLARE @destino CHARACTER(1)
SET @origen = dbo.funct_aux_nombre_codPais('Italia')
SET @destino = dbo.funct_aux_nombre_codPais('Pakistán')
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160415', 2000, @origen, @destino)

DECLARE @origen CHARACTER(1)
DECLARE @destino CHARACTER(1)
SET @origen = dbo.funct_aux_nombre_codPais('Italia')
SET @destino = dbo.funct_aux_nombre_codPais('Panamá')
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170115', 2500, @origen, @destino)


/*
*********************************************************************************************
* Test restricciones de integridad: ERROR
*********************************************************************************************
*/
-- *****************
-- Tabla Paises
-- *****************
PRINT('Test PRIMARY KEY: se espera ERROR por repetir codPais')

INSERT INTO Paises(codPais, nomPais)
VALUES('1', 'Uruguay');

PRINT('Test PRIMARY KEY: se espera ERROR porque codPais no puede ser nulo')

INSERT INTO Paises(nomPais)
VALUES('Uruguay');

PRINT('Test UNIQUE nomPais: se espera ERROR porque se repite nomPais')
  
INSERT INTO Paises(codPais, nomPais)
VALUES('H', 'Alemania');

PRINT('Test UNIQUE nomPais: se espera ERROR porque se repite nomPais')

INSERT INTO Paises(codPais, nomPais)
VALUES('H', 'Suecia');

-- *****************
-- Tabla Fabricantes
-- *****************
PRINT('Test PRIMARY KEY: se espera ERROR por repetir codFab')

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('VA', 'Renault', '7 John Knox Ln, 9QW', 'renault_factory1@renault.com', 570);

PRINT('Test PRIMARY KEY: se espera ERROR porque codFab no puede ser nulo')

INSERT INTO Fabricantes(nomFab, dirFab, mailFab, cantEmp)
VALUES('Renault', '7 John Knox Ln, 9QW', 'renault_factory1@renault.com', 570);

PRINT('Test UNIQUE mailFab: se espera ERROR porque se repite mailFab')
 
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('XA', 'Renault', '7 John Knox Ln, 9QW', 'volkswagen_factory1@volkswagen.com', 570);

PRINT('Test CHECK cantEmp > 0: se espera ERROR porque cantEmp tiene que ser mayor a cero')
 
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('XA', 'Renault', '7 John Knox Ln, 9QW', 'renault_factory1@renault.com', 0);

-- *****************
-- Tabla Plantas
-- *****************
PRINT('Test PRIMARY KEY: se espera ERROR por repetir codFab')

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('5', 'HA', 'Campbell Motors', '38 Douglas Rd', 'campbell@motors.com', '4');

PRINT('Test PRIMARY KEY: se espera ERROR porque codFab no puede ser nulo')

INSERT INTO Plantas(codPlan, nomPlan, dirPlan, mailPlan, codPais)
VALUES('5', 'Campbell Motors', '38 Douglas Rd', 'campbell@motors.com', '4');

PRINT('Test FOREIGN KEY: se espera ERROR porque no existe el codFab')

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('6', 'HC', 'Campbell Motors', '38 Douglas Rd', 'camp@motors.com', '4');

PRINT('Test FOREIGN KEY: se espera ERROR porque no existe el codPais')
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('6', 'HA', 'Campbell Motors', '38 Douglas Rd', 'camp@motors.com', 'X');

PRINT('Test UNIQUE mailPlan: se espera ERROR porque se repite mailPlan')

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('6', 'HA', 'Campbell Motors', '38 Douglas Rd', 'campbell@motors.com', '4');

-- *****************
-- Tabla Vehiculos
-- *****************








