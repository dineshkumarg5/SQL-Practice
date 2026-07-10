-- ============================================================
-- SQL Practice | Interview Queries - Consecutive Records
-- File: 11_Interview_Queries/consecutive_records.sql
-- ============================================================

USE sql_practice;

-- -------------------------------------------------------
-- Setup: create a demo table with consecutive number patterns
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS demo_consecutive (
    id     INT PRIMARY KEY,
    value  INT
);

INSERT INTO demo_consecutive VALUES
(1,100),(2,100),(3,100),(4,200),(5,200),(6,100),(7,300),(8,300),(9,300),(10,300);

-- -------------------------------------------------------
-- Find rows where the same value appears 3+ times consecutively
-- Using LAG/LEAD window functions (MySQL 8.0+)
-- -------------------------------------------------------
SELECT DISTINCT value AS consecutive_value
FROM (
    SELECT
        value,
        LAG(value, 1)  OVER (ORDER BY id) AS prev_val,
        LEAD(value, 1) OVER (ORDER BY id) AS next_val
    FROM demo_consecutive
) windowed
WHERE value = prev_val AND value = next_val;

-- -------------------------------------------------------
-- Show the full consecutive groups with group ID
-- -------------------------------------------------------
SELECT
    id,
    value,
    id - ROW_NUMBER() OVER (PARTITION BY value ORDER BY id) AS grp
FROM demo_consecutive
ORDER BY id;

-- -------------------------------------------------------
-- Find groups of consecutive duplicates with count
-- -------------------------------------------------------
SELECT
    value,
    COUNT(*)              AS consecutive_count,
    MIN(id)               AS start_id,
    MAX(id)               AS end_id
FROM (
    SELECT
        id,
        value,
        id - ROW_NUMBER() OVER (PARTITION BY value ORDER BY id) AS grp
    FROM demo_consecutive
) grouped
GROUP BY value, grp
ORDER BY start_id;

-- -------------------------------------------------------
-- Classic interview: find employees with 3 consecutive salary records
-- (e.g., same salary across 3 consecutive employee_id rows)
-- -------------------------------------------------------
SELECT DISTINCT e1.salary AS three_time_consecutive_salary
FROM employees e1
JOIN employees e2 ON e1.employee_id = e2.employee_id - 1 AND e1.salary = e2.salary
JOIN employees e3 ON e2.employee_id = e3.employee_id - 1 AND e2.salary = e3.salary;

-- -------------------------------------------------------
-- Self-join method for consecutive (without window functions)
-- -------------------------------------------------------
SELECT DISTINCT a.value
FROM demo_consecutive a
JOIN demo_consecutive b ON b.id = a.id + 1 AND b.value = a.value
JOIN demo_consecutive c ON c.id = b.id + 1 AND c.value = b.value;

-- Clean up
DROP TABLE IF EXISTS demo_consecutive;
