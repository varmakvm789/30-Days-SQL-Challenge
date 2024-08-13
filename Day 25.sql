-- Day *25/30 ---------

-- Drop the orders table if it exists
DROP TABLE IF EXISTS orders1;

-- Create the orders table with columns: date, product_id, product_name, and revenue
CREATE TABLE orders1 (
    date DATE,
    product_id INT,
    product_name VARCHAR(255),
    revenue DECIMAL(10, 2)
);

-- Insert sample data into the orders table representing orders of iPhones
INSERT INTO orders1 (date, product_id, product_name, revenue) VALUES
('2024-01-01', 101, 'iPhone 13 Pro', 1000.00),
('2024-01-01', 102, 'iPhone 13 Pro Max', 1200.00),
('2024-01-02', 101, 'iPhone 13 Pro', 950.00),
('2024-01-02', 103, 'iPhone 12 Pro', 1100.00),
('2024-01-03', 102, 'iPhone 13 Pro Max', 1250.00),
('2024-01-03', 104, 'iPhone 11', 1400.00),
('2024-01-04', 101, 'iPhone 13 Pro', 800.00),
('2024-01-04', 102, 'iPhone 13 Pro Max', 1350.00),
('2024-01-05', 103, 'iPhone 12 Pro', 1000.00),
('2024-01-05', 104, 'iPhone 11', 700.00),
('2024-01-06', 101, 'iPhone 13 Pro', 600.00),
('2024-01-06', 102, 'iPhone 13 Pro Max', 550.00),
('2024-01-07', 101, 'iPhone 13 Pro', 400.00),
('2024-01-07', 103, 'iPhone 12 Pro', 250.00),
('2024-01-08', 102, 'iPhone 13 Pro Max', 200.00),
('2024-01-08', 104, 'iPhone 11', 150.00),
('2024-01-09', 101, 'iPhone 13 Pro', 100.00),
('2024-01-09', 102, 'iPhone 13 Pro Max', 50.00),
('2024-01-10', 101, 'iPhone 13 Pro', 1000.00),
('2024-01-10', 102, 'iPhone 13 Pro Max', 1200.00),
('2024-01-11', 101, 'iPhone 13 Pro', 950.00),
('2024-01-11', 103, 'iPhone 12 Pro', 1100.00),
('2024-01-12', 102, 'iPhone 13 Pro Max', 1250.00),
('2024-01-12', 104, 'iPhone 11', 1400.00);

/*
-- Flipkart Business Analyst Interview Question

Question: 
	Write a SQL query to calculate the running 
	total revenue for each combination of date and product ID.

Expected Output Columns: 
	date, product_id, product_name, revenue, running_total
	ORDER BY product_id, date ascending

*/

SELECT * FROM orders1 ;

-- Query Breakdown ---

-- Running total for revenue for each prod_id, date combination

------------------------------------------
--Approach 1 : Using window function
------------------------------------------

SELECT
    date,
    product_id,
    product_name,
    revenue,
    SUM(revenue) OVER (PARTITION BY product_id ORDER BY date) AS running_total
FROM
    orders1
ORDER BY
    product_id,
    date;

------------------------------------------
-- Approach 2 : Using Joins
------------------------------------------

SELECT
    o1.date,
    o1.product_id,
    o1.product_name,
    o1.revenue,
    COALESCE(SUM(o2.revenue), 0) AS running_total
FROM
    orders1 o1
LEFT JOIN
    orders1 o2
ON
    o1.product_id = o2.product_id
    AND o2.date <= o1.date
GROUP BY
    o1.date,
    o1.product_id,
    o1.product_name,
    o1.revenue
ORDER BY
    o1.product_id,
    o1.date;
