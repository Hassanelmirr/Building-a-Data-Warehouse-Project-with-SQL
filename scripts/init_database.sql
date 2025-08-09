
======================================================
  Create Database and Schemas
======================================================
Script Purpose: 
  This script created a new database name "DataWarehouse" after checking if it already exists.
  If the database exists, it would drop and recreated. 
  Additionally, the script sets up three schemas within the database:
  'bonze', 'silver' and 'gold.
  

-- Create a new database

USE master;
GO

-- Drop & Recreate the database

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE Datawarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;
GO


-- Create the "datawarehouse" dataset

CREATE DATABASE DataWarehouse;

USE DataWarehouse;
Go

-- Create the Schemas

CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver; 
GO

CREATE SCHEMA gold;
Go
