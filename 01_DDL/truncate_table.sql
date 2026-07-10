-- ============================================================
-- SQL Practice | DDL - Truncate Table
-- File: 01_DDL/truncate_table.sql
-- ============================================================

USE sql_practice;

-- Create a demo table for safe truncation
CREATE TABLE IF NOT EXISTS demo_logs (
    log_id    INT          PRIMARY KEY AUTO_INCREMENT,
    message   VARCHAR(255),
    logged_at DATETIME     DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO demo_logs (message) VALUES
('Server started'),
('User logged in'),
('Query executed'),
('User logged out');

SELECT * FROM demo_logs;

-- TRUNCATE removes all rows but keeps the table structure
-- It also resets AUTO_INCREMENT counter
TRUNCATE TABLE demo_logs;

-- Verify: table is empty, AUTO_INCREMENT resets
SELECT * FROM demo_logs;

-- Re-insert to confirm AUTO_INCREMENT started from 1 again
INSERT INTO demo_logs (message) VALUES ('Fresh start after truncate');
SELECT * FROM demo_logs;

-- Key differences: TRUNCATE vs DELETE
-- TRUNCATE: faster, cannot be rolled back (DDL), resets AUTO_INCREMENT
-- DELETE:   slower, can be rolled back (DML), does NOT reset AUTO_INCREMENT

DROP TABLE IF EXISTS demo_logs;
