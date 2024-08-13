-- Day 2 -- 

-- Create pages table
CREATE TABLE pages (
    page_id INTEGER PRIMARY KEY,
    page_name VARCHAR(255)
);

-- Insert data into pages table
INSERT INTO pages (page_id, page_name) VALUES
(20001, 'SQL Solutions'),
(20045, 'Brain Exercises'),
(20701, 'Tips for Data Analysts');

-- Create page_likes table
CREATE TABLE page_likes (
    user_id INTEGER,
    page_id INTEGER,
    liked_date DATE,
    FOREIGN KEY (page_id) REFERENCES pages(page_id)
);

-- Insert data into page_likes table
INSERT INTO page_likes (user_id, page_id, liked_date) VALUES
(111, 20001, '2022-04-08 00:00:00'),
(121, 20045, '2022-03-12 00:00:00'),
(156, 20001, '2022-07-25 00:00:00');


/*
Question 1:
Write a SQL query to retrieve the IDs of the Facebook pages that have zero likes. 
The output should be sorted in ascending order based on the page IDs.
*/


SELECT * FROM pages 
SELECT * FROM page_likes

Breakdown:
-- Fetch all the page_id's to see what are the fb pages available i'e., LEFT JOIN
-- Group the page_id's
-- filter pages having zero likes in page_likes

SELECT
	p.page_id,
	p.page_name
FROM
	pages p
LEFT JOIN
	page_likes l ON l.page_id = p.page_id
GROUP BY p.page_id
HAVING count(l.page_id) = 0
ORDER BY 1 ;




------------------------------------------------------------------------------------------------

-- Create the events table
CREATE TABLE events (
    app_id INTEGER,
    event_type VARCHAR(10),
    timestamp DATE
);

-- Insert records into the events table
INSERT INTO events (app_id, event_type, timestamp) VALUES
(123, 'impression', '2022-07-18 11:36:12'),
(123, 'impression', '2022-07-18 11:37:12'),
(123, 'click', '2022-07-18 11:37:42'),
(234, 'impression', '2022-07-18 14:15:12'),
(234, 'click', '2022-07-18 14:16:12');

/*

Question 2: 

Write a query to calculate the click-through rate (CTR) for the app in 2022 and round the results to 2 decimal places.

Definition and note:
Percentage of click-through rate (CTR) = 100.0 * Number of clicks / Number of impressions
To avoid integer division, multiply the CTR by 100.0, not 100.
Expected Output Columns: app_id, ctr

Question 2 Link :: https://datalemur.com/questions/click-through-rate

*/

SELECT * FROM EVENTS ;

Breakdown :
-- Find the total_clicks, total_impressions i.e, USING CTE and SUM fn.
-- Filter timestamp for year 2022
-- Group by app_id
-- Calculate the CTR, Round it to 2 decimals


My Approach:

SELECT 
	app_id,
	ROUND((100 *(SUM(CASE WHEN event_type = 'click' THEN 1 ELSE 0 END)) / (SUM(CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END))) , 2) as ctr
FROM
	Events 
WHERE EXTRACT(YEAR from timestamp) = 2022
GROUP BY app_id ;
