-- ============================================================
-- SQL Practice | Sample Database Schema
-- File: Sample_Database/schema.sql
-- Description: Creates all tables used across the SQL scripts
-- ============================================================

CREATE DATABASE IF NOT EXISTS sql_practice;
USE sql_practice;

-- -----------------------------------------------
-- Table: departments
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS departments (
    department_id   INT           PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100)  NOT NULL,
    location        VARCHAR(100)  NOT NULL
);

-- -----------------------------------------------
-- Table: employees
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS employees (
    employee_id   INT            PRIMARY KEY AUTO_INCREMENT,
    name          VARCHAR(100)   NOT NULL,
    email         VARCHAR(150)   UNIQUE NOT NULL,
    department_id INT,
    salary        DECIMAL(10, 2) NOT NULL,
    hire_date     DATE           NOT NULL,
    manager_id    INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE SET NULL,
    FOREIGN KEY (manager_id)    REFERENCES employees(employee_id)     ON DELETE SET NULL
);

-- -----------------------------------------------
-- Table: customers
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS customers (
    customer_id   INT          PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email         VARCHAR(150) UNIQUE NOT NULL,
    phone         VARCHAR(20),
    city          VARCHAR(100)
);

-- -----------------------------------------------
-- Table: orders
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS orders (
    order_id     INT            PRIMARY KEY AUTO_INCREMENT,
    customer_id  INT,
    order_date   DATE           NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    status       ENUM('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE SET NULL
);

-- -----------------------------------------------
-- Table: courses
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS courses (
    course_id   INT          PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(150) NOT NULL,
    credits     INT          NOT NULL,
    instructor  VARCHAR(100) NOT NULL
);

-- -----------------------------------------------
-- Table: students
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS students (
    student_id      INT          PRIMARY KEY AUTO_INCREMENT,
    name            VARCHAR(100) NOT NULL,
    email           VARCHAR(150) UNIQUE NOT NULL,
    age             INT,
    enrollment_date DATE         NOT NULL
);

-- -----------------------------------------------
-- Table: enrollments (junction table: students <-> courses)
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS enrollments (
    enrollment_id INT  PRIMARY KEY AUTO_INCREMENT,
    student_id    INT  NOT NULL,
    course_id     INT  NOT NULL,
    grade         CHAR(2),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id)  REFERENCES courses(course_id)   ON DELETE CASCADE
);

-- -----------------------------------------------
-- Table: audit_log (used by Trigger scripts)
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS audit_log (
    log_id      INT          PRIMARY KEY AUTO_INCREMENT,
    action      VARCHAR(50)  NOT NULL,
    table_name  VARCHAR(100) NOT NULL,
    record_id   INT,
    changed_at  DATETIME     DEFAULT CURRENT_TIMESTAMP,
    description VARCHAR(255)
);
