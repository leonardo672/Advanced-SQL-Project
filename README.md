## Advanced SQL Project

This repository demonstrates **advanced SQL concepts** using a realistic business scenario with employees, departments, sales, bonuses, and projects.  

It is designed to showcase **“Продвинутый” SQL skills**, including:

- **CTEs (Common Table Expressions)**
- **Window functions** (RANK, SUM OVER)
- **Nested queries**
- **Aggregations and joins**
- **Conditional logic (CASE statements)**
- **Cross-database adaptability** (MySQL, PostgreSQL, SQLite)

### 📝 Features

- Common Table Expressions (CTEs)
- Window functions (RANK, SUM OVER)
- Nested queries and aggregates
- Cross-database scripts: MySQL, PostgreSQL, SQLite

---------

## Deep Conceptual Mapping: SQL Principles → OOP Mental Models

This document provides a **deep, principle-level explanation** of how advanced SQL constructs map to Object-Oriented Programming (OOP) concepts. It is intended to demonstrate *how to think* about SQL, not just how to write it.

### 1. Table Aliases

| SQL Element             | OOP Analogy                     | Deep Explanation                                                                                                                                              |
| ----------------------- | ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `employees e`           | Object reference (`Employee e`) | An alias behaves like a local variable referencing an object. It does not create a new object; it simply provides a readable handle within the current scope. |
| `sales s`               | Object reference (`Sale s`)     | Represents a reference to related objects used during relationship traversal (joins).                                                                         |
| `department_ranking dr` | ViewModel reference             | Alias to a derived object designed for output rather than persistence.                                                                                        |
| `top_department td`     | Singleton-like reference        | Represents a globally computed object shared across all result rows.                                                                                          |

**Key Insight:** Aliases are *not* operators or methods; they are scoped references that enable expressive navigation of data.

------------

### 2. Dot Notation (`.`)

| SQL Syntax              | OOP Analogy            | Deep Explanation                                                       |
| ----------------------- | ---------------------- | ---------------------------------------------------------------------- |
| `e.employee_id`         | `e.employeeId`         | Dot notation represents property access on an object reference.        |
| `s.sale_amount`         | `s.amount`             | Accessing attributes of related objects after relationship resolution. |
| `dr.total_compensation` | `dr.totalCompensation` | Accessing computed (derived) properties.                               |

**Key Insight:** SQL dot notation mirrors object property access, not method invocation.

------------

### 3. JOIN Operations

| SQL Construct  | OOP Analogy           | Deep Explanation                                                      |
| -------------- | --------------------- | --------------------------------------------------------------------- |
| `LEFT JOIN`    | Optional association  | Preserves the parent object even when no related child objects exist. |
| `JOIN` (INNER) | Mandatory association | Parent object exists only when relationship exists.                   |
| `CROSS JOIN`   | Context injection     | Injects a global or shared object into all object instances.          |

**Key Insight:** JOINs define object graph traversal rules.

------------

### 4. GROUP BY

| SQL Construct               | OOP Analogy        | Deep Explanation                                                  |
| --------------------------- | ------------------ | ----------------------------------------------------------------- |
| `GROUP BY e.employee_id`    | Implicit loop      | SQL performs an implicit iteration over unique object identities. |
| Multiple `GROUP BY` columns | Composite identity | Defines uniqueness across multiple attributes.                    |

**Key Insight:** GROUP BY introduces an implicit iteration boundary, similar to `for-each` loops.

------------

### 5. Aggregate Functions

| SQL Function    | OOP Analogy          | Deep Explanation                                        |
| --------------- | -------------------- | ------------------------------------------------------- |
| `SUM()`         | Reduce operation     | Combines a collection of values into a single result.   |
| `MAX()`         | Comparator reduction | Selects the highest value in a collection.              |
| `COALESCE(x,0)` | Null-safe fallback   | Ensures safe default values when collections are empty. |

**Key Insight:** Aggregates collapse collections; window functions do not.

------------

### 6. Common Table Expressions (CTEs)

| SQL Construct         | OOP Analogy                   | Deep Explanation                                          |
| --------------------- | ----------------------------- | --------------------------------------------------------- |
| `WITH ... AS (...)`   | Immutable intermediate object | Represents a pure function result that cannot be mutated. |
| Multiple chained CTEs | Transformation pipeline       | Sequential functional transformations of data.            |

**Key Insight:** CTEs resemble functional programming pipelines more than procedural code.

------------

### 7. Window Functions

| SQL Construct       | OOP Analogy                 | Deep Explanation                                        |
| ------------------- | --------------------------- | ------------------------------------------------------- |
| `RANK() OVER (...)` | Method on grouped objects   | Computes relative position without collapsing identity. |
| `SUM() OVER (...)`  | Non-destructive aggregation | Computes totals while keeping each object intact.       |

**Key Insight:** Window functions preserve row identity while adding derived context.

------------

### 8. CASE Expressions

| SQL Construct                         | OOP Analogy         | Deep Explanation                                         |
| ------------------------------------- | ------------------- | -------------------------------------------------------- |
| `CASE WHEN ... THEN ... ELSE ... END` | Conditional logic   | Equivalent to `if / else` branching at the object level. |
| Derived labels                        | Computed properties | Adds semantic meaning without changing underlying data.  |

------------

### 9. Final SELECT

| SQL Construct      | OOP Analogy        | Deep Explanation                                |
| ------------------ | ------------------ | ----------------------------------------------- |
| Final `SELECT`     | DTO / ViewModel    | Defines the output contract of the query.       |
| Column expressions | Getter methods     | Derived values computed at read time.           |
| `ORDER BY`         | Sorting collection | Orders objects for presentation or consumption. |

------------

## Conceptual Summary

This project intentionally documents advanced SQL logic using **Object-Oriented Programming (OOP) analogies** to demonstrate **conceptual mastery**, not merely syntactic familiarity.

The following principles are consistently applied throughout the queries:

* **Table aliases (`e`, `s`, `dr`, `td`) behave like object references**, providing a clear and concise way to access attributes and relationships.
* **Common Table Expressions (CTEs)** function as **immutable intermediate objects or collections**, computed once and reused across the query pipeline.
* **Window functions** behave like **methods applied over object collections** while **preserving individual row (object) identity**.
* **Aggregate functions (`SUM`, `MAX`, etc.)** simulate **operations on collections of objects**, similar to reducing a list to a single computed value.
* **JOIN operations** represent **relationships between objects and classes**, such as one-to-many and many-to-one associations.

This conceptual mapping reflects how complex SQL queries can be reasoned about using the same mental models applied in object-oriented software design, reinforcing a deeper understanding of SQL beyond surface-level syntax.

   
## Query Architecture & CTE Data Flow

The diagram below illustrates how base tables, Common Table Expressions (CTEs),
and window functions interact to produce the final analytical result.
It combines traditional ER relationships with SQL data flow dependencies.

<img width="1195" height="1814" alt="db-company-flow2" src="https://github.com/user-attachments/assets/823eeee8-670c-4d84-b076-74dce177ae43" />

