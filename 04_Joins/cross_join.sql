-- ============================================================
-- SQL Practice | Joins - CROSS JOIN
-- File: 04_Joins/cross_join.sql
-- Description: Returns the Cartesian product — every row of Table A
--              combined with every row of Table B
--              No ON condition needed
-- ============================================================

USE sql_practice;

-- Basic CROSS JOIN: every department paired with every status
SELECT
    d.department_name,
    status_options.status
FROM departments d
CROSS JOIN (
    SELECT 'Active'   AS status UNION ALL
    SELECT 'Inactive' UNION ALL
    SELECT 'On Leave'
) AS status_options
ORDER BY d.department_name, status_options.status;

-- CROSS JOIN to generate a size × color product matrix
SELECT
    sizes.size,
    colors.color,
    CONCAT(sizes.size, '-', colors.color) AS variant
FROM
    (SELECT 'S' AS size UNION ALL SELECT 'M' UNION ALL SELECT 'L' UNION ALL SELECT 'XL') sizes
CROSS JOIN
    (SELECT 'Red' AS color UNION ALL SELECT 'Blue' UNION ALL SELECT 'Green') colors
ORDER BY sizes.size, colors.color;

-- Practical: pair each employee with every course (training combinations)
SELECT
    e.name       AS employee_name,
    c.course_name,
    c.credits
FROM employees e
CROSS JOIN courses c
ORDER BY e.name, c.course_name;

-- CROSS JOIN row count demo
SELECT
    (SELECT COUNT(*) FROM employees)    AS employees_count,
    (SELECT COUNT(*) FROM courses)      AS courses_count,
    (SELECT COUNT(*) FROM employees) *
    (SELECT COUNT(*) FROM courses)      AS cross_join_rows;

-- Key Points:
-- CROSS JOIN = Cartesian product (m rows × n rows = m*n results)
-- No JOIN condition (ON clause) is used
-- Use with small tables — result set grows exponentially
-- Useful for generating all possible combinations
