-- ============================================================
-- SQL Practice | DDL - Create Database
-- File: 01_DDL/create_database.sql
-- ============================================================

USE sql_practice;

-- Create a new database
CREATE DATABASE IF NOT EXISTS sql_practice;

-- Show all databases
SHOW DATABASES;

-- Switch to a specific database
USE sql_practice;

-- Show currently selected database
SELECT DATABASE();

-- Drop a database (use with caution)
-- DROP DATABASE IF EXISTS test_db;
