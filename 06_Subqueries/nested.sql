-- ============================================================
-- SQL Practice | Subqueries - Nested Subquery
-- File: 06_Subqueries/nested.sql
-- Description: Subqueries inside subqueries (multiple levels of nesting)
--              Also covers subqueries in FROM clause (derived tables / inline views)
-- ============================================================

USE sql_practice;

-- Nested subquery: employees earning above overall average,
-- who are in departments with avg salary > 75000
SELECT name, salary, department_id
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
  AND department_id IN (
      SELECT department_id
      FROM employees
      GROUP BY department_id
      HAVING AVG(salary) > 75000
  );

-- Subquery in FROM clause (derived table / inline view)
SELECT dept_summary.department_id, dept_summary.avg_salary
FROM (
    SELECT department_id, ROUND(AVG(salary), 2) AS avg_salary
    FROM employees
    GROUP BY department_id
) AS dept_summary
WHERE dept_summary.avg_salary > 70000;

-- Three-level nested subquery: customer with the most orders
SELECT customer_name
FROM customers
WHERE customer_id = (
    SELECT customer_id
    FROM orders
    WHERE customer_id IS NOT NULL
    GROUP BY customer_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- Nested subquery using derived table to rank by revenue
SELECT
    ranked.customer_id,
    c.customer_name,
    ranked.total_spent
FROM (
    SELECT customer_id, SUM(total_amount) AS total_spent
    FROM orders
    WHERE customer_id IS NOT NULL
    GROUP BY customer_id
    ORDER BY total_spent DESC
    LIMIT 3
) AS ranked
JOIN customers c ON c.customer_id = ranked.customer_id;

-- Nested subquery: get top 2 earners per department
SELECT e.name, e.salary, e.department_id
FROM employees e
WHERE (
    SELECT COUNT(*)
    FROM employees e2
    WHERE e2.department_id = e.department_id
      AND e2.salary >= e.salary
) <= 2
ORDER BY e.department_id, e.salary DESC;

-- Subquery in ORDER BY clause
SELECT name, salary
FROM employees
ORDER BY (
    SELECT AVG(salary) FROM employees e2 WHERE e2.department_id = employees.department_id
) DESC;

-- Key Points:
-- Nested subqueries can go multiple levels deep
-- Subqueries in FROM clause are called derived tables (must be aliased)
-- Each nesting level can reference outer query columns (correlated)
-- Deep nesting reduces readability — consider CTEs (WITH clause) for clarity
