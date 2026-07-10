-- ============================================================
-- SQL Practice | Triggers - BEFORE DELETE
-- File: 09_Triggers/before_delete.sql
-- Description: Fires BEFORE a row is deleted from the table
--              Can archive data or prevent deletion
-- ============================================================

USE sql_practice;

-- Create an archive table for deleted employees
CREATE TABLE IF NOT EXISTS employees_archive (
    archive_id    INT          PRIMARY KEY AUTO_INCREMENT,
    employee_id   INT,
    name          VARCHAR(100),
    email         VARCHAR(150),
    department_id INT,
    salary        DECIMAL(10,2),
    hire_date     DATE,
    deleted_at    DATETIME     DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

-- BEFORE DELETE trigger: archive employee before deletion
DROP TRIGGER IF EXISTS trg_before_delete_employee$$

CREATE TRIGGER trg_before_delete_employee
BEFORE DELETE ON employees
FOR EACH ROW
BEGIN
    -- Archive the row before deleting
    INSERT INTO employees_archive
        (employee_id, name, email, department_id, salary, hire_date)
    VALUES
        (OLD.employee_id, OLD.name, OLD.email, OLD.department_id, OLD.salary, OLD.hire_date);

    -- Also log the deletion in audit_log
    INSERT INTO audit_log (action, table_name, record_id, description)
    VALUES (
        'DELETE',
        'employees',
        OLD.employee_id,
        CONCAT('Employee deleted: ', OLD.name, ' | Salary was: ', OLD.salary)
    );
END$$

-- BEFORE DELETE trigger: prevent deleting a department with employees
DROP TRIGGER IF EXISTS trg_before_delete_department$$

CREATE TRIGGER trg_before_delete_department
BEFORE DELETE ON departments
FOR EACH ROW
BEGIN
    DECLARE v_emp_count INT;

    SELECT COUNT(*) INTO v_emp_count
    FROM employees
    WHERE department_id = OLD.department_id;

    IF v_emp_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete a department that has employees. Reassign first.';
    END IF;
END$$

DELIMITER ;

-- Test: delete an employee (should archive and log)
-- First insert a test employee to safely delete
INSERT INTO employees (name, email, department_id, salary, hire_date)
VALUES ('Temp User', 'temp@company.com', 6, 45000.00, '2024-01-01');

SET @test_id = LAST_INSERT_ID();

DELETE FROM employees WHERE employee_id = @test_id;

-- Verify: employee gone from employees, exists in archive
SELECT * FROM employees        WHERE name = 'Temp User';
SELECT * FROM employees_archive WHERE name = 'Temp User';
SELECT * FROM audit_log        ORDER BY changed_at DESC LIMIT 3;

-- Test: delete a department with employees (should raise error)
-- DELETE FROM departments WHERE department_id = 1;

-- Clean up
DROP TABLE IF EXISTS employees_archive;

-- Key Points:
-- BEFORE DELETE fires before the row is removed from the table
-- OLD.column contains the values of the row being deleted
-- No NEW values exist in DELETE triggers
-- Useful for: soft deletes, archiving, cascading actions, prevention
-- SIGNAL can abort the DELETE to protect data integrity
