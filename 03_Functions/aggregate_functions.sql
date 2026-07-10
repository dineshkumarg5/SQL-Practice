-- ============================================================
-- SQL Practice | Functions - Aggregate Functions
-- File: 03_Functions/aggregate_functions.sql
-- ============================================================

USE sql_practice;

-- COUNT
SELECT COUNT(*)             AS total_employees  FROM employees;
SELECT COUNT(manager_id)    AS employees_with_manager FROM employees;  -- Ignores NULLs
SELECT COUNT(DISTINCT department_id) AS dept_count FROM employees;

-- SUM
SELECT SUM(salary)          AS total_payroll    FROM employees;
SELECT SUM(total_amount)    AS total_revenue    FROM orders;

-- AVG
SELECT AVG(salary)          AS avg_salary       FROM employees;
SELECT ROUND(AVG(salary), 2) AS avg_salary_rounded FROM employees;

-- MIN and MAX
SELECT MIN(salary)          AS lowest_salary    FROM employees;
SELECT MAX(salary)          AS highest_salary   FROM employees;
SELECT MIN(hire_date)       AS earliest_hire    FROM employees;
SELECT MAX(hire_date)       AS latest_hire      FROM employees;

-- Aggregate with GROUP BY
SELECT
    department_id,
    COUNT(*)        AS headcount,
    SUM(salary)     AS dept_payroll,
    AVG(salary)     AS avg_salary,
    MIN(salary)     AS min_salary,
    MAX(salary)     AS max_salary
FROM employees
GROUP BY department_id
ORDER BY dept_payroll DESC;

-- Aggregate per customer orders
SELECT
    customer_id,
    COUNT(order_id)      AS order_count,
    SUM(total_amount)    AS total_spent,
    AVG(total_amount)    AS avg_order_value
FROM orders
WHERE customer_id IS NOT NULL
GROUP BY customer_id
ORDER BY total_spent DESC;

-- GROUP BY with HAVING (filter aggregated results)
SELECT
    department_id,
    COUNT(*)  AS headcount
FROM employees
GROUP BY department_id
HAVING headcount > 2;

-- Multiple aggregates in one query
SELECT
    COUNT(*)                     AS total_orders,
    SUM(total_amount)            AS total_revenue,
    AVG(total_amount)            AS avg_order,
    MAX(total_amount)            AS largest_order,
    MIN(total_amount)            AS smallest_order
FROM orders
WHERE status = 'Delivered';
