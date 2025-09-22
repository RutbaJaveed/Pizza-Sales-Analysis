# Pizza Sales Analysis

## Project Overview
A data analysis project using SQL and Excel. Extracted KPIs and business insights from the pizza sales dataset through SQL queries, validated results, and built an interactive Excel dashboard to visualize sales trends, category/size performance, and best/worst sellers.

## Objectives

1. Extract key KPIs: total revenue, average order value, total pizzas sold, total orders, average pizzas per order.

2. Analyze daily and hourly sales trends.

3. Explore sales contribution by pizza category and size.

4. Identify best and worst selling pizzas.

5. Build an Excel dashboard for interactive visualization.

## Tools & Technologies

1. SQL – Data extraction and KPI calculation

2. Excel – Pivot tables, charts, and dashboard design

## Dataset

Pizza Sales Dataset on Kaggle (https://www.kaggle.com/datasets/nextmillionaire/pizza-sales-dataset)

## SQL Queries
KPI Requirements:

-- Total Revenue

SELECT SUM(total_price) AS Total_Revenue 
FROM pizza_sales;

-- Average Order Value

SELECT SUM(total_price)/COUNT(DISTINCT order_id) AS Average_Order_Value 
FROM pizza_sales;

-- Total Pizzas Sold

SELECT SUM(quantity) AS Total_Pizzas_Sold 
FROM pizza_sales;

-- Total Orders

SELECT COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales;

-- Average Pizzas Per Order (Method 1)

SELECT 
   CAST(
       CAST(SUM(quantity) AS DECIMAL(10,2)) /
       CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) 
   AS DECIMAL(10,2)) AS Avg_Pizzas_Per_Order
FROM pizza_sales;

-- Average Pizzas Per Order (Simplified Method 2)

SELECT 
   CAST(SUM(quantity) * 1.0 / COUNT(DISTINCT order_id) AS DECIMAL(10,2)) 
   AS Avg_Pizzas_Per_Order
FROM pizza_sales;

Chart Requirements:

-- View Dataset

SELECT * FROM pizza_sales;

-- Daily Trend of Orders

SELECT DATENAME(DW, order_date) AS Order_Day, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date);

-- Hourly Trend of Orders

SELECT DATEPART(HOUR, order_time) AS Order_Hours, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY Order_Hours;

-- Percentage of Sales by Pizza Category

SELECT 
    pizza_category, 
    SUM(total_price) AS total_sales,
    SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS sales_percentage 
FROM pizza_sales
GROUP BY pizza_category;

-- Percentage of Sales by Pizza Size

SELECT 
    pizza_size, 
    SUM(total_price) AS total_sales,
    ROUND(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales),2) AS sales_percentage 
FROM pizza_sales
GROUP BY pizza_size;

-- Total Pizzas Sold by Pizza Category

SELECT pizza_category, SUM(quantity) AS total_pizzas_sold
FROM pizza_sales
GROUP BY pizza_category;

-- Top 5 Best Sellers by Pizzas Sold

SELECT TOP 5 pizza_name, SUM(quantity) AS pizzas_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY pizzas_sold DESC;

-- Bottom 5 Sellers by Pizzas Sold

SELECT TOP 5 pizza_name, SUM(quantity) AS pizzas_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY pizzas_sold ASC;

## Project Workflow

SQL Analysis → Extracted KPIs and generated sales insights.

Excel Validation → Cross-checked SQL results in Excel.

Dashboard Creation → Designed an interactive dashboard with KPIs, trends, category/size performance, and best/worst sellers.

## Dashboard Preview

<img width="1315" height="760" alt="Dashboard_ss" src="https://github.com/user-attachments/assets/bd00b75f-65e2-4651-8872-04bd84323391" />

