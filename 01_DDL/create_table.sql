-- ============================================================
-- SQL Practice | DDL - Create Table
-- File: 01_DDL/create_table.sql
-- ============================================================

USE sql_practice;

-- Basic table creation
CREATE TABLE IF NOT EXISTS products (
    product_id   INT           PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(150)  NOT NULL,
    category     VARCHAR(100),
    price        DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    stock        INT           DEFAULT 0,
    created_at   DATETIME      DEFAULT CURRENT_TIMESTAMP
);

-- Table with UNIQUE and CHECK constraints
CREATE TABLE IF NOT EXISTS suppliers (
    supplier_id   INT          PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(150) UNIQUE NOT NULL,
    rating        INT          CHECK (rating BETWEEN 1 AND 5)
);

-- Show all tables in the current database
SHOW TABLES;

-- Describe a table structure
DESCRIBE employees;
DESCRIBE products;

-- Show CREATE TABLE statement
SHOW CREATE TABLE employees;
