-- ============================================================
-- SQL Practice | Subqueries - Multiple Row Subquery
-- File: 06_Subqueries/multiple_row.sql
-- Description: Subqueries that return MULTIPLE rows
--              Used with IN, NOT IN, ANY, ALL operators
-- ============================================================

USE sql_practice;

-- IN: employees in departments located in 'Bangalore'
SELECT name, department_id, salary
FROM employees
WHERE department_id IN (
    SELECT department_id FROM departments WHERE location = 'Bangalore'
);

-- NOT IN: employees NOT in 'Engineering' or 'Finance'
SELECT name, department_id
FROM employees
WHERE department_id NOT IN (
    SELECT department_id FROM departments
    WHERE department_name IN ('Engineering', 'Finance')
);

-- IN with orders: customers who have placed at least one order
SELECT customer_name, city
FROM customers
WHERE customer_id IN (
    SELECT DISTINCT customer_id FROM orders WHERE customer_id IS NOT NULL
);

-- NOT IN: customers who have NEVER placed an order
SELECT customer_name, city
FROM customers
WHERE customer_id NOT IN (
    SELECT DISTINCT customer_id FROM orders WHERE customer_id IS NOT NULL
);

-- ANY: employees earning more than ANY employee in HR (dept 2)
SELECT name, salary
FROM employees
WHERE salary > ANY (
    SELECT salary FROM employees WHERE department_id = 2
)
AND department_id <> 2
ORDER BY salary;

-- ALL: employees earning more than ALL employees in HR
SELECT name, salary
FROM employees
WHERE salary > ALL (
    SELECT salary FROM employees WHERE department_id = 2
)
ORDER BY salary DESC;

-- IN with subquery from enrollment: students enrolled in DBMS course
SELECT name
FROM students
WHERE student_id IN (
    SELECT student_id FROM enrollments WHERE course_id = (
        SELECT course_id FROM courses WHERE course_name LIKE '%Database%'
    )
);

-- Key Points:
-- IN / NOT IN: check if value exists in a list of returned values
-- ANY:  true if condition is true for AT LEAST ONE value in subquery
-- ALL:  true if condition is true for ALL values in subquery
-- Avoid NOT IN with NULLs in subquery — use NOT EXISTS instead
