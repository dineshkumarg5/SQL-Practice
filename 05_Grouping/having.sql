-- ============================================================
-- SQL Practice | Grouping - HAVING
-- File: 05_Grouping/having.sql
-- Description: HAVING filters grouped results (like WHERE but for aggregates)
-- ============================================================

USE sql_practice;

-- HAVING with COUNT: departments with more than 2 employees
SELECT
    department_id,
    COUNT(*) AS headcount
FROM employees
GROUP BY department_id
HAVING headcount > 2;

-- HAVING with AVG: departments where average salary > 70000
SELECT
    d.department_name,
    ROUND(AVG(e.salary), 2) AS avg_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_id, d.department_name
HAVING avg_salary > 70000
ORDER BY avg_salary DESC;

-- HAVING with SUM: customers who have spent more than 5000 total
SELECT
    c.customer_name,
    COUNT(o.order_id)         AS order_count,
    SUM(o.total_amount)       AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING total_spent > 5000
ORDER BY total_spent DESC;

-- WHERE vs HAVING together
-- WHERE filters rows BEFORE grouping; HAVING filters AFTER grouping
SELECT
    d.department_name,
    COUNT(e.employee_id)      AS headcount,
    SUM(e.salary)             AS total_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary > 60000            -- Filter individual rows first
GROUP BY d.department_id, d.department_name
HAVING headcount >= 2             -- Then filter groups
ORDER BY total_salary DESC;

-- HAVING with MIN / MAX
SELECT
    department_id,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary
FROM employees
GROUP BY department_id
HAVING MIN(salary) > 55000;

-- HAVING with multiple conditions
SELECT
    department_id,
    COUNT(*)          AS headcount,
    AVG(salary)       AS avg_salary
FROM employees
GROUP BY department_id
HAVING headcount >= 2 AND AVG(salary) > 70000;

-- Key Points:
-- HAVING filters AFTER GROUP BY (operates on aggregated data)
-- WHERE filters BEFORE GROUP BY (operates on individual rows)
-- You can use column aliases in HAVING (MySQL extension)
-- Without GROUP BY, HAVING treats the whole table as one group
