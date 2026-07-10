-- ============================================================
-- SQL Practice | DML - ORDER BY
-- File: 02_DML/order_by.sql
-- ============================================================

USE sql_practice;

-- Sort ascending (default)
SELECT name, salary FROM employees
ORDER BY salary ASC;

-- Sort descending
SELECT name, salary FROM employees
ORDER BY salary DESC;

-- Sort by multiple columns
SELECT name, department_id, salary FROM employees
ORDER BY department_id ASC, salary DESC;

-- Sort by column alias
SELECT name, salary * 12 AS annual_salary
FROM employees
ORDER BY annual_salary DESC;

-- Sort by column position (column 2 = salary)
SELECT name, salary FROM employees
ORDER BY 2 DESC;

-- ORDER BY with WHERE
SELECT name, salary, department_id
FROM employees
WHERE department_id = 1
ORDER BY salary DESC;

-- ORDER BY with LIMIT (Top-N pattern)
SELECT name, salary FROM employees
ORDER BY salary DESC
LIMIT 5;

-- ORDER BY with NULL values (NULLs appear last in ASC, first in DESC by default)
SELECT name, manager_id FROM employees
ORDER BY manager_id ASC;    -- NULLs (top managers) appear first

-- ORDER BY with CASE expression (custom sort order)
SELECT name, status FROM orders
ORDER BY
    CASE status
        WHEN 'Delivered'  THEN 1
        WHEN 'Shipped'    THEN 2
        WHEN 'Processing' THEN 3
        WHEN 'Pending'    THEN 4
        WHEN 'Cancelled'  THEN 5
        ELSE 6
    END;

-- ORDER BY on a string column
SELECT customer_name, city FROM customers
ORDER BY city ASC, customer_name ASC;
