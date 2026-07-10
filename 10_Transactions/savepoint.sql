-- ============================================================
-- SQL Practice | Transactions - SAVEPOINT
-- File: 10_Transactions/savepoint.sql
-- Description: SAVEPOINTs allow partial rollback within a transaction
-- ============================================================

USE sql_practice;

SET autocommit = 0;

-- -------------------------------------------------------
-- Example 1: Basic SAVEPOINT usage
-- -------------------------------------------------------
START TRANSACTION;

-- Step 1
INSERT INTO audit_log (action, table_name, record_id, description)
VALUES ('TEST', 'audit_log', 0, 'Step 1 completed');

SAVEPOINT sp_after_step1;

-- Step 2
UPDATE employees SET salary = salary + 1000 WHERE employee_id = 2;

SAVEPOINT sp_after_step2;

-- Step 3 (something goes wrong)
UPDATE employees SET salary = -5000 WHERE employee_id = 3;  -- Bad data!

-- Rollback only to Step 2 (undo Step 3 but keep Steps 1 & 2)
ROLLBACK TO SAVEPOINT sp_after_step2;

-- Verify: employee 2 updated, employee 3 unchanged
SELECT employee_id, name, salary FROM employees WHERE employee_id IN (2, 3);

-- Release a savepoint (optional cleanup)
RELEASE SAVEPOINT sp_after_step1;

-- Commit the good parts (Step 1 + Step 2)
COMMIT;

-- -------------------------------------------------------
-- Example 2: Multi-stage order processing with savepoints
-- -------------------------------------------------------
START TRANSACTION;

SAVEPOINT sp_start;

-- Stage 1: Update order status
UPDATE orders SET status = 'Processing' WHERE order_id = 5;
SAVEPOINT sp_stage1;

-- Stage 2: Create audit entry
INSERT INTO audit_log (action, table_name, record_id, description)
VALUES ('UPDATE', 'orders', 5, 'Order #5 moved to Processing');
SAVEPOINT sp_stage2;

-- Stage 3: (assume this stage fails — rollback to stage2)
-- UPDATE orders SET status = 'Invalid' WHERE order_id = 5;
-- ROLLBACK TO SAVEPOINT sp_stage2;

-- All good — commit everything
COMMIT;

SELECT * FROM orders     WHERE order_id = 5;
SELECT * FROM audit_log  ORDER BY changed_at DESC LIMIT 3;

SET autocommit = 1;

-- Key Points:
-- SAVEPOINT creates a named checkpoint within a transaction
-- ROLLBACK TO SAVEPOINT undoes changes AFTER the savepoint (not the whole transaction)
-- RELEASE SAVEPOINT removes the savepoint marker (doesn't commit or rollback)
-- Multiple savepoints can exist simultaneously within one transaction
-- Savepoints are automatically released on COMMIT or full ROLLBACK
