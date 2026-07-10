-- ============================================================
-- SQL Practice | Triggers - BEFORE UPDATE
-- File: 09_Triggers/before_update.sql
-- Description: Fires BEFORE an UPDATE is applied to a row
--              Access OLD (original) and NEW (updated) values
-- ============================================================

USE sql_practice;

DELIMITER $$

-- BEFORE UPDATE trigger: prevent salary reduction > 20%
DROP TRIGGER IF EXISTS trg_before_update_salary$$

CREATE TRIGGER trg_before_update_salary
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    -- Block drastic salary cuts
    IF NEW.salary < OLD.salary * 0.80 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary reduction cannot exceed 20% at a time.';
    END IF;
END$$

-- BEFORE UPDATE trigger: track salary changes in audit_log
DROP TRIGGER IF EXISTS trg_before_update_employee$$

CREATE TRIGGER trg_before_update_employee
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    -- Only log if salary actually changed
    IF OLD.salary <> NEW.salary THEN
        INSERT INTO audit_log (action, table_name, record_id, description)
        VALUES (
            'UPDATE',
            'employees',
            OLD.employee_id,
            CONCAT('Salary changed for ', OLD.name,
                   ' from ', OLD.salary, ' to ', NEW.salary)
        );
    END IF;

    -- Only log if department changed
    IF OLD.department_id <> NEW.department_id THEN
        INSERT INTO audit_log (action, table_name, record_id, description)
        VALUES (
            'UPDATE',
            'employees',
            OLD.employee_id,
            CONCAT(OLD.name, ' moved from dept ', OLD.department_id,
                   ' to dept ', NEW.department_id)
        );
    END IF;
END$$

-- BEFORE UPDATE trigger: prevent changing a delivered order status
DROP TRIGGER IF EXISTS trg_before_update_order_status$$

CREATE TRIGGER trg_before_update_order_status
BEFORE UPDATE ON orders
FOR EACH ROW
BEGIN
    IF OLD.status = 'Delivered' AND NEW.status <> 'Delivered' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot change status of a Delivered order.';
    END IF;
END$$

DELIMITER ;

-- Test: valid salary update (triggers audit log)
UPDATE employees SET salary = 98000 WHERE employee_id = 1;
SELECT * FROM audit_log ORDER BY changed_at DESC LIMIT 3;

-- Test: salary reduction > 20% (should raise error)
-- UPDATE employees SET salary = 40000 WHERE employee_id = 1;

-- Test: department transfer
UPDATE employees SET department_id = 4 WHERE employee_id = 10;
SELECT * FROM audit_log ORDER BY changed_at DESC LIMIT 3;

-- Key Points:
-- BEFORE UPDATE fires before the row is actually updated
-- OLD.column = original value; NEW.column = incoming new value
-- Modify NEW values to override what gets stored
-- SIGNAL aborts the UPDATE and rolls it back
-- Ideal for: validation, change tracking, audit logging
