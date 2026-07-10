-- ============================================================
-- SQL Practice | Subqueries - Single Row Subquery
-- File: 06_Subqueries/single_row.sql
-- Description: Subqueries that return exactly ONE row and ONE column
--              Used with =, >, <, >=, <=, <> operators
-- ============================================================

USE sql_practice;

-- Find the employee with the highest salary
SELECT name, salary
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);

-- Find employees earning more than the average salary
SELECT name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY salary DESC;

-- Find employees in the same department as 'Alice Johnson'
SELECT name, department_id
FROM employees
WHERE department_id = (
    SELECT department_id FROM employees WHERE name = 'Alice Johnson'
);

-- Find the most recent order
SELECT * FROM orders
WHERE order_date = (SELECT MAX(order_date) FROM orders);

-- Find the customer who placed the largest order
SELECT customer_name, city
FROM customers
WHERE customer_id = (
    SELECT customer_id
    FROM orders
    WHERE total_amount = (SELECT MAX(total_amount) FROM orders)
    LIMIT 1
);

-- Subquery in SELECT clause (scalar subquery)
SELECT
    name,
    salary,
    (SELECT AVG(salary) FROM employees)               AS company_avg,
    salary - (SELECT AVG(salary) FROM employees)      AS diff_from_avg
FROM employees
ORDER BY diff_from_avg DESC;

-- Subquery in HAVING clause
SELECT department_id, AVG(salary) AS dept_avg
FROM employees
GROUP BY department_id
HAVING AVG(salary) > (SELECT AVG(salary) FROM employees);
