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

INSERT INTO Paises(codPais, nomPais)
VALUES('1', 'Estados Unidos');

INSERT INTO Paises(codPais, nomPais)
VALUES('2', 'Canadá');

INSERT INTO Paises(codPais, nomPais)
VALUES('3', 'México');

INSERT INTO Paises(codPais, nomPais)
VALUES('9', 'Brasil');

INSERT INTO Paises(codPais, nomPais)
VALUES('J', 'Japón');

INSERT INTO Paises(codPais, nomPais)
VALUES('K', 'Corea');

INSERT INTO Paises(codPais, nomPais)
VALUES('S', 'Inglaterra');

INSERT INTO Paises(codPais, nomPais)
VALUES('W', 'Alemania');

INSERT INTO Paises(codPais, nomPais)
VALUES('Y', 'Suecia');

INSERT INTO Paises(codPais, nomPais)
VALUES('Z', 'Italia');

-- Otros países

INSERT INTO Paises(codPais, nomPais)
VALUES('4', 'Argentina');

INSERT INTO Paises(codPais, nomPais)
VALUES('5', 'Chile');

INSERT INTO Paises(codPais, nomPais)
VALUES('6', 'Uruguay');

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
VALUES('BB', 'Bmw', '8 Copley St, Batley WF17 8JA', 'bmw_factory2@bmw.com', 100);

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
VALUES('EB', 'Dodge', '3 Lon Ger-Y-Coed, Ammanford 18', 'dodge_factory2@dodge.com', 80);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('FA', 'Ford', '2 Boston End, Thetford IP24', 'ford_factory1@ford.com', 160);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('FB', 'Ford', '4 Boston End, Thetford IP24', 'ford_factory2@ford.com', 260);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('GA', 'GM', '1-4 Smithy Row, NG1', 'gm_factory1@gm.com', 450);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('GB', 'GM', '1 Smithy Row, NG1', 'gm_factory2@gm.com', 450);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('HA', 'Honda', '26A Station St, 5HJ', 'honda_factory1@honda.com', 320);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('HB', 'Honda', '25 Station St, 5HJ', 'honda_factory2@honda.com', 300);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('JA', 'Jaguar', '15 Sutton Ave, 3JY', 'jaguar_factory1@jaguar.com', 620);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('JB', 'Jaguar', '20 Sutton Ave, 3K', 'jaguar_factory2@jaguar.com', 320);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('LA', 'Lincon', '9-15 Queen St, Cardiff CF10', 'lincon_factory1@lincon.com', 220);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('LB', 'Lincon', '20 Queen St, Cardiff CF1', 'lincon_factory2@lincon.com', 220);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('MA', 'Mercury', '375 Lonsdale Rd, 9PY', 'mercury_factory1@mercury.com', 460);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('MB', 'Mercury', '300 Lonsdale Rd, 9PY', 'mercury_factory2@mercury.com', 460);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('NA', 'Nissan', 'Saltcoats, 1YZ', 'nissan_factory1@nissan.com', 340);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('NB', 'Nissan', 'Saltcoats, 20YZ', 'nissan_factory2@nissan.com', 340);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('PA', 'Plymounth', '21 Station Rd Blvd, 5SN', 'plymounth_factory1@plymounth.com', 380);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('PB', 'Plymounth', '18 Station Rd Blvd, 5SN', 'plymounth_factory2@plymounth.com', 380);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('SA', 'Saab', 'A9, Bridge of Allan, FK9', 'saab_factory1@saab.com', 180);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('SB', 'Saab', 'Bridge of Allan, FK9', 'saab_factory2@saab.com', 180);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('TA', 'Toyota', '12 Tayside Dr, Edgward 8RD', 'toyota_factory1@toyota.com', 240);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('TB', 'Toyota', '10 Tayside Dr, Edgward 8RD', 'toyota_factory2@toyota.com', 240);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('VA', 'Volkswagen', '21 Lon Tyr Haul, 9SF', 'volkswagen_factory1@volkswagen.com', 570);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('VB', 'Volkswagen', '31 Lon Tyr Haul, 9', 'volkswagen_factory2@volkswagen.com', 570);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('2A', 'Pontiac', '9 Kingsgate St, 9PD', 'pontiac_factory1@pontiac.com', 250);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('2B', 'Pontiac', '10 Kingsgate St, 9PD', 'pontiac_factory2@pontiac.com', 250);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('3A', 'Oldsmobile', '38 Queens Rd, 2ET', 'oldsmobile_factory1@oldsmobile.com', 440);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('3B', 'Oldsmobile', '40 Queens Rd, 2ET', 'oldsmobile_factory2@oldsmobile.com', 440);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('4A', 'Buick', '13 Beckett Cl, London SW16 1AN', 'buick_factory1@buick.com', 80);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('4B', 'Buick', '20 Beckett Cl, London SW16 1AN', 'buick_factory2@buick.com', 80);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('6A', 'Cadillac', '145 Sandringham Rd, Cleeth 9BP', 'cadillac_factory1@cadillac.com', 60);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('6B', 'Cadillac', '3 Sandringham Rd, Cleeth 9BP', 'cadillac_factory2@cadillac.com', 60);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('7A', 'GM Canada', '40 Springfield Rd, 3DU', 'gmcanada_factory1@gm.com', 250);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('7B', 'GM Canada', '20 Springfield Rd, 3DU', 'gmcanada_factory2@gm.com', 250);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('8A', 'Saturn', '42 Church St, 7AS', 'saturn_factory1@saturn.com', 190);

