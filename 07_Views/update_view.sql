-- ============================================================
-- SQL Practice | Views - Update View
-- File: 07_Views/update_view.sql
-- ============================================================

USE sql_practice;

-- Ensure the base view exists
CREATE OR REPLACE VIEW vw_employee_details AS
SELECT
    e.employee_id,
    e.name          AS employee_name,
    e.email,
    e.salary,
    e.hire_date,
    d.department_name,
    d.location
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;

-- -------------------------------------------------------
-- METHOD 1: Replace the view definition with CREATE OR REPLACE VIEW
-- -------------------------------------------------------
CREATE OR REPLACE VIEW vw_employee_details AS
SELECT
    e.employee_id,
    e.name          AS employee_name,
    e.email,
    e.salary,
    e.hire_date,
    DATEDIFF(CURDATE(), e.hire_date) AS days_employed,   -- New column added
    d.department_name,
    d.location
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;

SELECT * FROM vw_employee_details LIMIT 5;

-- -------------------------------------------------------
-- METHOD 2: ALTER VIEW
-- -------------------------------------------------------
ALTER VIEW vw_high_salary_employees AS
SELECT employee_id, name, salary, department_id, hire_date
FROM employees
WHERE salary > 75000;   -- Threshold changed from 80000 to 75000

SELECT * FROM vw_high_salary_employees;

-- -------------------------------------------------------
-- DML through a view (Updatable Views)
-- A simple single-table view without GROUP BY / DISTINCT / subquery IS updatable
-- -------------------------------------------------------
CREATE OR REPLACE VIEW vw_simple_employees AS
SELECT employee_id, name, salary FROM employees;

-- Update through the view (modifies the base table)
UPDATE vw_simple_employees
SET salary = salary * 1.05
WHERE employee_id = 1;

-- Insert through a simple view
-- INSERT INTO vw_simple_employees (name, salary) VALUES ('Test User', 50000);
-- (Works only if view covers all NOT NULL columns of the base table)

-- Verify update
SELECT employee_id, name, salary FROM employees WHERE employee_id = 1;

-- Views that are NOT updatable:
-- - Views with JOIN, UNION, GROUP BY, HAVING, DISTINCT, aggregates
-- - Views with subqueries in SELECT list

-- Key Points:
-- Use CREATE OR REPLACE VIEW to update view definition without dropping it
-- ALTER VIEW is an explicit alternative
-- Simple single-table views support INSERT/UPDATE/DELETE
-- Complex views (joins, aggregates) are read-only
