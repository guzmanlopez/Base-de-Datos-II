/* Creacion de la BD */
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