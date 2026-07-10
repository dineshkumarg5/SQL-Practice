-- ============================================================
-- SQL Practice | Stored Procedures - Create Procedure
-- File: 08_Stored_Procedures/create_procedure.sql
-- ============================================================

USE sql_practice;

DELIMITER $$

-- Simple procedure: get all employees
CREATE PROCEDURE IF NOT EXISTS sp_get_all_employees()
BEGIN
    SELECT employee_id, name, salary, department_id, hire_date
    FROM employees
    ORDER BY name;
END$$

-- Procedure with local variables
CREATE PROCEDURE IF NOT EXISTS sp_salary_stats()
BEGIN
    DECLARE v_avg_salary  DECIMAL(10,2);
    DECLARE v_max_salary  DECIMAL(10,2);
    DECLARE v_min_salary  DECIMAL(10,2);
    DECLARE v_total_staff INT;

    SELECT
        AVG(salary),
        MAX(salary),
        MIN(salary),
        COUNT(*)
    INTO
        v_avg_salary,
        v_max_salary,
        v_min_salary,
        v_total_staff
    FROM employees;

    SELECT
        v_total_staff  AS total_employees,
        v_avg_salary   AS average_salary,
        v_max_salary   AS highest_salary,
        v_min_salary   AS lowest_salary;
END$$

-- Procedure with IF...ELSE logic
CREATE PROCEDURE IF NOT EXISTS sp_salary_grade(IN p_employee_id INT)
BEGIN
    DECLARE v_salary DECIMAL(10,2);
    DECLARE v_grade  VARCHAR(20);

    SELECT salary INTO v_salary FROM employees WHERE employee_id = p_employee_id;

    IF v_salary >= 90000 THEN
        SET v_grade = 'Senior';
    ELSEIF v_salary >= 70000 THEN
        SET v_grade = 'Mid-Level';
    ELSEIF v_salary >= 55000 THEN
        SET v_grade = 'Junior';
    ELSE
        SET v_grade = 'Entry Level';
    END IF;

    SELECT p_employee_id AS employee_id, v_salary AS salary, v_grade AS grade;
END$$

DELIMITER ;

-- Call procedures
CALL sp_get_all_employees();
CALL sp_salary_stats();
CALL sp_salary_grade(1);
CALL sp_salary_grade(5);

-- Show all stored procedures
SHOW PROCEDURE STATUS WHERE Db = 'sql_practice';

-- Key Points:
-- Stored procedures are named blocks of SQL saved in the database
-- Use DELIMITER $$ to change delimiter (avoids conflict with ; inside procedure)
-- DECLARE must come before any other statements in BEGIN...END
-- Local variables are session-scoped and go away when procedure ends
