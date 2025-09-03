# 0x02 - Data Population Script

This script (`seed.sql`) is designed to populate the database schema with realistic, **sample data**. It's an essential part of the project that demonstrates how the normalized tables work together and provides a sandbox for running queries.

---

## 📌 About the Script

- **Purpose**: To insert a wide range of mock data, including users, properties, bookings, payments, and reviews.
- **Data Integrity**: The script follows all foreign key constraints, ensuring the data is valid and consistent with the defined schema.
- **Idempotence**: It begins with a `TRUNCATE CASCADE` command, which allows you to run the script multiple times without creating duplicate records. This command first deletes all data from the tables, then re-inserts the sample data.

---

## 🚀 How to Use

1.  Ensure your database is running and the schema (`schema.sql`) has been successfully loaded.
2.  Open your SQL client or terminal.
3.  Execute the script using the `\i` command in `psql` or `SOURCE` in MySQL:

    ```bash
    -- For PostgreSQL
    \i sql/seed.sql

    -- For MySQL
    SOURCE sql/seed.sql;
    ```

    Alternatively, you can copy and paste the entire script directly into your SQL shell.

---

## 📂 Data Structure and Relationships

The script populates the following tables in a specific order to satisfy foreign key dependencies:

1.  `users`
2.  `locations`
3.  `properties` (links to `users` and `locations`)
4.  `bookings` (links to `properties` and `users`)
5.  `payments` (links to `bookings`)
6.  `reviews` (links to `properties` and `users`)
7.  `messages` (links to `users`)
