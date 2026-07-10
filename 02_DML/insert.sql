-- ============================================================
-- SQL Practice | DML - INSERT
-- File: 02_DML/insert.sql
-- ============================================================

USE sql_practice;

-- Insert a single row (all columns)
INSERT INTO departments (department_name, location)
VALUES ('Research & Development', 'Bangalore');

-- Insert a single row (specific columns)
INSERT INTO employees (name, email, department_id, salary, hire_date)
VALUES ('Sophia Adams', 'sophia@company.com', 1, 88000.00, '2024-04-01');

-- Insert multiple rows at once
INSERT INTO customers (customer_name, email, phone, city) VALUES
('Vikram Iyer',   'vikram@mail.com',   '9001002003', 'Surat'),
('Pooja Desal',   'pooja@mail.com',    '9004005006', 'Ahmedabad'),
('Suresh Pandey', 'suresh@mail.com',   '9007008009', 'Bhopal');

-- Insert with SELECT (copy rows from one table to another)
CREATE TABLE IF NOT EXISTS high_salary_employees AS
SELECT employee_id, name, salary
FROM employees
WHERE salary > 80000;

SELECT * FROM high_salary_employees;

-- INSERT IGNORE: skips rows that would cause a duplicate key error
INSERT IGNORE INTO students (name, email, age, enrollment_date)
VALUES ('Aarav Patel', 'aarav@uni.com', 20, '2022-07-01');  -- email already exists

-- INSERT ON DUPLICATE KEY UPDATE
INSERT INTO students (name, email, age, enrollment_date)
VALUES ('Aarav Patel', 'aarav@uni.com', 21, '2022-07-01')
ON DUPLICATE KEY UPDATE age = 21;

-- Verify inserts
SELECT * FROM customers ORDER BY customer_id DESC LIMIT 5;
SELECT * FROM high_salary_employees;

DROP TABLE IF EXISTS high_salary_employees;
