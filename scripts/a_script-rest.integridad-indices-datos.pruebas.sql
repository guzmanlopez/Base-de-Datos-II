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


