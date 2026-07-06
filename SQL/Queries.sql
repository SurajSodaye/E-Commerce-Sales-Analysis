--Querries
--Basic SQL Queries

--1. Total Number of Customers
SELECT COUNT(*) AS Total_Customers
FROM CUSTOMERS;

--2. Total Number of Orders
SELECT COUNT(*) AS Total_Orders
FROM ORDERS;

--3. List All Product Categories
SELECT DISTINCT product_category_name
FROM PRODUCTS
ORDER BY product_category_name;

--4. Total Revenue
SELECT SUM(payment_value) AS Total_Revenue
FROM PAYMENTS;

--5. Count OF Orders by Status
SELECT order_status, COUNT(*) AS Total_Orders
FROM ORDERS
GROUP BY order_status
ORDER BY Total_Orders;

--Moderate SQL Queries
--1. Top 10 Customers by Number of Orders
SELECT c.customer_unique_id, COUNT(o.order_id) AS Total_Orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id
ORDER BY Total_Orders DESC LIMIT 10;

--2. Top 10 Cities by Number of Customers
SELECT customer_city, COUNT(*) AS Total_Customers
FROM Customers
GROUP BY customer_city
ORDER BY Total_Customers DESC LIMIT 10;

--3. Revenue by States
SELECT c.customer_state, COUNT(DISTINCT o.order_id) AS total_orders, SUM(p.payment_value) AS Revenue_Statewise
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id

JOIN payments p
ON o.order_id = p.order_id

GROUP BY c.customer_state
ORDER BY Revenue_Statewise DESC;

--4. Revenue by Product Category
SELECT p.product_category_name, SUM(oi.price) AS Total_Revenue
FROM Products p
JOIN Order_Items oi
ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY Total_Revenue;

--5. Top 10 Most Expensive Products Sold
SELECT product_id, MAX(price) AS Highest_Price
FROM order_items
GROUP BY product_id
ORDER BY Highest_Price DESC LIMIT 10;

--Advanced Queries
--1. Rank Customers by Total Spending
SELECT c.customer_id, SUM(py.payment_value) AS Total_Spending,
RANK() OVER(
ORDER BY SUM(py.payment_value) DESC) AS Customer_Rank
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id

JOIN payments py
ON o.order_id = py.order_id

GROUP BY c.customer_id
ORDER BY Customer_Rank;

--2. Customer Segmentation Using CASE
SELECT c.customer_unique_id , SUM(p.payment_value) AS Total_Spent,
CASE
WHEN SUM(p.payment_value)>=10000 THEN 'Premium Customer'
WHEN SUM(p.payment_value)<10000 AND SUM(p.payment_value)>=5000 THEN 'Gold Customer'
WHEN SUM(p.payment_value)<5000 AND SUM(p.payment_value)>=1000 THEN 'Silver Customer'
ELSE 'Regular Customer'
END AS Customer_Segment

FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id

JOIN payments p
ON o.order_id=p.order_id

GROUP BY c.customer_unique_id

ORDER BY Total_Spent DESC;

--3. Monthly Revenue (CTE)
WITH Monthly_Revenue AS(
	SELECT  DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
			ROUND(SUM(p.payment_value),2) AS Revenue
	FROM orders o
	JOIN payments p
		ON o.order_id = p.order_id
	GROUP BY DATE_TRUNC('month', o.order_purchase_timestamp) 
)

SELECT * FROM Monthly_Revenue
ORDER BY month;

--4. Top 3 Products in Each Category
WITH Product_Revenue AS
(
    SELECT
        p.product_category_name,
        oi.product_id,
        ROUND(SUM(oi.price),2) AS revenue,

        DENSE_RANK() OVER (
            PARTITION BY p.product_category_name
            ORDER BY SUM(oi.price) DESC
        ) AS product_rank

    FROM products p
	JOIN order_items oi
    ON p.product_id = oi.product_id

    GROUP BY p.product_category_name, oi.product_id
)

SELECT * FROM Product_Revenue
WHERE product_rank <= 3
ORDER BY product_category_name, product_rank;