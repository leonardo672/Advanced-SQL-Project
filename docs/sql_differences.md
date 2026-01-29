# SQL Dialect Differences in this Project

This document highlights the differences between **MySQL 8+**, **PostgreSQL 15+**, and **SQLite 3.30+** used in this repository.

| Feature                     | MySQL 8+                               | PostgreSQL 15+                       | SQLite 3.30+                       |
|-------------------------------|----------------------------------------|-------------------------------------|------------------------------------|
| **Database creation**         | `CREATE DATABASE IF NOT EXISTS db;`    | Conditional block or `CREATE DATABASE` via `dblink` | SQLite opens file; no SQL command |
| **Auto-increment PK**         | `INT AUTO_INCREMENT PRIMARY KEY`       | `SERIAL PRIMARY KEY`                | `INTEGER PRIMARY KEY AUTOINCREMENT` |
| **String concatenation**      | `CONCAT(first_name, ' ', last_name)`   | `first_name || ' ' || last_name`   | `first_name || ' ' || last_name`  |
| **CTEs (WITH clause)**        | Supported (MySQL 8+)                   | Fully supported                     | Fully supported                    |
| **Window functions**          | Supported (`RANK() OVER ...`)          | Fully supported                     | Supported (3.30+)                  |
| **NULL handling in ORDER BY** | `NULLS LAST` not default (use `ISNULL`) | `NULLS LAST` supported              | Implicit; use `COALESCE()` if needed |
| **LIMIT / OFFSET**            | `LIMIT 10 OFFSET 5`                     | Same syntax                          | Same syntax                        |
| **Transactions**              | Fully supported                         | Fully supported                      | Fully supported                    |

> Notes:
> - All three scripts implement the **same business logic**: employees, departments, sales, bonuses, and projects.  
> - Queries may vary slightly to accommodate dialect-specific syntax.  
> - This project demonstrates **advanced SQL features** (CTEs, window functions, nested queries) across multiple SQL engines.
