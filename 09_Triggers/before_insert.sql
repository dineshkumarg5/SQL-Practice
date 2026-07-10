-- ============================================================
-- SQL Practice | Triggers - BEFORE INSERT
-- File: 09_Triggers/before_insert.sql
-- Description: Fires BEFORE a new row is inserted into the table
--              Useful for data validation and automatic value setting
-- ============================================================

USE sql_practice;

DELIMITER $$

-- BEFORE INSERT trigger: auto-capitalize employee name and validate salary
DROP TRIGGER IF EXISTS trg_before_insert_employee$$

CREATE TRIGGER trg_before_insert_employee
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    -- Capitalize first letter of each word in name
    SET NEW.name = CONCAT(
        UPPER(SUBSTRING(NEW.name, 1, 1)),
        LOWER(SUBSTRING(NEW.name, 2))
    );

    -- Ensure salary is not below a minimum threshold
    IF NEW.salary < 30000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary cannot be below 30,000.';
    END IF;

    -- Set hire_date to today if not provided
    IF NEW.hire_date IS NULL THEN
        SET NEW.hire_date = CURDATE();
    END IF;
END$$

-- BEFORE INSERT trigger: validate order amount
DROP TRIGGER IF EXISTS trg_before_insert_order$$

CREATE TRIGGER trg_before_insert_order
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
    IF NEW.total_amount <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Order total_amount must be greater than zero.';
    END IF;

    IF NEW.order_date IS NULL THEN
        SET NEW.order_date = CURDATE();
    END IF;
END$$

DELIMITER ;

-- Test BEFORE INSERT trigger on employees
INSERT INTO employees (name, email, department_id, salary, hire_date)
VALUES ('john doe', 'johndoe@company.com', 2, 65000.00, '2024-08-01');

SELECT * FROM employees WHERE email = 'johndoe@company.com';

-- Test salary validation (should raise an error)
-- INSERT INTO employees (name, email, department_id, salary, hire_date)
-- VALUES ('Low Paid', 'lowpaid@company.com', 3, 10000.00, '2024-08-01');

-- Test BEFORE INSERT trigger on orders
INSERT INTO orders (customer_id, order_date, total_amount, status)
VALUES (1, '2024-08-10', 2500.00, 'Pending');

-- Show all triggers
SHOW TRIGGERS FROM sql_practice;

-- Key Points:
-- BEFORE INSERT fires before the row is written to the table
-- Use NEW.column_name to access and modify the incoming data
-- SIGNAL SQLSTATE raises a custom error and aborts the INSERT
-- Ideal for: data sanitization, validation, default values
