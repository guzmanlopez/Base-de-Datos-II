/*
*********************************************************************************************
* Creación de la Basse de Datos                                                             *
*********************************************************************************************
*/
CREATE DATABASE BD_VEHICULOS
go
USE BD_VEHICULOS
go
/* Creacion de tablas */
CREATE TABLE Paises(codPais character(1) not null,
                    nomPais varchar(30) not null)
go
CREATE TABLE Fabricantes(codFab character(2) not null,
                         nomFab varchar(30) not null,
						 dirFab varchar(30) not null,
						 mailFab varchar(50))
go
CREATE TABLE Plantas(codPlan numeric(6) not null,
                     codFab character(2) not null,
					 nomPlan varchar(30) not null,
					 dirPlan varchar(30) not null,
					 mailPlan varchar(50),
					 codPais character(1) not null)
go
CREATE TABLE Vehiculos(vin character(17) not null,
                       modelo varchar(30) not null,
					   color varchar(20) not null,
					   peso numeric(12,2),
					   caracteristicas varchar(100),
					   codPais character(1) not null,
					   codFab character(2) not null)
go
CREATE TABLE Envios(idEnvio numeric(6) identity(1,1) not null,
                    fchEnvio datetime,
					pesoEnvio numeric(12,2),
					oriEnvio character(1) not null,
					desEnvio character(1) not null)
go
CREATE TABLE Carga(idEnvio numeric(6) not null,
                   idCarga numeric(6) not null,
				   vin character(17) not null,
				   pesoCarga numeric(12,2)) 
go
/*
*********************************************************************************************
* Script con las restricciones de integridad creadas sobre el script de creación de tablas, *
* índices, y el ingreso de datos de prueba.                                                 *
*********************************************************************************************
*/
go
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
--Mercedes Benz
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('WDAFE3209GDA10190', 'Hatchback', 'blanco', 3500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'W', 'DA')
go
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('WDAFE3150HDA10190', 'Spyder', 'negro', 2100, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'W', 'DA')
go
--Pontiac
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('12AFE3204G2A10190', 'Sunbird', 'blanco', 3800, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', '2A')
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
-- *****************
-- Insertar datos de cargas para que la consulta D) no sea vacía
-- *****************
CREATE PROCEDURE sp_insertar_datos_query_d
@idEnvio INT, 
@desdeidCarga INT,
@vin CHARACTER(17),
@pesoCarga NUMERIC(12,2),
@cantCargas INT
AS
BEGIN
DECLARE @ite INT
SET @ite = @desdeidCarga
WHILE (@ite <= @cantCargas)
	BEGIN
	INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
    VALUES(@idEnvio, @ite, @vin, @pesoCarga)
SET @ite = @ite + 1
	END	
