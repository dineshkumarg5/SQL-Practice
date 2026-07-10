-- ============================================================
-- SQL Practice | Interview Queries - Employees Without Department
-- File: 11_Interview_Queries/employees_without_department.sql
-- ============================================================

USE sql_practice;

-- -------------------------------------------------------
-- Method 1: IS NULL on department_id
-- -------------------------------------------------------
SELECT employee_id, name, email, salary
FROM employees
WHERE department_id IS NULL;

-- -------------------------------------------------------
-- Method 2: LEFT JOIN + NULL check
-- -------------------------------------------------------
SELECT
    e.employee_id,
    e.name,
    e.salary,
    d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
WHERE d.department_id IS NULL;

-- -------------------------------------------------------
-- Method 3: NOT IN with subquery
-- -------------------------------------------------------
SELECT employee_id, name, salary
FROM employees
WHERE department_id NOT IN (
    SELECT department_id FROM departments
);

-- -------------------------------------------------------
-- Method 4: NOT EXISTS
-- -------------------------------------------------------
SELECT e.employee_id, e.name, e.salary
FROM employees e
WHERE NOT EXISTS (
    SELECT 1 FROM departments d WHERE d.department_id = e.department_id
);

-- -------------------------------------------------------
-- Extension: Departments with NO employees
-- -------------------------------------------------------
SELECT d.department_id, d.department_name, d.location
FROM departments d
WHERE NOT EXISTS (
    SELECT 1 FROM employees e WHERE e.department_id = d.department_id
);

-- Using LEFT JOIN
SELECT d.department_id, d.department_name
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
WHERE e.employee_id IS NULL;

-- -------------------------------------------------------
-- Practical view: all employees with their dept or 'Unassigned'
-- -------------------------------------------------------
SELECT
    e.employee_id,
    e.name,
    e.salary,
    COALESCE(d.department_name, 'Unassigned') AS department
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
ORDER BY department, e.name;
