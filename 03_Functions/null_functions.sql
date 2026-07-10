-- ============================================================
-- SQL Practice | Functions - NULL Functions
-- File: 03_Functions/null_functions.sql
-- ============================================================

USE sql_practice;

-- IFNULL: replaces NULL with a specified value
SELECT
    name,
    IFNULL(manager_id, 'No Manager') AS manager
FROM employees;

SELECT
    order_id,
    IFNULL(customer_id, 'Guest') AS customer
FROM orders;

-- COALESCE: returns first non-NULL value from a list
SELECT
    name,
    COALESCE(manager_id, department_id, 0) AS fallback_id
FROM employees;

-- Practical: display city or 'Unknown' for customers
SELECT
    customer_name,
    COALESCE(city, phone, 'No Contact Info') AS contact_info
FROM customers;

-- NULLIF: returns NULL if two values are equal; otherwise returns the first value
SELECT NULLIF(100, 100)   AS result;    -- Returns NULL
SELECT NULLIF(100, 200)   AS result;    -- Returns 100

-- Practical: avoid division by zero using NULLIF
SELECT
    department_id,
    SUM(salary)                               AS total_salary,
    COUNT(*)                                  AS headcount,
    SUM(salary) / NULLIF(COUNT(*), 0)         AS avg_salary_safe
FROM employees
GROUP BY department_id;

-- ISNULL / IS NOT NULL
SELECT * FROM employees WHERE manager_id IS NULL;
SELECT * FROM employees WHERE manager_id IS NOT NULL;

-- IF function (ternary-like)
SELECT
    name,
    IF(manager_id IS NULL, 'Manager', 'Employee') AS role
FROM employees;

-- CASE with NULL handling
SELECT
    name,
    salary,
    CASE
        WHEN manager_id IS NULL THEN 'Department Head'
        ELSE CONCAT('Reports to Employee #', manager_id)
    END AS reporting_line
FROM employees;

-- Count NULL vs non-NULL values
SELECT
    COUNT(*)            AS total_rows,
    COUNT(manager_id)   AS has_manager,
    COUNT(*) - COUNT(manager_id) AS no_manager
FROM employees;
