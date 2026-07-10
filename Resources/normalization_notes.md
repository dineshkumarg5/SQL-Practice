# 📐 Database Normalization Notes

## What is Normalization?
Normalization is the process of organizing a database to **reduce data redundancy** and **improve data integrity** by dividing large tables into smaller, related tables and defining relationships between them.

---

## Why Normalize?
- ✅ Eliminate data redundancy (duplicate data)
- ✅ Prevent update, insert, and delete anomalies
- ✅ Ensure data consistency
- ✅ Easier maintenance

---

## Normal Forms

### 🔹 First Normal Form (1NF)
**Rules:**
1. Each column must contain **atomic (indivisible) values**
2. Each column must contain values of the **same type**
3. Each row must be **uniquely identifiable** (primary key)
4. No repeating groups or arrays

**❌ Before 1NF:**
| StudentID | Name  | Courses           |
|-----------|-------|-------------------|
| 1         | Alice | Math, Science, PE |

**✅ After 1NF:**
| StudentID | Name  | Course  |
|-----------|-------|---------|
| 1         | Alice | Math    |
| 1         | Alice | Science |
| 1         | Alice | PE      |

---

### 🔹 Second Normal Form (2NF)
**Rules:**
1. Must be in **1NF**
2. No **partial dependencies** — every non-key attribute must depend on the **entire** primary key (relevant only when composite primary key exists)

**❌ Before 2NF:**
| StudentID | CourseID | StudentName | CourseName |
|-----------|----------|-------------|------------|
| 1         | C01      | Alice       | Math       |

- `StudentName` depends only on `StudentID` ← partial dependency
- `CourseName` depends only on `CourseID` ← partial dependency

**✅ After 2NF (split into 3 tables):**
- **Students**: `StudentID`, `StudentName`
- **Courses**: `CourseID`, `CourseName`
- **Enrollments**: `StudentID`, `CourseID`

---

### 🔹 Third Normal Form (3NF)
**Rules:**
1. Must be in **2NF**
2. No **transitive dependencies** — non-key attributes must not depend on other non-key attributes

**❌ Before 3NF:**
| EmployeeID | DeptID | DeptName    |
|------------|--------|-------------|
| 1          | D01    | Engineering |

- `DeptName` depends on `DeptID`, not on `EmployeeID` ← transitive dependency

**✅ After 3NF:**
- **Employees**: `EmployeeID`, `DeptID`
- **Departments**: `DeptID`, `DeptName`

---

### 🔹 Boyce-Codd Normal Form (BCNF)
**Rules:**
1. Must be in **3NF**
2. For every functional dependency `A → B`, `A` must be a **candidate key**
3. Stricter than 3NF; handles anomalies 3NF misses

---

### 🔹 Fourth Normal Form (4NF)
**Rules:**
1. Must be in **BCNF**
2. No **multi-valued dependencies** (A → B and A → C independently)

---

### 🔹 Fifth Normal Form (5NF)
**Rules:**
1. Must be in **4NF**
2. No **join dependencies** — cannot reconstruct data by joining two smaller tables

> In practice, most databases are normalized to **3NF** or **BCNF**.

---

## Anomalies (Problems Without Normalization)

| Anomaly      | Description                                           | Example                              |
|--------------|-------------------------------------------------------|--------------------------------------|
| **Insert**   | Cannot insert data without unrelated data             | Can't add a course with no students  |
| **Update**   | Changing one value requires updating many rows        | Changing dept name in every emp row  |
| **Delete**   | Deleting a row removes unintended related data        | Deleting last student deletes course |

---

## Functional Dependencies

A **functional dependency** `A → B` means: knowing the value of A uniquely determines the value of B.

| Type                | Definition                                            |
|---------------------|-------------------------------------------------------|
| Full dependency     | B depends on entire composite key                     |
| Partial dependency  | B depends on only part of composite key               |
| Transitive dependency | A → B → C (B is non-key, C depends on B not on A) |

---

## Denormalization

Intentionally introducing redundancy for **performance** reasons.

| Use Case              | Reason                                             |
|-----------------------|----------------------------------------------------|
| Read-heavy systems    | Avoid expensive JOINs                              |
| Data warehouses       | Star/Snowflake schema for fast analytics           |
| Reporting dashboards  | Pre-aggregated summary tables                      |

---

## Sample Schema Evolution

### Unnormalized
```
orders: order_id, customer_name, customer_email, product1, product2, product3
```

### 1NF
```
orders: order_id, customer_name, customer_email, product_name
```

### 2NF
```
customers: customer_id, customer_name, customer_email
orders: order_id, customer_id, product_name
```

### 3NF
```
customers: customer_id, customer_name, customer_email
orders:    order_id, customer_id, product_id
products:  product_id, product_name, price
```

---

## Quick Reference Table

| Normal Form | Key Requirement                                   |
|-------------|---------------------------------------------------|
| 1NF         | Atomic values, no repeating groups                |
| 2NF         | 1NF + no partial dependency                       |
| 3NF         | 2NF + no transitive dependency                    |
| BCNF        | 3NF + every determinant is a candidate key        |
| 4NF         | BCNF + no multi-valued dependencies               |
| 5NF         | 4NF + no join dependencies                        |
