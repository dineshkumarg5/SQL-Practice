-- ============================================================
-- SQL Practice | Interview Queries - Second Highest Salary
-- File: 11_Interview_Queries/second_highest_salary.sql
-- ============================================================

USE sql_practice;

-- Method 1: Using subquery with MAX
SELECT MAX(salary) AS second_highest_salary
FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);

-- Method 2: Using DISTINCT + ORDER BY + LIMIT OFFSET
SELECT DISTINCT salary AS second_highest_salary
FROM employees
ORDER BY salary DESC
LIMIT 1 OFFSET 1;

-- Method 3: Using DENSE_RANK() window function (MySQL 8.0+)
SELECT salary AS second_highest_salary
FROM (
    SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM employees
) ranked
WHERE rnk = 2
LIMIT 1;

-- With NULL handling: return NULL if second highest doesn't exist
SELECT IFNULL(
    (SELECT DISTINCT salary FROM employees ORDER BY salary DESC LIMIT 1 OFFSET 1),
    NULL
) AS second_highest_salary;

-- With employee details: who earns the second highest salary
SELECT employee_id, name, salary, department_id
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE salary < (SELECT MAX(salary) FROM employees)
);

-- Key Points:
-- MAX within WHERE filters out the highest value first
-- DENSE_RANK() is the modern, clean approach
-- Multiple employees can share the second-highest salary
-- Always handle the edge case where it may not exist (use IFNULL)
