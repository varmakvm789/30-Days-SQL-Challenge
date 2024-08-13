-- 28/30 Days SQL Challenge!

-- DROP TABLE IF EXISTS orders;

CREATE TABLE orders4 (
    order_id INT PRIMARY KEY,
    seller_id INT,
    sale_amount DECIMAL(10, 2)
);


-- DROP TABLE IF EXISTS returns;

CREATE TABLE returns2 (
    return_id INT PRIMARY KEY,
    seller_id INT,
    return_quantity INT
);


INSERT INTO orders4 (order_id, seller_id, sale_amount) VALUES
(1, 101, 1500.00),
(2, 102, 2200.00),
(3, 103, 1800.00),
(4, 104, 2500.00),
(5, 107, 1900.00),
(6, 106, 2100.00),
(7, 107, 2400.00),
(8, 107, 1700.00),
(9, 108, 2000.00),
(10, 107, 2300.00),
(11, 103, 2600.00),
(12, 102, 2900.00),
(13, 101, 3100.00),
(14, 101, 2800.00),
(15, 101, 3300.00),
(16, 106, 2700.00),
(17, 101, 3000.00),
(18, 108, 3200.00),
(19, 107, 3400.00),
(20, 106, 3500.00),
(21, 101, 3600.00),
(22, 102, 3700.00),
(23, 103, 3800.00),
(24, 102, 3900.00),
(25, 105, 4000.00);

INSERT INTO returns2 (return_id, seller_id, return_quantity) VALUES
(1, 101, 10),
(2, 102, 5),
(3, 103, 8),
(4, 104, 3),
(5, 105, 12),
(6, 106, 6),
(7, 107, 4),
(8, 108, 9);



/*
-- Amazon DS Interview Question?

-- Given two tables, orders and return, containing sales and returns data for Amazon's 


write a SQL query to find the top 3 sellers with the highest sales amount 
but the lowest lowest return qty. 

*/


SELECT * FROM orders4  ;
SELECT * FROM returns2 ;

/*  Query Breakdown ---

-- Calculate the total sales amount for each seller.
-- Calculate the total return quantity for each seller.
-- Combine these metrics and rank sellers by sales amount while considering their return quantity.
-- Select the top 3 sellers based on the highest sales amount and lowest return quantity.

*/


-- ------------------
-- My Approach
-- ------------------

WITH SellerSales AS (
    SELECT 
        seller_id,
        SUM(sale_amount) AS total_sales
    FROM orders4
    GROUP BY seller_id
),
SellerReturns AS (
    SELECT 
        seller_id,
        COALESCE(SUM(return_quantity), 0) AS total_returns
    FROM returns2
    GROUP BY seller_id
),
CombinedData AS (
    SELECT 
        s.seller_id,
        s.total_sales,
        COALESCE(r.total_returns, 0) AS total_returns
    FROM SellerSales s
    LEFT JOIN SellerReturns r ON s.seller_id = r.seller_id
),
RankedSellers AS (
    SELECT
        seller_id,
        total_sales,
        total_returns,
        ROW_NUMBER() OVER (ORDER BY total_sales DESC, total_returns ASC) AS rank
    FROM CombinedData
)
SELECT
    seller_id,
    total_sales,
    total_returns
FROM RankedSellers
WHERE rank <= 3;



















	