-- ============================================================
-- SQL Practice | Interview Queries - Duplicate Records
-- File: 11_Interview_Queries/duplicate_records.sql
-- ============================================================

USE sql_practice;

-- -------------------------------------------------------
-- Find duplicates in the employees table (by name)
-- -------------------------------------------------------
SELECT name, COUNT(*) AS occurrence
FROM employees
GROUP BY name
HAVING COUNT(*) > 1;

-- Find duplicates by email
SELECT email, COUNT(*) AS occurrence
FROM employees
GROUP BY email
HAVING COUNT(*) > 1;

-- -------------------------------------------------------
-- Show full rows of duplicates (with all columns)
-- -------------------------------------------------------
SELECT e.*
FROM employees e
INNER JOIN (
    SELECT name
    FROM employees
    GROUP BY name
    HAVING COUNT(*) > 1
) dups ON e.name = dups.name
ORDER BY e.name;

-- -------------------------------------------------------
-- Detect duplicate orders (same customer, same date, same amount)
-- -------------------------------------------------------
SELECT customer_id, order_date, total_amount, COUNT(*) AS dup_count
FROM orders
GROUP BY customer_id, order_date, total_amount
HAVING COUNT(*) > 1;

-- Show full duplicate order rows
SELECT o.*
FROM orders o
INNER JOIN (
    SELECT customer_id, order_date, total_amount
    FROM orders
    GROUP BY customer_id, order_date, total_amount
    HAVING COUNT(*) > 1
) dups ON  o.customer_id   = dups.customer_id
       AND o.order_date    = dups.order_date
       AND o.total_amount  = dups.total_amount
ORDER BY o.customer_id, o.order_date;

-- -------------------------------------------------------
-- Using ROW_NUMBER to identify duplicates
-- -------------------------------------------------------
SELECT *
FROM (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY name ORDER BY employee_id) AS row_num
    FROM employees
) ranked
WHERE row_num > 1;   -- Any row_num > 1 is a duplicate

-- -------------------------------------------------------
-- Count total duplicate rows (vs distinct rows)
-- -------------------------------------------------------
SELECT
    COUNT(*)                          AS total_rows,
    COUNT(DISTINCT name)              AS distinct_names,
    COUNT(*) - COUNT(DISTINCT name)   AS duplicate_rows
FROM employees;
