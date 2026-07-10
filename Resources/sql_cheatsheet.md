# 📋 SQL Cheat Sheet

## DDL Commands
| Command    | Syntax                                          |
|------------|--------------------------------------------------|
| CREATE DB  | `CREATE DATABASE db_name;`                       |
| USE DB     | `USE db_name;`                                   |
| CREATE TABLE | `CREATE TABLE t (col TYPE constraints);`       |
| ALTER ADD  | `ALTER TABLE t ADD COLUMN col TYPE;`             |
| ALTER MODIFY | `ALTER TABLE t MODIFY COLUMN col TYPE;`        |
| ALTER DROP | `ALTER TABLE t DROP COLUMN col;`                 |
| RENAME     | `RENAME TABLE old TO new;`                       |
| TRUNCATE   | `TRUNCATE TABLE t;`                              |
| DROP       | `DROP TABLE IF EXISTS t;`                        |

---

## DML Commands
| Command    | Syntax                                           |
|------------|---------------------------------------------------|
| INSERT     | `INSERT INTO t (cols) VALUES (vals);`             |
| UPDATE     | `UPDATE t SET col=val WHERE cond;`               |
| DELETE     | `DELETE FROM t WHERE cond;`                      |
| SELECT     | `SELECT cols FROM t WHERE cond;`                 |

---

## Clauses
| Clause        | Purpose                                      |
|---------------|----------------------------------------------|
| `WHERE`       | Filter rows before grouping                  |
| `GROUP BY`    | Group rows by one or more columns            |
| `HAVING`      | Filter groups after GROUP BY                 |
| `ORDER BY`    | Sort results ASC / DESC                      |
| `LIMIT n`     | Return first n rows                          |
| `LIMIT n OFFSET m` | Skip m rows, return n rows            |
| `DISTINCT`    | Remove duplicate rows from result            |

---

## Joins
| Join Type     | Returns                                      |
|---------------|----------------------------------------------|
| `INNER JOIN`  | Matched rows in both tables                  |
| `LEFT JOIN`   | All rows from left + matched from right      |
| `RIGHT JOIN`  | All rows from right + matched from left      |
| `FULL JOIN`   | All rows from both (LEFT UNION RIGHT)        |
| `SELF JOIN`   | Table joined with itself                     |
| `CROSS JOIN`  | Cartesian product of both tables             |

---

## Aggregate Functions
| Function      | Description                                  |
|---------------|----------------------------------------------|
| `COUNT(*)`    | Count all rows                               |
| `COUNT(col)`  | Count non-NULL values                        |
| `SUM(col)`    | Sum of values                                |
| `AVG(col)`    | Average of values                            |
| `MIN(col)`    | Minimum value                                |
| `MAX(col)`    | Maximum value                                |

---

## String Functions
| Function               | Description                          |
|------------------------|--------------------------------------|
| `UPPER(str)`           | Convert to uppercase                 |
| `LOWER(str)`           | Convert to lowercase                 |
| `LENGTH(str)`          | Byte length                          |
| `CHAR_LENGTH(str)`     | Character length                     |
| `CONCAT(a, b)`         | Concatenate strings                  |
| `SUBSTRING(str,pos,n)` | Extract substring                    |
| `TRIM(str)`            | Remove leading/trailing spaces       |
| `REPLACE(str,old,new)` | Replace substring                    |
| `INSTR(str,sub)`       | Position of substring                |
| `LPAD(str,len,pad)`    | Left-pad string                      |
| `RPAD(str,len,pad)`    | Right-pad string                     |

---

## Numeric Functions
| Function             | Description                            |
|----------------------|----------------------------------------|
| `ROUND(n, d)`        | Round to d decimal places              |
| `FLOOR(n)`           | Round down to integer                  |
| `CEIL(n)`            | Round up to integer                    |
| `ABS(n)`             | Absolute value                         |
| `MOD(n, d)`          | Remainder of n ÷ d                     |
| `POWER(base, exp)`   | base raised to exp                     |
| `SQRT(n)`            | Square root                            |
| `TRUNCATE(n, d)`     | Truncate to d decimal places           |

