-- Sunrise Supermarket DB 
-- Oracle SQL Syntax
-- ISHIMWE UWASE Diane(20252SEN154)


-- TABLE CREATION --

CREATE TABLE customers (
  customer_id NUMBER PRIMARY KEY,
  customer_name VARCHAR2(100),
  email VARCHAR2(100),
  city VARCHAR2(50)
);

CREATE TABLE products (
  product_id NUMBER PRIMARY KEY,
  product_name VARCHAR2(100),
  category VARCHAR2(50),
  price NUMBER(12,2)
);

CREATE TABLE orders (
  order_id NUMBER PRIMARY KEY,
  customer_id NUMBER REFERENCES customers(customer_id),
  order_date DATE
);

CREATE TABLE order_items (
  order_item_id NUMBER PRIMARY KEY,
  order_id NUMBER REFERENCES orders(order_id),
  product_id NUMBER REFERENCES products(product_id),
  quantity NUMBER
);


-- DATA INSERTION --

-- Customers: At least 5 records (Inserted 6 to demonstrate LEFT JOIN)
INSERT INTO customers (customer_id, customer_name, email, city) VALUES (1, 'Alice Ishimwe', 'alice@test.com', 'Kigali');
INSERT INTO customers (customer_id, customer_name, email, city) VALUES (2, 'Jones Mugisha', 'bob@test.com', 'Gisenyi');
INSERT INTO customers (customer_id, customer_name, email, city) VALUES (3, 'Charlie Keza', 'charlie@test.com', 'Kigali');
INSERT INTO customers (customer_id, customer_name, email, city) VALUES (4, 'Claire Usanase', 'diana@test.com', 'Musanze');
INSERT INTO customers (customer_id, customer_name, email, city) VALUES (5, 'Evan Manzi', 'evan@test.com', 'Butare');
INSERT INTO customers (customer_id, customer_name, email, city) VALUES (6, 'Frank Kimanyi', 'frank@test.com', 'Kigali');

-- Products: At least 8 records across 3 distinct categories (Electronics, Groceries, Home Goods)
INSERT INTO products (product_id, product_name, category, price) VALUES (1, 'Laptop', 'Electronics', 800000.00);
INSERT INTO products (product_id, product_name, category, price) VALUES (2, 'Smartphone', 'Electronics', 60000.00);
INSERT INTO products (product_id, product_name, category, price) VALUES (3, 'Apples', 'Groceries', 800.00);
INSERT INTO products (product_id, product_name, category, price) VALUES (4, 'Bread', 'Groceries', 1300.00);
INSERT INTO products (product_id, product_name, category, price) VALUES (5, 'Milk', 'Groceries', 900.00);
INSERT INTO products (product_id, product_name, category, price) VALUES (6, 'Coffee Maker', 'Home Goods', 45000.00);
INSERT INTO products (product_id, product_name, category, price) VALUES (7, 'Blender', 'Home Goods', 30000.00);
INSERT INTO products (product_id, product_name, category, price) VALUES (8, 'Headphones', 'Electronics', 15000.00);

-- Orders: At least 15 records on multiple different dates (All 2026)
INSERT INTO orders (order_id, customer_id, order_date) VALUES (1, 1, DATE '2026-01-01');
INSERT INTO orders (order_id, customer_id, order_date) VALUES (2, 2, DATE '2026-01-05');
INSERT INTO orders (order_id, customer_id, order_date) VALUES (3, 3, DATE '2026-01-10');
INSERT INTO orders (order_id, customer_id, order_date) VALUES (4, 4, DATE '2026-01-15');
INSERT INTO orders (order_id, customer_id, order_date) VALUES (5, 5, DATE '2026-01-20');
INSERT INTO orders (order_id, customer_id, order_date) VALUES (6, 1, DATE '2026-01-25');
INSERT INTO orders (order_id, customer_id, order_date) VALUES (7, 2, DATE '2026-02-01');
INSERT INTO orders (order_id, customer_id, order_date) VALUES (8, 3, DATE '2026-02-05');
INSERT INTO orders (order_id, customer_id, order_date) VALUES (9, 4, DATE '2026-02-10');
INSERT INTO orders (order_id, customer_id, order_date) VALUES (10, 5, DATE '2026-02-15');
INSERT INTO orders (order_id, customer_id, order_date) VALUES (11, 1, DATE '2026-02-20');
INSERT INTO orders (order_id, customer_id, order_date) VALUES (12, 2, DATE '2026-02-25');
INSERT INTO orders (order_id, customer_id, order_date) VALUES (13, 3, DATE '2026-03-01');
INSERT INTO orders (order_id, customer_id, order_date) VALUES (14, 4, DATE '2026-03-05');
INSERT INTO orders (order_id, customer_id, order_date) VALUES (15, 5, DATE '2026-03-10');

-- Order Items: At least 25 records (Inserted 29) linking orders to products
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (1, 1, 1, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (2, 1, 8, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (3, 1, 4, 2);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (4, 1, 5, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (5, 2, 4, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (6, 2, 5, 2);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (7, 2, 3, 3);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (8, 3, 2, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (9, 3, 8, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (10, 4, 6, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (11, 4, 3, 5);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (12, 4, 5, 2);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (13, 4, 4, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (14, 5, 7, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (15, 5, 3, 4);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (16, 6, 8, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (17, 6, 4, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (18, 7, 3, 5);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (19, 7, 5, 2);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (20, 8, 8, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (21, 8, 6, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (22, 9, 5, 3);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (23, 10, 4, 2);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (24, 10, 3, 3);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (25, 11, 6, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (26, 12, 2, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (27, 13, 3, 6);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (28, 14, 7, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (29, 15, 1, 1);



-- 1. Customer Orders (INNER JOIN)
SELECT o.order_id, c.customer_name, c.city, o.order_date
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

-- 2. Order Item Details (JOIN)
SELECT oi.order_item_id, p.product_name, p.category, p.price, oi.quantity
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;

-- 3. All Customers and their Orders (LEFT JOIN)
SELECT c.customer_name, c.email, o.order_id, o.order_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- 4. Above Average Spenders (CTE)
WITH customer_spend AS (
    SELECT c.customer_id, c.customer_name, SUM(oi.quantity * p.price) AS total_spent
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT customer_name, total_spent
FROM customer_spend
WHERE total_spent > (SELECT AVG(total_spent) FROM customer_spend);

-- 5. Rank Customers by Spend (Window Function)
SELECT c.customer_name, SUM(oi.quantity * p.price) AS total_spent,
RANK() OVER (ORDER BY SUM(oi.quantity * p.price) DESC) as rank
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name;

-- 6. Numbering Customer Orders
SELECT customer_id, order_id, order_date,
ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) as order_number
FROM orders;

-- 7. Running Total of Revenue
WITH daily_revenue_cte AS (
    SELECT o.order_date, SUM(oi.quantity * p.price) AS daily_revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY o.order_date
)
SELECT order_date, daily_revenue,
SUM(daily_revenue) OVER (ORDER BY order_date) as cumulative_revenue
FROM daily_revenue_cte;

-- 8. Days Between Orders
WITH lag_orders AS (
    SELECT customer_id, order_id, order_date,
    LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) as previous_date
    FROM orders
)
SELECT customer_id, order_id, order_date,
(order_date - previous_date) AS days_passed
FROM lag_orders
WHERE previous_date IS NOT NULL;
