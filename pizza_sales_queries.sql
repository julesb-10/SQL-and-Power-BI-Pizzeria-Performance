-- Data imported using PostgreSQL's import tool

-- Converting order_date to a proper date column instead of VARCHAR

ALTER TABLE pizza_sales
ALTER COLUMN order_date TYPE DATE
USING TO_DATE(order_date, 'DD-MM-YYYY');



-- 1. Total Revenue:
SELECT SUM(total_price) as total_revenue FROM pizza_sales;




-- 2. Average Order Value:
WITH order_values AS (SELECT order_id, SUM(total_price) AS order_value 
					  FROM pizza_sales
					  GROUP BY order_id)
SELECT AVG(order_value) as avg_order_value FROM order_values;


-- ALTERNATIVELY:


SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS avg_order_value
FROM pizza_sales;




-- 3. Total Pizzas Sold
SELECT SUM(quantity) AS total_pizzas_sold FROM pizza_sales;




-- 4. Total Orders Placed
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales;




-- 5. Average Pizzas Per Order
WITH order_quants AS (SELECT order_id, SUM(quantity) AS order_quantity 
					  FROM pizza_sales
					  GROUP BY order_id)
SELECT AVG(order_quantity) as avg_pizzas_per_order 
FROM order_quants;


--ALTERNATIVELY:


SELECT (SUM(quantity) * 1.0 / COUNT(DISTINCT order_id)) AS avg_pizzas_per_order
FROM pizza_sales;






--TREND QUERIES & MORE (daily total orders trend, hourly total orders trend, % of sales by pizza category, etc.)


-- Daily orders trend:
SELECT TO_CHAR(order_date, 'Day') AS day_name,
	   COUNT(DISTINCT order_id) as total_orders
FROM pizza_sales
GROUP BY day_name
ORDER BY MIN(order_date);




-- Hourly Orders Trend
SELECT EXTRACT (HOUR FROM order_time) as hour_of_day,
	   COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY hour_of_day
ORDER BY hour_of_day;




-- Monthly Orders Trend
SELECT TO_CHAR(order_date, 'Month') AS month_name,
	   COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY month_name
ORDER BY MIN(order_date);




-- Percentage of Sales by Category
SELECT pizza_category, 
	   SUM(total_price) AS total_sales,
	   ROUND((SUM(total_price) / (SELECT SUM(total_price) FROM pizza_sales WHERE EXTRACT(MONTH FROM order_date) = 1)) * 100, 2) AS percent_contribution	   
FROM pizza_sales
WHERE EXTRACT(MONTH FROM order_date) = 1 
GROUP BY pizza_category;




-- Percentage of Sales by Pizza Size
SELECT pizza_size, SUM(total_price) AS total_sales,
	   ROUND(SUM(total_price) / (SELECT SUM(total_price) FROM pizza_sales) * 100, 2) AS percent_contribution
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;




-- Total Pizzas Sold by Category
SELECT pizza_category, 
	   SUM(quantity) AS pizzas_sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY pizzas_sold DESC;




-- Top 5 Best Sellers by Total Pizzas Sold
SELECT pizza_name,
	   SUM(quantity) AS total_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_sold DESC
LIMIT 5;
-- Decent solution but doesn't allow for ties


-- ALTERNATIVELY (Allowing for ties):


WITH orders_by_name AS (SELECT pizza_name, SUM(quantity) AS quantity_sold
						FROM pizza_sales
						GROUP BY pizza_name)
SELECT pizza_name, 
	   quantity_sold,
	   ROW_NUMBER() OVER (ORDER BY quantity_sold DESC) AS orders_rank
FROM orders_by_name;


--COMBINING INTO CTE AND FILTERING OFF OF THAT:


WITH quant_sold_rankings AS	(SELECT pizza_name, SUM(quantity) AS total_sold,
								    RANK() OVER(ORDER BY SUM(quantity) DESC) AS ranking
							 FROM pizza_sales
							 GROUP BY pizza_name)
SELECT * FROM quant_sold_rankings
WHERE ranking <= 5;

-- NOTE: Could use DENSE_RANK() depending on how we want rankings to progress after a tie,
-- and ROW_NUMBER() if we don't want to take ties into account, but still use a window 
-- function that we can filter off of




-- Top 5 Best Sellers by Revenue
WITH revenue_rank AS (SELECT pizza_name,
						     SUM(total_price) AS total_revenue,
						     RANK() OVER(ORDER BY SUM(total_price) DESC) AS revenue_ranking	   
					  FROM pizza_sales
					  GROUP BY pizza_name)
SELECT *
FROM revenue_rank
WHERE revenue_ranking <= 5;




-- Bottom 5 Worst Sellers by Total Pizzas Sold
WITH quant_sold_rankings AS	(SELECT pizza_name, SUM(quantity) AS total_sold,
								    RANK() OVER(ORDER BY SUM(quantity)) AS ranking
							 FROM pizza_sales
							 GROUP BY pizza_name)
SELECT * FROM quant_sold_rankings
WHERE ranking <= 5;




-- Bottom 5 Worst Sellers by Revenue
WITH revenue_rank AS (SELECT pizza_name,
						     SUM(total_price) AS total_revenue,
						     RANK() OVER(ORDER BY SUM(total_price)) AS revenue_ranking	   
					  FROM pizza_sales
					  GROUP BY pizza_name)
SELECT *
FROM revenue_rank
WHERE revenue_ranking <= 5;