INSERT INTO Fabricantes(codFab, nomFab, dirFab, mailFab, cantEmp)
VALUES('8B', 'Saturn', '32 Church St, 7AS', 'saturn_factory2@saturn.com', 190);

-- *****************
-- Tabla Plantas
-- *****************

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'AA', 'Audi usa', '2335 Canton Hwy #6 Windsor', 'audi@usa.com', '1');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'AA', 'Audi Inglaterra', '7564 N Academy Ave', 'audi@inglaterra.com', 'S');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('3', 'AB', 'Audi Brasil', '88 E Saint Elmo Rd', 'audi@brasil.com', '9');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'BA', 'BMW US Perfection Inc', '6 Arch St #9757 Alcida', 'bmw@usa.com', '1');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'BA', 'BMW IT Luxury Inc', '75 Westchester Ave', 'bmw@italia.com', 'Z');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('3', 'BB', 'BMW CH Luxury Inc', '80 Westchester Ave', 'bmw@chile.com', '5');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'CA', 'Chrysler Canada Creations', '447 Commercial St Se Lile', 'chrysler@canada.com', '2');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'CA', 'Chrysler Corea Designs', '765 Rock Island Rd', 'chrysler@corea.com', 'K');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('3', 'CB', 'Chrysler México Designs', '8 Rock Island Rd', 'chrysler@mexico.com', '3');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'DA', 'Benz German Designs', '9 So Ilhung Island Rd', 'benz@alemania.com', 'W');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'DA', 'Benz Sweeden Designs', '9 So Ilhung Island Rd', 'benz@suecia.com', 'Y');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('3', 'DB', 'Benz Argentina Designs', '9 So Ilhung Island Rd', 'benz@argentina.com', '4');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'EA', 'Dodge USA Designs', '40 Us Highway 12e', 'dodge@usa.com', '1');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'EB', 'Dodge Mexico Designs', '50 Us Highway 12e', 'dodge@mexico.com', '3');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'FA', 'Ford usa Valley Propane Inc', '3 Mill Rd Baker Brook', 'ford@usa.com', '1');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'FA', 'Ford German Valley Propane Inc', '6 Mill Rd Baker Brook', 'ford@alemania.com', 'W');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('3', 'FB', 'Ford MX Valley Propane Inc', '20 Mill Rd Baker Brook', 'ford@mexico.com', '3');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'GA', 'GM Usa Ep Systems', '37 Us Highway 12e', 'gm@usa.com', '1');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'GA', 'GM England Ep Systems', '40 Us Highway 12e', 'gm@inglaterra.com', 'S');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('3', 'GB', 'GM Brasil Ep Systems', '50 Us Highway 12e', 'gm@brasil.com', '9');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'HA', 'Honda Japon Campbell Auto', '2859 Dorsett Rd', 'honda@japon.com', 'J');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'HA', 'Honda Corea Campbell Auto', '2859 Dorsett Rd', 'honda@corea.com', 'K');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('3', 'HB', 'Honda Chile Campbell Auto', '2859 Dorsett Rd', 'honda@chile.com', '5');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'JA', 'Jaguar Italy Auto', '3045 Dorsett Rd', 'jaguar@italia.com', 'Z');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'JA', 'Jaguar Suecia Auto', '30 Dorsett Rd', 'jaguar@suecia.com', 'Y');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('3', 'JB', 'Jaguar Brasil Auto', '3060 Dorsett Rd', 'jaguar@brasil.com', '9');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'LA', 'Lincon England Auto', '3045 Belmont Rd', 'lincon@inglaterra.com', 'S');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'LB', 'Lincon Argentina Auto', '30 Belmont Rd', 'lincon@argentina.com', '4');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'MA', 'Mercury USA Designs', '1 Belmont Rd 3F', 'mercury@usa.com', '1');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'MB', 'Mercury Chile Designs', '99 Belmont Rd 3F', 'mercury@chile.com', '5');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'NA', 'Nissan Corea Designs', '1 Pittsford Rd 3F', 'nissan@corea.com', 'K');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'NB', 'Nissan Chile Designs', '10 Pittsford Rd 3F', 'nissan@chile.com', '5');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'PA', 'Plymounth USA Designs', '1 Pittsford Rd 3B', 'plymounth@usa.com', '1');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'PB', 'Plymounth Uruguay Designs', '13 Pittsford Rd 3B', 'plymounth@uruguay.com', '6');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'SA', 'Saab Italy Designs', '01 Pittsford Rd 3Z', 'saab@italia.com', 'Z');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'SB', 'Saab Uruguay Designs', '19 Pittsford Rd 3Z9', 'saab@uruguay.com', '6');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'TA', 'Toyota Japon Designs', 'Pittsford Rd 39', 'toyota@japon.com', 'J');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'TB', 'Toyota Corea Designs', 'Pittsford Rd 59', 'toyota@corea.com', 'K');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', 'VA', 'Volkswagen German Designs', 'Pittsford Rd 129', 'vw@alemania.com', 'W');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', 'VB', 'Volkswagen Brasil Designs', 'Pittsford Rd 300', 'vw@brasil.com', '9');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', '2A', 'Pontiac USA Designs', 'Pittsford Rd 23B', 'pontiac@usa.com', '1');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', '2B', 'Pontiac Chile Designs', 'Pittsford Rd 23C', 'pontiac@chile.com', '5');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', '3A', 'Oldsmobile Sweeden Designs', 'Belmont Rd 33B', 'oldsmobile@suecia.com', 'Y');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', '3B', 'Oldsmobile Argentina Designs', 'Belmont Rd 33C', 'oldsmobile@argentina.com', '4');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', '4A', 'Buick England Auto', '9547 Belmont Rd #21', 'buick@inglaterra.com', 'S');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', '4B', 'Buick Uruguay Auto', '9547 Belmont Rd #21', 'buick@uruguay.com', '6');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', '6A', 'Cadillac USA Consultants', '73 Pittsford Victor Rd', 'cadillac@usa.com', '1');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', '6B', 'Cadillac Brasil Consultants', '5174 Interstate 45 N', 'cadillac@brasil.com', '9');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', '7A', 'GM Canada Designs', '136 W Grand Ave #3', 'gmcanada@canada.com', '2');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', '7A', 'GM Canada Designs', '136 W Grand Ave #4', 'gmcanada2@canada.com', '2');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('3', '7B', 'GM Canada Designs', '136 W Grand Ave #5', 'gmcanada@mexico.com', '3');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('1', '8A', 'Saturn Canada Designs', '136 W Grand Ave #8', 'saturn@canada.com', '2');

