-- ============================================================
-- SQL Practice | Views - Drop View
-- File: 07_Views/drop_view.sql
-- ============================================================

USE sql_practice;

-- Drop a single view
DROP VIEW IF EXISTS vw_simple_employees;

-- Drop multiple views in one statement
DROP VIEW IF EXISTS
    vw_high_salary_employees,
    vw_manager_summary;

-- Verify views remaining
SHOW FULL TABLES WHERE Table_type = 'VIEW';

-- Recreate a view after dropping (common pattern)
DROP VIEW IF EXISTS vw_active_orders;

CREATE VIEW vw_active_orders AS
SELECT
    o.order_id,
    c.customer_name,
    o.order_date,
    o.total_amount,
    o.status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.status NOT IN ('Delivered', 'Cancelled');

SELECT * FROM vw_active_orders;

-- Drop the newly created view
DROP VIEW IF EXISTS vw_active_orders;

-- Clean up any remaining practice views
DROP VIEW IF EXISTS vw_employee_details;
DROP VIEW IF EXISTS vw_customer_order_summary;
DROP VIEW IF EXISTS vw_student_courses;

SHOW FULL TABLES WHERE Table_type = 'VIEW';

-- Key Points:
-- DROP VIEW removes the view definition (base table data is unaffected)
-- IF EXISTS prevents error when view doesn't exist
-- Multiple views can be dropped in one statement
-- Dropping a base table does NOT automatically drop views referencing it
--   (they become invalid/broken instead)
