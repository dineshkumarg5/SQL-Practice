-- ============================================================
-- SQL Practice | Subqueries - Correlated Subquery
-- File: 06_Subqueries/correlated.sql
-- Description: A subquery that references the OUTER query's table
--              Executes once per row in the outer query
-- ============================================================

USE sql_practice;

-- Employees earning more than the average salary of their OWN department
SELECT
    e.name,
    e.salary,
    e.department_id
FROM employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id   -- references outer query
);

-- Find the employee with the highest salary in each department
SELECT
    e.name,
    e.department_id,
    e.salary
FROM employees e
WHERE e.salary = (
    SELECT MAX(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
)
ORDER BY e.department_id;

-- Customers who have placed more orders than average
SELECT
    c.customer_name,
    (SELECT COUNT(*) FROM orders o WHERE o.customer_id = c.customer_id) AS order_count
FROM customers c
WHERE (
    SELECT COUNT(*) FROM orders o WHERE o.customer_id = c.customer_id
) > (
    SELECT AVG(cnt) FROM (
        SELECT COUNT(*) AS cnt FROM orders WHERE customer_id IS NOT NULL GROUP BY customer_id
    ) subq
);

-- EXISTS: find departments that HAVE at least one employee
SELECT department_name
FROM departments d
WHERE EXISTS (
    SELECT 1 FROM employees e WHERE e.department_id = d.department_id
);

-- NOT EXISTS: departments with NO employees
SELECT department_name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1 FROM employees e WHERE e.department_id = d.department_id
);

-- EXISTS: students enrolled in at least one course
SELECT name
FROM students s
WHERE EXISTS (
    SELECT 1 FROM enrollments e WHERE e.student_id = s.student_id
);

-- Correlated subquery in SELECT clause
SELECT
    e.name,
    e.salary,
    (
        SELECT COUNT(*)
        FROM employees e2
        WHERE e2.department_id = e.department_id
    ) AS dept_headcount
FROM employees e
ORDER BY e.department_id;

-- Key Points:
-- Correlated subqueries reference the outer query — they re-execute for every row
-- EXISTS / NOT EXISTS are efficient alternatives to IN / NOT IN with NULLs
-- EXISTS returns TRUE/FALSE; no data is returned from the subquery
-- Can be slow on large datasets; consider JOINs for better performance
