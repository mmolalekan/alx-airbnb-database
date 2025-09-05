-- for faster login and user lookups
CREATE INDEX idx_users_email ON users (email);

-- for efficient joins with the users table
CREATE INDEX idx_properties_host_id ON properties (host_id);

-- for filtering properties by location
CREATE INDEX idx_properties_location_id ON properties (location_id);

-- for quickly finding all bookings made by a user
CREATE INDEX idx_bookings_user_id ON bookings (user_id);

-- for quickly finding all bookings for a property
CREATE INDEX idx_bookings_property_id ON bookings (property_id);

-- for filtering bookings by status
CREATE INDEX idx_bookings_status ON bookings (status);

-- for fast joins with the properties table
CREATE INDEX idx_reviews_property_id ON reviews (property_id);

-- for efficiently finding all reviews by a specific user
CREATE INDEX idx_reviews_user_id ON reviews (user_id);

--Find all bookings for a specific user in a country
EXPLAIN ANALYZE
SELECT
  b.booking_id,
  b.start_date,
  b.end_date,
  p.city
FROM
  "Booking" b
  JOIN "Property" p ON b.property_id = p.property_id
WHERE
  b.user_id = 'c1d9b3e6-5f4a-4c28-98e3-0d2f8a4e8d1c'
  AND p.country = 'Nigeria';