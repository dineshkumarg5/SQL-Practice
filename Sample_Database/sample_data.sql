-- ============================================================
-- SQL Practice | Sample Data
-- File: Sample_Database/sample_data.sql
-- Description: Inserts sample rows into all tables
-- Run schema.sql first before running this file
-- ============================================================

USE sql_practice;

-- -----------------------------------------------
-- Departments
-- -----------------------------------------------
INSERT INTO departments (department_name, location) VALUES
('Engineering',     'Bangalore'),
('Human Resources', 'Mumbai'),
('Finance',         'Chennai'),
('Marketing',       'Delhi'),
('Operations',      'Hyderabad'),
('IT Support',      'Pune');

-- -----------------------------------------------
-- Employees
-- -----------------------------------------------
INSERT INTO employees (name, email, department_id, salary, hire_date, manager_id) VALUES
('Alice Johnson',  'alice@company.com',   1, 95000.00, '2019-03-15', NULL),
('Bob Smith',      'bob@company.com',     1, 82000.00, '2020-06-01', 1),
('Carol White',    'carol@company.com',   2, 67000.00, '2018-11-20', NULL),
('David Brown',    'david@company.com',   3, 75000.00, '2021-01-10', NULL),
('Eva Martinez',   'eva@company.com',     4, 58000.00, '2022-05-25', NULL),
('Frank Lee',      'frank@company.com',   1, 91000.00, '2017-08-12', 1),
('Grace Kim',      'grace@company.com',   5, 63000.00, '2023-02-14', NULL),
('Henry Wilson',   'henry@company.com',   2, 70000.00, '2020-09-30', 3),
('Irene Clark',    'irene@company.com',   3, 82000.00, '2019-07-07', 4),
('James Davis',    'james@company.com',   6, 55000.00, '2021-11-01', NULL),
('Karen Thomas',   'karen@company.com',   4, 61000.00, '2022-03-18', 5),
('Leo Harris',     'leo@company.com',     1, 95000.00, '2016-05-22', 1),
('Mona Lewis',     'mona@company.com',    2, 67000.00, '2023-07-11', 3),
('Nathan Scott',   'nathan@company.com',  5, 58000.00, '2022-12-05', 7),
('Olivia Turner',  'olivia@company.com',  6, 52000.00, '2024-01-20', 10);

-- -----------------------------------------------
-- Customers
-- -----------------------------------------------
INSERT INTO customers (customer_name, email, phone, city) VALUES
('Ravi Sharma',    'ravi@mail.com',    '9876543210', 'Bangalore'),
('Priya Nair',     'priya@mail.com',   '9123456780', 'Chennai'),
('Arjun Mehta',    'arjun@mail.com',   '9988776655', 'Mumbai'),
('Sneha Pillai',   'sneha@mail.com',   '9090909090', 'Delhi'),
('Kiran Rao',      'kiran@mail.com',   '9111222333', 'Hyderabad'),
('Deepa Joshi',    'deepa@mail.com',   '9444555666', 'Pune'),
('Amit Verma',     'amit@mail.com',    '9777888999', 'Kolkata'),
('Neha Gupta',     'neha@mail.com',    '9222333444', 'Jaipur'),
('Rahul Patil',    'rahul@mail.com',   '9555666777', 'Nagpur'),
('Sonia Singh',    'sonia@mail.com',   '9666777888', 'Lucknow');

-- -----------------------------------------------
-- Orders
-- -----------------------------------------------
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES
(1,  '2024-01-05', 1500.00,  'Delivered'),
(2,  '2024-01-12', 3200.50,  'Delivered'),
(3,  '2024-02-03', 875.00,   'Shipped'),
(1,  '2024-02-20', 4500.00,  'Delivered'),
(4,  '2024-03-08', 620.75,   'Processing'),
(5,  '2024-03-15', 9800.00,  'Delivered'),
(6,  '2024-04-01', 2350.00,  'Pending'),
(7,  '2024-04-22', 1100.00,  'Cancelled'),
(2,  '2024-05-10', 5400.00,  'Shipped'),
(8,  '2024-05-18', 760.00,   'Delivered'),
(9,  '2024-06-02', 3300.00,  'Processing'),
(10, '2024-06-25', 1850.00,  'Pending'),
(3,  '2024-07-04', 2200.00,  'Delivered'),
(NULL,'2024-07-15',980.00,   'Pending');   -- Order with no linked customer

-- -----------------------------------------------
-- Courses
-- -----------------------------------------------
INSERT INTO courses (course_name, credits, instructor) VALUES
('Database Management Systems', 4, 'Dr. Ramesh'),
('Data Structures & Algorithms', 4, 'Prof. Lakshmi'),
('Web Development',             3, 'Mr. Suresh'),
('Machine Learning',            4, 'Dr. Anitha'),
('Operating Systems',           3, 'Prof. Venkat'),
('Computer Networks',           3, 'Dr. Pradeep');

-- -----------------------------------------------
-- Students
-- -----------------------------------------------
INSERT INTO students (name, email, age, enrollment_date) VALUES
('Aarav Patel',    'aarav@uni.com',   20, '2022-07-01'),
('Bhavya Shah',    'bhavya@uni.com',  21, '2021-07-01'),
('Chitra Menon',   'chitra@uni.com',  22, '2020-07-01'),
('Devraj Singh',   'devraj@uni.com',  19, '2023-07-01'),
('Esha Reddy',     'esha@uni.com',    21, '2021-07-01'),
('Farhan Khan',    'farhan@uni.com',  20, '2022-07-01'),
('Gayatri Iyer',   'gayatri@uni.com', 23, '2020-07-01'),
('Harsh Trivedi',  'harsh@uni.com',   19, '2023-07-01');

-- -----------------------------------------------
-- Enrollments
-- -----------------------------------------------
INSERT INTO enrollments (student_id, course_id, grade) VALUES
(1, 1, 'A'),  (1, 2, 'B+'), (1, 3, 'A'),
(2, 1, 'B'),  (2, 4, 'A'),  (2, 5, 'B+'),
(3, 2, 'A+'), (3, 3, 'B'),  (3, 6, 'A'),
(4, 1, 'C'),  (4, 2, 'B'),
(5, 3, 'A'),  (5, 4, 'A+'), (5, 5, 'B'),
(6, 1, 'B+'), (6, 6, 'A'),
(7, 2, 'A'),  (7, 4, 'B+'), (7, 5, 'A'),
(8, 3, 'B'),  (8, 6, 'A+');
