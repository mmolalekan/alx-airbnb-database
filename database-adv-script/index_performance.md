# Index Performance Report

```sql
EXPLAIN ANALYZE
SELECT b.booking_id, b.start_date, b.end_date, p.city
FROM "Booking" b
JOIN "Property" p ON b.property_id = p.property_id
WHERE b.user_id = 'c1d9b3e6-5f4a-4c28-98e3-0d2f8a4e8d1c'
  AND p.country = 'Nigeria';
-- The output would likely show `Seq Scan on bookings`.
```

**After Indexing**:
After creating the index `idx_bookings_property_id`, The output should now show `Index Scan using idx_bookings_property_id on bookings`, confirming that the index is being used to speed up the query.
