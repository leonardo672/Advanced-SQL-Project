-- =========================================
-- SQLite 3.30+ Advanced Project Script
-- Features: CTEs, nested queries, window functions, joins, aggregates
-- =========================================

-- 1.SQLite creates databases by opening a file, so no CREATE DATABASE needed
-- You can just open a file like: sqlite3 company.db

-- 2.Drop tables if they exist
DROP TABLE IF EXISTS bonuses;
DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- 3.Create Tables

-- Departments Table
CREATE TABLE departments (
    department_id INTEGER PRIMARY KEY AUTOINCREMENT,
    department_name TEXT NOT NULL
);

-- Employees Table
CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    department_id INTEGER,
    hire_date DATE NOT NULL,
    salary REAL NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Sales Table
CREATE TABLE sales (
    sale_id INTEGER PRIMARY KEY AUTOINCREMENT,
    employee_id INTEGER,
    sale_date DATE NOT NULL,
    sale_amount REAL NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- Projects Table
CREATE TABLE projects (
    project_id INTEGER PRIMARY KEY AUTOINCREMENT,
    project_name TEXT NOT NULL,
    department_id INTEGER,
    start_date DATE NOT NULL,
    end_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Bonuses Table
CREATE TABLE bonuses (
    bonus_id INTEGER PRIMARY KEY AUTOINCREMENT,
    employee_id INTEGER,
    bonus_date DATE NOT NULL,
    bonus_amount REAL NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- 4.Insert Sample Data

INSERT INTO departments (department_name) VALUES
('Sales'), ('Marketing'), ('IT'), ('HR');

INSERT INTO employees (first_name, last_name, department_id, hire_date, salary) VALUES
('Alice','Smith',1,'2020-01-15',60000),
('Bob','Johnson',1,'2019-03-10',65000),
('Charlie','Williams',2,'2021-06-20',55000),
('David','Brown',3,'2018-11-05',70000),
('Eva','Davis',1,'2022-02-28',50000),
('Frank','Miller',4,'2017-09-12',48000),
('Grace','Lee',2,'2019-09-01',58000);

INSERT INTO sales (employee_id, sale_date, sale_amount) VALUES
(1,'2025-01-01',1000),
(1,'2025-01-15',1200),
(2,'2025-01-05',2000),
(2,'2025-02-01',1800),
(5,'2025-01-20',1500),
(7,'2025-01-25',1300);

INSERT INTO projects (project_name, department_id, start_date, end_date) VALUES
('Website Redesign',2,'2025-01-01','2025-06-30'),
('Product Launch',1,'2025-02-01','2025-08-31'),
('Internal Tools',3,'2025-03-01',NULL);

INSERT INTO bonuses (employee_id, bonus_date, bonus_amount) VALUES
(1,'2025-01-31',500),
(2,'2025-01-31',800),
(5,'2025-01-31',300),
(7,'2025-01-31',400);

-- =========================================
-- 5.Advanced Query: CTEs + Window Functions
-- Rank employees by total compensation (salary + sales + bonuses)
-- Identify top departments by total sales
-- =========================================

WITH employee_sales AS (
    -- Total sales per employee
    SELECT
        e.employee_id,
        e.first_name,
        e.last_name,
        e.department_id,
        e.salary,
        COALESCE(SUM(s.sale_amount),0) AS total_sales
    FROM employees e
    LEFT JOIN sales s ON e.employee_id = s.employee_id
    GROUP BY e.employee_id, e.first_name, e.last_name, e.department_id, e.salary
),
employee_bonuses AS (
    -- Total bonuses per employee
    SELECT
        e.employee_id,
        COALESCE(SUM(b.bonus_amount),0) AS total_bonus
    FROM employees e
    LEFT JOIN bonuses b ON e.employee_id = b.employee_id
    GROUP BY e.employee_id
),
employee_compensation AS (
    -- Combine salary + sales + bonuses
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
    -- Rank employees within department
    SELECT
        ec.*,
        d.department_name,
        RANK() OVER (PARTITION BY ec.department_id ORDER BY ec.total_compensation DESC) AS comp_rank,
        SUM(ec.total_sales) OVER (PARTITION BY ec.department_id) AS dept_total_sales
    FROM employee_compensation ec
    JOIN departments d ON ec.department_id = d.department_id
),
top_department AS (
    -- Identify department with highest total sales
    SELECT
        department_id,
        MAX(dept_total_sales) AS max_dept_sales
    FROM department_ranking
    GROUP BY department_id
    ORDER BY max_dept_sales DESC
    LIMIT 1
)
SELECT
    dr.first_name || ' ' || dr.last_name AS employee_name,
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