---

## Date Functions
| Function               | Description                          |
|------------------------|--------------------------------------|
| `NOW()`                | Current datetime                     |
| `CURDATE()`            | Current date                         |
| `YEAR(d)`              | Year from date                       |
| `MONTH(d)`             | Month from date                      |
| `DAY(d)`               | Day from date                        |
| `DATEDIFF(a,b)`        | Days between two dates               |
| `DATE_ADD(d,INTERVAL)` | Add interval to date                 |
| `DATE_FORMAT(d,fmt)`   | Format date as string                |
| `STR_TO_DATE(s,fmt)`   | Parse string to date                 |

---

## NULL Functions
| Function           | Description                              |
|--------------------|------------------------------------------|
| `IFNULL(a, b)`     | Return b if a is NULL                    |
| `COALESCE(a,b,c…)` | First non-NULL value in list             |
| `NULLIF(a, b)`     | Return NULL if a = b, else a             |
| `IS NULL`          | Check if value is NULL                   |
| `IS NOT NULL`      | Check if value is not NULL               |

---

## Window Functions (MySQL 8.0+)
| Function                              | Description                      |
|---------------------------------------|----------------------------------|
| `ROW_NUMBER() OVER (...)`             | Unique row number                |
| `RANK() OVER (...)`                   | Rank with gaps                   |
| `DENSE_RANK() OVER (...)`             | Rank without gaps                |
| `LAG(col, n) OVER (...)`              | Value n rows before current      |
| `LEAD(col, n) OVER (...)`             | Value n rows after current       |
| `SUM(col) OVER (PARTITION BY ...)`    | Running/group sum                |
| `AVG(col) OVER (PARTITION BY ...)`    | Group average                    |
| `PERCENT_RANK() OVER (...)`           | Relative rank as 0.0–1.0         |

---

## Subqueries
| Type          | Used With                            |
|---------------|--------------------------------------|
| Single Row    | `=`, `>`, `<`, `>=`, `<=`, `<>`      |
| Multiple Row  | `IN`, `NOT IN`, `ANY`, `ALL`         |
| Correlated    | References outer query column        |
| Derived Table | In `FROM` clause, must be aliased    |

---

## Transaction Control
| Command                    | Description                        |
|----------------------------|------------------------------------|
| `START TRANSACTION`        | Begin a transaction                |
| `COMMIT`                   | Save all changes permanently       |
| `ROLLBACK`                 | Undo all changes                   |
| `SAVEPOINT name`           | Create a checkpoint                |
| `ROLLBACK TO SAVEPOINT`    | Undo back to checkpoint            |
| `RELEASE SAVEPOINT`        | Remove checkpoint marker           |

---

## Stored Procedures
```sql
DELIMITER $$
CREATE PROCEDURE proc_name(IN p_id INT, OUT p_result VARCHAR(50))
BEGIN
    SELECT name INTO p_result FROM employees WHERE employee_id = p_id;
END$$
DELIMITER ;

CALL proc_name(1, @result);
SELECT @result;
```

---

## Views
```sql
CREATE OR REPLACE VIEW view_name AS
SELECT col1, col2 FROM table WHERE condition;

-- Query it
SELECT * FROM view_name;

-- Drop it
DROP VIEW IF EXISTS view_name;
```

---

## Triggers
```sql
DELIMITER $$
CREATE TRIGGER trigger_name
BEFORE INSERT ON table_name
FOR EACH ROW
BEGIN
    -- use NEW.col to access/modify incoming data
    SET NEW.col = UPPER(NEW.col);
END$$
DELIMITER ;
```

| Timing  | Event  | Access       |
|---------|--------|--------------|
| BEFORE  | INSERT | NEW.*        |
| AFTER   | INSERT | NEW.*        |
| BEFORE  | UPDATE | OLD.*, NEW.* |
| AFTER   | UPDATE | OLD.*, NEW.* |
| BEFORE  | DELETE | OLD.*        |
| AFTER   | DELETE | OLD.*        |
