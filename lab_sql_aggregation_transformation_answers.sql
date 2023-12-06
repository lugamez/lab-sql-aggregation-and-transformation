USE SAKILA;

/* Challenge 1
1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration */

SELECT MAX(LENGTH) AS "MAX_DURATION", MIN(LENGTH) AS "MIN_DURATION" FROM SAKILA.FILM;

/* 1.2. Express the average movie duration in hours and minutes. Don't use decimals.*/

SELECT SEC_TO_TIME(ROUND(AVG(LENGTH), 0)*60) AS "AVERAGE MOVIE DURATION" FROM SAKILA.FILM;

/* 2. You need to gain insights related to rental dates:
2.1 Calculate the number of days that the company has been operating.
Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column 
from the latest date. */

SELECT DATEDIFF(MAX(RENTAL_DATE), MIN(RENTAL_DATE)) AS "DAYS OPERATING" FROM SAKILA.RENTAL;

/* 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. 
Return 20 rows of results. */

SELECT 
*, MONTHNAME(RENTAL_DATE) AS "RENTAL MONTH", DAYNAME(RENTAL_DATE) AS "RENTAL DAY"
FROM SAKILA.RENTAL
LIMIT 20;

/* 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', 
depending on the day of the week.
Hint: use a conditional expression. */

SELECT 
*, MONTHNAME(RENTAL_DATE) AS "RENTAL MONTH", DAYNAME(RENTAL_DATE) AS "RENTAL DAY",
CASE
WHEN DAYNAME(RENTAL_DATE) IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday') THEN 'Workday'
ELSE 'Weekend'
END AS "DAY TYPE"
FROM SAKILA.RENTAL;

/* 3. You need to ensure that customers can easily access information about the movie collection. 
To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, 
replace it with the string 'Not Available'. Sort the results of the film title in ascending order.

Please note that even if there are currently no null values in the rental duration column, the query should still be written
to handle such cases in the future.
Hint: Look for the IFNULL() function. */

SELECT TITLE, IFNULL(NULL, LENGTH) FROM SAKILA.FILM
ORDER BY TITLE ASC;

/* 4. Bonus: The marketing team for the movie rental company now needs to create a personalized email
 campaign for customers. To achieve this, you need to retrieve the concatenated first and last names of 
 customers, along with the first 3 characters of their email address, so that you can address them by
 their first name and use their email address to send personalized recommendations. 
 The results should be ordered by last name in ascending order to make it easier to use the data. */

SELECT CONCAT(FIRST_NAME," ", LAST_NAME," ",LEFT(EMAIL, 3)) AS "CUSTOMER" FROM SAKILA.CUSTOMER;

/* Challenge 2
1. Next, you need to analyze the films in the collection to gain some more insights. 
Using the film table, determine:
1.1 The total number of films that have been released. */

SELECT COUNT(*) AS "RELEASED FILMS" FROM SAKILA.FILM;

/* 1.2 The number of films for each rating. */

SELECT RATING, COUNT(RATING) AS "NUMBER OF FILMS PER RATING" FROM SAKILA.FILM
GROUP BY RATING;

/* 1.3 The number of films for each rating, sorting the results in descending order of the number of films.
This will help you to better understand the popularity of different film ratings and adjust 
purchasing decisions accordingly. */


SELECT RATING, COUNT(*) AS "NUMBER OF FILMS PER RATING" FROM SAKILA.FILM
GROUP BY RATING
ORDER BY COUNT(RATING) DESC;

/* 2. Using the film table, determine:
2.1 The mean film duration for each rating, and sort the results in descending order of the 
mean duration. Round off the average lengths to two decimal places. This will help identify popular 
movie lengths for each category. */

SELECT RATING, ROUND(AVG(LENGTH),2) AS "AVERAGE LENGTH PER RATING" FROM SAKILA.FILM
GROUP BY RATING
ORDER BY AVG(LENGTH) DESC;

/* 2.2 Identify which ratings have a mean duration of over two hours in order to help select films
 for customers who prefer longer movies. */
 
 SELECT RATING, ROUND(AVG(LENGTH),2) AS "AVERAGE LENGTH PER RATING"
 FROM SAKILA.FILM
 GROUP BY RATING
 HAVING ROUND(AVG(LENGTH),2) > 120;
 
 /* 3. Bonus: determine which last names are not repeated in the table actor. */
 
 SELECT LAST_NAME, COUNT(*) AS "LAST NAME APPEARS X TIMES" FROM SAKILA.ACTOR
 GROUP BY LAST_NAME
 HAVING COUNT(*) = 1;


