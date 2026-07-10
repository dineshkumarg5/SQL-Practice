-- ============================================================
-- SQL Practice | Interview Queries - Delete Duplicates
-- File: 11_Interview_Queries/delete_duplicates.sql
-- ============================================================

USE sql_practice;

-- -------------------------------------------------------
-- Setup: create a demo table with duplicates
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS demo_duplicates (
    id     INT PRIMARY KEY AUTO_INCREMENT,
    name   VARCHAR(100),
    email  VARCHAR(150),
    city   VARCHAR(100)
);

INSERT INTO demo_duplicates (name, email, city) VALUES
('Alice',   'alice@mail.com',   'Bangalore'),
('Alice',   'alice@mail.com',   'Bangalore'),   -- duplicate
('Bob',     'bob@mail.com',     'Chennai'),
('Bob',     'bob@mail.com',     'Chennai'),     -- duplicate
('Carol',   'carol@mail.com',   'Mumbai'),
('David',   'david@mail.com',   'Delhi'),
('David',   'david@mail.com',   'Delhi');       -- duplicate

SELECT * FROM demo_duplicates;

-- -------------------------------------------------------
-- Method 1: DELETE with self-join (keep lowest id per duplicate)
-- -------------------------------------------------------
DELETE d1
FROM demo_duplicates d1
INNER JOIN demo_duplicates d2
    ON  d1.name  = d2.name
    AND d1.email = d2.email
    AND d1.id    > d2.id;    -- Keep the row with the smaller id

SELECT * FROM demo_duplicates;   -- Should show one row per person

-- -------------------------------------------------------
-- Restore duplicates and demonstrate Method 2
-- -------------------------------------------------------
TRUNCATE TABLE demo_duplicates;
INSERT INTO demo_duplicates (name, email, city) VALUES
('Alice',  'alice@mail.com',  'Bangalore'),
('Alice',  'alice@mail.com',  'Bangalore'),
('Bob',    'bob@mail.com',    'Chennai'),
('Carol',  'carol@mail.com',  'Mumbai');

-- Method 2: Using a subquery with NOT IN (keep max id)
DELETE FROM demo_duplicates
WHERE id NOT IN (
    SELECT max_id FROM (
        SELECT MAX(id) AS max_id
        FROM demo_duplicates
        GROUP BY name, email
    ) AS keep_rows
);

SELECT * FROM demo_duplicates;

-- -------------------------------------------------------
-- Method 3: Recommended modern approach using ROW_NUMBER CTE
-- (Available in MySQL 8.0+)
-- -------------------------------------------------------
-- Step 1: Identify duplicates
WITH duplicates AS (
    SELECT id,
           ROW_NUMBER() OVER (PARTITION BY name, email ORDER BY id) AS rn
    FROM demo_duplicates
)
SELECT id FROM duplicates WHERE rn > 1;

-- Step 2: Delete them
WITH duplicates AS (
    SELECT id,
           ROW_NUMBER() OVER (PARTITION BY name, email ORDER BY id) AS rn
    FROM demo_duplicates
)
DELETE FROM demo_duplicates
WHERE id IN (SELECT id FROM duplicates WHERE rn > 1);

-- Clean up
DROP TABLE IF EXISTS demo_duplicates;