END;
go
-- Crear envío
DECLARE @pesoTotal NUMERIC(12,2)
SELECT @pesoTotal = peso*1.05*600 FROM Vehiculos WHERE vin = '12AFE3204G2A10190' 
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170408', @pesoTotal, '1', '2');
go
-- Insertar cargas al envío creado
DECLARE @idE INT
DECLARE @peso NUMERIC(12,2)
SELECT @idE = idEnvio FROM Envios WHERE fchEnvio = '20170408'
SELECT @peso = peso*1.05 FROM Vehiculos WHERE vin = '12AFE3204G2A10190' 
EXEC sp_insertar_datos_query_d @idE, 1, '12AFE3204G2A10190', @peso, 600
go
-- *****************
-- Insertar datos para que la consulta F) no sea vacía
-- *****************
-- Crear país Holanda en Tabla Paises
INSERT INTO Paises(codPais, nomPais)
VALUES('H', 'Holanda');
go
-- Crear un envío
DECLARE @pesoTotal NUMERIC(12,2)
SELECT @pesoTotal = peso*1.05*20 FROM Vehiculos WHERE vin = 'WDAFE3209GDA10190' 
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20170308', @pesoTotal, '1', 'H');
go
-- Crear cargas (20) para el envío creado
DECLARE @idE INT
DECLARE @peso NUMERIC(12,2)
SELECT @idE = idEnvio FROM Envios WHERE fchEnvio = '20170308'
SELECT @peso = peso*1.05 FROM Vehiculos WHERE vin = 'WDAFE3209GDA10190' 
EXEC sp_insertar_datos_query_d @idE, 1, 'WDAFE3209GDA10190', @peso, 20
go
-- *****************
-- Insertar datos para que la consulta H) no sea vacía
-- *****************
-- Vehículo sin envío
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('WDAFE3200FDA10190', 'E500', 'gris', 3300, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'W', 'DA')
go
-- Vehículo enviado (dos años después de su fabricación)
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('WDAFE3202EDA10190', 'E500', 'gris', 3300, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'W', 'DA')
go
-- Crear un envío
DECLARE @pesoTotal NUMERIC(12,2)
SELECT @pesoTotal = peso*1.05*1 FROM Vehiculos WHERE vin = 'WDAFE3202EDA10190' 
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160910', @pesoTotal, 'W', '9');
go
-- Crear cargas para el envío creado
DECLARE @idE INT
DECLARE @peso NUMERIC(12,2)
SELECT @idE = idEnvio FROM Envios WHERE fchEnvio = '20160910'
SELECT @peso = peso*1.05 FROM Vehiculos WHERE vin = 'WDAFE3202EDA10190' 
EXEC sp_insertar_datos_query_d @idE, 1, 'WDAFE3202EDA10190', @peso, 1
go
-- *****************
-- Insertar datos para que la consulta I) no sea vacía
-- *****************
-- Insertar Vehículo 
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('JHAFE3150GHA10190', 'Avancier', 'rojo', 4300, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'J', 'HA')
go
-- Crear envío para mes 04
DECLARE @pesoTotal NUMERIC(12,2)
SELECT @pesoTotal = peso*1.05*150 FROM Vehiculos WHERE vin = 'JHAFE3150GHA10190' 
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160420', @pesoTotal, 'J', 'W');
-- Insertar cargas al envío creado (150 autos)
DECLARE @idE INT
DECLARE @peso NUMERIC(12,2)
SELECT @idE = idEnvio FROM Envios WHERE fchEnvio = '20160420'
SELECT @peso = peso*1.05 FROM Vehiculos WHERE vin = 'JHAFE3150GHA10190' 
EXEC sp_insertar_datos_query_d @idE, 1, 'JHAFE3150GHA10190', @peso, 150
go
-- Crear envío para mes 08
DECLARE @pesoTotal NUMERIC(12,2)
SELECT @pesoTotal = peso*1.05*110 FROM Vehiculos WHERE vin = 'JHAFE3150GHA10190' 
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20160825', @pesoTotal, 'J', 'W');
go
-- Insertar cargas al envío creado (110 autos)
DECLARE @idE INT
DECLARE @peso NUMERIC(12,2)
SELECT @idE = idEnvio FROM Envios WHERE fchEnvio = '20160825'
SELECT @peso = peso*1.05 FROM Vehiculos WHERE vin = 'JHAFE3150GHA10190' 
EXEC sp_insertar_datos_query_d @idE, 1, 'JHAFE3150GHA10190', @peso, 110
go
-- Crear envío para mes 12
DECLARE @pesoTotal NUMERIC(12,2)
SELECT @pesoTotal = peso*1.05*15 FROM Vehiculos WHERE vin = 'JHAFE3150GHA10190' 
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20161221', @pesoTotal, 'J', 'W');
go
-- Insertar cargas al envío creado (menos de 20 autos = 15)
DECLARE @idE INT
DECLARE @peso NUMERIC(12,2)
SELECT @idE = idEnvio FROM Envios WHERE fchEnvio = '20161221'
SELECT @peso = peso*1.05 FROM Vehiculos WHERE vin = 'JHAFE3150GHA10190' 
EXEC sp_insertar_datos_query_d @idE, 1, 'JHAFE3150GHA10190', @peso, 15
go
/*
*********************************************************************************************
* Script con funciones y procedimientos                                                     *
*********************************************************************************************
*/
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
go
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
go
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
go
-- Test OK
DECLARE @output CHARACTER(17)
SET @output = dbo.funct_validar_digitoverificador_vin('1AAFE3203FAA10190');
PRINT @output
go
-- Test devuelve VIN corregido
DECLARE @output CHARACTER(17)
SET @output = dbo.funct_validar_digitoverificador_vin('1AAFE3209FAA10190');
PRINT @output
go
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
go
-- Test 2015
DECLARE @output INT
SET @output = dbo.funct_aniodelmodelo_vin('1AAFE3203FAA10190');
PRINT @output
go
-- Test 2016
DECLARE @output INT
SET @output = dbo.funct_aniodelmodelo_vin('1AAFE3201GAA10190');
PRINT @output
go
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
go
-- Test
DECLARE @fchIni DATE
DECLARE @fchFin DATE
DECLARE @output INT
SET @fchIni = '20150101' 
SET @fchFin = '20170620'
SET @output = dbo.funct_fechas_cantvehiculos_pais_maxcant(@fchIni, @fchFin)
PRINT @output
go
/*
*********************************************************************************************
* d. Mediante un procedimiento almacenado que reciba un rango de fechas de envío,
* cambiar el país de destino del envío a todos los vehículos cuyo país de fabricación del
* vehículo sea el mismo que el país de destino del envío, en ese caso crear un país de
* código ‘#’ que tenga como descripción ‘LOCAL’ y poner ese dato como destino.
*********************************************************************************************
*/
go
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
go
-- Test procedure
-- Insertar país local en la tabla Paises
INSERT INTO Paises(codPais, nomPais)
VALUES('#', 'LOCAL');
go
-- Insertar un envío cuyo destino final sea el país que lo fabrico
DECLARE @pesoTot NUMERIC(12,2)
SELECT @pesoTot = peso*1.05 FROM Vehiculos WHERE vin = '16AFE3201F6A10190'
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20151008', @pesoTot, '2', '1');
go
-- Insertar Carga (1 auto para el envío creado)
DECLARE @pesoTot NUMERIC(12,2)
SELECT @pesoTot = peso*1.05 FROM Vehiculos WHERE vin = '16AFE3201F6A10190'
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
VALUES((SELECT idEnvio FROM Envios
	    WHERE fchEnvio = '20151008'
	    AND oriEnvio = '2'
	    AND desEnvio = '1'), 1, '16AFE3201F6A10190', @pesoTot)
