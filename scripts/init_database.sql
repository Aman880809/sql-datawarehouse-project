/*
============================================================
Create Database & Schemas
============================================================
Script Purpose:
	This script creates a new database named 'DataWarehouse' after chechking if it alrady exists.
	If the database exists, it is dropped recreated. Additionally, the script sets upt three schemas
	within the databse: 'bronze', 'silver', & 'gold'.

WARNING:
	Running this script will drop  the entire 'DataWarehouse' if it exists.
	All data in database will be permanently deleted. Proceed with caution
	and ensure you have proper backup before running this script.
*/




USE master;
GO

-- Drop & recreate  the 'DataWarehouse' Database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse
END;
GO


-- Create the 'DataWarehouse' Database
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- CREATE SCHEMA
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
