-- EXPLORE THE DATA
select * from superstore_file.sales;
select 
    *
FROM
    superstore_file.sales
WHERE
    `Order Priority` IS NULL
	OR `Discount` IS NULL
	OR `Customer Name` IS NULL
	OR `Product Name` IS NULL;
    
UPDATE superstore_file.sales
SET `Order Date`= STR_TO_DATE(`Order Date`, '%m/%d/%Y'),
    `Ship Date` = STR_TO_DATE(`Ship Date`, '%m/%d/%Y');

-- CLEANING DATA

-- Changing Data Types

ALTER TABLE superstore_file.sales
MODIFY COLUMN `Postal Code` VARCHAR(10);

-- Removing Duplicates

SELECT `Row ID`, COUNT(*) 
FROM superstore_file.sales
GROUP BY `Row ID`
HAVING COUNT(*) > 1;

-- Standardizing Text Fields

select `Order Priority` 
from superstore_file.sales
where  `Order Priority` = TRIM(LOWER(`Order Priority`));

select `Ship Mode` 
from superstore_file.sales
where `Ship Mode`  = TRIM(LOWER(`Ship Mode`));

-- Removing Anomalous Data

SELECT * FROM superstore_file.sales
WHERE Profit < 0 OR Sales < 0 OR `Quantity ordered new` < 0;

--- NULL VALUES

-- NULL OR BLANK VALUES

select * 
from superstore_file.sales 
where `Ship Mode` is null;