-- ============================================================
-- SQL Practice | Functions - Date Functions
-- File: 03_Functions/date_functions.sql
-- ============================================================

USE sql_practice;

-- Current date and time
SELECT NOW()            AS current_datetime;
SELECT CURDATE()        AS current_date;
SELECT CURTIME()        AS current_time;
SELECT SYSDATE()        AS system_datetime;

-- Extract parts of a date
SELECT
    hire_date,
    YEAR(hire_date)    AS hire_year,
    MONTH(hire_date)   AS hire_month,
    DAY(hire_date)     AS hire_day,
    WEEK(hire_date)    AS week_number,
    DAYNAME(hire_date) AS day_name,
    MONTHNAME(hire_date) AS month_name,
    QUARTER(hire_date) AS quarter
FROM employees;

-- DATE_FORMAT: custom formatting
SELECT
    name,
    DATE_FORMAT(hire_date, '%d-%m-%Y')  AS formatted_date,
    DATE_FORMAT(hire_date, '%D %M %Y')  AS long_format
FROM employees;

-- DATEDIFF: number of days between two dates
SELECT
    name,
    hire_date,
    DATEDIFF(CURDATE(), hire_date)         AS days_employed,
    FLOOR(DATEDIFF(CURDATE(), hire_date) / 365) AS years_employed
FROM employees;

-- DATE_ADD / DATE_SUB
SELECT
    order_id,
    order_date,
    DATE_ADD(order_date, INTERVAL 7  DAY)   AS delivery_expected,
    DATE_SUB(order_date, INTERVAL 1  MONTH) AS one_month_before
FROM orders;

-- TIMESTAMPDIFF
SELECT
    name,
    TIMESTAMPDIFF(YEAR,  hire_date, CURDATE()) AS years,
    TIMESTAMPDIFF(MONTH, hire_date, CURDATE()) AS months
FROM employees;

-- STR_TO_DATE: parse a string into a DATE
SELECT STR_TO_DATE('10-07-2025', '%d-%m-%Y') AS parsed_date;

-- LAST_DAY of the month
SELECT LAST_DAY('2024-02-01') AS last_day_of_feb;

-- Practical: find employees hired in the last 3 years
SELECT name, hire_date
FROM employees
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
ORDER BY hire_date DESC;

-- Find orders placed in 2024
SELECT * FROM orders
WHERE YEAR(order_date) = 2024
ORDER BY order_date;
