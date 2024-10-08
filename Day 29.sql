-- 29/30 Days SQL Challenge

DROP TABLE IF EXISTS Sales;
-- Create Sales table
CREATE TABLE Sales2 (
    sale_id INT,
    product_id INT,
    year INT,
    quantity INT,
    price INT
);
-- Insert sample records into Sales table
INSERT INTO Sales2 (sale_id, product_id, year, quantity, price) 
VALUES
(1, 100, 2008, 10, 5000),
(2, 100, 2009, 12, 5000),
(7, 200, 2011, 15, 9000),
(3, 100, 2010, 8, 5500),
(4, 100, 2011, 15, 4800),
(5, 200, 2013, 20, 8500),
(6, 200, 2006, 18, 9200),
(8, 300, 2012, 25, 7500),
(9, 300, 2009, 30, 7200),
(10, 300, 2013, 22, 6800);



/*
-- Walmart Data Analyst Interview Question

Write a solution to select the product id, year, quantity, 
and price for the first year of every product sold.
*/


SELECT * FROM SALES2
ORDER BY Product_id, year;

/*  Query Breakdown --
-- Identify the first year each product was sold.
-- Retrieve the sales records for these first years.
*/


-- --------------------------
-- My Approach 1: Using subquery & Window Fn
-- --------------------------

SELECT
	product_id,
	year as first_year,
	quantity,
	price
FROM
	(SELECT
		sale_id,
		product_id,
		year,
		quantity,
		price,
		ROW_NUMBER() OVER(partition by product_id order by year) as Rnk
	FROM
		sales2) v1
WHERE
	rnk = 1

-- --------------------------
-- My Approach 2: Using CTE & Joins
-- --------------------------
	
WITH FirstSaleYear AS (
    SELECT 
        product_id,
        MIN(year) AS first_year
    FROM Sales2
    GROUP BY product_id
)
SELECT
    s.product_id,
    s.year,
    s.quantity,
    s.price
FROM Sales2 s
JOIN FirstSaleYear f
ON s.product_id = f.product_id AND s.year = f.first_year;








	