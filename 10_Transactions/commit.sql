-- ============================================================
-- SQL Practice | Transactions - COMMIT
-- File: 10_Transactions/commit.sql
-- Description: COMMIT permanently saves all changes made since START TRANSACTION
-- ============================================================

USE sql_practice;

-- Disable autocommit for this session
SET autocommit = 0;

-- -------------------------------------------------------
-- Example 1: Commit a salary update
-- -------------------------------------------------------
START TRANSACTION;

UPDATE employees SET salary = salary * 1.10 WHERE department_id = 1;

-- Verify change (visible within this session before commit)
SELECT employee_id, name, salary FROM employees WHERE department_id = 1;

-- If satisfied, permanently save changes
COMMIT;

-- -------------------------------------------------------
-- Example 2: Transfer order status update (atomic operation)
-- -------------------------------------------------------
START TRANSACTION;

-- Step 1: Mark order as Shipped
UPDATE orders SET status = 'Shipped' WHERE order_id = 3;

-- Step 2: Log the status change
INSERT INTO audit_log (action, table_name, record_id, description)
VALUES ('UPDATE', 'orders', 3, 'Order #3 status changed to Shipped');

-- Both steps succeed — commit
COMMIT;

SELECT * FROM orders WHERE order_id = 3;
SELECT * FROM audit_log ORDER BY changed_at DESC LIMIT 3;

-- -------------------------------------------------------
-- Example 3: Insert multiple related records atomically
-- -------------------------------------------------------
START TRANSACTION;

-- Insert a new customer
INSERT INTO customers (customer_name, email, phone, city)
VALUES ('Ajay Mehta', 'ajay@mail.com', '9876000111', 'Surat');

SET @new_customer = LAST_INSERT_ID();

-- Insert their first order
INSERT INTO orders (customer_id, order_date, total_amount, status)
VALUES (@new_customer, CURDATE(), 4500.00, 'Pending');

-- Commit both together — atomically
COMMIT;

SELECT * FROM customers WHERE customer_name = 'Ajay Mehta';
SELECT * FROM orders   WHERE customer_id = @new_customer;

-- Restore autocommit
SET autocommit = 1;

-- Key Points:
-- COMMIT makes all transaction changes permanent
-- Other sessions see committed changes only after COMMIT
-- Once committed, changes cannot be undone with ROLLBACK
-- Transactions ensure Atomicity (all-or-nothing)
