-- =========================================
-- MySQL 8+ Advanced Project Script
-- Purpose: Demonstrate advanced SQL skills
-- Features: CTEs, nested queries, window functions, joins, aggregates
-- =========================================

-- 1.Create Database if not exists
CREATE DATABASE IF NOT EXISTS company_db;
USE company_db;

-- 2.Drop tables if they exist for clean run
DROP TABLE IF EXISTS bonuses;
DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- 3.Create Tables
-- Departments Table
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL
);

-- Employees Table
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department_id INT,
    hire_date DATE NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Sales Table
CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    sale_date DATE NOT NULL,
    sale_amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- Projects Table
CREATE TABLE projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    department_id INT,
    start_date DATE NOT NULL,
    end_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Bonuses Table
CREATE TABLE bonuses (
    bonus_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    bonus_date DATE NOT NULL,
    bonus_amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- 4.Insert Sample Data

-- Departments
INSERT INTO departments (department_name) VALUES
('Sales'), ('Marketing'), ('IT'), ('HR');

-- Employees
INSERT INTO employees (first_name, last_name, department_id, hire_date, salary) VALUES
('Alice', 'Smith', 1, '2020-01-15', 60000),
('Bob', 'Johnson', 1, '2019-03-10', 65000),
('Charlie', 'Williams', 2, '2021-06-20', 55000),
('David', 'Brown', 3, '2018-11-05', 70000),
('Eva', 'Davis', 1, '2022-02-28', 50000),
('Frank', 'Miller', 4, '2017-09-12', 48000),
('Grace', 'Lee', 2, '2019-09-01', 58000);

-- Sales
INSERT INTO sales (employee_id, sale_date, sale_amount) VALUES
(1, '2025-01-01', 1000),
(1, '2025-01-15', 1200),
(2, '2025-01-05', 2000),
(2, '2025-02-01', 1800),
(5, '2025-01-20', 1500),
(7, '2025-01-25', 1300);

-- Projects
INSERT INTO projects (project_name, department_id, start_date, end_date) VALUES
('Website Redesign', 2, '2025-01-01', '2025-06-30'),
('Product Launch', 1, '2025-02-01', '2025-08-31'),
('Internal Tools', 3, '2025-03-01', NULL);

-- Bonuses
INSERT INTO bonuses (employee_id, bonus_date, bonus_amount) VALUES
(1, '2025-01-31', 500),
(2, '2025-01-31', 800),
(5, '2025-01-31', 300),
(7, '2025-01-31', 400);

-- =========================================
-- 5.Advanced Query: CTEs, Nested Queries, Window Functions
-- Goal: Rank employees by total compensation (salary + sales + bonuses) within each department
-- Also identify top departments by total sales
-- =========================================

WITH employee_sales AS (
    -- Aggregate total sales per employee
    SELECT 
        e.employee_id,
        e.first_name,
        e.last_name,
        e.department_id,
        e.salary,
        COALESCE(SUM(s.sale_amount),0) AS total_sales -- Replaces NULL with a default value (like 0 for sums) -- 
    FROM employees e
    LEFT JOIN sales s ON e.employee_id = s.employee_id
    GROUP BY e.employee_id, e.first_name, e.last_name, e.department_id, e.salary
),
employee_bonuses AS (
    -- Aggregate total bonuses per employee
    SELECT
        e.employee_id,
        COALESCE(SUM(b.bonus_amount),0) AS total_bonus
    FROM employees e
    LEFT JOIN bonuses b ON e.employee_id = b.employee_id
    GROUP BY e.employee_id
),
employee_compensation AS (
    -- Combine salary, sales, bonuses
    SELECT
        es.employee_id,
        es.first_name,
        es.last_name,
        es.department_id,
        es.salary,
        es.total_sales,
        eb.total_bonus,
        (es.salary + es.total_sales + eb.total_bonus) AS total_compensation
    FROM employee_sales es
    JOIN employee_bonuses eb ON es.employee_id = eb.employee_id
),
department_ranking AS (
    -- Rank employees within their department by total compensation
    SELECT
        ec.*,
        d.department_name,
        RANK() OVER (PARTITION BY ec.department_id ORDER BY ec.total_compensation DESC) AS comp_rank,
        SUM(ec.total_sales) OVER (PARTITION BY ec.department_id) AS dept_total_sales
    FROM employee_compensation ec
    JOIN departments d ON ec.department_id = d.department_id
),
top_department AS (
    -- Identify the department with highest total sales
    SELECT
        department_id,
        MAX(dept_total_sales) AS max_dept_sales
    FROM department_ranking
    GROUP BY department_id 
    ORDER BY max_dept_sales DESC  -- descending order -- 
    LIMIT 1 -- return only the single row with the highest max_dept_sales, i.e., the top-selling department. -- 
)
-- Final Select: Top 2 employees per department + department status
SELECT
    CONCAT(dr.first_name, ' ', dr.last_name) AS employee_name, -- CONCAT = joins (concatenates) strings together. -- 
    dr.department_name,
    dr.salary,
    dr.total_sales,
    dr.total_bonus,
    dr.total_compensation,
    dr.comp_rank,
    td.max_dept_sales AS top_department_sales,
    CASE
        WHEN dr.department_id = td.department_id THEN 'Top Department'
        ELSE 'Other Department'
    END AS department_status
FROM department_ranking dr
CROSS JOIN top_department td
WHERE dr.comp_rank <= 2
ORDER BY dr.department_id, dr.comp_rank;
