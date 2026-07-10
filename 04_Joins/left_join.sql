-- ============================================================
-- SQL Practice | Joins - LEFT JOIN
-- File: 04_Joins/left_join.sql
-- Description: Returns ALL rows from the LEFT table + matched rows from RIGHT
--              Unmatched right-side rows appear as NULL
-- ============================================================

USE sql_practice;

-- Basic LEFT JOIN: all employees including those without a department
SELECT
    e.employee_id,
    e.name,
    e.salary,
    d.department_name,
    d.location
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;

-- Find employees with NO department assigned (NULLs from right table)
SELECT
    e.name,
    e.salary
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
WHERE d.department_id IS NULL;

-- All customers including those with no orders
SELECT
    c.customer_name,
    c.city,
    COUNT(o.order_id)       AS order_count,
    COALESCE(SUM(o.total_amount), 0) AS total_spent
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name, c.city
ORDER BY total_spent DESC;

-- Customers who have NEVER placed an order
SELECT
    c.customer_name,
    c.email,
    c.city
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- All departments with their employee count (including empty departments)
SELECT
    d.department_name,
    d.location,
    COUNT(e.employee_id) AS employee_count
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name, d.location
ORDER BY employee_count DESC;

-- All students with their enrollments (students with no courses show NULL)
SELECT
    s.name          AS student_name,
    c.course_name,
    e.grade
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
LEFT JOIN courses     c ON e.course_id  = c.course_id
ORDER BY s.name;