go
-- Ejecutar procedure sin cambios por no coincidir fechas
EXEC sp_fechasenvio_cambiapaisdestino '20170101', '20170105'  
go
SELECT * 
FROM Envios E
WHERE E.desEnvio = '#';
go
-- Ejecutar procedure con cambios
EXEC sp_fechasenvio_cambiapaisdestino '20150101', '20151231'  
go
SELECT * 
FROM Envios E
WHERE E.desEnvio = '#';
go
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
go
-- Test 
DECLARE @output VARCHAR(30)
SET @output = dbo.funct_fechas_nompais_menorcantvehic('20100101',GETDATE())
PRINT @output
go
-- Durante 2015
DECLARE @output VARCHAR(30)
SET @output = dbo.funct_fechas_nompais_menorcantvehic('20150101','20151231')
PRINT @output
go
-- Durante 2016
DECLARE @output VARCHAR(30)
SET @output = dbo.funct_fechas_nompais_menorcantvehic('20160101','20161231')
PRINT @output
go
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
go
-- Test para codFab = AA
DECLARE @out1 INT
DECLARE @out2 INT
EXEC sp_codfab_cantplantas_cantmodelosvehic 'AA', @out1 OUTPUT, @out2 OUTPUT  
PRINT 'Cant_plantas: ' + CAST(@out1 AS CHARACTER(2)) + '| Cant_modelos: ' + CAST(@out2 AS CHARACTER(2))
go
-- Test para codFab = JA
DECLARE @out1 INT
DECLARE @out2 INT
EXEC sp_codfab_cantplantas_cantmodelosvehic 'JA', @out1 OUTPUT, @out2 OUTPUT  
PRINT 'Cant_plantas: ' + CAST(@out1 AS CHARACTER(2)) + '| Cant_modelos: ' + CAST(@out2 AS CHARACTER(2))
go
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
go
-- Test para 'Audi'
DECLARE @out1 INT
DECLARE @out2 INT
EXEC sp_nomfab_cantplantas_cantmodelosvehic 'Audi', @out1 OUTPUT, @out2 OUTPUT  
PRINT 'Cant_plantas: ' + CAST(@out1 AS CHARACTER(2)) + '| Cant_modelos: ' + CAST(@out2 AS CHARACTER(2))
go
/*
*********************************************************************************************
* Script con disparadores                                                                   *
*********************************************************************************************
*/
/*
*********************************************************************************************
* a. Crear un trigger que valide un número de VIN al ingresar un nuevo vehículo, debe
* utilizar la función creada en el punto 4a.
*********************************************************************************************
*/
-- Función auxiliar: impide VIN con caracteres I, O, Q o Ñ
CREATE FUNCTION funct_impedir_caracteres_vin
(@vin CHARACTER(17))
RETURNS BIT
AS
BEGIN
DECLARE @ret BIT
SET @ret = 1
-- Recorrer VIN 
DECLARE @ite INT
SET @ite = 1
WHILE (@ite < 18 AND @ret = 1)
	BEGIN
	IF(SUBSTRING(@vin,@ite,1) IN ('I','O','Q','Ñ'))
	BEGIN
	SET @ret = 0
	END	
