--- Day 08 -----

-- Create tweets table
CREATE TABLE tweets (
    tweet_id INTEGER,
    user_id INTEGER,
    msg VARCHAR(255),
    tweet_date TIMESTAMP
);

-- Insert sample records
INSERT INTO tweets (tweet_id, user_id, msg, tweet_date) VALUES
(214252, 111, 'Am considering taking Tesla private at $420. Funding secured.', '2021-12-30 00:00:00'),
(739252, 111, 'Despite the constant negative press covfefe', '2022-01-01 00:00:00'),
(846402, 111, 'Following @NickSinghTech on Twitter changed my life!', '2022-02-14 00:00:00'),
(241425, 254, 'If the salary is so competitive why won’t you tell me what it is?', '2022-03-01 00:00:00'),
(231574, 148, 'I no longer have a manager. I can"t be managed', '2022-03-23 00:00:00');

-- Formulate the question

/*
	
Question:
Write a query to obtain a histogram of tweets posted per user in 2022. 
Output the tweet count per user as the bucket and the number of Twitter users who fall into that bucket.

*/

SELECT * FROM tweets ;

/* Query Breakdown :

-- count the tweets per each user 
-- Filter the tweet_date year as 2022
-- Count the users w.r.t tweets posted

*/

-- My Approach :

SELECT
	tweet_count,
	count(user_id) as user_count
FROM
   (SELECT 
		user_id,
		count(tweet_id) as tweet_count
	FROM tweets
	WHERE EXTRACT(YEAR FROM tweet_date) = 2022
	GROUP BY user_id) v1
GROUP BY tweet_count ;