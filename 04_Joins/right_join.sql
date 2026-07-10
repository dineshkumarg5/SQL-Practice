-- ============================================================
-- SQL Practice | Joins - RIGHT JOIN
-- File: 04_Joins/right_join.sql
-- Description: Returns ALL rows from the RIGHT table + matched rows from LEFT
--              Unmatched left-side rows appear as NULL
-- ============================================================

USE sql_practice;

-- Basic RIGHT JOIN: all departments including those with no employees
SELECT
    e.name          AS employee_name,
    e.salary,
    d.department_name,
    d.location
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.department_id;

-- Departments that have NO employees
SELECT
    d.department_name,
    d.location
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.department_id
WHERE e.employee_id IS NULL;

-- All orders including orders with no linked customer
SELECT
    c.customer_name,
    c.city,
    o.order_id,
    o.total_amount,
    o.status
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id;

-- Orders that have NO customer record (orphaned orders)
SELECT
    o.order_id,
    o.order_date,
    o.total_amount,
    o.status
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id
WHERE c.customer_id IS NULL;

-- All courses with enrolled students (show courses with no students too)
SELECT
    c.course_name,
    c.instructor,
    COUNT(e.student_id) AS enrolled_count
FROM enrollments e
RIGHT JOIN courses c ON e.course_id = c.course_id
GROUP BY c.course_id, c.course_name, c.instructor
ORDER BY enrolled_count DESC;

-- Note: RIGHT JOIN is rarely used in practice.
-- A RIGHT JOIN (A, B) is equivalent to LEFT JOIN (B, A) with tables swapped.
-- Most developers prefer LEFT JOIN for readability.
