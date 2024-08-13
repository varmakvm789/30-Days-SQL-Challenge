-- --  Day 19/30 SQL Challenge

-- Google Interview Question for DA

-- DDL Script
CREATE TABLE student_names(
    student_id INT,
    name VARCHAR(50)
);

-- DML Script
INSERT INTO student_names (student_id, name) VALUES
(1, 'RAM'),
(2, 'ROBERT'),
(3, 'ROHIM'),
(4, 'RAM'),
(5, 'ROBERT');


-- Question 
-- Get the count of distint student that are not unique 


SELECT * FROM student_names ; 

-- My Approach :

SELECT
	count(*) as distinct_stu_count
FROM 
	(SELECT
		name
	FROM student_names
	GROUP BY name
	HAVING count(name) = 1) v1 ;