INSERT INTO Plantas(codPlan, codFab, nomPlan, dirPlan, mailPlan, codPais)
VALUES('2', '8B', 'Saturn Uruguay Designs', '136 W Grand Ave #20', 'saturn@uruguay.com', '6');

-- *****************
-- Tabla Vehiculos
-- *****************

-- Audi
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1AAFE3203FAA1019', 'A4', 'gris', 2500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'AA')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1AAFE3201GAA1019', 'A4', 'negro', 2500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'AA')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1AAAL320XHAA1019', 'A5', 'negro', 1500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'AA')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('9ABAL320XHAB1019', 'A5', 'gris', 1500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '9', 'AB')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('SAAAL3207HAA1019', 'A5', 'gris', 1500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'S', 'AA')

-- BMW

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1BAAL3150FBA1019', 'Z3', 'negro', 1000, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'BA')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1BAAL3159GBA1019', 'Z3', 'negro', 1000, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'BA')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('ZBAFE3201HBA1019', 'Z4', 'gris', 1800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'Z', 'BA')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('5BBFE3204HBB1019', 'Z4', 'negro', 1800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '5', 'BB')

-- Buick

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('S4AFE3201F4A1019', 'LaCrosse', 'negro', 2800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'S', '4A')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('S4AFE320XG4A1019', 'LaCrosse', 'negro', 2800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'S', '4A')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('S4AFE3208H4A1019', 'LaCrosse', 'gris', 2800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'S', '4A')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('64BFE3154G4B1019', 'LaCrosse', 'gris', 2800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '6', '4B')

