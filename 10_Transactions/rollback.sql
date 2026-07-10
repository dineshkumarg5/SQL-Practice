-- ============================================================
-- SQL Practice | Transactions - ROLLBACK
-- File: 10_Transactions/rollback.sql
-- Description: ROLLBACK undoes all changes made since START TRANSACTION
-- ============================================================

USE sql_practice;

SET autocommit = 0;

-- -------------------------------------------------------
-- Example 1: Rollback an accidental mass update
-- -------------------------------------------------------
START TRANSACTION;

-- Oops: accidentally update ALL employees' salaries
UPDATE employees SET salary = 99999.00;

-- Check the damage
SELECT employee_id, name, salary FROM employees LIMIT 5;

-- Undo the mistake
ROLLBACK;

-- Verify: salaries restored
SELECT employee_id, name, salary FROM employees LIMIT 5;

-- -------------------------------------------------------
-- Example 2: Rollback on error (simulated)
-- -------------------------------------------------------
START TRANSACTION;

UPDATE orders SET status = 'Cancelled' WHERE order_id = 6;
INSERT INTO audit_log (action, table_name, record_id, description)
VALUES ('UPDATE', 'orders', 6, 'Order cancelled');

-- Simulate a business rule check
-- If order total > 5000, don't allow cancellation
-- (In real code, this check would happen in app logic or procedure)
-- For demo: rollback manually
ROLLBACK;

SELECT * FROM orders WHERE order_id = 6;   -- Status unchanged

-- -------------------------------------------------------
-- Example 3: Rollback vs Commit (full decision flow)
-- -------------------------------------------------------
START TRANSACTION;

SET @new_salary = 120000.00;

UPDATE employees SET salary = @new_salary WHERE employee_id = 1;

-- Check if new salary is within budget cap
SELECT @budget_ok := (SELECT SUM(salary) FROM employees) < 1500000;

-- If budget exceeded, rollback; otherwise commit
-- (MySQL doesn't support IF in plain scripts — use procedure for real logic)
-- For demo, we simulate rollback:
ROLLBACK;

SELECT name, salary FROM employees WHERE employee_id = 1;

SET autocommit = 1;

-- Key Points:
-- ROLLBACK undoes all uncommitted changes in the current transaction
-- Does NOT undo committed changes (COMMIT is final)
-- Does NOT undo DDL statements (CREATE, DROP, ALTER auto-commit)
-- ROLLBACK is your safety net during multi-step DML operations
-- Always pair with error handling in stored procedures (DECLARE HANDLER)
