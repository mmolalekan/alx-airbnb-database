-- =========================================
-- Partitioning Script for the "Booking" Table
-- This script migrates the existing Booking table to a partitioned structure.
-- The process is wrapped in a transaction to ensure data integrity.
-- =========================================
BEGIN;

-- =========================================
-- Step 1: Temporarily remove the foreign key constraint
-- The constraint on the Payment table must be dropped to prevent conflicts
-- during the migration process.
-- =========================================
ALTER TABLE "Payment"
DROP CONSTRAINT IF EXISTS fk_payment_booking;

-- =========================================
-- Step 2: Rename the original table
-- The existing, unpartitioned "Booking" table is renamed to prepare for the
-- creation of the new partitioned parent table.
-- =========================================
ALTER TABLE "Booking"
RENAME TO "Booking_Temp";

-- =========================================
-- Step 3: Create the new partitioned parent table
-- This new "Booking" table is the parent for all partitions and is
-- partitioned by the 'start_date' column. The primary key is now a composite
-- key including both the booking_id and start_date to enable efficient
-- partitioning.
-- =========================================
CREATE TABLE
  "Booking" (
    booking_id UUID NOT NULL DEFAULT gen_random_uuid (),
    property_id UUID NOT NULL REFERENCES "Property" (property_id),
    user_id UUID NOT NULL REFERENCES "User" (user_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL NOT NULL,
    status VARCHAR NOT NULL CHECK (status IN ('pending', 'confirmed', 'canceled')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id, start_date)
  )
PARTITION BY
  RANGE (start_date);

-- =========================================
-- Step 4: Create new partitions
-- Partitions are created for each year to store bookings.
-- The 'DEFAULT' partition handles any bookings that fall outside
-- the specified yearly ranges.
-- =========================================
CREATE TABLE
  booking_2024 PARTITION OF "Booking" FOR
VALUES
FROM
  ('2024-01-01') TO ('2025-01-01');

CREATE TABLE
  booking_2025 PARTITION OF "Booking" FOR
VALUES
FROM
  ('2025-01-01') TO ('2026-01-01');

CREATE TABLE
  booking_2026 PARTITION OF "Booking" FOR
VALUES
FROM
  ('2026-01-01') TO ('2027-01-01');

CREATE TABLE
  booking_default PARTITION OF "Booking" DEFAULT;

-- =========================================
-- Step 5: Copy data to the new partitioned table
-- All existing data from the old table is inserted into the new
-- partitioned table. PostgreSQL automatically places each row in the
-- correct partition.
-- =========================================
INSERT INTO
  "Booking" (
    booking_id,
    property_id,
    user_id,
    start_date,
    end_date,
    total_price,
    status,
    created_at
  )
SELECT
  booking_id,
  property_id,
  user_id,
  start_date,
  end_date,
  total_price,
  status,
  created_at
FROM
  "Booking_Temp";

-- =========================================
-- Step 6: Create indexes for performance
-- To maintain high performance, indexes are created on the child partitions.
-- =========================================
CREATE INDEX IF NOT EXISTS idx_booking_start_date_2024 ON booking_2024 (start_date);

CREATE INDEX IF NOT EXISTS idx_booking_start_date_2025 ON booking_2025 (start_date);

CREATE INDEX IF NOT EXISTS idx_booking_start_date_2026 ON booking_2026 (start_date);

CREATE INDEX IF NOT EXISTS idx_booking_user_id_2024 ON booking_2024 (user_id);

CREATE INDEX IF NOT EXISTS idx_booking_user_id_2025 ON booking_2025 (user_id);

CREATE INDEX IF NOT EXISTS idx_booking_user_id_2026 ON booking_2026 (user_id);

CREATE INDEX IF NOT EXISTS idx_booking_property_id_2024 ON booking_2024 (property_id);

CREATE INDEX IF NOT EXISTS idx_booking_property_id_2025 ON booking_2025 (property_id);

CREATE INDEX IF NOT EXISTS idx_booking_property_id_2026 ON booking_2026 (property_id);

-- Update table statistics after data migration
ANALYZE "Booking";

-- =========================================
-- Step 7: Re-establish foreign key on "Payment" table
-- A composite foreign key is added to link "Payment" to the new "Booking"
-- partitioned table, using both booking_id and start_date.
-- =========================================
ALTER TABLE "Payment"
ADD COLUMN start_date DATE;

UPDATE "Payment" p
SET
  start_date = b.start_date
FROM
  "Booking" b
WHERE
  p.booking_id = b.booking_id;

ALTER TABLE "Payment"
ALTER COLUMN start_date
SET
  NOT NULL;

ALTER TABLE "Payment" ADD CONSTRAINT fk_payment_booking FOREIGN KEY (booking_id, start_date) REFERENCES "Booking" (booking_id, start_date);

-- =========================================
-- Step 8: Performance comparison
-- These queries demonstrate the performance improvement gained by partitioning.
-- The partitioned query only scans the relevant partition, while the
-- old query must scan the entire table.
-- =========================================
-- Query on the old, non-partitioned table
EXPLAIN ANALYZE
SELECT
  booking_id,
  start_date,
  end_date,
  status
FROM
  "Booking_Temp"
WHERE
  start_date BETWEEN DATE '2025-10-01' AND DATE  '2025-12-31';

-- Query on the new partitioned table
EXPLAIN ANALYZE
SELECT
  booking_id,
  start_date,
  end_date,
  status
FROM
  "Booking"
WHERE
  start_date BETWEEN DATE '2025-10-01' AND DATE  '2025-12-31';

-- =========================================
-- Final step: Commit the transaction
-- =========================================
COMMIT;

-- rollback;