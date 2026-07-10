-- ============================================================
-- SQL Practice | Grouping - GROUP BY
-- File: 05_Grouping/group_by.sql
-- ============================================================

USE sql_practice;

-- Basic GROUP BY
SELECT department_id, COUNT(*) AS headcount
FROM employees
GROUP BY department_id;

-- GROUP BY with multiple aggregate functions
SELECT
    department_id,
    COUNT(*)                  AS headcount,
    SUM(salary)               AS total_salary,
    ROUND(AVG(salary), 2)     AS avg_salary,
    MIN(salary)               AS min_salary,
    MAX(salary)               AS max_salary
FROM employees
GROUP BY department_id
ORDER BY total_salary DESC;

-- GROUP BY with JOIN (show department name instead of ID)
SELECT
    d.department_name,
    d.location,
    COUNT(e.employee_id)      AS headcount,
    ROUND(AVG(e.salary), 2)   AS avg_salary
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name, d.location
ORDER BY headcount DESC;

-- GROUP BY on orders
SELECT
    status,
    COUNT(order_id)           AS order_count,
    SUM(total_amount)         AS revenue,
    ROUND(AVG(total_amount),2) AS avg_value
FROM orders
GROUP BY status
ORDER BY revenue DESC;

-- GROUP BY by year and month
SELECT
    YEAR(order_date)          AS order_year,
    MONTH(order_date)         AS order_month,
    COUNT(order_id)           AS orders_count,
    SUM(total_amount)         AS monthly_revenue
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY order_year, order_month;

-- GROUP BY on students per course
SELECT
    c.course_name,
    COUNT(e.student_id)       AS enrolled_students,
    AVG(
        CASE e.grade
            WHEN 'A+'  THEN 10
            WHEN 'A'   THEN 9
            WHEN 'B+'  THEN 8
            WHEN 'B'   THEN 7
            WHEN 'C'   THEN 6
            ELSE 5
        END
    )                         AS avg_grade_points
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
ORDER BY enrolled_students DESC;

-- GROUP BY city (customers)
SELECT city, COUNT(*) AS customer_count
FROM customers
GROUP BY city
ORDER BY customer_count DESC;
