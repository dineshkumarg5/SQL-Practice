-- ============================================================
-- SQL Practice | Interview Queries - Top N Salary
-- File: 11_Interview_Queries/top_n_salary.sql
-- ============================================================

USE sql_practice;

-- -------------------------------------------------------
-- Top 3 salaries (overall)
-- -------------------------------------------------------

-- Method 1: DISTINCT + ORDER BY + LIMIT
SELECT DISTINCT salary
FROM employees
ORDER BY salary DESC
LIMIT 3;

-- Method 2: With employee names
SELECT name, salary, department_id
FROM employees
ORDER BY salary DESC
LIMIT 3;

-- -------------------------------------------------------
-- Top N salary per department (using DENSE_RANK)
-- -------------------------------------------------------
-- Top 2 salaries per department
SELECT department_id, name, salary, rnk
FROM (
    SELECT
        department_id,
        name,
        salary,
        DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rnk
    FROM employees
) ranked
WHERE rnk <= 2
ORDER BY department_id, rnk;

-- -------------------------------------------------------
-- Top 3 earners overall (with rank details)
-- -------------------------------------------------------
SELECT
    name,
    salary,
    DENSE_RANK()  OVER (ORDER BY salary DESC) AS dense_rank,
    RANK()        OVER (ORDER BY salary DESC) AS rank_val,
    ROW_NUMBER()  OVER (ORDER BY salary DESC) AS row_num
FROM employees
ORDER BY salary DESC
LIMIT 10;

-- -------------------------------------------------------
-- Bottom 3 salaries (using ASC order)
-- -------------------------------------------------------
SELECT name, salary
FROM employees
ORDER BY salary ASC
LIMIT 3;

-- -------------------------------------------------------
-- Top customer by spending
-- -------------------------------------------------------
SELECT
    c.customer_name,
    SUM(o.total_amount)  AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC
LIMIT 3;

-- -------------------------------------------------------
-- Top N courses by enrollment
-- -------------------------------------------------------
SELECT
    c.course_name,
    COUNT(e.student_id) AS enrolled_count
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
ORDER BY enrolled_count DESC
LIMIT 3;

-- -------------------------------------------------------
-- Percentile-based top earners (top 20% by salary)
-- -------------------------------------------------------
SELECT name, salary, dept_pct
FROM (
    SELECT
        name,
        salary,
        PERCENT_RANK() OVER (ORDER BY salary) AS dept_pct
    FROM employees
) ranked
WHERE dept_pct >= 0.80
ORDER BY salary DESC;
