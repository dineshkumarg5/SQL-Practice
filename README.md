# 🗄️ SQL Practice

![SQL](https://img.shields.io/badge/SQL-MySQL-blue)
![Scripts](https://img.shields.io/badge/Scripts-51-success)
![License](https://img.shields.io/badge/License-MIT-green)

A structured collection of SQL practice scripts covering database fundamentals, joins, functions, subqueries, views, stored procedures, triggers, transactions, and interview-oriented queries.

📌 **Contains 51 well-organized SQL scripts across 11 modules**, designed for learning, revision, and technical interview preparation.

---

## 📈 Repository Overview

- 🗄️ 51 SQL Scripts
- 📂 11 Learning Modules
- 💡 Interview-Oriented Examples
- 🧩 Sample Database Included

---

## 📂 Topics Covered

| #  | Module                 | Topics                                              | Scripts |
|----|------------------------|-----------------------------------------------------|---------|
| 01 | **DDL**                | CREATE, ALTER, RENAME, TRUNCATE, DROP               | 6       |
| 02 | **DML**                | INSERT, UPDATE, DELETE, SELECT, WHERE, ORDER BY     | 6       |
| 03 | **Functions**          | Aggregate, String, Numeric, Date, NULL Functions    | 5       |
| 04 | **Joins**              | INNER, LEFT, RIGHT, FULL, SELF, CROSS JOIN          | 6       |
| 05 | **Grouping**           | GROUP BY, HAVING, DISTINCT                          | 3       |
| 06 | **Subqueries**         | Single Row, Multiple Row, Correlated, Nested        | 4       |
| 07 | **Views**              | CREATE VIEW, UPDATE VIEW, DROP VIEW                 | 3       |
| 08 | **Stored Procedures**  | CREATE, Parameters, EXECUTE                         | 3       |
| 09 | **Triggers**           | BEFORE INSERT, AFTER INSERT, BEFORE UPDATE/DELETE   | 4       |
| 10 | **Transactions**       | COMMIT, ROLLBACK, SAVEPOINT                         | 3       |
| 11 | **Interview Queries**  | Salary Ranks, Duplicates, Consecutive Records, etc. | 8       |

---

## 🧩 Sample Database

All scripts use a **common sample database** with the following tables:

| Table         | Description                              |
|---------------|------------------------------------------|
| `employees`   | Employee records with salary and manager |
| `departments` | Department information and locations     |
| `students`    | Student enrollment data                  |
| `courses`     | Course catalogue with credits            |
| `customers`   | Customer contact details                 |
| `orders`      | Purchase orders and status               |

The schema and sample data are located in the [`Sample_Database/`](Sample_Database/) folder.

---

## 🚀 How to Run

### Prerequisites
- [MySQL 8.0+](https://dev.mysql.com/downloads/mysql/) or [MySQL Workbench](https://www.mysql.com/products/workbench/)

### Steps

```bash
# Step 1: Clone the repository
git clone https://github.com/dineshkumarg5/SQL-Practice.git
cd SQL-Practice
```

```sql
-- Step 2: Import the schema
SOURCE Sample_Database/schema.sql;

-- Step 3: Import sample data
SOURCE Sample_Database/sample_data.sql;

-- Step 4: Run any script
SOURCE 04_Joins/inner_join.sql;
```

---

## 📌 Purpose

This repository documents my SQL learning journey and serves as a structured reference for database concepts, query writing, and technical interview preparation.

---

## 👤 Author

**Dinesh Kumar G**
- GitHub: [@dineshkumarg5](https://github.com/dineshkumarg5)
- Email: dinesh369.official@gmail.com

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).
