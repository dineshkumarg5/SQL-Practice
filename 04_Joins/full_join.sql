-- ============================================================
-- SQL Practice | Joins - FULL JOIN (FULL OUTER JOIN)
-- File: 04_Joins/full_join.sql
-- Description: Returns ALL rows from BOTH tables
--              NULL fills where there is no match on either side
--              MySQL doesn't support FULL OUTER JOIN natively —
--              achieved using UNION of LEFT JOIN and RIGHT JOIN
-- ============================================================

USE sql_practice;

-- FULL JOIN: all employees AND all departments (with NULL where no match)
SELECT
    e.employee_id,
    e.name          AS employee_name,
    d.department_name,
    d.location
FROM employees e
LEFT JOIN departments d  ON e.department_id = d.department_id

UNION

SELECT
    e.employee_id,
    e.name          AS employee_name,
    d.department_name,
    d.location
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.department_id;

-- FULL JOIN: all customers AND all orders (including guest orders & inactive customers)
SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.total_amount,
    o.status
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id

UNION

SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.total_amount,
    o.status
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id;

-- FULL JOIN to find unmatched rows on BOTH sides
-- (employees without dept OR depts without employees)
SELECT
    e.name          AS employee_name,
    d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
WHERE d.department_id IS NULL

UNION

SELECT
    e.name          AS employee_name,
    d.department_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.department_id
WHERE e.employee_id IS NULL;

-- Key Points:
-- FULL OUTER JOIN = LEFT JOIN UNION RIGHT JOIN (MySQL workaround)
-- Returns all rows from both tables
-- NULL fills unmatched columns
-- Use UNION (not UNION ALL) to avoid duplicates in matched rows
