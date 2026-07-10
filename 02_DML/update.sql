-- ============================================================
-- SQL Practice | DML - UPDATE
-- File: 02_DML/update.sql
-- ============================================================

USE sql_practice;

-- Update a single column for a specific row
UPDATE employees
SET salary = 100000.00
WHERE employee_id = 1;

-- Update multiple columns at once
UPDATE employees
SET salary    = 70000.00,
    hire_date = '2020-01-01'
WHERE employee_id = 10;

-- Update rows based on a condition
UPDATE employees
SET salary = salary * 1.10        -- 10% pay raise
WHERE department_id = 1;          -- For all Engineering staff

-- Update using a subquery in WHERE clause
UPDATE employees
SET salary = salary * 1.05
WHERE department_id = (
    SELECT department_id
    FROM departments
    WHERE department_name = 'Finance'
);

-- Update all rows (no WHERE clause - use with caution!)
-- UPDATE orders SET status = 'Processing' WHERE status = 'Pending';

-- Safe update with LIMIT
UPDATE orders
SET status = 'Cancelled'
WHERE status = 'Pending'
  AND order_date < '2024-03-01'
LIMIT 5;

-- Verify changes
SELECT employee_id, name, salary, department_id FROM employees ORDER BY employee_id;
SELECT order_id, status, order_date FROM orders WHERE status = 'Cancelled';
