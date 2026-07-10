-- ============================================================
-- SQL Practice | Interview Queries - Department Wise Salary
-- File: 11_Interview_Queries/department_wise_salary.sql
-- ============================================================

USE sql_practice;

-- -------------------------------------------------------
-- Basic: department-wise salary summary
-- -------------------------------------------------------
SELECT
    d.department_name,
    COUNT(e.employee_id)      AS headcount,
    SUM(e.salary)             AS total_salary,
    ROUND(AVG(e.salary), 2)   AS avg_salary,
    MIN(e.salary)             AS min_salary,
    MAX(e.salary)             AS max_salary
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
ORDER BY total_salary DESC;

-- -------------------------------------------------------
-- Salary share percentage per department
-- -------------------------------------------------------
SELECT
    d.department_name,
    SUM(e.salary)                                              AS dept_salary,
    ROUND(SUM(e.salary) / (SELECT SUM(salary) FROM employees) * 100, 2) AS pct_of_total
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
ORDER BY dept_salary DESC;

-- -------------------------------------------------------
-- Department with highest average salary
-- -------------------------------------------------------
SELECT d.department_name, ROUND(AVG(e.salary), 2) AS avg_salary
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
ORDER BY avg_salary DESC
LIMIT 1;

-- -------------------------------------------------------
-- Employees earning above their department average
-- -------------------------------------------------------
SELECT
    e.name,
    e.salary,
    d.department_name,
    ROUND(dept_avg.avg_salary, 2) AS dept_avg_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) dept_avg ON e.department_id = dept_avg.department_id
WHERE e.salary > dept_avg.avg_salary
ORDER BY d.department_name, e.salary DESC;

-- -------------------------------------------------------
-- Using window functions (MySQL 8.0+)
-- -------------------------------------------------------
SELECT
    name,
    salary,
    department_id,
    ROUND(AVG(salary) OVER (PARTITION BY department_id), 2) AS dept_avg,
    SUM(salary)       OVER (PARTITION BY department_id)      AS dept_total,
    RANK()            OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_rank
FROM employees
ORDER BY department_id, salary_rank;

-- -------------------------------------------------------
-- Highest paid employee per department
-- -------------------------------------------------------
SELECT department_id, name, salary
FROM (
    SELECT
        department_id,
        name,
        salary,
        RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rnk
    FROM employees
) ranked
WHERE rnk = 1
ORDER BY department_id;
