-- ============================================================
-- SQL Practice | Stored Procedures - Parameters
-- File: 08_Stored_Procedures/procedure_parameter.sql
-- Description: IN, OUT, and INOUT parameters in stored procedures
-- ============================================================

USE sql_practice;

DELIMITER $$

-- IN parameter: filter employees by department
CREATE PROCEDURE IF NOT EXISTS sp_employees_by_dept(IN p_dept_id INT)
BEGIN
    SELECT employee_id, name, salary, hire_date
    FROM employees
    WHERE department_id = p_dept_id
    ORDER BY salary DESC;
END$$

-- OUT parameter: return total employee count
CREATE PROCEDURE IF NOT EXISTS sp_employee_count(OUT p_count INT)
BEGIN
    SELECT COUNT(*) INTO p_count FROM employees;
END$$

-- OUT parameter: return average salary for a department
CREATE PROCEDURE IF NOT EXISTS sp_dept_avg_salary(
    IN  p_dept_id   INT,
    OUT p_avg_salary DECIMAL(10,2)
)
BEGIN
    SELECT ROUND(AVG(salary), 2)
    INTO p_avg_salary
    FROM employees
    WHERE department_id = p_dept_id;
END$$

-- INOUT parameter: apply salary raise and return new value
CREATE PROCEDURE IF NOT EXISTS sp_apply_raise(
    IN    p_employee_id INT,
    INOUT p_raise_pct   DECIMAL(5,2)
)
BEGIN
    DECLARE v_old_salary DECIMAL(10,2);
    DECLARE v_new_salary DECIMAL(10,2);

    SELECT salary INTO v_old_salary
    FROM employees WHERE employee_id = p_employee_id;

    SET v_new_salary = v_old_salary * (1 + p_raise_pct / 100);

    UPDATE employees
    SET salary = v_new_salary
    WHERE employee_id = p_employee_id;

    SET p_raise_pct = v_new_salary;   -- return new salary via INOUT
END$$

-- Procedure with multiple IN params: search employees
CREATE PROCEDURE IF NOT EXISTS sp_search_employees(
    IN p_min_salary   DECIMAL(10,2),
    IN p_dept_id      INT
)
BEGIN
    SELECT name, salary, department_id
    FROM employees
    WHERE salary >= p_min_salary
      AND (p_dept_id = 0 OR department_id = p_dept_id)  -- 0 means all departments
    ORDER BY salary DESC;
END$$

DELIMITER ;

-- Call with IN parameter
CALL sp_employees_by_dept(1);
CALL sp_employees_by_dept(3);

-- Call with OUT parameter
CALL sp_employee_count(@total);
SELECT @total AS total_employees;

-- Call with IN + OUT
CALL sp_dept_avg_salary(1, @avg);
SELECT @avg AS engineering_avg_salary;

-- Call with INOUT
SET @raise = 10.00;
CALL sp_apply_raise(2, @raise);
SELECT @raise AS new_salary_after_raise;

-- Call with multiple IN params
CALL sp_search_employees(70000, 0);   -- All depts, salary >= 70000
CALL sp_search_employees(60000, 1);   -- Engineering, salary >= 60000

-- Key Points:
-- IN:    Value passed into procedure (read-only inside procedure)
-- OUT:   Value returned by procedure (write-only inside procedure)
-- INOUT: Value passed in AND returned (read-write inside procedure)
-- User-defined session variables (@var) hold OUT/INOUT results
