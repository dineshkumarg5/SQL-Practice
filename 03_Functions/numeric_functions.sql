-- ============================================================
-- SQL Practice | Functions - Numeric Functions
-- File: 03_Functions/numeric_functions.sql
-- ============================================================

USE sql_practice;

-- ROUND
SELECT salary, ROUND(salary, -3)    AS rounded_to_thousands FROM employees;
SELECT ROUND(3.14159, 2)            AS pi_rounded;

-- FLOOR / CEIL / CEILING
SELECT salary, FLOOR(salary / 1000) AS thousands FROM employees;
SELECT CEIL(4.1)                    AS ceiling_val;
SELECT FLOOR(4.9)                   AS floor_val;

-- ABS (absolute value)
SELECT ABS(-5000)    AS absolute_val;
SELECT ABS(5000)     AS absolute_val;

-- MOD (modulus / remainder)
SELECT MOD(10, 3)    AS remainder;          -- Returns 1
SELECT employee_id, MOD(employee_id, 2) AS is_even FROM employees;

-- POWER / POW
SELECT POW(2, 10)    AS two_to_ten;         -- 1024
SELECT POWER(9, 0.5) AS square_root_of_9;  -- 3

-- SQRT
SELECT SQRT(144)     AS square_root;

-- TRUNCATE (different from TRUNC in Oracle; truncates decimal places)
SELECT TRUNCATE(salary, -3)          AS truncated_salary FROM employees;
SELECT TRUNCATE(3.99999, 2)          AS truncated;

-- GREATEST / LEAST
SELECT GREATEST(10, 25, 5, 88, 3)   AS greatest_val;
SELECT LEAST(10, 25, 5, 88, 3)      AS least_val;

-- SIGN
SELECT SIGN(-50)    AS negative_sign;   -- -1
SELECT SIGN(0)      AS zero_sign;       --  0
SELECT SIGN(50)     AS positive_sign;   --  1

-- Practical: salary bands
SELECT
    name,
    salary,
    FLOOR(salary / 10000) * 10000               AS salary_band_start,
    FLOOR(salary / 10000) * 10000 + 9999        AS salary_band_end
FROM employees
ORDER BY salary_band_start;

-- Random number
SELECT RAND()                  AS random_number;
SELECT FLOOR(RAND() * 100) + 1 AS random_1_to_100;
