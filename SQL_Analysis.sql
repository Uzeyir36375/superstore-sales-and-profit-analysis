CREATE DATABASE sales_analysis;
USE sales_analysis;
SELECT * FROM superstore LIMIT 10;

-- The dataset has an order date column. 
-- We can use this column to create new columns like order month, order year, and order day, which will be very valuable 
-- for sales and profit analysis according to time periods. So let’s add these columns:

-- Convert 'Order Date' and 'Ship Date' columns to datetime
UPDATE superstore
SET `Order Date` = STR_TO_DATE(`Order Date`, '%m/%d/%Y'),
    `Ship Date` = STR_TO_DATE(`Ship Date`, '%m/%d/%Y');

-- Add 'Order Month' and 'Order Year' columns
ALTER TABLE superstore
ADD COLUMN `Order Month` INT,
ADD COLUMN `Order Year` INT;

-- Update 'Order Month' and 'Order Year' based on 'Order Date'
UPDATE superstore
SET `Order Month` = MONTH(`Order Date`),
    `Order Year` = YEAR(`Order Date`);

-- Add 'Order Day of Week' column
ALTER TABLE superstore
ADD COLUMN `Order Day of Week` INT;

-- Update 'Order Day of Week' based on 'Order Date'
UPDATE superstore
SET `Order Day of Week` = DAYOFWEEK(`Order Date`);

-- Let's see if our changes have occurred successfully
SELECT * FROM superstore limit 5;

-- Now let’s have a look at the monthly sales
SELECT `Order Month`, SUM(`Sales`) AS monthly_sales
FROM superstore
GROUP BY `Order Month`;

-- Now let’s have a look at the sales by category:
SELECT 	`Category`, SUM(`Sales`) AS sales_by_category
FROM superstore
GROUP BY `Category`;

-- Now let’s have a look at the sales by sub-category:
SELECT `Sub-Category`, SUM(`Sales`) AS sales_by_sub_category
FROM superstore
GROUP BY `Sub-Category`;

-- Now let’s have a look at the monthly profits:
SELECT `Order Month`, SUM(`Profit`) AS monthly_profit
FROM superstore
GROUP BY `Order Month`;

-- Now let’s have a look at the profit by category:
SELECT `Category`, SUM(`Profit`) AS profit_by_category
FROM superstore
GROUP BY `Category`;

-- Now let’s have a look at the profit by sub-category:
SELECT `Sub-Category`, SUM(`Profit`) AS profit_by_sub_category
FROM superstore
GROUP BY `Sub-Category`;

-- Now let’s have a look at the sales and profit analysis by customer segments:
SELECT `Segment` , SUM(`Sales`) AS total_sales, SUM(`Profit`) AS total_profit
FROM superstore
GROUP BY `Segment`;









