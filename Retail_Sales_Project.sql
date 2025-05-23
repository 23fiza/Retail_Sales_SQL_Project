use sql_project;

/*---Total Records--*/
SELECT count(*) FROM retail_sales;

/*---Top 10 Records--*/
SELECT  * FROM retail_sales LIMIT 10;

/*---Null or Empty Records---*/
SELECT  * FROM retail_sales 
WHERE transactions_id IS NULL;

SELECT  * FROM retail_sales 
WHERE sale_date IS NULL;

SELECT  * FROM retail_sales 
WHERE transactions_id IS NULL
OR
sale_time IS NULL
OR
customer_id IS NULL
OR
gender IS NULL
OR
age IS NULL
OR
category IS NULL
OR
quantity IS NULL
OR
price_per_unit IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL;

/*DATA CLEANING*/
/*Delete All the Null Values*/

DELETE FROM retail_sales 
WHERE transactions_id IS NULL
OR
sale_time IS NULL
OR
customer_id IS NULL
OR
gender IS NULL
OR
age IS NULL
OR
category IS NULL
OR
quantity IS NULL
OR
price_per_unit IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL;
SET SQL_SAFE_UPDATES = 0;

/******DATA EXPLORATION******/

/******HOW MANY SALES WE HAVE? ******/

SELECT COUNT(*) AS 'Total_Sales' FROM retail_sales;

/******HOW MANY CUSTOMER WE HAVE? ******/

SELECT COUNT(DISTINCT(customer_Id)) AS 'Total_Customer'
 FROM retail_sales;

/******HOW MANY CATEGORY WE HAVE? ******/

SELECT DISTINCT(category) AS 'Total_Category'
FROM retail_sales;

/*Write a SQL query to retrieve all the columns for sales made on 22-11-05*/
SELECT * FROM retail_sales
WHERE sale_date = '22-11-05';

/*Write a query to retreive all the transactions where the category is clothing and the quantity sold is more than 3
in the month of Nov-2022*/

SELECT * FROM retail_sales
WHERE category = "clothing"
AND MONTH(sale_date) = '11' AND YEAR(sale_date) = '2022'
AND quantity >3;

/*Write a SQL query to calculate total_Sale for each category */
SELECT category, SUM(total_sale) AS 'tota_sales',
COUNT(*) AS 'total_orders'
FROM retail_sales
GROUP BY category;

/* Write a SQL query to find the average age of customer who purhcased item from the Beauty Category */

SELECT ROUND(AVG(age),0) AS 'Avg_age', category  FROM retail_sales
WHERE category = "Beauty"
GROUP BY category;

/* Write a SQL query to find all the transactions where the total sale is greater than 1000*/

SELECT * FROM retail_sales
WHERE total_sale >1000;

/*Write a SQL query to find the total number of transaction made by each gender in each category*/
SELECT category, gender, COUNT(*) AS 'total_count' FROM retail_sales
GROUP by gender, category
ORDER BY 2;

/*Write a SQL query to calculate the average sale for each month,
Find out best selling month in each year*/

WITH t1 AS  
(SELECT YEAR(sale_date) AS 'Year', MONTH(sale_date) AS 'Month', ROUND(AVG(total_sale)) AS 'avg_sales',
RANK () OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS '_rank'
FROM retail_sales
GROUP BY MONTH(sale_date),YEAR(sale_date))
SELECT Year, Month , avg_sales FROM t1
WHERE _rank =1;

/*Write a SQL query to find a top 5 customers beased on the highest total sales*/
SELECT customer_id, SUM(total_sale) AS 'total_sale' FROM retail_sales
GROUP BY customer_id
ORDER BY total_sale DESC LIMIT 5 ;

/*Write a SQL query to find the unique customer who purchased items from each category*/

SELECT category ,COUNT(DISTINCT(customer_id)) AS 'unique_customer'
FROM retail_sales
GROUP BY category;

/*Write a SQL query to create each shift and number of Orders (Example Morning <=12, Afternoon Between 12 and 17, Evening >17*/
WITH hourly_shift AS(
SELECT *,
CASE 
WHEN HOUR(sale_time) <=12 THEN 'Morning'
WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
ELSE 'Evening'
END AS 'shift'
FROM retail_sales)
SELECT shift, COUNT(*) AS 'total_count' FROM
hourly_shift
GROUP BY shift;