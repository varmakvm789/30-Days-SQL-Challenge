--Day 27/30 

-- DDL SCHEMA ---

DROP TABLE IF EXISTS orders;

-- Create the orders table
CREATE TABLE orders3 (
    user_id INT,
    item_ordered VARCHAR(512)
);

-- DML Schema ----
INSERT INTO orders3 VALUES 
('1', 'Pizza'),
('1', 'Burger'),
('2', 'Cold Drink'),
('2', 'Burger'),
('3', 'Burger'),
('3', 'Cold Drink'),
('4', 'Pizza'),
('4', 'Cold Drink'),
('5', 'Cold Drink'),
('6', 'Burger'),
('6', 'Cold Drink'),
('7', 'Pizza'),
('8', 'Burger');

-- Flipkart Data Analyst Interview Questions
-- Question: Write an SQL query to fetch user IDs that have only bought both 'Burger' and 'Cold Drink' items.

-- Expected Output Columns: user_id

/* Query Breakdown -----

-- Group by user_id and aggregate the items they have purchased.
-- Filter users who have purchased exactly 'Burger' and 'Cold Drink'.
-- Exclude users who have purchased any other items.

*/

SELECT * FROM orders3 ;


-- -----------------------
-- My Approach :
-- -----------------------

SELECT 
    user_id
	-- COUNT(DISTINCT item_ordered)
FROM orders
GROUP BY user_id
HAVING COUNT(DISTINCT item_ordered) = 2 -- Ensures the user has bought exactly two distinct items.
   AND SUM(CASE WHEN item_ordered IN ('Burger', 'Cold Drink') THEN 1 ELSE 0 END) = 2;
   -- Ensures that the two distinct items are 'Burger' and 'Cold Drink'.
   -- If both items are present, the sum of the CASE statement should be 2.
    




