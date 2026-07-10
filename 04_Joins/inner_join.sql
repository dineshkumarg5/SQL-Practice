-- ============================================================
-- SQL Practice | Joins - INNER JOIN
-- File: 04_Joins/inner_join.sql
-- Description: Returns only rows where there is a match in BOTH tables
-- ============================================================

USE sql_practice;

-- Basic INNER JOIN: employees with their department name
SELECT
    e.employee_id,
    e.name          AS employee_name,
    e.salary,
    d.department_name,
    d.location
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;

-- INNER JOIN with WHERE filter
SELECT
    e.name,
    e.salary,
    d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Engineering'
ORDER BY e.salary DESC;

-- INNER JOIN: orders with customer details
SELECT
    o.order_id,
    c.customer_name,
    c.city,
    o.order_date,
    o.total_amount,
    o.status
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.order_date DESC;

-- Three-table INNER JOIN: students, enrollments, courses
SELECT
    s.name          AS student_name,
    c.course_name,
    c.instructor,
    e.grade
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN courses     c ON e.course_id  = c.course_id
ORDER BY s.name, c.course_name;

-- INNER JOIN with aggregate
SELECT
    d.department_name,
    COUNT(e.employee_id)      AS headcount,
    ROUND(AVG(e.salary), 2)  AS avg_salary
FROM departments d
INNER JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY avg_salary DESC;

-- Key Points:
-- INNER JOIN = JOIN (they are equivalent)
-- Returns only matched rows; unmatched rows from either table are excluded
-- Most commonly used join type
