# 🎯 SQL Interview Questions & Answers

## 📌 Basic SQL

**Q1. What is the difference between DELETE, TRUNCATE, and DROP?**
| Feature       | DELETE         | TRUNCATE         | DROP              |
|---------------|----------------|------------------|-------------------|
| Type          | DML            | DDL              | DDL               |
| Rollback      | ✅ Yes          | ❌ No             | ❌ No              |
| WHERE clause  | ✅ Supported    | ❌ Not supported  | ❌ N/A             |
| Resets AI     | ❌ No           | ✅ Yes            | N/A               |
| Fires trigger | ✅ Yes          | ❌ No             | ❌ No              |
| Removes struct| ❌ No           | ❌ No             | ✅ Yes             |

---

**Q2. What is the difference between WHERE and HAVING?**
- `WHERE` filters **individual rows** before grouping.
- `HAVING` filters **groups** after `GROUP BY`.
- `WHERE` cannot use aggregate functions; `HAVING` can.

---

**Q3. What is a PRIMARY KEY vs UNIQUE KEY?**
| Feature      | PRIMARY KEY         | UNIQUE KEY         |
|--------------|---------------------|--------------------|
| NULL allowed | ❌ No               | ✅ Yes (once)       |
| Per table    | Only one            | Multiple allowed   |
| Purpose      | Uniquely identify row | Prevent duplicates |

---

**Q4. What is a FOREIGN KEY?**
A foreign key is a column (or group of columns) in a table that references the PRIMARY KEY of another table. It enforces **referential integrity**.

---

**Q5. What is the difference between CHAR and VARCHAR?**
| Feature     | CHAR             | VARCHAR          |
|-------------|------------------|------------------|
| Length      | Fixed            | Variable         |
| Padding     | Pads with spaces | No padding       |
| Storage     | Wastes space     | Efficient        |
| Use case    | Fixed-length data (codes) | Variable text |

---

## 📌 Joins

**Q6. What is the difference between INNER JOIN and LEFT JOIN?**
- `INNER JOIN`: Returns only matching rows from both tables.
- `LEFT JOIN`: Returns ALL rows from the left table + matched rows from the right. Unmatched right rows are `NULL`.

**Q7. What is a SELF JOIN?**
A join where a table is joined with itself. Commonly used for hierarchical data (employee-manager relationship).

**Q8. What is a CROSS JOIN?**
Returns the Cartesian product — every row from Table A combined with every row from Table B. If A has 5 rows and B has 4 rows, result has 20 rows.

---

## 📌 Aggregates & Grouping

**Q9. What does COUNT(*) vs COUNT(col) return?**
- `COUNT(*)`: Counts all rows including NULLs.
- `COUNT(col)`: Counts only non-NULL values in that column.

**Q10. Can you use a column alias in HAVING?**
Yes in MySQL (extension to SQL standard). In strict SQL, you must repeat the expression.

---

## 📌 Subqueries

**Q11. What is a correlated subquery?**
A subquery that references a column from the outer query. It re-executes for every row in the outer query, making it potentially slower.

**Q12. What is the difference between IN and EXISTS?**
- `IN`: Compares value against a list of returned values.
- `EXISTS`: Checks if the subquery returns any rows (TRUE/FALSE).
- `NOT EXISTS` is safer than `NOT IN` when subquery may return NULLs.

---

## 📌 Interview Queries

**Q13. Find the second highest salary.**
```sql
SELECT MAX(salary) FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);
```

**Q14. Find the Nth highest salary.**
```sql
SELECT salary FROM (
    SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM employees
) r WHERE rnk = N;
```

**Q15. Delete duplicate rows but keep one.**
```sql
DELETE e1 FROM employees e1
INNER JOIN employees e2
  ON e1.name = e2.name AND e1.email = e2.email AND e1.employee_id > e2.employee_id;
```

**Q16. Find employees with no department.**
```sql
SELECT * FROM employees WHERE department_id IS NULL;
-- OR
SELECT e.* FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
WHERE d.department_id IS NULL;
```

**Q17. Find consecutive duplicate records.**
```sql
SELECT DISTINCT value FROM (
    SELECT value,
           LAG(value)  OVER (ORDER BY id) AS prev_val,
           LEAD(value) OVER (ORDER BY id) AS next_val
    FROM demo_table
) t WHERE value = prev_val AND value = next_val;
```

**Q18. Top N salaries per department.**
```sql
SELECT department_id, name, salary
FROM (
    SELECT *, DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rnk
    FROM employees
) r WHERE rnk <= N;
```

---

## 📌 Views

**Q19. What is a view? When would you use it?**
A view is a virtual table based on a SELECT statement. Use it to:
- Simplify complex queries
- Restrict column access (security)
- Present aggregated data

**Q20. Can you UPDATE data through a view?**
Yes, for **simple views** (single table, no GROUP BY/DISTINCT/aggregate). Complex views are read-only.

---

## 📌 Stored Procedures & Triggers

**Q21. What is the difference between a stored procedure and a function?**
| Feature       | Stored Procedure  | Function          |
|---------------|-------------------|-------------------|
| Returns       | Multiple result sets | Single value   |
| Called with   | `CALL proc()`     | Used in SELECT    |
| DML allowed   | ✅ Yes            | ❌ Limited        |
| Use in query  | ❌ No             | ✅ Yes            |

**Q22. What is a trigger? Name the types.**
A trigger is SQL code that automatically executes when a DML event occurs on a table.
Types: `BEFORE INSERT`, `AFTER INSERT`, `BEFORE UPDATE`, `AFTER UPDATE`, `BEFORE DELETE`, `AFTER DELETE`.

---

## 📌 Transactions

**Q23. What are the ACID properties?**
| Property      | Meaning                                            |
|---------------|----------------------------------------------------|
| **Atomicity** | All-or-nothing — either all operations succeed or none |
| **Consistency** | Data moves from one valid state to another       |
| **Isolation** | Transactions are independent of each other        |
| **Durability**| Committed changes are permanent even after crash  |

**Q24. What is a SAVEPOINT?**
A named checkpoint within a transaction. Allows partial rollback to that point without rolling back the entire transaction.

---

## 📌 Normalization

**Q25. What are the normal forms?**
| NF  | Rule                                                   |
|-----|--------------------------------------------------------|
| 1NF | No repeating groups; each cell has atomic value        |
| 2NF | 1NF + no partial dependency on composite primary key   |
| 3NF | 2NF + no transitive dependency on non-prime attributes |
| BCNF| Stricter 3NF — every determinant is a candidate key    |
