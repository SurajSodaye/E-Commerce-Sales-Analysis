--Check Rows Count
SELECT COUNT(*) AS Total_Customers FROM Customers;
SELECT COUNT(*) AS Total_orders FROM Orders;
SELECT COUNT(*) AS Total_items FROM order_items;
SELECT COUNT(*) AS Total_products FROM products;
SELECT COUNT(*) AS Total_payments FROM payments;

--Check Duplicate Records
SELECT customer_id,
COUNT(*) FROM customers
GROUP BY customer_id
HAVING COUNT(*)>1;

SELECT order_id,
COUNT(*) FROM orders
GROUP BY order_id
HAVING COUNT(*)>1;

SELECT product_id,
COUNT(*) FROM products
GROUP BY product_id
HAVING COUNT(*)>1;

SELECT order_id, payment_type, payment_value,
COUNT(*) FROM payments
GROUP BY order_id, payment_type, payment_value
HAVING COUNT(*)>1;

--Check NULL Values
SELECT * FROM Customers
WHERE Customer_zip_code_prefix IS NULL 
OR Customer_city IS NULL 
OR Customer_State IS NULL;

SELECT * FROM Orders
WHERE order_delivered_customer_date IS NULL;

SELECT * FROM Products
WHERE Product_category_name IS NULL;

--UPDATE NULL VALUE FROM PRODUCT 
UPDATE Products
SET product_category_name = 'Unknown'
WHERE product_category_name IS NULL;

SELECT * FROM payments
WHERE payment_type IS NULL
OR payment_value IS NULL;

--Check Blank Values
SELECT * FROM Products 
WHERE TRIM(Product_category_name)='';

--Check Invalid Values
SELECT * FROM order_items
WHERE price<0
OR freight_value<0
OR price=0;

SELECT * FROM Payments
WHERE payment_value<0;

--Check Date Consistency
--Purchase date shouldn't be after delivery date
SELECT *
FROM orders
WHERE order_purchase_timestamp > order_delivered_customer_date;

--Estimated delivery shouldn't be before purchase.
SELECT *
FROM orders
WHERE order_estimated_delivery_date < order_purchase_timestamp;

--Orders without Customers
SELECT o.order_id 
FROM orders o
LEFT JOIN customers c
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

--Order Items without Products
SELECT oi.order_id
FROM order_items oi
LEFT JOIN products pr
ON oi.product_id = pr.product_id
WHERE pr.product_id IS NULL;