-- Cadillac

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('16AFE3201F6A1019', 'XTS', 'gris', 3800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', '6A')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('16AFE320XG6A1019', 'XTS', 'gris', 3800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', '6A')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('16AFE3208H6A1019', 'XTS', 'negro', 3800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', '6A')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('96BFE3208H6B1019', 'XTS', 'negro', 3800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '9', '6B')

-- Chrysler
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('2CAFE3208FCA1019', 'Pacifica', 'negro', 2800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '2', 'CA')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('2CAFE3206GCA1019', 'Pacifica', 'negro', 2800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '2', 'CA')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('2CAFE3204HCA1019', 'Pacifica', 'gris', 2800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '2', 'CA')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('KCAFE3208FCA1019', 'Pacifica', 'verde', 2800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'K', 'CA')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('KCAFE3206GCA1019', 'Pacifica', 'verde', 2800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'K', 'CA')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('KCAFE3204HCA1019', 'Pacifica', 'verde', 2800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'K', 'CA')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('3CBFE3203HCB1019', 'Pacifica', 'rojo', 2800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '3', 'CB')

-- Dodge
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1EAFE3208FEA1019', 'Challenger', 'negro', 3000, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'EA')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1EAFE3206GEA1019', 'Challenger', 'negro', 3000, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'EA')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1EAFE3204HEA1019', 'Challenger', 'negro', 3000, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'EA')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('3EBFE3200HEB1019', 'Challenger', 'negro', 3000, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '3', 'EB')

-- Ford
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1FAFE320XGFA1019', 'Mustang', 'rojo', 3200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'FA')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1FAFE3208HFA1019', 'Mustang', 'rojo', 3200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'FA')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('WFAFE3204HFA1019', 'Mustang', 'negro', 3200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'W', 'FA')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('3FBFE3204HFB1019', 'Mustang', 'gris', 3200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '3', 'FB')

-- GM
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1GAFE3205FGA1019', 'Camaro', 'negro', 5200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'GA')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1GAFE3203GGA1019', 'Camaro', 'gris', 5200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'GA')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('SGAFE3202FGA1019', 'Camaro', 'gris', 5200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'S', 'GA')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('SGAFE3200GGA1019', 'Camaro', 'negro', 5200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'S', 'GA')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('9GBFE3203GGB1019', 'Camaro', 'negro', 5200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '9', 'GB')

-- GM Canada
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('27AFE3202F7A1019', 'Camaro', 'negro', 5200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '2', '7A')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('27AFE3200G7A1019', 'Camaro', 'gris', 5200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '2', '7A')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('27AFE3209H7A1019', 'Camaro', 'gris', 5200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '2', '7A')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('37BFE320XG7B1019', 'Camaro', 'negro', 5200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '3', '7B')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('37BFE3208H7B1019', 'Camaro', 'negro', 5200, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '3', '7B')

-- Honda

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('JHAFE3207GHA1019', 'Civic', 'gris', 4000, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'J', 'HA')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('JHAFE3205HHA1019', 'Civic', 'negro', 4000, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'J', 'HA')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('KHAFE3206FHA1019', 'Civic', 'gris', 4000, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'K', 'HA')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('KHAFE3204GHA1019', 'Civic', 'negro', 4000, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'K', 'HA')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('5HBFE3208GHB1019', 'Civic', 'gris', 4000, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '5', 'HB')

