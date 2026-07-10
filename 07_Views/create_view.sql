-- ============================================================
-- SQL Practice | Views - Create View
-- File: 07_Views/create_view.sql
-- ============================================================

USE sql_practice;

-- Simple view: employee details with department name
CREATE OR REPLACE VIEW vw_employee_details AS
SELECT
    e.employee_id,
    e.name          AS employee_name,
    e.email,
    e.salary,
    e.hire_date,
    d.department_name,
    d.location
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;

-- Query the view like a regular table
SELECT * FROM vw_employee_details;
SELECT * FROM vw_employee_details WHERE department_name = 'Engineering';

-- View: high salary employees
CREATE OR REPLACE VIEW vw_high_salary_employees AS
SELECT employee_id, name, salary, department_id
FROM employees
WHERE salary > 80000
WITH CHECK OPTION;   -- Prevent inserting/updating rows that don't meet the WHERE condition

SELECT * FROM vw_high_salary_employees ORDER BY salary DESC;

-- View: order summary per customer
CREATE OR REPLACE VIEW vw_customer_order_summary AS
SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    COUNT(o.order_id)          AS total_orders,
    COALESCE(SUM(o.total_amount), 0) AS total_spent
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name, c.city;

SELECT * FROM vw_customer_order_summary ORDER BY total_spent DESC;

-- View: student course enrollment
CREATE OR REPLACE VIEW vw_student_courses AS
SELECT
    s.name          AS student_name,
    s.email,
    c.course_name,
    c.instructor,
    e.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses     c ON e.course_id  = c.course_id;

SELECT * FROM vw_student_courses ORDER BY student_name;

-- View: manager with direct report count
CREATE OR REPLACE VIEW vw_manager_summary AS
SELECT
    m.employee_id   AS manager_id,
    m.name          AS manager_name,
    COUNT(e.employee_id) AS direct_reports
FROM employees m
LEFT JOIN employees e ON m.employee_id = e.manager_id
GROUP BY m.employee_id, m.name
HAVING direct_reports > 0;

SELECT * FROM vw_manager_summary ORDER BY direct_reports DESC;

-- Show all views in current database
SHOW FULL TABLES WHERE Table_type = 'VIEW';

-- Describe a view
DESCRIBE vw_employee_details;

-- Key Points:
-- Views are virtual tables; they do not store data physically
-- Created with CREATE VIEW or CREATE OR REPLACE VIEW
-- Can be queried exactly like a table
-- WITH CHECK OPTION ensures DML via view respects the WHERE filter
