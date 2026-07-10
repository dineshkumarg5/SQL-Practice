-- ============================================================
-- SQL Practice | DDL - Rename Table
-- File: 01_DDL/rename_table.sql
-- ============================================================

USE sql_practice;

-- Method 1: RENAME TABLE statement
CREATE TABLE IF NOT EXISTS temp_employees (
    id   INT PRIMARY KEY,
    name VARCHAR(100)
);

RENAME TABLE temp_employees TO backup_employees;

-- Verify rename
SHOW TABLES;

-- Method 2: ALTER TABLE ... RENAME TO
ALTER TABLE backup_employees
RENAME TO old_employees;

SHOW TABLES;

-- Rename multiple tables in a single statement
-- RENAME TABLE table_one TO table_one_bak,
--              table_two TO table_two_bak;

-- Clean up
DROP TABLE IF EXISTS old_employees;
