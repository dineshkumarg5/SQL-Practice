-- ============================================================
-- SQL Practice | DML - SELECT
-- File: 02_DML/select.sql
-- ============================================================

USE sql_practice;

-- Select all columns from a table
SELECT * FROM employees;

-- Select specific columns
SELECT name, email, salary FROM employees;

-- Column aliases
SELECT
    name          AS employee_name,
    salary        AS monthly_salary,
    department_id AS dept
FROM employees;

-- Select with arithmetic expressions
SELECT
    name,
    salary,
    salary * 12          AS annual_salary,
    salary * 0.10        AS bonus
FROM employees;

-- Select with string concatenation
SELECT
    CONCAT(name, ' (', email, ')') AS employee_info
FROM employees;

-- Select DISTINCT values
SELECT DISTINCT department_id FROM employees;
SELECT DISTINCT city           FROM customers;

-- Select with LIMIT
SELECT * FROM employees LIMIT 5;

-- Select with LIMIT and OFFSET (pagination)
SELECT * FROM employees LIMIT 5 OFFSET 5;   -- Page 2

-- Select with IF / CASE expression
SELECT
    name,
    salary,
    CASE
        WHEN salary >= 90000 THEN 'Senior'
        WHEN salary >= 70000 THEN 'Mid-Level'
        ELSE                      'Junior'
    END AS grade
FROM employees;

-- Count total rows
SELECT COUNT(*) AS total_employees FROM employees;

-- Select from multiple tables (comma-separated — old-style join)
SELECT e.name, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;