-- Jaguar

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('YJAFE3202GJA1019', 'IPACE CONCEPT', 'gris', 3500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'Y', 'JA')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('YJAFE3200HJA1019', 'IPACE CONCEPT', 'negro', 3500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'Y', 'JA')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('ZJAFE320XGJA1019', 'IPACE CONCEPT', 'gris', 3500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'Z', 'JA')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('ZJAFE3208HJA1019', 'IPACE CONCEPT', 'negro', 3500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'Z', 'JA')

INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('9JBFE320XHJB1019', 'IPACE CONCEPT', 'gris', 3500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '9', 'JB')

/*
DECLARE @vin CHARACTER(17)
DECLARE @output CHARACTER(17)
SET @vin = dbo.funct_aux_VIN_generator('9','JB','Hierro','2.0',2017)
SET @output = dbo.funct_validar_digitoverificador_vin(@vin);
PRINT @vin + '   ' + @output

SELECT F.codFab, F.nomFab, P.codPais FROM 
Plantas P, Fabricantes F
WHERE P.codFab = F.codFab
--AND P.codFab IN ('JA', 'JB')
ORDER BY nomFab ASC
*/

-- *****************
-- Tabla Envios
-- *****************

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20150315', 3990, '1', 'Z');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170415', 3990, '1', 'Z');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160915', 3990, '1', 'Y');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170115', 1575, '1', 'Y');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160115', 2625, '1', '2');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20151015', 2625, '1', '2');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20151115', 1050, '1', '3');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160815', 1050, '1', '5');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170415', 3150, '1', '5');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160415', 3150, '1', '5');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20150415', 3150, '1', '6');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170215', 3360, '1', '6');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160615', 3360, '1', '9');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160715', 5460, '1', '9');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20150715', 5460, '1', 'Z');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160815', 5460, '2', 'Z');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20150915', 5460, '2', 'Z');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170315', 5460, '2', 'J');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170115', 2940, '2', 'Z');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160115', 2940, '2', 'Z');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20150315', 2940, '2', 'J');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170120', 5460, '3', 'J');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160111', 5460, '3', '6');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170207', 2940, '3', '6');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170224', 3150, '3', 'K');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170305', 3360, '3', 'K');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170407', 1890, '5', '6');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20161120', 4200, '5', '6');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160809', 2940, '6', '5');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170115', 3990, '9', '1');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170620', 1575, '9', '1');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20161005', 5460, '9', '2');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170314', 3675, '9', '2');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170318', 4200, 'J', 'Z');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20161204', 4200, 'J', 'Z');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170103', 2940, 'K', 'Z');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160828', 2940, 'K', 'J');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20150120', 2940, 'K', 'J');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160214', 4200, 'K', 'S');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20150226', 4200, 'K', 'S');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20151010', 2940, 'S', '9');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170102', 2940, 'S', '9');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160505', 2940, 'S', '6');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170213', 1575, 'S', '6');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20161220', 5460, 'S', '6');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20150606', 5460, 'S', '2');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170420', 3360, 'W', 'J');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170501', 3675, 'Y', 'J');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160820', 3675, 'Y', 'K');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170123', 1890, 'Z', '2');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170111', 3675, 'Z', '1');

INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20161008', 3675, 'Z', 'K');

-- *****************
-- Tabla Cargas
-- *****************

INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(1, 1, '16AFE3201F6A1019', 3990)

INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(2, 2, '16AFE3208H6A1019', 3990)

INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(3, 3, '16AFE320XG6A1019', 3990)

INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(4, 4, '1AAAL320XHAA1019', 1575)

INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(5, 5, '1AAFE3201GAA1019', 2625)

INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(6, 6, '1AAFE3203FAA1019', 2625)

INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(7, 7, '1BAAL3150FBA1019', 1050)

INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(8, 8, '1BAAL3159GBA1019', 1050)
 
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(9, 9, '1EAFE3204HEA1019', 3150)

INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES(10, 10, '1EAFE3206GEA1019', 3150)


SELECT * FROM Vehiculos;

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








