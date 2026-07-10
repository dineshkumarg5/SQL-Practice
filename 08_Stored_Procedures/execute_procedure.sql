-- ============================================================
-- SQL Practice | Stored Procedures - Execute Procedure
-- File: 08_Stored_Procedures/execute_procedure.sql
-- ============================================================

USE sql_practice;

-- -------------------------------------------------------
-- Ensure procedures exist before calling
-- -------------------------------------------------------
DELIMITER $$

CREATE PROCEDURE IF NOT EXISTS sp_get_all_employees()
BEGIN
    SELECT employee_id, name, salary, department_id FROM employees ORDER BY name;
END$$

CREATE PROCEDURE IF NOT EXISTS sp_employees_by_dept(IN p_dept_id INT)
BEGIN
    SELECT employee_id, name, salary FROM employees WHERE department_id = p_dept_id;
END$$

CREATE PROCEDURE IF NOT EXISTS sp_employee_count(OUT p_count INT)
BEGIN
    SELECT COUNT(*) INTO p_count FROM employees;
END$$

CREATE PROCEDURE IF NOT EXISTS sp_order_report(
    IN  p_status    VARCHAR(20),
    OUT p_count     INT,
    OUT p_revenue   DECIMAL(10,2)
)
BEGIN
    SELECT COUNT(*), COALESCE(SUM(total_amount),0)
    INTO p_count, p_revenue
    FROM orders
    WHERE status = p_status;
END$$

DELIMITER ;

-- -------------------------------------------------------
-- Execute (CALL) Procedures
-- -------------------------------------------------------

-- No-parameter procedure
CALL sp_get_all_employees();

-- IN parameter
CALL sp_employees_by_dept(1);   -- Engineering
CALL sp_employees_by_dept(2);   -- Human Resources
CALL sp_employees_by_dept(3);   -- Finance

-- OUT parameter
CALL sp_employee_count(@emp_total);
SELECT @emp_total AS total_employees;

-- Mixed IN + OUT parameters
CALL sp_order_report('Delivered', @d_count, @d_revenue);
SELECT @d_count AS delivered_orders, @d_revenue AS delivered_revenue;

CALL sp_order_report('Pending', @p_count, @p_revenue);
SELECT @p_count AS pending_orders, @p_revenue AS pending_revenue;

CALL sp_order_report('Cancelled', @c_count, @c_revenue);
SELECT @c_count AS cancelled_orders, @c_revenue AS cancelled_revenue;

-- Drop procedures
DROP PROCEDURE IF EXISTS sp_get_all_employees;
DROP PROCEDURE IF EXISTS sp_employees_by_dept;
DROP PROCEDURE IF EXISTS sp_employee_count;
DROP PROCEDURE IF EXISTS sp_salary_stats;
DROP PROCEDURE IF EXISTS sp_salary_grade;
DROP PROCEDURE IF EXISTS sp_dept_avg_salary;
DROP PROCEDURE IF EXISTS sp_apply_raise;
DROP PROCEDURE IF EXISTS sp_search_employees;
DROP PROCEDURE IF EXISTS sp_order_report;

-- Verify all procedures removed
SHOW PROCEDURE STATUS WHERE Db = 'sql_practice';

-- Key Points:
-- Use CALL to execute a stored procedure
-- Pass OUT/INOUT values as user variables (@var)
-- Use SELECT @var to see the returned output value
-- DROP PROCEDURE IF EXISTS removes a procedure safely