SET @ite = @ite + 1
	END	
RETURN @ret
END;
go
-- Trigger
CREATE TRIGGER trigger_validar_vin_insert_vehiculo
ON Vehiculos 
INSTEAD OF INSERT
AS
BEGIN
DECLARE @vin CHARACTER(17)
DECLARE @codPais CHARACTER(1)
DECLARE @codFab CHARACTER(2)
DECLARE @codFabPais CHARACTER(2)
DECLARE @caracteres BIT
SET @codPais = ''
SET @codFab = ''
SET @codFabPais = ''
SET @caracteres = 1
-- Validar caracteres no permitidos
SELECT @caracteres = dbo.funct_impedir_caracteres_vin(I.vin)
FROM inserted I
IF(@caracteres = 1)
BEGIN
	SELECT @vin = dbo.funct_validar_digitoverificador_vin(I.vin) 
	FROM inserted I 
	-- Check codPais
	SELECT @codPais = (I.codPais) 
	FROM inserted I, Paises P
	WHERE I.codPais = P.codPais 
	-- Check codFab
	SELECT @codFab = (I.codFab) 
	FROM inserted I, Fabricantes F
	WHERE I.codFab = F.codFab
	-- Check codPais y codFab
	SELECT @codFabPais = (I.codFab) 
	FROM inserted I, Plantas P
	WHERE I.codFab = P.codFab
	AND I.codPais = P.codPais
	IF (@codPais = '')
		BEGIN
		PRINT 'No existe el [codPais] para el vehículo que se quiere ingresar' 
		END
	ELSE IF (@codFab = '')
		BEGIN
		PRINT 'No existe el [codFab] para el vehículo que se quiere ingresar' 
		END
	ELSE IF (@codFabPais = '')
		BEGIN
		PRINT 'No existe la planta para el vehículo que se quiere ingresar' 
		END
	ELSE IF (@vin <> 'OK')
		BEGIN
		INSERT INTO Vehiculos
		SELECT @vin, I.modelo, I.color, I.peso, I.caracteristicas, I.codPais, I.codFab
		FROM INSERTED I
		PRINT 'VEHICULO INGRESADO (VIN CORREGIDO!)'
		END
	ELSE IF (@vin = 'OK')
		BEGIN
		INSERT INTO Vehiculos
		SELECT I.vin, I.modelo, I.color, I.peso, I.caracteristicas, I.codPais, I.codFab
		FROM INSERTED I
		PRINT 'VEHICULO INGRESADO (VIN OK)'
		END
END
ELSE
	BEGIN
	PRINT 'CARACTERES EN vin NO PERMITIDOS'
	END
END;
go
-- Test OK, vin OK
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1AAAL3205EAA10190', 'A4', 'gris', 2500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'AA')
go
-- Test OK, vin CORREGIDO
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1AAAL3154EAA10190', 'A4', 'gris', 2500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'AA')
go
-- Test ERROR, caracter no permitido I
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1AIAL3205EAA10190', 'A4', 'gris', 2500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'AA')
go
-- Test ERROR, caracter no permitido O
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1AOAL3205EAA10190', 'A4', 'gris', 2500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'AA')
go
-- Test ERROR, caracter no permitido Q
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1AQAL3205EAA10190', 'A4', 'gris', 2500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'AA')
go
-- Test ERROR, caracter no permitido Ñ
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab)
VALUES ('1AÑAL3205EAA10190', 'A4', 'gris', 2500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'AA')
go
-- Test ERROR, no existe codPais
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab) 
VALUES ('XAAAL3204EAA10190', 'A4', 'verde', 2500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', 'X', 'AA')
go
-- Test ERROR, no existe codFab
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab) 
VALUES ('XAAAL3204EAA10190', 'A4', 'verde', 2500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '1', 'AC')
go
-- Test ERROR, no existe codFab para el codPais (no existe la planta)
INSERT INTO Vehiculos(vin, modelo, color, peso, caracteristicas, codPais, codFab) 
VALUES ('XAAAL3204EAA10190', 'A4', 'verde', 2500, 'Frenos ABS, Aire Acondicionado y tapizado de cuero', '2', 'AA')
go
/*
*********************************************************************************************
* b. Crear un trigger al ingresar una línea de carga, ponga el peso correcto de acuerdo al
* peso del vehículo mas el 5% de combustible y accesorios, también debe acumular el
* peso total del envío.
*********************************************************************************************
*/
CREATE TRIGGER trigger_peso_insert_carga
ON Carga 
INSTEAD OF INSERT
AS
BEGIN
UPDATE Envios
SET pesoEnvio = pesoEnvio + (SELECT SUM(V.peso * 1.05)
							FROM inserted I, Vehiculos V, Envios E
							WHERE I.vin = V.vin
							AND I.idEnvio = E.idEnvio)
