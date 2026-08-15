/*
=====================================================================
Stored Procedure: Load Bronze Layer (Source > Bronze)
=====================================================================
Scrript Purpose:
	This Stored Procedure loads data into the 'bronze' schema from external CSV files.
	It performs the following actions:
	  -Truncate the bronze table before loading data.
	  -Uses the 'BULK INSERT'command to load data from csv Files to bronze tables.

Parameters:
	None.
	This stored procedure does not accept any parameters or return any values.

Usage Example:
	EXEC bronze.load_bronze;
=====================================================================
*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN

	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
	    SET @batch_start_time= GETDATE(); 
		print '=============================================================='
		print 'Loading Bronze Layer'
		print '=============================================================='

		print'---------------------------------------------------------------'
		print'Loading CRM Tables'
		print'---------------------------------------------------------------'

		SET @start_time= GETDATE(); 
		print'>> Truncating Table: bronze.crm_cut_info'
		TRUNCATE TABLE bronze.crm_cut_info

		print'>> Insaerting Data Into: bronze.crm_cut_info'
		BULK INSERT bronze.crm_cut_info
		FROM 'C:\Users\Aman Chaurasiya\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time= GETDATE(); 
		PRINT'>>LOAD DURATION: '+CAST (DATEDIFF(SECOND, @start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT'-----------------'


		SET @start_time= GETDATE(); 
		print'>> Truncating Table: bronze.crm_prd_info'
		TRUNCATE TABLE bronze.crm_prd_info

		print'>> Insaerting Data Into:  bronze.crm_prd_info'
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\Aman Chaurasiya\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		)
		SET @end_time= GETDATE(); 
		PRINT'>>LOAD DURATION: '+CAST (DATEDIFF(SECOND, @start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT'-----------------'


		SET @start_time= GETDATE();
		print'>> Truncating Table: bronze.crm_sales_details'
		TRUNCATE TABLE bronze.crm_sales_details

		print'>> Insaerting Data Into: bronze.crm_sales_details'
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\Aman Chaurasiya\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time= GETDATE(); 
		PRINT'>>LOAD DURATION: '+CAST (DATEDIFF(SECOND, @start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT'-----------------'


	print'---------------------------------------------------------------'
	print'Loading ERP Tables'
	print'---------------------------------------------------------------'

		SET @start_time= GETDATE();
		print'>> Truncating Table: bronze.erp_cust_az12'
		TRUNCATE TABLE bronze.erp_cust_az12

		print'>> Insaerting Data Into: bronze.erp_cust_az12'
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\Aman Chaurasiya\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		with (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		)
		SET @end_time= GETDATE(); 
		PRINT'>>LOAD DURATION: '+CAST (DATEDIFF(SECOND, @start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT'-----------------'


		SET @start_time= GETDATE();
		print'>> Truncating Table: bronze.erp_loc_a101'
		TRUNCATE TABLE bronze.erp_loc_a101

		print'>> Insaerting Data Into: bronze.erp_loc_a101'
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\Aman Chaurasiya\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		with (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time= GETDATE(); 
		PRINT'>>LOAD DURATION: '+CAST (DATEDIFF(SECOND, @start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT'-----------------'


		SET @start_time= GETDATE();
		print'>> Truncating Table: bronze.erp_px_cat_g1v2'
		TRUNCATE TABLE bronze.erp_px_cat_g1v2

		print'>> Insaerting Data Into: bronze.erp_px_cat_g1v2'
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\Aman Chaurasiya\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		with (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time= GETDATE(); 
		PRINT'>>LOAD DURATION: '+CAST (DATEDIFF(SECOND, @start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT'-----------------';

	    SET @batch_end_time = GETDATE();
		print'========================================================================='
		print'Loading Bronze layer is Completed';
		print'>> TOTAL LOAD DURATION: ' + CAST (DATEDIFF(SECOND,@batch_start_time, @batch_end_time) AS NVARCHAR) + 'seconds';
		print'========================================================================='


	END TRY
	BEGIN CATCH
		PRINT'=========================================================================='
		PRINT'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT'ERROR MESSAGE' + ERROR_MESSAGE(); 
		PRINT'ERROR MESSAGE' + CAST (ERROR_NUMBER() AS NVARCHAR); 
		PRINT'ERROR MESSAGE' + CAST (ERROR_STATE() AS NVARCHAR); 
		PRINT'=========================================================================='
	END CATCH

END
