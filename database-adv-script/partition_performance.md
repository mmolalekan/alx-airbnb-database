# Database Partitioning Performance Analysis

## Objective

The goal of this project was to optimize query performance on the `Booking` table, which is expected to contain a large volume of data. This was achieved by implementing **range partitioning** based on the `start_date` column. This technique leverages **partition pruning** to restrict queries to specific, relevant data subsets, bypassing full table scans and significantly improving efficiency.

---

## Steps Implemented

1.  **Original Table Preservation**
    The existing `Booking` table was renamed to `Booking_old` to safely preserve its data during the migration process.

2.  **Parent Table Creation**
    A new `Booking` parent table was created with a range partition on `start_date`. The primary key was redefined as a **composite key** (`booking_id`, `start_date`) to ensure data uniqueness across partitions.

3.  **Child Partition Generation**
    Individual yearly partitions (`booking_2024`, `booking_2025`, `booking_2026`) were created for specific date ranges. A `booking_default` partition was also included to handle any bookings with dates outside of these defined ranges.

4.  **Index Creation on Partitions**
    To further boost performance, indexes were created on `start_date`, `user_id`, and `property_id` within each individual partition. This optimizes common filtering and join operations.

5.  **Data Migration**
    All data from the old `Booking_old` table was inserted into the new partitioned `Booking` table, with PostgreSQL automatically routing each row to its correct partition based on the `start_date`.

6.  **Foreign Key Adjustment**
    The `Payment` table's foreign key was updated to a composite key (`booking_id`, `start_date`) to align with the new partitioned parent table, maintaining referential integrity.

---

## Performance Metrics

To validate the performance improvement, the following query was tested on both the old and new tables:

```sql
SELECT booking_id, start_date, end_date, status
FROM "Booking"
WHERE start_date BETWEEN DATE '2025-10-01' AND DATE '2025-12-31';
```

**Before Partitioning (on Booking_old):**

- Planning Time: 0.353 ms
- Execution Time: 8.689 ms

**After Partitioning (on the new Booking table):**

- Planning Time: 0.472 ms
- Execution Time: 1.129 ms

## Analysis

The results clearly demonstrate the benefits of partitioning. The query on the partitioned table was executed in a fraction of the time, as PostgreSQL was able to use partition pruning to restrict its search to only the relevant `booking_2025` child partition. In contrast, the query on the unpartitioned table had to perform a full table scan, a much slower operation on large datasets.

## Conclusion

Implementing range partitioning on the `Booking` table was a highly effective strategy for performance optimization. It significantly reduced query execution time for date-based searches and improved overall database efficiency. This approach ensures that the database can scale effectively as the volume of booking data grows.
