--KPI REQUIREMENTS:

-- Total Revenue
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;

-- Average Order Value
SELECT SUM(total_price)/COUNT(DISTINCT order_id) AS Average_Order_Value FROM pizza_sales;

-- Total Pizzas Sold
SELECT SUM(quantity) AS Total_Pizzas_Sold FROM pizza_sales;

-- Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales;

-- Average Pizzas Per Order (Method 1)
SELECT 
	   CAST(
	   CAST(SUM(quantity) AS DECIMAL(10,2)) /
	   CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) 
	   AS Avg_Pizzas_Per_Order 
FROM pizza_sales;
-- Average Pizzas Per Order (Simplified Method 2)
SELECT 
	   CAST(
	   CAST(SUM(quantity) AS DECIMAL(10,2)) /
	   COUNT(DISTINCT order_id) 
	   AS DECIMAL(10,2)) 
	   AS Avg_Pizzas_Per_Order 
FROM pizza_sales;

--CHART REQUIREMENTS:
SELECT * FROM pizza_sales;

--DAILY TREND
SELECT DATENAME(DW, order_date) AS Order_Day, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date);

--HOURLY TREND
SELECT DATEPART(HOUR, order_time) AS Order_Hours, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY Order_Hours;

--PERCENTAGE OF SALES BY PIZZA CATEGORY
SELECT 
	pizza_category, 
	SUM(total_price) AS total_sales,
	SUM(total_price) * 100/(SELECT SUM(total_price) FROM pizza_sales) AS sales_percentage 
FROM pizza_sales
GROUP BY pizza_category;

--PERCENTAGE OF SALES BY PIZZA SIZE 
SELECT 
	pizza_size, 
	SUM(total_price) AS total_sales,
	ROUND(SUM(total_price) * 100/(SELECT SUM(total_price) FROM pizza_sales),2) AS sales_percentage 
FROM pizza_sales
GROUP BY pizza_size;

--TOTAL PIZZAS SOLD BY PIZZA CATEGORY
SELECT pizza_category, SUM(quantity) AS total_pizzas_sold
FROM pizza_sales
GROUP BY pizza_category;

-- TOP 5 BEST SELLERS BY TOTAL PIZZAS SOLD
SELECT TOP 5 pizza_name, SUM(quantity) AS pizzas_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY pizzas_sold DESC;

-- BOTTOM 5 SELLERS BY TOTAL PIZZAS SOLD
SELECT TOP 5 pizza_name, SUM(quantity) AS pizzas_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY pizzas_sold;
