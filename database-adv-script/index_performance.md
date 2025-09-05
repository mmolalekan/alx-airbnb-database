# Index Performance Report

```sql
EXPLAIN SELECT FROM bookings WHERE property_id = 'c1d9b3e6-5f4a-4c28-98e3-0d2f8a4e8d1c';
-- The output would likely show `Seq Scan on bookings`.
```

**After Indexing**:
After creating the index `idx_bookings_property_id`, the query plan would change to:

```sql
EXPLAIN SELECT * FROM bookings WHERE property_id = 'c1d9b3e6-5f4a-4c28-98e3-0d2f8a4e8d1c';
-- The output should now show `Index Scan using idx_bookings_property_id on bookings`, confirming that the index is being used to speed up the query.
```
