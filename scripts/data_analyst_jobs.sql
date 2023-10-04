--1.	How many rows are in the data_analyst_jobs table?

SELECT COUNT (*)
FROM data_analyst_jobs;

--Answer: 1793

-- 2.	Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?

SELECT *
FROM data_analyst_jobs
LIMIT 10;

--Answer: ExxonMobil

-- 3.	How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?

SELECT location, COUNT(*)
FROM data_analyst_jobs
WHERE location='TN' OR location='KY'
GROUP BY location;

--Answer: 21 postings in TN & ## postings in TN or KY 27 (6 in KY)

-- 4.	How many postings in Tennessee have a star rating above 4?

SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location='TN' AND star_rating>4.0
GROUP BY location;

--Answer: 3

-- 5.	How many postings in the dataset have a review count between 500 and 1000?

SELECT COUNT(*)
FROM data_analyst_jobs
WHERE review_count>500 AND review_count<1000;

--Answer: 150

-- 6.	Show the average star rating for companies in each state. The output should show the state as `state` and the average rating for the state as `avg_rating`. Which state shows the highest average rating?

SELECT location AS state, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
GROUP BY state
ORDER BY avg_rating DESC;

--Answer: Nebraska

-- 7.	Select unique job titles from the data_analyst_jobs table. How many are there?

SELECT DISTINCT title
FROM data_analyst_jobs;

--Answer: 881

-- 8.	How many unique job titles are there for California companies?

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE location='CA';

--Answer: 230

-- 9.	Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?

SELECT company, SUM(review_count) AS total_reviews, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE company IS NOT NULL AND review_count>5000
GROUP BY company;

--Answer: 40 (41 if you remove the WHERE clause)

-- 10.	Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?

SELECT company, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE company IS NOT NULL AND review_count>5000
GROUP BY company
ORDER BY avg_rating DESC;

--Answer: Six companies, all with an average star rating of ~4.2:
--        #1	Unilever
--        #2	General Motors
--        #3	Nike
--        #4	American Express
--        #5	Microsoft
--        #6	Kaiser Permanente

-- 11.	Find all the job titles that contain the word ‘Analyst’. How many different job titles are there?

SELECT DISTINCT title
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%';

--Answer: 774 (Googled how to make the LIKE operator not case sensitive, as I noticed in question 12 that NOT LIKE 'Analyst' still showed a job title with 'ANALYST')

-- 12.	How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?

SELECT DISTINCT title
FROM data_analyst_jobs
WHERE title NOT ILIKE '%Analyst%' OR title NOT ILIKE '%Analytics%';

--Answer: 801 (See Question 11 - LIKE is case sensitive, where ILIKE is not)

-- **BONUS:**
-- You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks. 
--  - Disregard any postings where the domain is NULL. 
--  - Order your results so that the domain with the greatest number of `hard to fill` jobs is at the top. 
--   - Which four industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?


SELECT domain, COUNT(skill) AS hard_to_fill_jobs
FROM data_analyst_jobs
WHERE domain IS NOT NULL AND skill LIKE '%SQL%' AND days_since_posting>21
GROUP BY domain
ORDER BY hard_to_fill_jobs DESC
LIMIT 4;

--Answer:
--       #1	Internet & Software:			62 "hard to fill" jobs
--       #2	Banks & Financial Services:		61 "hard to fill" jobs
--       #3	Consulting & Business Services:	57 "hard to fill" jobs
--       #4	Health Care:					52 "hard to fill" jobs