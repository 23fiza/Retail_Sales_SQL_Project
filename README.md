# 🛒 SQL Retail Sales Data Analysis

This project involves cleaning, exploring, and analyzing a retail sales dataset using SQL. The data includes details on sales transactions, customer demographics, product categories, and time of sale. The goal is to extract business insights such as customer behavior, sales performance, and category trends.

## 📂 Project Structure

- `sql_project/`  
  ├── `retail_sales` table  
  ├── SQL queries for:  
  │   ├── Data inspection  
  │   ├── Data cleaning  
  │   ├── Exploratory data analysis  
  │   └── Business insights  

## 🧾 Dataset Overview

The `retail_sales` table contains the following columns:

| Column           | Description                       |
|------------------|-----------------------------------|
| transactions_id  | Unique ID for each transaction    |
| sale_date        | Date of sale                      |
| sale_time        | Time of sale                      |
| customer_id      | Unique ID for each customer       |
| gender           | Gender of customer                |
| age              | Age of customer                   |
| category         | Product category                  |
| quantity         | Quantity sold                     |
| price_per_unit   | Unit price                        |
| cogs             | Cost of goods sold                |
| total_sale       | Total sale amount                 |

---

## 🔧 Data Cleaning

All rows containing `NULL` values in any of the critical columns are deleted to ensure data quality.

```sql
DELETE FROM retail_sales 
WHERE transactions_id IS NULL
OR sale_time IS NULL
OR customer_id IS NULL
OR gender IS NULL
OR age IS NULL
OR category IS NULL
OR quantity IS NULL
OR price_per_unit IS NULL
OR cogs IS NULL
OR total_sale IS NULL;

Markdown
 📊 Key Analyses
 📈 General Stats
Total Sales Records

sql
Copy
Edit
SELECT COUNT(*) FROM retail_sales;
Total Unique Customers

sql
Copy
Edit
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
Total Unique Categories

sql
Copy
Edit
SELECT DISTINCT category FROM retail_sales;
📅 Date-Based Analysis
Sales on a specific date (e.g., 22-11-05)

sql
Copy
Edit
SELECT * FROM retail_sales WHERE sale_date = '22-11-05';
Clothing sales (quantity > 3) in Nov 2022

sql
Copy
Edit
SELECT * FROM retail_sales 
WHERE category = 'clothing'
AND MONTH(sale_date) = 11 
AND YEAR(sale_date) = 2022
AND quantity > 3;
🧍 Customer & Demographics
Top 5 Customers by Total Sales

sql
Copy
Edit
SELECT customer_id, SUM(total_sale) AS total_sale 
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sale DESC 
LIMIT 5;
Average Age of Beauty Category Buyers

sql
Copy
Edit
SELECT ROUND(AVG(age),0) AS Avg_age 
FROM retail_sales
WHERE category = 'Beauty';
🛍️ Product Performance
Sales by Category

sql
Copy
Edit
SELECT category, SUM(total_sale) AS total_sales, COUNT(*) AS total_orders 
FROM retail_sales
GROUP BY category;
Unique Customers per Category

sql
Copy
Edit
SELECT category, COUNT(DISTINCT customer_id) AS unique_customer 
FROM retail_sales 
GROUP BY category;
🕒 Time-Based Insights
Best-Selling Month per Year

sql
Copy
Edit
WITH t1 AS (
    SELECT YEAR(sale_date) AS Year, 
           MONTH(sale_date) AS Month, 
           ROUND(AVG(total_sale)) AS avg_sales,
           RANK () OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS _rank
    FROM retail_sales
    GROUP BY MONTH(sale_date), YEAR(sale_date)
)
SELECT Year, Month, avg_sales 
FROM t1 
WHERE _rank = 1;
Sales Distribution by Shift (Morning, Afternoon, Evening)

sql
Copy
Edit
WITH hourly_shift AS (
    SELECT *,
           CASE 
               WHEN HOUR(sale_time) <= 12 THEN 'Morning'
               WHEN HOUR(sale_time) BETWEEN 13 AND 17 THEN 'Afternoon'
               ELSE 'Evening'
           END AS shift
    FROM retail_sales
)
SELECT shift, COUNT(*) AS total_count 
FROM hourly_shift 
GROUP BY shift;
🚀 How to Use
Clone the repository:

bash
Copy
Edit
git clone https://github.com/yourusername/sql_project.git
cd sql_project
Load the SQL script into your local SQL environment.

Run individual queries for analysis or modify them for further exploration.

🧠 Insights and Business Use Cases
Identify high-value customers

Understand time-of-day sales trends

Analyze product category performance

Segment customers by demographics and behavior

