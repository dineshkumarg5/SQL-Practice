-- ============================================================
-- SQL Practice | Joins - SELF JOIN
-- File: 04_Joins/self_join.sql
-- Description: A table joined to itself to compare rows within the same table
--              Commonly used for hierarchical or relational data in one table
-- ============================================================

USE sql_practice;

-- Self Join: list each employee with their manager's name
SELECT
    e.employee_id           AS emp_id,
    e.name                  AS employee_name,
    e.salary                AS emp_salary,
    m.name                  AS manager_name,
    m.salary                AS manager_salary
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id
ORDER BY m.name, e.name;

-- Employees who earn MORE than their manager
SELECT
    e.name   AS employee,
    e.salary AS emp_salary,
    m.name   AS manager,
    m.salary AS mgr_salary
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id
WHERE e.salary > m.salary;

-- Count direct reports per manager
SELECT
    m.employee_id           AS manager_id,
    m.name                  AS manager_name,
    COUNT(e.employee_id)    AS direct_reports
FROM employees m
LEFT JOIN employees e ON m.employee_id = e.manager_id
GROUP BY m.employee_id, m.name
HAVING direct_reports > 0
ORDER BY direct_reports DESC;

-- Find pairs of employees in the same department earning similar salaries
SELECT
    e1.name   AS employee_1,
    e2.name   AS employee_2,
    e1.salary,
    e1.department_id
FROM employees e1
JOIN employees e2
    ON  e1.department_id = e2.department_id
    AND e1.employee_id   < e2.employee_id   -- avoid duplicates and self-pairs
    AND ABS(e1.salary - e2.salary) < 5000   -- within 5000 salary range
ORDER BY e1.department_id;

-- Key Points:
-- A self join uses the same table twice with different aliases
-- Useful for hierarchical data (employee-manager, category-subcategory)
-- Always use table aliases to differentiate the two instances
