--IMPORT DATA FROM CSV--
--IMPORT DATA IN CUSTOMERS TABLE
COPY CUSTOMERS(CUSTOMER_ID, CUSTOMER_UNIQUE_ID, CUSTOMER_ZIP_CODE_PREFIX, CUSTOMER_CITY, CUSTOMER_STATE)
FROM 'C:\Users\suraj\OneDrive\Dokumen\Data Analyst\E-Commerce Sales Analysis project\customers_dataset.csv'
CSV HEADER;

--IMPORT DATA IN ORDERS TABLE
COPY ORDERS(ORDER_ID, CUSTOMER_ID, ORDER_STATUS, ORDER_PURCHASE_TIMESTAMP, ORDER_APPROVED_AT, ORDER_DELIVERED_CARRIER_DATE,
			ORDER_DELIVERED_CUSTOMER_DATE, ORDER_ESTIMATED_DELIVERY_DATE)
FROM 'C:\Users\suraj\OneDrive\Dokumen\Data Analyst\E-Commerce Sales Analysis project\orders_dataset.csv'
CSV HEADER;

--IMPORT DATA IN ORDER_ITEMS TABLE
COPY ORDER_ITEMS(ORDER_ID, ORDER_ITEM_ID, PRODUCT_ID, PRICE, FREIGHT_VALUE)
FROM 'C:\Users\suraj\OneDrive\Dokumen\Data Analyst\E-Commerce Sales Analysis project\order_items_dataset.csv'
CSV HEADER;

--IMPORT DATA IN PRODUCTS TABLE
COPY PRODUCTS(PRODUCT_ID, PRODUCT_CATEGORY_NAME)
FROM 'C:\Users\suraj\OneDrive\Dokumen\Data Analyst\E-Commerce Sales Analysis project\products_dataset.csv'
CSV HEADER;

--IMPORT DATA IN PAYMENTS TABLE
COPY PAYMENTS(order_id, payment_type, payment_installments, payment_value)
FROM 'C:\Users\suraj\OneDrive\Dokumen\Data Analyst\E-Commerce Sales Analysis project\payments_dataset.csv'
CSV HEADER;

--DISPLAY TABLES
SELECT * FROM CUSTOMERS;
SELECT * FROM ORDERS;
SELECT * FROM ORDER_ITEMS;
SELECT * FROM PRODUCTS;
SELECT * FROM PAYMENTS;

