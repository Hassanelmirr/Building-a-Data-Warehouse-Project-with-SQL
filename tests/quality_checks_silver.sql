-- ==========================================================================
-- CHECKING THE QUALITY (BEFORE & AFTER) TRANSFORMATION OF THE DATA
-- IN ORDER TO LOAD IT TO THE SILVER LAYER.
-- ==========================================================================

----------------------------------------------------
--   crm_cust_info
----------------------------------------------------

-- Check for Nulls and Duplicates in the primary key 
-- expectation : NO RESULT

SELECT * FROM bronze.crm_cust_info

SELECT cst_id, 
	COUNT(*) AS nb_of_duplicates
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id =0

SELECT * FROM( -- subquery cration
	SELECT *,
		ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
	From bronze.crm_cust_info
)t WHERE flag_last = 1

--- droping unwanted spaces

SELECT * FROM bronze.crm_cust_info

SELECT cst_firstname FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

SELECT DISTINCT cst_gndr FROM bronze.crm_cust_info
SELECT DISTINCT cst_material_status FROM bronze.crm_cust_info


---- after loading data to silver , checking the past issues in the silver

SELECT COUNT(*) as s FROM silver.crm_cust_info 
SELECT COUNT(*) as b FROM bronze.crm_cust_info

SELECT * FROM silver.crm_cust_info

-- duplicates and zeros
SELECT cst_id, 
	COUNT(*) AS nb_of_duplicates
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id =0

-- unwanted spaces
SELECT cst_firstname FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

-- Data normalization

SELECT DISTINCT cst_gndr from silver.crm_cust_info
SELECT DISTINCT cst_material_status from silver.crm_cust_info

--- 8 Rows have droped after the transformation


----------------------------------------------------
--   crm_prd_info
----------------------------------------------------

-- check duplicates and zeros
SELECT prd_id,
	Count(*) as Duplicates
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL


-- check unwanted spaces
SELECT *
FROM bronze.crm_prd_info
where prd_key != TRIM(prd_key)


SELECT *
FROM bronze.crm_prd_info
where prd_nm != TRIM(prd_nm)

SELECT *
FROM bronze.crm_prd_info
where prd_line != TRIM(prd_line)

SELECT DISTINCT prd_line FROM bronze.crm_prd_info

-- After transformation 

SELECT prd_cost From silver.crm_prd_info

SELECT DISTINCT prd_cost From silver.crm_prd_info


----------------------------------------------------
--   crm_sales_details
----------------------------------------------------

--- QUALITY CHECK 

SELECT * FROM bronze.crm_sales_details
SELECT * FROM silver.crm_cust_info
SELECT * FROM silver.crm_prd_info

SELECT * FROM bronze.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt

SELECT 
	sls_sales,
	sls_quantity,
	sls_price
FROM bronze.crm_sales_details
where sls_sales != sls_quantity * sls_price 
	OR sls_sales IS NULL OR sls_price IS NULL OR sls_quantity IS NULL
	OR sls_sales <0  OR sls_price < 0  OR sls_quantity < 0	

-- check for invalid date

-- for sls_order_dt
SELECT 
	NULLIF(sls_order_dt, 0 ) sls_order_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt <= 0 OR LEN(sls_order_dt) != 8 OR sls_order_dt > 20500101 OR sls_order_dt < 19000101

SELECT * FROM bronze.crm_sales_details
WHERE len(sls_order_dt) > 8

SELECT * FROM bronze.crm_sales_details
WHERE sls_cust_id NOT IN (SELECT cst_id FROM silver.crm_cust_info)

-- for sls_ship_dt

SELECT 
	NULLIF(sls_ship_dt, 0 ) sls_ship_dt
FROM bronze.crm_sales_details
WHERE sls_ship_dt <= 0 OR LEN(sls_ship_dt) != 8 OR sls_ship_dt > 20500101 OR sls_ship_dt < 19000101

SELECT * FROM bronze.crm_sales_details
WHERE len(sls_ship_dt) > 8

-- FOR sls_due_dt

SELECT 
	NULLIF(sls_due_dt, 0 ) sls_due_dt
FROM bronze.crm_sales_details
WHERE sls_due_dt <= 0 OR LEN(sls_due_dt) != 8 OR sls_due_dt > 20500101 OR sls_due_dt < 19000101

SELECT * FROM bronze.crm_sales_details
WHERE len(sls_due_dt) > 8

----------------------------------------------------
--   erp_cust_az12
----------------------------------------------------

SELECT * FROM bronze.erp_cust_az12
SELECT * FROM silver.crm_cust_info

SELECT cid FROM bronze.erp_cust_az12
WHERE cid IN (SELECT cst_key FROM silver.crm_cust_info)

SELECT DISTINCT gen FROM bronze.erp_cust_az12


-- testing 

SELECT DISTINCT gen, 
	CASE
		WHEN UPPER(TRIM(gen)) = ' ' THEN 'N/A'
		WHEN UPPER(TRIM(gen)) IN( 'F', 'FEMALE') THEN 'Female'
		WHEN UPPER(TRIM(gen)) IN ( 'M','MALE') THEN 'Male'
		WHEN UPPER(TRIM(gen)) IS NULL THEN 'N/A'
	ELSE gen
	END gen
FROM bronze.erp_cust_az12


----------------------------------------------------
--   erp_loc_a101
----------------------------------------------------

SELECT * FROM bronze.erp_loc_a101
SELECT * FROM silver.erp_cust_az12

SELECT cid FROM bronze.erp_loc_a101
WHERE cid not IN (SELECT cid FROM silver.erp_cust_az12)

----------------------------------------------------
--   erp_px_cat_g1v2
----------------------------------------------------

SELECT * FROM bronze.erp_px_cat_g1v2
SELECT * FROM silver.crm_prd_info


SELECT * FROM bronze.erp_px_cat_g1v2
WHERE id != TRIM(id)
