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

- Common Table Expressions (CTEs)
- Window functions (RANK, SUM OVER)
- Nested queries and aggregates
- Cross-database scripts: MySQL, PostgreSQL, SQLite

---------

# Full SQL → OOP Analogy (Detailed with Explanations)

This document explains **every important SQL concept used in the project** and maps it to an **Object-Oriented Programming (OOP) analogy**, with a clear explanation for each mapping.


| SQL Concept                                               | OOP Analogy                       | Explanation                                                            |
| --------------------------------------------------------- | --------------------------------- | ---------------------------------------------------------------------- |
| `CREATE DATABASE company_db`                              | Application / Project namespace   | Acts as the top-level container that holds all domain models and logic |
| `company_db`                                              | Project / Module                  | Logical scope where all classes live                                   |
| `employees` table                                         | Class `Employee`                  | Table defines the structure (schema) of Employee objects               |
| `departments` table                                       | Class `Department`                | Defines Department objects                                             |
| `sales` table                                             | Class `Sale`                      | Represents transactional objects linked to employees                   |
| `bonuses` table                                           | Class `Bonus`                     | Represents bonus reward objects                                        |
| Row in a table                                            | Object instance                   | Each row corresponds to one instantiated object                        |
| `employee_id`                                             | Object unique identifier          | Primary key, equivalent to an `id` field in a class                    |
| `department_id`                                           | Object reference                  | Foreign key linking one object to another                              |
| `employees e`                                             | Object reference (`Employee e`)   | Alias works like a local variable pointing to an object                |
| `sales s`                                                 | Object reference (`Sale s`)       | Alias referencing Sale objects                                         |
| `bonuses b`                                               | Object reference (`Bonus b`)      | Alias referencing Bonus objects                                        |
| `departments d`                                           | Object reference (`Department d`) | Alias referencing Department objects                                   |
| `e.employee_id`                                           | Property access                   | Accessing a field on an object using dot notation                      |
| `e.first_name`                                            | Property access                   | Read-only access to object attribute                                   |
| `e.salary`                                                | Property access                   | Access numeric attribute used in business logic                        |
| `LEFT JOIN sales s ON e.employee_id = s.employee_id`      | One-to-many relationship          | Attach multiple Sale objects to one Employee                           |
| `LEFT JOIN bonuses b ON e.employee_id = b.employee_id`    | One-to-many relationship          | Attach multiple Bonus objects to one Employee                          |
| `JOIN departments d ON e.department_id = d.department_id` | Many-to-one relationship          | Employee references a single Department                                |
| `SUM(s.sale_amount)`                                      | Method on collection              | Aggregates a list of Sale objects into a single value                  |
| `SUM(b.bonus_amount)`                                     | Method on collection              | Aggregates Bonus values                                                |
| `COALESCE(x, 0)`                                          | Null-safe default                 | Ensures a value exists even if collection is empty                     |
| `GROUP BY e.employee_id`                                  | Loop over objects                 | Defines iteration boundary for aggregation                             |
| `WITH employee_sales AS (...)`                            | Temporary computed class          | Creates an immutable derived dataset                                   |
| `employee_sales es`                                       | Derived object                    | Object holding precomputed sales per employee                          |
| `WITH employee_bonuses AS (...)`                          | Temporary computed class          | Precomputes bonus aggregation                                          |
| `employee_bonuses eb`                                     | Derived object                    | Object holding precomputed bonuses                                     |
| `WITH employee_compensation AS (...)`                     | Business-domain object            | Combines multiple attributes into one logical model                    |
| `(salary + sales + bonus)`                                | Business logic method             | Equivalent to `calculateTotalCompensation()`                           |
| `employee_compensation ec`                                | Computed object                   | Holds calculated business values                                       |
| `WITH department_ranking AS (...)`                        | Department-level view model       | Represents department-scoped computed state                            |
| `department_ranking dr`                                   | ViewModel / DTO                   | Object designed for presentation/output                                |
| `RANK() OVER (PARTITION BY department_id ...)`            | Ranking method                    | Orders employees within department context                             |
| `SUM(total_sales) OVER (PARTITION BY department_id)`      | Department method                 | Calculates department-wide totals                                      |
| `WITH top_department AS (...)`                            | Global computed object            | Determines best-performing department                                  |
| `top_department td`                                       | Singleton-like object             | One shared object accessible everywhere                                |
| `CROSS JOIN top_department td`                            | Global context injection          | Makes global data available to all rows                                |
| `CASE WHEN ... THEN ... ELSE ... END`                     | Conditional logic                 | Equivalent to `if / else` statements                                   |
| `department_status`                                       | Derived attribute                 | Computed property based on condition                                   |
| `CONCAT(first_name, last_name)`                           | Getter method                     | Equivalent to `getFullName()`                                          |
| `WHERE dr.comp_rank <= 2`                                 | Business rule filter              | Applies constraints to object selection                                |
| Final `SELECT`                                            | Output DTO                        | Defines final shape of returned data                                   |
| `ORDER BY department_id, comp_rank`                       | Sorting logic                     | Orders objects for presentation                                        |

---

## Conceptual Summary

This project intentionally documents advanced SQL logic using **Object-Oriented Programming (OOP) analogies** to demonstrate **conceptual mastery**, not merely syntactic familiarity.

The following principles are consistently applied throughout the queries:

* **Table aliases (`e`, `s`, `dr`, `td`) behave like object references**, providing a clear and concise way to access attributes and relationships.
* **Common Table Expressions (CTEs)** function as **immutable intermediate objects or collections**, computed once and reused across the query pipeline.
* **Window functions** behave like **methods applied over object collections** while **preserving individual row (object) identity**.
* **Aggregate functions (`SUM`, `MAX`, etc.)** simulate **operations on collections of objects**, similar to reducing a list to a single computed value.
* **JOIN operations** represent **relationships between objects and classes**, such as one-to-many and many-to-one associations.

This conceptual mapping reflects how complex SQL queries can be reasoned about using the same mental models applied in object-oriented software design, reinforcing a deeper understanding of SQL beyond surface-level syntax.

   
