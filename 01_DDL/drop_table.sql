-- ============================================================
-- SQL Practice | DDL - Drop Table
-- File: 01_DDL/drop_table.sql
-- ============================================================

USE sql_practice;

-- Create tables to demonstrate DROP
CREATE TABLE IF NOT EXISTS test_table_a (
    id   INT PRIMARY KEY,
    data VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS test_table_b (
    id      INT PRIMARY KEY,
    a_id    INT,
    FOREIGN KEY (a_id) REFERENCES test_table_a(id)
);

-- Drop a table (fails if foreign keys reference it)
-- DROP TABLE test_table_a;  -- This would fail due to FK in test_table_b

-- Drop child table first, then parent
DROP TABLE IF EXISTS test_table_b;
DROP TABLE IF EXISTS test_table_a;

-- Verify tables are gone
SHOW TABLES;

-- DROP DATABASE example (commented out for safety)
-- DROP DATABASE IF EXISTS sample_test_db;

-- Key Points:
-- DROP TABLE removes the table structure AND all data permanently
-- IF EXISTS prevents error if the table doesn't exist
-- Cannot DROP a table that is referenced by a FOREIGN KEY constraint
-- DDL operation: cannot be rolled back in MySQL
