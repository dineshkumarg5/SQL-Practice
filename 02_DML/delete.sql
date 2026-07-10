-- ============================================================
-- SQL Practice | DML - DELETE
-- File: 02_DML/delete.sql
-- ============================================================

USE sql_practice;

-- Delete a specific row
DELETE FROM customers
WHERE customer_id = 10;

-- Delete rows matching a condition
DELETE FROM orders
WHERE status = 'Cancelled';

-- Delete rows using IN clause
DELETE FROM employees
WHERE department_id IN (
    SELECT department_id FROM departments
    WHERE location = 'Pune'
);

-- Delete with subquery
DELETE FROM orders
WHERE customer_id = (
    SELECT customer_id FROM customers
    WHERE customer_name = 'Vikram Iyer'
);

-- Delete with LIMIT (safe batch deletion)
DELETE FROM audit_log
ORDER BY changed_at ASC
LIMIT 100;

-- Delete all rows (like TRUNCATE but DML — can be rolled back)
-- DELETE FROM audit_log;

-- Verify deletions
SELECT * FROM customers;
SELECT * FROM orders;

-- Key Points:
-- DELETE removes specific rows; table structure remains
-- Always use WHERE to avoid deleting all rows accidentally
-- Supports transactions (can be rolled back unlike TRUNCATE)
-- Fires BEFORE DELETE / AFTER DELETE triggers