FROM inserted I2, Envios E2
WHERE E2.idEnvio = I2.idEnvio;
INSERT INTO Carga(idEnvio, idCarga, vin, pesoCarga)
SELECT I3.idEnvio, I3.idCarga, I3.vin, (SELECT SUM(V2.peso * 1.05)
							FROM inserted I3, Vehiculos V2
							WHERE I3.vin = V2.vin)
FROM inserted I3, Vehiculos V2
WHERE I3.vin = V2.vin
END;
go
-- Test OK
INSERT INTO Carga(idEnvio, idCarga, vin)
VALUES(1, 2, '16AFE3201F6A10190')
go
INSERT INTO Carga(idEnvio, idCarga, vin)
VALUES(2, 2, '16AFE3208H6A10190')
go
-- Test OK, ingresar 3 cargas más al idEnvio = 52
INSERT INTO Carga(idEnvio, idCarga, vin)
VALUES(52, 2, 'ZJAFE320XGJA10190')
go
INSERT INTO Carga(idEnvio, idCarga, vin)
VALUES(52, 3, 'ZJAFE320XGJA10190')
go
INSERT INTO Carga(idEnvio, idCarga, vin)
VALUES(52, 4, 'ZJAFE320XGJA10190')
go
-- Ver cargas del idEnvio = 52
SELECT *
FROM Carga
WHERE idEnvio = 52;
go
/*
*********************************************************************************************
* c. Definir un trigger que al ingresar un envío, si el país de origen es igual al país de
* destino no procese la linea.
*********************************************************************************************
*/
CREATE TRIGGER trigger_validar_origendestino_insert_envio
ON Envios 
INSTEAD OF INSERT
AS
BEGIN
INSERT INTO Envios
SELECT I.fchEnvio, I.pesoEnvio, I.oriEnvio, I.desEnvio
FROM inserted I, inserted I2
WHERE I.idEnvio = I2.idEnvio 
AND I.oriEnvio <> I2.desEnvio
END;
go
-- Test OK
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20150315', 3990, '1', 'Z');
go
-- Test no procesa línea
INSERT INTO Envios(fchEnvio, pesoEnvio, oriEnvio, desEnvio)
VALUES ('20150315', 3990, '1', '1');
go
-- Ver tabla (el idEnvio = 62 corresponde a la inserción Test OK)
SELECT * 
FROM Envios
WHERE fchEnvio = '20150315';
go
/*
*********************************************************************************************
* d. Implementar un trigger que permita el borrado de uno o más envíos, para ello debe
* borrar en cascada todos los registros en las tablas relacionadas, se debe tener en
* cuenta los borrados múltiples.
*********************************************************************************************
*/
CREATE TRIGGER trigger_delete_envio
ON Envios 
INSTEAD OF DELETE
AS
BEGIN
-- Borrar de tabla Carga
DELETE FROM Carga
WHERE idEnvio IN (SELECT D.idEnvio FROM deleted D)
-- Borrar de tabla Envio
DELETE FROM Envios
WHERE idEnvio IN (SELECT D2.idEnvio FROM deleted D2)
END;
go
-- Test OK
-- Múltiple (borra las cuatro cargas del idEnvio = 52 en la tabla Carga y el propio idEnvio = 52 en la tabla Envios)
DELETE FROM Envios
WHERE idEnvio = 52;
go
-- Ver cargas del idEnvio = 52
SELECT *
FROM Carga
WHERE idEnvio = 52;
go
-- Ver idEnvio = 52
SELECT *
FROM Envios
WHERE idEnvio = 52;