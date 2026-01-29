# Advanced SQL Project

This repository demonstrates **advanced SQL concepts** using a realistic business scenario with employees, departments, sales, bonuses, and projects.  

It is designed to showcase **“Продвинутый” SQL skills**, including:

- **CTEs (Common Table Expressions)**
- **Window functions** (RANK, SUM OVER)
- **Nested queries**
- **Aggregations and joins**
- **Conditional logic (CASE statements)**
- **Cross-database adaptability** (MySQL, PostgreSQL, SQLite)

## 📝 Features

1. **Employee Sales Analysis**  
   - Calculate total sales per employee  
   - Include bonuses and salary to compute total compensation

2. **Department Rankings**  
   - Rank employees by total compensation using `RANK() OVER (PARTITION BY ...)`  
   - Identify top departments based on total sales

3. **Cross-DB Compatibility**  
   - Each database has its own script optimized for dialect-specific syntax  
   - Shows ability to adapt advanced SQL logic to multiple engines

---------

# Full Comprehensive SQL → OOP Analogy

This document maps the SQL concepts used in the Advanced SQL Project to Object-Oriented Programming (OOP) analogies.

| SQL Concept / Code Snippet                                                                        | OOP Analogy                                       | Explanation                                                          |
| ------------------------------------------------------------------------------------------------- | ------------------------------------------------- | -------------------------------------------------------------------- |
| `CREATE TABLE employees (...)`                                                                    | `class Employee`                                  | Table = class; each row = object instance                            |
| `employee_id INT AUTO_INCREMENT PRIMARY KEY`                                                      | `Employee.employee_id` (attribute)                | Column = object property; auto-increment = automatically assigned ID |
| `first_name VARCHAR(50)`                                                                          | `Employee.first_name`                             | Attribute/property of the object                                     |
| `department_id INT`                                                                               | `Employee.department_id`                          | Attribute linking to another object (`Department`)                   |
| `CREATE TABLE departments (...)`                                                                  | `class Department`                                | Departments table = class; each row = object instance                |
| `department_id INT PRIMARY KEY`                                                                   | `Department.department_id`                        | Unique ID property of Department                                     |
| `CREATE TABLE sales (...)`                                                                        | `class Sale`                                      | Each sale = object; links to `Employee` via `employee_id`            |
| `employee_id INT` in `sales`                                                                      | `Sale.employee`                                   | Foreign key → reference to Employee object                           |
| `LEFT JOIN sales s ON e.employee_id = s.employee_id`                                              | `employee.sales = [Sale]`                         | Attach a list of Sale objects to each Employee object                |
| `WITH employee_sales AS (...)`                                                                    | `List<Employee>.map(sales_sum)`                   | CTE = temporary data structure / intermediate computation            |
| `COALESCE(SUM(s.sale_amount),0)`                                                                  | `sum(employee.sales) or 0`                        | Aggregate method on object collection; default 0 if empty            |
| `employee_bonuses AS (...)`                                                                       | `sum(employee.bonuses)`                           | Another temporary collection aggregation                             |
| `employee_compensation AS (...)`                                                                  | `employee.total_compensation()`                   | Combine salary + sales + bonus; like a method calculating total      |
| `RANK() OVER (PARTITION BY department_id ORDER BY total_compensation DESC)`                       | `department.rank_employees()`                     | Window function = method that ranks objects within a group           |
| `SUM(ec.total_sales) OVER (PARTITION BY ec.department_id)`                                        | `department.total_sales()`                        | Method computing aggregate over all objects in department            |
| `JOIN departments d ON ec.department_id = d.department_id`                                        | `employee.department = Department`                | Object reference from Employee to Department                         |
| `CROSS JOIN top_department td`                                                                    | `global_top_department`                           | Global reference to highest-performing Department                    |
| `CASE WHEN dr.department_id = td.department_id THEN 'Top Department' ELSE 'Other Department' END` | `if employee.department == global_top_department` | Conditional logic at object level                                    |
| `GROUP BY e.employee_id, e.first_name, e.last_name, e.department_id, e.salary`                    | `for each employee object: aggregate(sales)`      | Loop over each object to compute aggregates                          |
| `CONCAT(dr.first_name, ' ', dr.last_name)`                                                        | `employee.full_name()`                            | Derived property (method) combining attributes                       |
| `INSERT INTO employees (...) VALUES (...)`                                                        | `new Employee(...)`                               | Object instantiation                                                 |
| `DROP TABLE IF EXISTS ...`                                                                        | `delete class/clear objects`                      | Reset the environment / clear objects                                |
| `CREATE DATABASE IF NOT EXISTS company_db`                                                        | `Project/Namespace`                               | Database = namespace / project container for classes                 |

---

### Notes

1. **CTEs** are like temporary collections or intermediate objects — computed once and reused in the main query.
2. **Window functions** operate like methods applied across a collection of objects.
3. **Aliases** (`e`, `s`, `dr`, `td`) = object references to simplify access.
4. **Aggregates** (`SUM`, `MAX`) = methods operating on object collections.
5. **Joins** = relationships between objects/classes (one-to-many, many-to-one).

   
