/*
*********************************************************************************************
* Script con las restricciones de integridad creadas sobre el script de creación de tablas, *
* índices, y el ingreso de datos de prueba.                                                 *
*********************************************************************************************
*/
USE BD_VEHICULOS;
go
/*
*********************************************************************************************
* Creación de las Restricciones de Integridad
*********************************************************************************************
*/
-- Tabla Paises
ALTER TABLE Paises
ADD CONSTRAINT const_Paises_pk_codPais PRIMARY KEY(codPais);
go
ALTER TABLE Paises
ADD CONSTRAINT const_Paises_uniq_nomPais UNIQUE(nomPais);
go
-- Tabla Fabricantes
ALTER TABLE Fabricantes
ADD CONSTRAINT const_Fabricantes_pk_codFab PRIMARY KEY(codFab);
go
ALTER TABLE Fabricantes
ADD CONSTRAINT const_Fabricantes_uniq_mailFab UNIQUE(mailFab);
go
ALTER TABLE Fabricantes
ADD cantEmp INT NOT NULL;
go
ALTER TABLE Fabricantes
ADD CONSTRAINT const_Fabricantes_chk_cantEmp CHECK (cantEmp > 0);
go
-- Tabla Plantas
ALTER TABLE Plantas
ADD CONSTRAINT const_Plantas_pk_codPlan_codFab PRIMARY KEY(codPlan, codFab);
go
ALTER TABLE Plantas
ADD CONSTRAINT const_Plantas_fk_codFab FOREIGN KEY(codFab) REFERENCES Fabricantes(codFab);
go
ALTER TABLE Plantas
ADD CONSTRAINT const_Plantas_fk_codPais FOREIGN KEY(codPais) REFERENCES Paises(codPais);
go
ALTER TABLE Plantas
ADD CONSTRAINT const_Plantas_uniq_mailPlan UNIQUE(mailPlan);
go
-- Tabla Vehiculos
ALTER TABLE Vehiculos
ADD CONSTRAINT const_Vehiculos_pk_vin PRIMARY KEY(vin);
go
ALTER TABLE Vehiculos
ADD CONSTRAINT const_Vehiculos_fk_codPais FOREIGN KEY(codPais) REFERENCES Paises(codPais);
go
ALTER TABLE Vehiculos
ADD CONSTRAINT const_Vehiculos_fk_codFab FOREIGN KEY(codFab) REFERENCES Fabricantes(codFab);
go
-- Tabla Envios
ALTER TABLE Envios
ADD CONSTRAINT const_Envios_pk_idEnvio PRIMARY KEY(idEnvio);
go
ALTER TABLE Envios
ADD CONSTRAINT const_Envios_fk_oriEnvio FOREIGN KEY(oriEnvio) REFERENCES Paises(codPais);
go
ALTER TABLE Envios
ADD CONSTRAINT const_Envios_fk_desEnvio FOREIGN KEY(desEnvio) REFERENCES Paises(codPais);
go
-- Tabla Carga
ALTER TABLE Carga
ADD CONSTRAINT const_Carga_pk_idEnvio_idCarga PRIMARY KEY(idEnvio, idCarga);
go
ALTER TABLE Carga
ADD CONSTRAINT const_Carga_fk_idEnvio FOREIGN KEY(idEnvio) REFERENCES Envios(idEnvio);
go
ALTER TABLE Carga
ADD CONSTRAINT const_Carga_fk_vin FOREIGN KEY(vin) REFERENCES Vehiculos(vin);
go
/*
*********************************************************************************************
* Creación de Índices
*********************************************************************************************
*/
-- Tabla Plantas
CREATE INDEX idx_Plantas_codFab
ON Plantas(codFab); 
go
CREATE INDEX idx_Plantas_codPais
ON Plantas(codPais); 
go
-- Tabla Vehiculos
CREATE INDEX idx_Vehiculos_codPais
ON Vehiculos(codPais); 
go
CREATE INDEX idx_Vehiculos_codFab
ON Vehiculos(codFab); 
go
-- Tabla Envios
CREATE INDEX idx_Envios_oriEnvio
ON Envios(oriEnvio); 
go
CREATE INDEX idx_Envios_desEnvio
ON Envios(desEnvio); 
go
-- Tabla Carga
CREATE INDEX idx_Carga_vin
ON Carga(vin); 
go
/*
*********************************************************************************************
* Ingreso de datos de prueba
*********************************************************************************************
*/
-- *** Tabla Paises ***
-- Insertar datos: output OK
INSERT INTO Paises(codPais, nomPais)
VALUES('1', 'Estados Unidos');
go
INSERT INTO Paises(codPais, nomPais)
VALUES('2', 'Canadá');
go
INSERT INTO Paises(codPais, nomPais)
VALUES('3', 'México');
go
INSERT INTO Paises(codPais, nomPais)
VALUES('4', 'Argentina');
go
INSERT INTO Paises(codPais, nomPais)
VALUES('5', 'Chile');
go
INSERT INTO Paises(codPais, nomPais)
VALUES('6', 'Panamá');
go
INSERT INTO Paises(codPais, nomPais)
VALUES('7', 'Pakistán');
go
INSERT INTO Paises(codPais, nomPais)
VALUES('8', 'España');
go
INSERT INTO Paises(codPais, nomPais)
VALUES('9', 'Brasil');
go
INSERT INTO Paises(codPais, nomPais)
VALUES('J', 'Japón');
go
INSERT INTO Paises(codPais, nomPais)
VALUES('K', 'Korea');
go
INSERT INTO Paises(codPais, nomPais)
VALUES('S', 'Inglaterra');
go
INSERT INTO Paises(codPais, nomPais)
VALUES('W', 'Alemania');
go
INSERT INTO Paises(codPais, nomPais)
VALUES('Y', 'Suecia');
go
INSERT INTO Paises(codPais, nomPais)
VALUES('Z', 'Italia');
go
-- Test primary key: output ERROR
PRINT('Test PRIMARY KEY: se espera ERROR')
go
INSERT INTO Paises(codPais, nomPais)
VALUES('1', 'Uruguay');
go
PRINT('Test PRIMARY KEY: se espera ERROR')
go
INSERT INTO Paises(nomPais)
VALUES('Uruguay');
go
-- Test unicidad nomPais: output ERROR
PRINT('Test UNIQUE: se espera ERROR')
go  
INSERT INTO Paises(codPais, nomPais)
VALUES('H', 'Alemania');
go
PRINT('Test UNIQUE: se espera ERROR')
go
INSERT INTO Paises(codPais, nomPais)
VALUES('H', 'Suecia');
go
-- *** Tabla Fabricantes ***
-- Insertar datos: output OK
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('AA', 'Audi', '12 The Horseshoes, Norton, Bury Saint Edmunds IP31 3NR', 'audi_factory1@audi.com', 120);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('BA', 'Bmw', '7 Copley St, Batley WF17 8JA', 'bmw_factory1@bmw.com', 100);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('4A', 'Buick', '13 Beckett Cl, London SW16 1AN', 'buick_factory1@buick.com', 80);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('6A', 'Cadillac', '145 Sandringham Rd, Cleeth 9BP', 'cadillac_factory1@cadillac.com', 60);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('CA', 'Chrysler', '36 Trewsbury Rd, 5DN', 'chrysler_factory1@chrysler.com', 140);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('BS', 'Dodge', '3 Lon Ger-Y-Coed, Ammanford 18', 'dodge_factory1@dodge.com', 80);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('FA', 'Ford', '2 Boston End, Thetford IP24', 'ford_factory1@ford.com', 160);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('7A', 'GM Canada', '40 Springfield Rd, 3DU', 'gmcanada_factory1@gm.com', 250);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('GA', 'GM', '1-4 Smithy Row, NG1', 'gm_factory1@gm.com', 450);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('HA', 'Honda', '26A Station St, 5HJ', 'honda_factory1@honda.com', 320);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('AS', 'Jaguar', '15 Sutton Ave, 3JY', 'jaguar_factory1@jaguar.com', 620);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('LA', 'Lincon', '9-15 Queen St, Cardiff CF10', 'lincon_factory1@lincon.com', 220);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('DA', 'Mercedes Benz', '44 Jean Armour Dr, 2SD', 'mercedesbenz_factory1@mercedesbenz.com', 570);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('MA', 'Mercury', '375 Lonsdale Rd, 9PY', 'mercury_factory1@mercury.com', 460);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('NA', 'Nissan', 'Saltcoats, 1YZ', 'nissan_factory1@nissan.com', 340);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('3A', 'Oldsmobile', '38 Queens Rd, 2ET', 'oldsmobile_factory1@oldsmobile.com', 440);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('2A', 'Pontiac', '9 Kingsgate St, 9PD', 'pontiac_factory1@pontiac.com', 250);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('PA', 'Plymounth', '21 Station Rd Blvd, 5SN', 'plymounth_factory1@plymounth.com', 380);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('SA', 'Saab', 'A9, Bridge of Allan, FK9', 'saab_factory1@saab.com', 180);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('8A', 'Saturn', '42 Church St, 7AS', 'saturn_factory1@saturn.com', 190);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('TA', 'Toyota', '12 Tayside Dr, Edgward 8RD', 'toyota_factory1@toyota.com', 240);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('VA', 'Volkswagen', '21 Lon Tyr Haul, 9SF', 'volkswagen_factory1@volkswagen.com', 570);
go
-- Test primary key: output ERROR
PRINT('Test PRIMARY KEY: se espera ERROR')
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('VA', 'Renault', '7 John Knox Ln, 9QW', 'renault_factory1@renault.com', 570);
go
PRINT('Test PRIMARY KEY: se espera ERROR')
go
INSERT INTO Fabricantes(nomFab, dirFab, mailFab, cantEmp)
VALUES('Renault', '7 John Knox Ln, 9QW', 'renault_factory1@renault.com', 570);
go
-- Test unicidad mailFab: output ERROR
PRINT('Test UNIQUE: se espera ERROR')
go 
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('XA', 'Renault', '7 John Knox Ln, 9QW', 'volkswagen_factory1@volkswagen.com', 570);
go
PRINT('Test UNIQUE: se espera ERROR')
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('XA', 'Renault', '7 John Knox Ln, 9QW', 'toyota_factory1@toyota.com', 570);
go
-- *** Tabla Plantas ***
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'AA', 'Northland Auto Supply', '2335 Canton Hwy #6 Windsor', 'northlandas@nas.com', '1');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'AA', 'Southland Auto Supply', '7564 N Academy Ave', 'southlandas@sas.com', '2');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('3', 'AA', 'Centerland Auto Supply', '88 E Saint Elmo Rd', 'centerlandas@cas.com', '3');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'BA', 'Perfection Automotive Inc', '6 Arch St #9757 Alcida', 'pai@pai.com', '1');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'BA', 'Luxury Automotive Inc', '75 Westchester Ave', 'luxury@luxury.com', '2');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', '4A', 'Druid Auto', '9547 Belmont Rd #21', 'druid@auto.com', '4');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', '4A', 'Arduid Auto', '1 Norris Ave #4095', 'arduid@arduid.com', '5');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', '6A', 'Automotive Consultants', '73 Pittsford Victor Rd', 'autoconsu@autoconsu.com', '4');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', '6A', 'Butomot Consultants', '5174 Interstate 45 N', 'butomotconsu@butomotconsu.com', 'J');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'CA', 'Kalaber Creations', '447 Commercial St Se Lile', 'kalaber@kalaber.com', 'S');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'CA', 'Kalaber Designs', '765 Rock Island Rd', 'kalaber@designs.com', 'W');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'BS', 'Tailor Made Products Inc', '47 Garfield Ave Swift', 'tailor@tailor.com', 'W');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'BS', 'Heador Made Products Inc', '202 Madison Ave', 'heador@heador.com', 'Y');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'FA', 'Valley Propane Inc', '3 Mill Rd Baker Brook', 'valleyprop@valleyprop.com', 'K');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'FA', 'Valley Buthane Inc', '56 Corporate Dr Becancour', 'valleybuth@valleybuth.com', '3');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', '7A', 'General White', '136 W Grand Ave #3', 'generalwhite@generalwhite.com', '1');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', '7A', 'General Black', '7 Tomahawk Dr Richmond', 'generalblack@generalblack.com', 'W');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'GA', 'Ep Systems', '37 Us Highway 12e', 'epsystems@epsystems.com', 'W');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'GA', 'Eq Systems', '1 Vernon Blvd', 'eqsystems@eqsystems.com', '2');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'HA', 'Campbell Auto', '2859 Dorsett Rd', 'campbell@campbell.com', 'Y');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'HA', 'Campbell Motors Inc', '4936 Walcott Rd', 'campbell@motorsinc.com', '1');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('3', 'HA', 'Campbell Motors Co', '6760 E Fayette St', 'campbell@motorsco.com', '2');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('4', 'HA', 'Campbell Auto Co', '5 Secaucus Rd', 'campbell@autoco.com', '3');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('5', 'HA', 'Campbell Motors', '38 Douglas Rd', 'campbell@motors.com', '4');












