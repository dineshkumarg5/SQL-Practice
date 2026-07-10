-- ============================================================
-- SQL Practice | Triggers - AFTER INSERT
-- File: 09_Triggers/after_insert.sql
-- Description: Fires AFTER a new row is successfully inserted
--              Useful for audit logging and cascading actions
-- ============================================================

USE sql_practice;

DELIMITER $$

-- AFTER INSERT trigger: log every new employee to audit_log
DROP TRIGGER IF EXISTS trg_after_insert_employee$$

CREATE TRIGGER trg_after_insert_employee
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (action, table_name, record_id, description)
    VALUES (
        'INSERT',
        'employees',
        NEW.employee_id,
        CONCAT('New employee added: ', NEW.name, ' | Salary: ', NEW.salary)
    );
END$$

-- AFTER INSERT trigger: log every new order
DROP TRIGGER IF EXISTS trg_after_insert_order$$

CREATE TRIGGER trg_after_insert_order
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (action, table_name, record_id, description)
    VALUES (
        'INSERT',
        'orders',
        NEW.order_id,
        CONCAT('New order placed | Customer ID: ', COALESCE(NEW.customer_id, 'Guest'),
               ' | Amount: ', NEW.total_amount,
               ' | Status: ', NEW.status)
    );
END$$

-- AFTER INSERT trigger: when a student enrolls, log it
DROP TRIGGER IF EXISTS trg_after_insert_enrollment$$

CREATE TRIGGER trg_after_insert_enrollment
AFTER INSERT ON enrollments
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (action, table_name, record_id, description)
    VALUES (
        'INSERT',
        'enrollments',
        NEW.enrollment_id,
        CONCAT('Student ID ', NEW.student_id, ' enrolled in Course ID ', NEW.course_id)
    );
END$$

DELIMITER ;

-- Test the triggers by inserting data
INSERT INTO employees (name, email, department_id, salary, hire_date)
VALUES ('Liam Cooper', 'liam@company.com', 4, 72000.00, '2024-09-01');

INSERT INTO orders (customer_id, order_date, total_amount, status)
VALUES (3, '2024-09-05', 3750.00, 'Processing');

INSERT INTO enrollments (student_id, course_id, grade)
VALUES (1, 4, 'B+');

-- View the audit log
SELECT * FROM audit_log ORDER BY changed_at DESC;

-- Key Points:
-- AFTER INSERT fires after the row is committed to the table
-- NEW.column_name contains the just-inserted row's values
-- Cannot modify NEW values (too late — row already written)
-- Ideal for: audit logs, notifications, cascading inserts
