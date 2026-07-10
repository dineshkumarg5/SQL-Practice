-- ============================================================
-- SQL Practice | DDL - Alter Table
-- File: 01_DDL/alter_table.sql
-- ============================================================

USE sql_practice;

-- Add a new column
ALTER TABLE employees
ADD COLUMN phone VARCHAR(20) AFTER email;

-- Modify column data type or size
ALTER TABLE employees
MODIFY COLUMN phone VARCHAR(15);

-- Rename a column
ALTER TABLE employees
RENAME COLUMN phone TO contact_number;

-- Drop a column
ALTER TABLE employees
DROP COLUMN contact_number;

-- Add a NOT NULL constraint
ALTER TABLE customers
MODIFY COLUMN customer_name VARCHAR(100) NOT NULL;

-- Add a UNIQUE constraint
ALTER TABLE students
ADD CONSTRAINT uq_student_email UNIQUE (email);

-- Add a FOREIGN KEY constraint
-- ALTER TABLE orders
-- ADD CONSTRAINT fk_customer
-- FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

-- Drop a FOREIGN KEY constraint
-- ALTER TABLE orders
-- DROP FOREIGN KEY fk_customer;

-- Add a DEFAULT value to a column
ALTER TABLE orders
ALTER COLUMN status SET DEFAULT 'Pending';

-- Verify changes
DESCRIBE employees;
