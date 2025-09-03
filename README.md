# ALX Airbnb Database Project

## 📌 Project Overview

This project is a key part of the **ALX Airbnb Database Module**, challenging you to apply principles of **database design, normalization, and data management**. The main goal is to build a functional, **production-ready relational database** for a service similar to Airbnb. This work emphasizes skills in creating scalable and efficient systems, a critical part of professional database engineering.

---

## 🎯 What You'll Learn

Upon finishing this project, you will be able to:

- **Design complex database systems** for real-world applications.
- **Normalize databases up to 3NF** to ensure data integrity and reduce redundancy.
- **Write robust SQL scripts** (`DDL`) to define database schemas, including keys, constraints, and indexes.
- **Populate the database** with realistic data using `SQL DML` scripts.
- **Collaborate and document your work** to industry standards.

---

## ⚙️ Prerequisites

To get started, you should have:

- A solid understanding of **relational databases and SQL**.
- Experience with **ER modeling tools** like Draw.io.
- A strong grasp of **data normalization concepts**.
- Familiarity with **GitHub** for project management.
- Knowledge of **database design best practices**.

---

## 🚀 Project Tasks

### **Task 1: ER Diagram**

- Create a detailed ERD to visually represent your database structure.
- Clearly define entities, attributes, and their relationships.

### **Task 2: Normalization**

- Refine your design by applying **normalization rules up to 3NF**.
- Focus on optimizing data integrity and eliminating redundant data.

### **Task 3: Schema Creation**

- Develop SQL **DDL scripts** to build your tables and their constraints.
- Include **primary keys, foreign keys, and indexes** to optimize performance.

### **Task 4: Data Seeding**

- Write SQL **DML scripts** to insert sample data.
- Populate the database with realistic entries for users, properties, bookings, and payments.

---

## 📂 Repository Structure

├── diagrams/ # ERD and design files
├── sql/
│ ├── schema.sql # The database schema (DDL)
│ ├── seed.sql # Sample data (DML)
│ └── queries.sql # Example validation queries
├── docs/
│ ├── normalization.md # Normalization documentation
│ └── README.md # This project overview
└── .gitignore

---

## 🧑‍💻 How to Run

1.  Clone this repository.
2.  Use a SQL client to execute the schema file:

    ```bash
    SOURCE sql/schema.sql;
    ```

3.  Populate the database with the sample data:

    ```bash
    SOURCE sql/seed.sql;
    ```

4.  (Optional) Run validation queries:

    ```bash
    SOURCE sql/queries.sql;
    ```

---

## 📖 Resources

- SQL Documentation (for PostgreSQL/MySQL)
- Guides on Database Normalization
- Draw.io tutorials for ERD modeling

---
