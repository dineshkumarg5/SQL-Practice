-- ============================================================
-- SQL Practice | DML - WHERE Clause
-- File: 02_DML/where_clause.sql
-- ============================================================

USE sql_practice;

-- Basic WHERE condition
SELECT * FROM employees WHERE department_id = 1;

-- Comparison operators
SELECT name, salary FROM employees WHERE salary > 80000;
SELECT name, salary FROM employees WHERE salary <= 60000;
SELECT name, salary FROM employees WHERE salary <> 95000;  -- Not equal

-- AND / OR / NOT operators
SELECT * FROM employees
WHERE department_id = 1 AND salary > 85000;

SELECT * FROM employees
WHERE department_id = 1 OR department_id = 3;

SELECT * FROM employees
WHERE NOT department_id = 2;

-- BETWEEN ... AND
SELECT name, salary FROM employees
WHERE salary BETWEEN 60000 AND 90000;

SELECT * FROM orders
WHERE order_date BETWEEN '2024-01-01' AND '2024-06-30';

-- IN / NOT IN
SELECT * FROM employees
WHERE department_id IN (1, 3, 5);

SELECT * FROM customers
WHERE city NOT IN ('Bangalore', 'Mumbai');

-- LIKE (pattern matching)
SELECT * FROM employees WHERE name LIKE 'A%';        -- Starts with A
SELECT * FROM employees WHERE name LIKE '%son';       -- Ends with son
SELECT * FROM employees WHERE email LIKE '%@company%'; -- Contains @company
SELECT * FROM employees WHERE name LIKE '_o%';        -- Second char is 'o'

-- IS NULL / IS NOT NULL
SELECT * FROM employees WHERE manager_id IS NULL;     -- Top-level managers
SELECT * FROM orders   WHERE customer_id IS NULL;     -- Orders with no customer

-- Combined complex condition
SELECT name, salary, department_id
FROM employees
WHERE salary > 60000
  AND department_id IN (1, 2, 3)
  AND name LIKE 'A%' OR name LIKE 'B%';
