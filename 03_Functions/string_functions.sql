-- ============================================================
-- SQL Practice | Functions - String Functions
-- File: 03_Functions/string_functions.sql
-- ============================================================

USE sql_practice;

-- UPPER / LOWER
SELECT UPPER(name)  AS name_upper FROM employees;
SELECT LOWER(email) AS email_lower FROM employees;

-- LENGTH / CHAR_LENGTH
SELECT name, LENGTH(name)      AS byte_length FROM employees;
SELECT name, CHAR_LENGTH(name) AS char_length FROM employees;

-- TRIM / LTRIM / RTRIM
SELECT TRIM('  SQL Practice  ')    AS trimmed;
SELECT LTRIM('   left space')      AS left_trimmed;
SELECT RTRIM('right space   ')     AS right_trimmed;

-- SUBSTRING / SUBSTR
SELECT name, SUBSTRING(name, 1, 5) AS first_5_chars FROM employees;
SELECT SUBSTR(email, 1, INSTR(email, '@') - 1) AS username FROM employees;

-- CONCAT / CONCAT_WS
SELECT CONCAT(name, ' - ', email)          AS full_info   FROM employees;
SELECT CONCAT_WS(', ', name, email, city)  AS customer_csv FROM customers;

-- REPLACE
SELECT REPLACE(email, '@company.com', '@corp.org') AS new_email FROM employees;

-- INSTR (find position of substring)
SELECT name, INSTR(name, ' ') AS space_position FROM employees;

-- LEFT / RIGHT
SELECT LEFT(name, 5)   AS first_5 FROM employees;
SELECT RIGHT(email, 11) AS domain  FROM employees;

-- REPEAT / SPACE / LPAD / RPAD
SELECT REPEAT('*', 5)               AS stars;
SELECT LPAD(employee_id, 6, '0')    AS padded_id FROM employees;
SELECT RPAD(name, 20, '.')          AS padded_name FROM employees;

-- REVERSE
SELECT name, REVERSE(name) AS reversed_name FROM employees LIMIT 5;

-- FORMAT (number formatting)
SELECT FORMAT(salary, 2) AS formatted_salary FROM employees;

-- Practical example: extract first and last name
SELECT
    name,
    SUBSTRING_INDEX(name, ' ', 1)   AS first_name,
    SUBSTRING_INDEX(name, ' ', -1)  AS last_name
FROM employees;
