-- EDA OF SUPERSTORE_FILE

-- TOTAL SALES AND TOTAL PROFIT
SELECT *
FROM superstore_file.sales;

SELECT sum(sales)AS total_sales,
       sum(Profit) AS total_profit
FROM superstore_file.sales;

-- SALES AND PROFIT BY PRODUCT CATEGORY

select `product category`,
sum(sales) as total_sales,
sum(Profit) as total_profit
from superstore_file.sales
group by `product category`
order by total_sales desc;

-- Top 10 Best-Selling Products

select * from superstore_file.sales;
select `product name`,
sum(sales) as total_sales
from superstore_file.sales
group by `product name`
order by total_sales desc
limit 10 ;

-- Profit Margin per Product

SELECT `product name`, 
       ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin
FROM superstore_file.sales
GROUP BY `product name`
ORDER BY profit_margin DESC
LIMIT 10;

-- Top 10 Customers by Sales

SELECT `customer name`, 
       SUM(sales) AS total_sales, 
       SUM(profit) AS total_profit
FROM superstore_file.sales
GROUP BY `customer name`
ORDER BY total_sales DESC
LIMIT 10;

-- Order Frequency Analysis

select * from superstore_file.sales;

SELECT `customer ID`,
       count(`order id`) AS total_orders
FROM superstore_file.sales
GROUP BY `Customer ID`
ORDER BY total_orders DESC
LIMIT 10;

-- Sales Contribution by Customer Segment

SELECT `customer segment`, 
       SUM(sales) AS total_sales, 
       SUM(profit) AS total_profit
FROM superstore_file.sales
GROUP BY `customer segment`;

-- Monthly Sales Trend

SELECT date_format(`order date`, '%Y-%m') AS MONTH,
       sum(sales) AS total_sales
from superstore_file.sales
GROUP BY MONTH
ORDER BY MONTH;

-- Yearly Sales Growth

select year(`order date`) as year,
		SUM(sales) AS total_sales, 
		SUM(profit) AS total_profit
FROM superstore_file.sales
GROUP BY year
ORDER BY year;

-- Days Between Order and Shipping

SELECT avg(datediff(`ship date`, `order date`)) AS avg_shipping_time
FROM superstore_file.sales;

-- Return Rate by Category

SELECT `product category`, 
       COUNT(CASE WHEN `return status` = 'Returned' THEN 1 END) * 100.0 / COUNT(*) AS return_rate
FROM superstore_file.sales
GROUP BY `product category`
ORDER BY return_rate DESC;

-- Impact of Discounts on Profit

SELECT 
    CASE 
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount BETWEEN 0.01 AND 0.10 THEN 'Low Discount (1-10%)'
        WHEN discount BETWEEN 0.11 AND 0.25 THEN 'Medium Discount (11-25%)'
        ELSE 'High Discount (26%+)'
    END AS discount_category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM superstore_file.sales
GROUP BY discount_category
ORDER BY discount_category;

-- check for duplicate orders
SELECT `Order ID`, 
		COUNT(*) FROM superstore_file.sales 
        GROUP BY `Order ID` HAVING COUNT(*) > 1;
        
-- Sales by Shipping Mode

SELECT `ship mode`, 
       SUM(sales) AS total_sales, 
       COUNT(`order id`) AS total_orders
FROM superstore_file.sales
GROUP BY `ship mode`;


