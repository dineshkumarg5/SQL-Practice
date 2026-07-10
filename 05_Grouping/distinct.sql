-- ============================================================
-- SQL Practice | Grouping - DISTINCT
-- File: 05_Grouping/distinct.sql
-- ============================================================

USE sql_practice;

-- DISTINCT on a single column
SELECT DISTINCT department_id FROM employees ORDER BY department_id;
SELECT DISTINCT city           FROM customers ORDER BY city;
SELECT DISTINCT status         FROM orders;

-- DISTINCT on multiple columns (unique combination)
SELECT DISTINCT department_id, salary FROM employees ORDER BY department_id, salary;

-- COUNT DISTINCT: how many unique departments have employees
SELECT COUNT(DISTINCT department_id) AS dept_with_employees FROM employees;
SELECT COUNT(DISTINCT customer_id)   AS customers_who_ordered FROM orders;
SELECT COUNT(DISTINCT course_id)     AS courses_with_students FROM enrollments;

-- DISTINCT vs GROUP BY (often interchangeable for simple use cases)
-- Using DISTINCT
SELECT DISTINCT department_id FROM employees;

-- Using GROUP BY (same result)
SELECT department_id FROM employees GROUP BY department_id;

-- DISTINCT with ORDER BY
SELECT DISTINCT city FROM customers ORDER BY city ASC;

-- DISTINCT in a subquery to find unique customers who ordered
SELECT customer_name
FROM customers
WHERE customer_id IN (
    SELECT DISTINCT customer_id FROM orders WHERE customer_id IS NOT NULL
);

-- DISTINCT with JOIN
SELECT DISTINCT
    d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary > 80000;

-- Practical: unique grades given
SELECT DISTINCT grade FROM enrollments ORDER BY grade;

-- Key Points:
-- DISTINCT removes duplicate rows from the result set
-- Works across all selected columns (not just one)
-- Can be used inside COUNT(DISTINCT col)
-- Slightly slower than without DISTINCT due to deduplication step
