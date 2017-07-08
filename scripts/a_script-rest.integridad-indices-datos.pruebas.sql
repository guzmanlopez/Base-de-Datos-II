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
go
ALTER TABLE Paises
ADD CONSTRAINT const_Paises_uniq_nomPais 
UNIQUE(nomPais);
go
-- Tabla Fabricantes
ALTER TABLE Fabricantes
ADD CONSTRAINT const_Fabricantes_pk_codFab 
PRIMARY KEY(codFab);
go
ALTER TABLE Fabricantes
ADD CONSTRAINT const_Fabricantes_uniq_mailFab 
UNIQUE(mailFab);
go
ALTER TABLE Fabricantes
ADD cantEmp INT NOT NULL;
go
ALTER TABLE Fabricantes
ADD CONSTRAINT const_Fabricantes_chk_cantEmp 
CHECK (cantEmp > 0);
go
-- Tabla Plantas
ALTER TABLE Plantas
ADD CONSTRAINT const_Plantas_pk_codPlan_codFab 
PRIMARY KEY(codPlan, codFab);
go
ALTER TABLE Plantas
ADD CONSTRAINT const_Plantas_fk_codFab 
FOREIGN KEY(codFab) REFERENCES Fabricantes(codFab);
go
ALTER TABLE Plantas
ADD CONSTRAINT const_Plantas_fk_codPais 
FOREIGN KEY(codPais) REFERENCES Paises(codPais);
go
ALTER TABLE Plantas
ADD CONSTRAINT const_Plantas_uniq_mailPlan 
UNIQUE(mailPlan);
go
-- Tabla Vehiculos
ALTER TABLE Vehiculos
ADD CONSTRAINT const_Vehiculos_pk_vin 
PRIMARY KEY(vin);
go
ALTER TABLE Vehiculos
ADD CONSTRAINT const_Vehiculos_fk_codPais 
FOREIGN KEY(codPais) REFERENCES Paises(codPais);
go
ALTER TABLE Vehiculos
ADD CONSTRAINT const_Vehiculos_fk_codFab
FOREIGN KEY(codFab) REFERENCES Fabricantes(codFab);
go
-- Tabla Envios
ALTER TABLE Envios
ADD CONSTRAINT const_Envios_pk_idEnvio 
PRIMARY KEY(idEnvio);
go
ALTER TABLE Envios
ADD CONSTRAINT const_Envios_fk_oriEnvio 
FOREIGN KEY(oriEnvio) REFERENCES Paises(codPais);
go
ALTER TABLE Envios
ADD CONSTRAINT const_Envios_fk_desEnvio 
FOREIGN KEY(desEnvio) REFERENCES Paises(codPais);
go
-- Tabla Carga
ALTER TABLE Carga
ADD CONSTRAINT const_Carga_pk_idEnvio_idCarga 
PRIMARY KEY(idEnvio, idCarga);
go
ALTER TABLE Carga
ADD CONSTRAINT const_Carga_fk_idEnvio 
FOREIGN KEY(idEnvio) REFERENCES Envios(idEnvio);
go
ALTER TABLE Carga
ADD CONSTRAINT const_Carga_fk_vin 
FOREIGN KEY(vin) REFERENCES Vehiculos(vin);
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
* Ingreso de datos de prueba: OK
*********************************************************************************************
*/
-- *****************
-- Tabla Paises 
-- *****************
go
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
VALUES('9', 'Brasil');
go
INSERT INTO Paises(codPais, nomPais)
VALUES('J', 'Japón');
go
INSERT INTO Paises(codPais, nomPais)
VALUES('K', 'Corea');
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
-- Otros países
INSERT INTO Paises(codPais, nomPais)
VALUES('4', 'Argentina');
go
INSERT INTO Paises(codPais, nomPais)
VALUES('5', 'Chile');
go
INSERT INTO Paises(codPais, nomPais)
VALUES('6', 'Uruguay');
go
-- *****************
-- Tabla Fabricantes
-- *****************
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('AA', 'Audi', '12 The Horseshoes, IP31', 'audi_factory1@audi.com', 120);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('AB', 'Audi', '14 The Horseshoes, IP31', 'audi_factory2@audi.com', 120);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('BA', 'Bmw', '7 Copley St, Batley WF17 8JA', 'bmw_factory1@bmw.com', 100);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('BB', 'Bmw', '8 Copley St, Batley WF17 8JA', 'bmw_factory2@bmw.com', 100);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('CA', 'Chrysler', '36 Trewsbury Rd, 5DN', 'chrysler_factory1@chrysler.com', 140);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('CB', 'Chrysler', '38 Trewsbury Rd, 5DN', 'chrysler_factory2@chrysler.com', 140);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('DA', 'Mercedes Benz', '44 Jean Armour Dr, 2SD', 'mercedesbenz_factory1@mercedesbenz.com', 570);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('DB', 'Mercedes Benz', '46 Jean Armour Dr, 2SD', 'mercedesbenz_factory2@mercedesbenz.com', 570);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('EA', 'Dodge', '4 Lon Ger-Y-Coed, Ammanford 18', 'dodge_factory1@dodge.com', 80);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('EB', 'Dodge', '3 Lon Ger-Y-Coed, Ammanford 18', 'dodge_factory2@dodge.com', 80);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('FA', 'Ford', '2 Boston End, Thetford IP24', 'ford_factory1@ford.com', 160);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('FB', 'Ford', '4 Boston End, Thetford IP24', 'ford_factory2@ford.com', 260);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('GA', 'GM', '1-4 Smithy Row, NG1', 'gm_factory1@gm.com', 450);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('GB', 'GM', '1 Smithy Row, NG1', 'gm_factory2@gm.com', 450);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('HA', 'Honda', '26A Station St, 5HJ', 'honda_factory1@honda.com', 320);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('HB', 'Honda', '25 Station St, 5HJ', 'honda_factory2@honda.com', 300);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('JA', 'Jaguar', '15 Sutton Ave, 3JY', 'jaguar_factory1@jaguar.com', 620);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('JB', 'Jaguar', '20 Sutton Ave, 3K', 'jaguar_factory2@jaguar.com', 320);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('LA', 'Lincon', '9-15 Queen St, Cardiff CF10', 'lincon_factory1@lincon.com', 220);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('LB', 'Lincon', '20 Queen St, Cardiff CF1', 'lincon_factory2@lincon.com', 220);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('MA', 'Mercury', '375 Lonsdale Rd, 9PY', 'mercury_factory1@mercury.com', 460);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('MB', 'Mercury', '300 Lonsdale Rd, 9PY', 'mercury_factory2@mercury.com', 460);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('NA', 'Nissan', 'Saltcoats, 1YZ', 'nissan_factory1@nissan.com', 340);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('NB', 'Nissan', 'Saltcoats, 20YZ', 'nissan_factory2@nissan.com', 340);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('PA', 'Plymounth', '21 Station Rd Blvd, 5SN', 'plymounth_factory1@plymounth.com', 380);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('PB', 'Plymounth', '18 Station Rd Blvd, 5SN', 'plymounth_factory2@plymounth.com', 380);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('SA', 'Saab', 'A9, Bridge of Allan, FK9', 'saab_factory1@saab.com', 180);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('SB', 'Saab', 'Bridge of Allan, FK9', 'saab_factory2@saab.com', 180);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('TA', 'Toyota', '12 Tayside Dr, Edgward 8RD', 'toyota_factory1@toyota.com', 240);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('TB', 'Toyota', '10 Tayside Dr, Edgward 8RD', 'toyota_factory2@toyota.com', 240);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('VA', 'Volkswagen', '21 Lon Tyr Haul, 9SF', 'volkswagen_factory1@volkswagen.com', 570);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('VB', 'Volkswagen', '31 Lon Tyr Haul, 9', 'volkswagen_factory2@volkswagen.com', 570);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('2A', 'Pontiac', '9 Kingsgate St, 9PD', 'pontiac_factory1@pontiac.com', 250);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('2B', 'Pontiac', '10 Kingsgate St, 9PD', 'pontiac_factory2@pontiac.com', 250);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('3A', 'Oldsmobile', '38 Queens Rd, 2ET', 'oldsmobile_factory1@oldsmobile.com', 440);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('3B', 'Oldsmobile', '40 Queens Rd, 2ET', 'oldsmobile_factory2@oldsmobile.com', 440);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('4A', 'Buick', '13 Beckett Cl, London SW16 1AN', 'buick_factory1@buick.com', 80);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('4B', 'Buick', '20 Beckett Cl, London SW16 1AN', 'buick_factory2@buick.com', 80);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('6A', 'Cadillac', '145 Sandringham Rd, Cleeth 9BP', 'cadillac_factory1@cadillac.com', 60);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('6B', 'Cadillac', '3 Sandringham Rd, Cleeth 9BP', 'cadillac_factory2@cadillac.com', 60);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('7A', 'GM Canada', '40 Springfield Rd, 3DU', 'gmcanada_factory1@gm.com', 250);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('7B', 'GM Canada', '20 Springfield Rd, 3DU', 'gmcanada_factory2@gm.com', 250);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('8A', 'Saturn', '42 Church St, 7AS', 'saturn_factory1@saturn.com', 190);
go
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('8B', 'Saturn', '32 Church St, 7AS', 'saturn_factory2@saturn.com', 190);
go
-- *****************
-- Tabla Plantas
-- *****************
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'AA', 'Audi usa', '2335 Canton Hwy #6 Windsor', 'audi@usa.com', '1');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'AA', 'Audi Inglaterra', '7564 N Academy Ave', 'audi@inglaterra.com', 'S');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('3', 'AB', 'Audi Brasil', '88 E Saint Elmo Rd', 'audi@brasil.com', '9');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'BA', 'BMW US Perfection Inc', '6 Arch St #9757 Alcida', 'bmw@usa.com', '1');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'BA', 'BMW IT Luxury Inc', '75 Westchester Ave', 'bmw@italia.com', 'Z');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('3', 'BB', 'BMW CH Luxury Inc', '80 Westchester Ave', 'bmw@chile.com', '5');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'CA', 'Chrysler Canada Creations', '447 Commercial St Se Lile', 'chrysler@canada.com', '2');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'CA', 'Chrysler Corea Designs', '765 Rock Island Rd', 'chrysler@corea.com', 'K');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('3', 'CB', 'Chrysler México Designs', '8 Rock Island Rd', 'chrysler@mexico.com', '3');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'DA', 'Benz German Designs', '9 So Ilhung Island Rd', 'benz@alemania.com', 'W');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'DA', 'Benz Sweeden Designs', '9 So Ilhung Island Rd', 'benz@suecia.com', 'Y');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('3', 'DB', 'Benz Argentina Designs', '9 So Ilhung Island Rd', 'benz@argentina.com', '4');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'EA', 'Dodge USA Designs', '40 Us Highway 12e', 'dodge@usa.com', '1');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'EB', 'Dodge Mexico Designs', '50 Us Highway 12e', 'dodge@mexico.com', '3');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'FA', 'Ford usa Valley Propane Inc', '3 Mill Rd Baker Brook', 'ford@usa.com', '1');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'FA', 'Ford German Valley Propane Inc', '6 Mill Rd Baker Brook', 'ford@alemania.com', 'W');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('3', 'FB', 'Ford MX Valley Propane Inc', '20 Mill Rd Baker Brook', 'ford@mexico.com', '3');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'GA', 'GM Usa Ep Systems', '37 Us Highway 12e', 'gm@usa.com', '1');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'GA', 'GM England Ep Systems', '40 Us Highway 12e', 'gm@inglaterra.com', 'S');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('3', 'GB', 'GM Brasil Ep Systems', '50 Us Highway 12e', 'gm@brasil.com', '9');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'HA', 'Honda Japon Campbell Auto', '2859 Dorsett Rd', 'honda@japon.com', 'J');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'HA', 'Honda Corea Campbell Auto', '2859 Dorsett Rd', 'honda@corea.com', 'K');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('3', 'HB', 'Honda Chile Campbell Auto', '2859 Dorsett Rd', 'honda@chile.com', '5');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'JA', 'Jaguar Italy Auto', '3045 Dorsett Rd', 'jaguar@italia.com', 'Z');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'JA', 'Jaguar Suecia Auto', '30 Dorsett Rd', 'jaguar@suecia.com', 'Y');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('3', 'JB', 'Jaguar Brasil Auto', '3060 Dorsett Rd', 'jaguar@brasil.com', '9');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'LA', 'Lincon England Auto', '3045 Belmont Rd', 'lincon@inglaterra.com', 'S');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'LB', 'Lincon Argentina Auto', '30 Belmont Rd', 'lincon@argentina.com', '4');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'MA', 'Mercury USA Designs', '1 Belmont Rd 3F', 'mercury@usa.com', '1');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'MB', 'Mercury Chile Designs', '99 Belmont Rd 3F', 'mercury@chile.com', '5');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'NA', 'Nissan Corea Designs', '1 Pittsford Rd 3F', 'nissan@corea.com', 'K');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'NB', 'Nissan Chile Designs', '10 Pittsford Rd 3F', 'nissan@chile.com', '5');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'PA', 'Plymounth USA Designs', '1 Pittsford Rd 3B', 'plymounth@usa.com', '1');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'PB', 'Plymounth Uruguay Designs', '13 Pittsford Rd 3B', 'plymounth@uruguay.com', '6');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'SA', 'Saab Italy Designs', '01 Pittsford Rd 3Z', 'saab@italia.com', 'Z');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'SB', 'Saab Uruguay Designs', '19 Pittsford Rd 3Z9', 'saab@uruguay.com', '6');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'TA', 'Toyota Japon Designs', 'Pittsford Rd 39', 'toyota@japon.com', 'J');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'TB', 'Toyota Corea Designs', 'Pittsford Rd 59', 'toyota@corea.com', 'K');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'VA', 'Volkswagen German Designs', 'Pittsford Rd 129', 'vw@alemania.com', 'W');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'VB', 'Volkswagen Brasil Designs', 'Pittsford Rd 300', 'vw@brasil.com', '9');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', '2A', 'Pontiac USA Designs', 'Pittsford Rd 23B', 'pontiac@usa.com', '1');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', '2B', 'Pontiac Chile Designs', 'Pittsford Rd 23C', 'pontiac@chile.com', '5');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', '3A', 'Oldsmobile Sweeden Designs', 'Belmont Rd 33B', 'oldsmobile@suecia.com', 'Y');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', '3B', 'Oldsmobile Argentina Designs', 'Belmont Rd 33C', 'oldsmobile@argentina.com', '4');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', '4A', 'Buick England Auto', '9547 Belmont Rd #21', 'buick@inglaterra.com', 'S');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', '4B', 'Buick Uruguay Auto', '9547 Belmont Rd #21', 'buick@uruguay.com', '6');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', '6A', 'Cadillac USA Consultants', '73 Pittsford Victor Rd', 'cadillac@usa.com', '1');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', '6B', 'Cadillac Brasil Consultants', '5174 Interstate 45 N', 'cadillac@brasil.com', '9');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', '7A', 'GM Canada Designs', '136 W Grand Ave #3', 'gmcanada@canada.com', '2');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', '7A', 'GM Canada Designs', '136 W Grand Ave #4', 'gmcanada2@canada.com', '2');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('3', '7B', 'GM Canada Designs', '136 W Grand Ave #5', 'gmcanada@mexico.com', '3');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', '8A', 'Saturn Canada Designs', '136 W Grand Ave #8', 'saturn@canada.com', '2');
go
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', '8B', 'Saturn Uruguay Designs', '136 W Grand Ave #20', 'saturn@uruguay.com', '6');
go
-- *****************
-- Tabla Vehiculos
-- *****************
-- Audi
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1AAFE3203FAA10190', 'A4', 'gris', 2500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'AA')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1AAFE3201GAA10190', 'A4', 'negro', 2500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'AA')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1AAAL320XHAA10190', 'A5', 'negro', 1500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'AA')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('9ABAL320XHAB10190', 'A5', 'gris', 1500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '9', 'AB')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('SAAAL3207HAA10190', 'A5', 'gris', 1500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'S', 'AA')
go
-- BMW
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1BAAL3150FBA10190', 'Z3', 'negro', 1000, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'BA')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1BAAL3159GBA10190', 'Z3', 'negro', 1000, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'BA')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('ZBAFE3201HBA10190', 'Z4', 'gris', 1800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'Z', 'BA')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('5BBFE3204HBB10190', 'Z4', 'negro', 1800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '5', 'BB')
go
-- Buick
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('S4AFE3201F4A10190', 'LaCrosse', 'negro', 2800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'S', '4A')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('S4AFE320XG4A10190', 'LaCrosse', 'negro', 2800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'S', '4A')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('S4AFE3208H4A10190', 'LaCrosse', 'gris', 2800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'S', '4A')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('64BFE3154G4B10190', 'LaCrosse', 'gris', 2800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '6', '4B')
go
-- Cadillac
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('16AFE3201F6A10190', 'XTS', 'gris', 3800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', '6A')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('16AFE320XG6A10190', 'XTS', 'gris', 3800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', '6A')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('16AFE3208H6A10190', 'XTS', 'negro', 3800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', '6A')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('96BFE3208H6B10190', 'XTS', 'negro', 3800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '9', '6B')
go
-- Chrysler
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('2CAFE3208FCA10190', 'Pacifica', 'negro', 2800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '2', 'CA')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('2CAFE3206GCA10190', 'Pacifica', 'negro', 2800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '2', 'CA')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('2CAFE3204HCA10190', 'Pacifica', 'gris', 2800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '2', 'CA')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('KCAFE3208FCA10190', 'Pacifica', 'verde', 2800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'K', 'CA')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('KCAFE3206GCA10190', 'Pacifica', 'verde', 2800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'K', 'CA')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('KCAFE3204HCA10190', 'Pacifica', 'verde', 2800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'K', 'CA')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('3CBFE3203HCB10190', 'Pacifica', 'rojo', 2800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '3', 'CB')
go
-- Dodge
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1EAFE3208FEA10190', 'Challenger', 'negro', 3000, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'EA')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1EAFE3206GEA10190', 'Challenger', 'negro', 3000, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'EA')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1EAFE3204HEA10190', 'Challenger', 'negro', 3000, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'EA')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('3EBFE3200HEB10190', 'Challenger', 'negro', 3000, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '3', 'EB')
go
-- Ford
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1FAFE320XGFA10190', 'Mustang', 'rojo', 3200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'FA')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1FAFE3208HFA10190', 'Mustang', 'rojo', 3200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'FA')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('WFAFE3204HFA10190', 'Mustang', 'negro', 3200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'W', 'FA')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('3FBFE3204HFB10190', 'Mustang', 'gris', 3200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '3', 'FB')
go
-- GM
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1GAFE3205FGA10190', 'Camaro', 'negro', 5200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'GA')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1GAFE3203GGA10190', 'Camaro', 'gris', 5200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'GA')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('SGAFE3202FGA10190', 'Camaro', 'gris', 5200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'S', 'GA')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('SGAFE3200GGA10190', 'Camaro', 'negro', 5200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'S', 'GA')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('9GBFE3203GGB10190', 'Camaro', 'negro', 5200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '9', 'GB')
go
-- GM Canada
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('27AFE3202F7A10190', 'Camaro', 'negro', 5200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '2', '7A')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('27AFE3200G7A10190', 'Camaro', 'gris', 5200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '2', '7A')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('27AFE3209H7A10190', 'Camaro', 'gris', 5200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '2', '7A')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('37BFE320XG7B10190', 'Camaro', 'negro', 5200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '3', '7B')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('37BFE3208H7B10190', 'Camaro', 'negro', 5200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '3', '7B')
go
-- Honda
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('JHAFE3207GHA10190', 'Civic', 'gris', 4000, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'J', 'HA')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('JHAFE3205HHA10190', 'Civic', 'negro', 4000, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'J', 'HA')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('KHAFE3206FHA10190', 'Civic', 'gris', 4000, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'K', 'HA')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('KHAFE3204GHA10190', 'Civic', 'negro', 4000, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'K', 'HA')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('5HBFE3208GHB10190', 'Civic', 'gris', 4000, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '5', 'HB')
go
-- Jaguar
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('YJAFE3202GJA10190', 'IPACE CONCEPT', 'gris', 3500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'Y', 'JA')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('YJAFE3200HJA10190', 'IPACE CONCEPT', 'negro', 3500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'Y', 'JA')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('ZJAFE320XGJA10190', 'IPACE CONCEPT', 'gris', 3500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'Z', 'JA')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('ZJAFE3208HJA10190', 'IPACE CONCEPT', 'negro', 3500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'Z', 'JA')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('9JBFE320XHJB10190', 'IPACE CONCEPT', 'gris', 3500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '9', 'JB')
go
-- *****************
-- Tabla Envios
-- *****************
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20150315', 3990, '1', 'Z');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170415', 3990, '1', 'Z');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160915', 3990, '1', 'Y');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170115', 1575, '1', 'Y');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160115', 2625, '1', '2');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20151015', 2625, '1', '2');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20151115', 1050, '1', '3');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160815', 1050, '1', '5');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170415', 3150, '1', '5');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160415', 3150, '1', '5');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20150415', 3150, '1', '6');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170215', 3360, '1', '6');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160615', 3360, '1', '9');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160715', 5460, '1', '9');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20150715', 5460, '1', 'Z');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160815', 5460, '2', 'Z');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20150915', 5460, '2', 'Z');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170315', 5460, '2', 'J');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170115', 2940, '2', 'Z');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160115', 2940, '2', 'Z');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20150315', 2940, '2', 'J');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170120', 5460, '3', 'J');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160111', 5460, '3', '6');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170207', 2940, '3', '6');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170224', 3150, '3', 'K');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170305', 3360, '3', 'K');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170407', 1890, '5', '6');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20161120', 4200, '5', '6');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160809', 2940, '6', '5');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170115', 3990, '9', '1');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170620', 1575, '9', '1');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20161005', 5460, '9', '2');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170314', 3675, '9', '2');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170318', 4200, 'J', 'Z');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20161204', 4200, 'J', 'Z');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170103', 2940, 'K', 'Z');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160828', 2940, 'K', 'J');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20150120', 2940, 'K', 'J');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160214', 4200, 'K', 'S');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20150226', 4200, 'K', 'S');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20151010', 2940, 'S', '9');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170102', 2940, 'S', '9');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160505', 2940, 'S', '6');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170213', 1575, 'S', '6');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20161220', 5460, 'S', '6');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20150606', 5460, 'S', '2');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170420', 3360, 'W', 'J');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170501', 3675, 'Y', 'J');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160820', 3675, 'Y', 'K');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170123', 1890, 'Z', '2');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170111', 3675, 'Z', '1');
go
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20161008', 3675, 'Z', 'K');
go
-- *****************
-- Tabla Cargas
-- *****************
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(1, 1, '16AFE3201F6A10190', 3990)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(2, 1, '16AFE3208H6A10190', 3990)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(3, 1, '16AFE320XG6A10190', 3990)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(4, 1, '1AAAL320XHAA10190', 1575)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(5, 1, '1AAFE3201GAA10190', 2625)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(6, 1, '1AAFE3203FAA10190', 2625)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(7, 1, '1BAAL3150FBA10190', 1050)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(8, 1, '1BAAL3159GBA10190', 1050)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(9, 1, '1EAFE3204HEA10190', 3150)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(10, 1, '1EAFE3206GEA10190', 3150)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(11, 1, '1EAFE3208FEA10190', 3150)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(12, 1, '1FAFE3208HFA10190', 3360)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(13, 1, '1FAFE320XGFA10190', 3360)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(14, 1, '1GAFE3203GGA10190', 5460)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(15, 1, '1GAFE3205FGA10190', 5460)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(16, 1, '27AFE3200G7A10190', 5460)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(17, 1, '27AFE3202F7A10190', 5460)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(18, 1, '27AFE3209H7A10190', 5460)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(19, 1, '2CAFE3204HCA10190', 2940)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(20, 1, '2CAFE3206GCA10190', 2940)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(21, 1, '2CAFE3208FCA10190', 2940)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(22, 1, '37BFE3208H7B10190', 5460)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(23, 1, '37BFE320XG7B10190', 5460)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(24, 1, '3CBFE3203HCB10190', 2940)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(25, 1, '3EBFE3200HEB10190', 3150)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(26, 1, '3FBFE3204HFB10190', 3360)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(27, 1, '5BBFE3204HBB10190', 1890)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(28, 1, '5HBFE3208GHB10190', 4200)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(29, 1, '64BFE3154G4B10190', 2940)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(30, 1, '96BFE3208H6B10190', 3990)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(31, 1, '9ABAL320XHAB10190', 1575)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(32, 1, '9GBFE3203GGB10190', 5460)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(33, 1, '9JBFE320XHJB10190', 3675)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(34, 1, 'JHAFE3205HHA10190', 4200)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(35, 1, 'JHAFE3207GHA10190', 4200)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(36, 1, 'KCAFE3204HCA10190', 2940)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(37, 1, 'KCAFE3206GCA10190', 2940)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(38, 1, 'KCAFE3208FCA10190', 2940)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(39, 1, 'KHAFE3204GHA10190', 4200)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(40, 1, 'KHAFE3206FHA10190', 4200)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(41, 1, 'S4AFE3201F4A10190', 2940)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(42, 1, 'S4AFE3208H4A10190', 2940)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(43, 1, 'S4AFE320XG4A10190', 2940)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(44, 1, 'SAAAL3207HAA10190', 1575)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(45, 1, 'SGAFE3200GGA10190', 5460)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(46, 1, 'SGAFE3202FGA10190', 5460)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(47, 1, 'WFAFE3204HFA10190', 3360)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(48, 1, 'YJAFE3200HJA10190', 3675)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(49, 1, 'YJAFE3202GJA10190', 3675)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(50, 1, 'ZBAFE3201HBA10190', 1890)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(51, 1, 'ZJAFE3208HJA10190', 3675)
go
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(52, 1, 'ZJAFE320XGJA10190', 3675)
go
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
go
PRINT('Test PRIMARY KEY: se espera ERROR porque codPais no puede ser nulo')
INSERT INTO Paises(nomPais)
VALUES('Uruguay');
go
PRINT('Test UNIQUE nomPais: se espera ERROR porque se repite nomPais')
INSERT INTO Paises(codPais, nomPais)
VALUES('H', 'Alemania');
go
PRINT('Test UNIQUE nomPais: se espera ERROR porque se repite nomPais')
INSERT INTO Paises(codPais, nomPais)
VALUES('H', 'Suecia');
go
-- *****************
-- Tabla Fabricantes
-- *****************
PRINT('Test PRIMARY KEY: se espera ERROR por repetir codFab')
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('AA', 'Audi', '7 John Knox Ln, 9QW', 'audi_factory1@audi.com', 570);
go
PRINT('Test PRIMARY KEY: se espera ERROR porque codFab no puede ser nulo')
INSERT INTO Fabricantes(nomFab, dirFab, mailFab, cantEmp)
VALUES('Renault', '7 John Knox Ln, 9QW', 'renault_factory1@renault.com', 570);
go
PRINT('Test UNIQUE mailFab: se espera ERROR porque se repite mailFab')
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('XA', 'Renault', '7 John Knox Ln, 9QW', 'audi_factory1@audi.com', 570);
GO
PRINT('Test CHECK cantEmp > 0: se espera ERROR porque cantEmp tiene que ser mayor a cero')
INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('XA', 'Renault', '7 John Knox Ln, 9QW', 'renault_factory1@renault.com', 0);
go
-- *****************
-- Tabla Plantas
-- *****************
PRINT('Test PRIMARY KEY: se espera ERROR por repetir codPlan y codFab')
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'AA', 'Audi USA Motors', '38 Douglas Rd', 'audiusa@motors.com', '4');
go
PRINT('Test PRIMARY KEY: se espera ERROR porque codFab no puede ser nulo')
INSERT INTO Plantas(codPlan, nomPlan, dirPlan, mailPlan, codPais)
VALUES('5', 'Audi USA Motors', '38 Douglas Rd', 'audiusa@motors.com', '4');
go
PRINT('Test PRIMARY KEY: se espera ERROR porque codPlan no puede ser nulo')
INSERT INTO Plantas(codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('5', 'Audi USA Motors', '38 Douglas Rd', 'audiusa@motors.com', '4');
go
PRINT('Test FOREIGN KEY: se espera ERROR porque no existe el codFab')
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('6', 'AC', 'Audi USA Motors', '38 Douglas Rd', 'audiusa@motors.com', '4');
go
PRINT('Test FOREIGN KEY: se espera ERROR porque no existe el codPais')
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('6', 'AA', 'Audi USA Motors', '38 Douglas Rd', 'audiusa@motors.com', 'X');
go
PRINT('Test UNIQUE mailPlan: se espera ERROR porque se repite mailPlan')
INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('6', 'AA', 'Audi USA Motors', '38 Douglas Rd', 'audi@usa.com', '4');
go
-- *****************
-- Tabla Vehiculos
-- *****************
PRINT('Test PRIMARY KEY: se espera ERROR por repetir vin')
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('9JBFE320XHJB10190', 'IPACE CONCEPT', 'gris', 3500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '9', 'JB')
go
PRINT('Test PRIMARY KEY: se espera ERROR porque vin no puede ser nulo')
INSERT INTO Vehiculos(modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('IPACE CONCEPT', 'gris', 3500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '9', 'JB')
go
PRINT('Test FOREIGN KEY: se espera ERROR porque no existe el codPais')
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('9JBFE320XHJB10191', 'IPACE CONCEPT', 'gris', 3500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'L', 'JB')
go
PRINT('Test FOREIGN KEY: se espera ERROR porque no existe el codFab')
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('9JBFE320XHJB10191', 'IPACE CONCEPT', 'gris', 3500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '9', 'JC')
go
-- *****************
-- Tabla Envios
-- *****************
PRINT('Test IDENTITY: se espera ERROR porque no se puede insertar en un campo AUTONUMERADO como idEnvio')
INSERT INTO Envios(idEnvio, fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES (1, '20161008', 3675, 'Z', 'K');
go
PRINT('Test FOREIGN KEY: se espera ERROR porque no existe el oriEnvio')
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20161008', 3675, 'X', 'K');
go
PRINT('Test FOREIGN KEY: se espera ERROR porque no existe el desEnvio')
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20161008', 3675, 'Z', 'X');
go
-- *****************
-- Tabla Carga
-- *****************
PRINT('Test PRIMARY KEY: se espera ERROR por repetir idEnvio e idCarga')
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(52, 52, 'ZJAFE320XGJA10190', 3675)
go
PRINT('Test PRIMARY KEY: se espera ERROR porque idEnvio no puede ser nulo')
INSERT INTO Carga(idCarga, vin, pesoCarga)
VALUES(53, 'ZJAFE320XGJA10190', 3675)
go
PRINT('Test PRIMARY KEY: se espera ERROR porque idCarga no puede ser nulo')
INSERT INTO Carga(idEnvio, vin, pesoCarga)
VALUES(52, 'ZJAFE320XGJA10190', 3675)
go
PRINT('Test FOREIGN KEY: se espera ERROR porque no existe el vin')
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(52, 53, 'ZJAFE320XGJA10191', 3675)
go