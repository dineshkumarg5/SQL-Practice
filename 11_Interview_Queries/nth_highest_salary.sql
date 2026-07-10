-- ============================================================
-- SQL Practice | Interview Queries - Nth Highest Salary
-- File: 11_Interview_Queries/nth_highest_salary.sql
-- ============================================================

USE sql_practice;

-- Method 1: Using DENSE_RANK() — most interview-friendly
-- Change @n to get any Nth highest salary
SET @n = 3;

SELECT salary AS nth_highest_salary
FROM (
    SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM employees
) ranked
WHERE rnk = @n
LIMIT 1;

-- Method 2: Using LIMIT with OFFSET (set N-1 as offset)
-- N = 3: LIMIT 1 OFFSET 2
SELECT DISTINCT salary AS third_highest_salary
FROM employees
ORDER BY salary DESC
LIMIT 1 OFFSET 2;

-- Method 3: Stored function to get Nth highest salary
DELIMITER $$
DROP FUNCTION IF EXISTS fn_nth_highest_salary$$

CREATE FUNCTION fn_nth_highest_salary(n INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE result DECIMAL(10,2);
    SET n = n - 1;
    SELECT DISTINCT salary INTO result
    FROM employees
    ORDER BY salary DESC
    LIMIT 1 OFFSET n;
    RETURN result;
END$$

DELIMITER ;

-- Test the function
SELECT fn_nth_highest_salary(1) AS first_highest;
SELECT fn_nth_highest_salary(2) AS second_highest;
SELECT fn_nth_highest_salary(3) AS third_highest;
SELECT fn_nth_highest_salary(4) AS fourth_highest;

-- Full result: all employees with salary rank
SELECT
    employee_id,
    name,
    salary,
    DENSE_RANK()  OVER (ORDER BY salary DESC) AS dense_rank,
    RANK()        OVER (ORDER BY salary DESC) AS rank_val,
    ROW_NUMBER()  OVER (ORDER BY salary DESC) AS row_num
FROM employees
ORDER BY salary DESC;

-- Difference between RANK, DENSE_RANK, ROW_NUMBER
-- RANK:        gaps after ties     (1, 2, 2, 4)
-- DENSE_RANK:  no gaps after ties  (1, 2, 2, 3)
-- ROW_NUMBER:  always unique       (1, 2, 3, 4)

DROP FUNCTION IF EXISTS fn_nth_highest_salary;
