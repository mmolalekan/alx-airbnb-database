-- Initial Query: Retrieves all bookings with user, property, and payment details.
-- This query uses multiple joins, which can be inefficient on large datasets.
EXPLAIN ANALYZE
SELECT
  b.booking_id,
  b.start_date,
  b.end_date,
  b.total_price,
  b.status,
  u.first_name AS user_first_name,
  u.last_name AS user_last_name,
  p.name AS property_name,
  p.price_per_night,
  py.amount AS payment_amount,
  py.payment_date
FROM
  bookings AS b
  INNER JOIN users AS u ON b.user_id = u.user_id
  INNER JOIN properties AS p ON b.property_id = p.property_id
  INNER JOIN payments AS py ON b.booking_id = py.booking_id;

-- Index creation for optimization
CREATE INDEX IF NOT EXISTS idx_booking_user_id ON "Booking" (user_id);

CREATE INDEX IF NOT EXISTS idx_booking_property_id ON "Booking" (property_id);

CREATE INDEX IF NOT EXISTS idx_payment_booking_id ON "Payment" (booking_id);

-- Refactored Query: Uses a more efficient approach with indexing.
-- This query is optimized by leveraging indexes on foreign keys,
-- which makes the joins significantly faster.
EXPLAIN ANALYZE
SELECT
  b.booking_id,
  b.start_date,
  b.end_date,
  b.total_price,
  b.status,
  u.first_name AS user_first_name,
  u.last_name AS user_last_name,
  p.name AS property_name,
  p.price_per_night,
  py.amount AS payment_amount,
  py.payment_date
FROM
  bookings AS b
  INNER JOIN users AS u ON b.user_id = u.user_id
  INNER JOIN properties AS p ON b.property_id = p.property_id
  INNER JOIN payments AS py ON b.booking_id = py.booking_id;

WHERE
  b.status = 'confirmed'
  AND b.start_date >= DATE '2025-10-01'
  AND p.city = 'New York';