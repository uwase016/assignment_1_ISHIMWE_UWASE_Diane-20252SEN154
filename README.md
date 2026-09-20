# PLSQL Assignment One: Sunrise Supermarket

## Student Information
**Name:** ISHIMWE UWASE Diane  
**Student ID:** 20252SEN154
**Database Used:** Oracle Database  

## Business Scenario Summary
Sunrise Supermarket is tracking customer purchasing behavior, popular product categories, and overall revenue trends over time. By utilizing SQL queries to combine and analyze order data, management can gain actionable insights into which product categories (like Electronics, Groceries, and Home Goods) are the most profitable and identify their most loyal, high-spending customers.

## Queries & Explanations

### 1. Customer Orders
```sql
SELECT o.order_id, c.customer_name, c.city, o.order_date
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;
```
**Explanation:** This query links orders to the customers who placed them using an inner join, allowing us to see exactly who bought what and their location.

### 2. Order Item Details
```sql
SELECT oi.order_item_id, p.product_name, p.category, p.price, oi.quantity
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;
```
**Explanation:** This query maps the raw order item IDs to the actual product names, categories, and prices, showing the exact contents and value of each line item.

### 3. All Customers and their Orders
```sql
SELECT c.customer_name, c.email, o.order_id, o.order_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;
```
**Explanation:** By using a LEFT JOIN, this query retrieves all registered customers in the system and displays their order history, intentionally preserving customers with zero orders (resulting in NULL values) so we can target them for first-purchase promotions.

### 4. Above Average Spenders
```sql
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
```
**Explanation:** This uses a Common Table Expression (CTE) to calculate the lifetime spend of each customer, and the main query filters that list to isolate the VIP customers who spend strictly more than the overall store average.

### 5. Rank Customers by Spend
```sql
SELECT c.customer_name, SUM(oi.quantity * p.price) AS total_spent,
RANK() OVER (ORDER BY SUM(oi.quantity * p.price) DESC) as rank
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name;
```
**Explanation:** This query utilizes the `RANK()` window function to order customers based on their total revenue contribution, giving our top spenders the highest rank.

### 6. Numbering Customer Orders
```sql
SELECT customer_id, order_id, order_date,
ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) as order_number
FROM orders;
```
**Explanation:** This applies the `ROW_NUMBER()` window function to assign sequential, chronological numbers to each order grouped by the specific customer.

### 7. Running Total of Revenue
```sql
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
```
**Explanation:** This query tracks the cumulative revenue growth of the supermarket over time by calculating daily revenue in a CTE and applying a rolling sum window function.

### 8. Days Between Orders
```sql
WITH lag_orders AS (
    SELECT customer_id, order_id, order_date,
    LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) as previous_date
    FROM orders
)
SELECT customer_id, order_id, order_date,
(order_date - previous_date) AS days_passed
FROM lag_orders
WHERE previous_date IS NOT NULL;
```
**Explanation:** Using the `LAG()` function, we retrieve a customer's previous order date on the same row as their current order, allowing us to subtract them and see the exact number of days passed between store visits.

## Screenshots/Results
<img width="1917" height="1077" alt="Q1" src="https://github.com/user-attachments/assets/200fb559-61b6-4f39-aa70-c7b5203f51ec" />
<img width="1917" height="1197" alt="Q2" src="https://github.com/user-attachments/assets/e0348215-3b99-45e0-9dc1-74a0fc1a6ba6" />
<img width="1917" height="1101" alt="Q3" src="https://github.com/user-attachments/assets/58e46e80-d50d-4fe7-a7b2-1d197e29b8be" />
<img width="1917" height="1057" alt="Q4" src="https://github.com/user-attachments/assets/759c4a23-92fd-40e5-b72d-b069c4001977" />
<img width="1917" height="922" alt="Q5" src="https://github.com/user-attachments/assets/91c885d3-a4f1-45f8-b36f-07ec659e7af6" />
<img width="1917" height="1062" alt="Q6" src="https://github.com/user-attachments/assets/df03e37e-a602-414a-93e3-bd030a9aee01" />
<img width="1917" height="1065" alt="Q7" src="https://github.com/user-attachments/assets/f9ba3b34-3ca2-4d04-96c3-eb4c4984d119" />
<img width="1917" height="1057" alt="Q8" src="https://github.com/user-attachments/assets/e15e1ea9-1fe5-4e2a-a78d-f8fee6b5f9bd" />

## Business Interpretation
Based on our data analysis, it is clear that the **Electronics** category (Laptops, Smartphones, Headphones) is the primary engine driving our revenue, pushing our top spenders like Alice Ishimwe and Evan Manzi to the top of our ranks. Meanwhile, **Groceries** act as high-frequency, low-ticket purchases that bring customers back into the store. The running total reveals consistent and healthy revenue growth across the quarter, characterized by steady daily sales with massive spikes whenever an electronics purchase occurs. 

## Challenges Resolved
I encountered two main hurdles while writing these queries. First, calculating the CTE for the average spend (Query 4) required carefully executing four-way joins (`customers`, `orders`, `order_items`, `products`) inside the CTE to get accurate groupings before using the aggregate `AVG()` function in the main `WHERE` clause. Secondly, formatting the date math for the `LAG` function (Query 8) was tricky; I had to ensure I partitioned it strictly by `customer_id` and then explicitly added a `WHERE previous_date IS NOT NULL` filter to the main query so that first-time orders (which have no prior date) were cleanly excluded from the days-between calculation.
