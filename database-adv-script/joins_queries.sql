-- INNER JOIN: Retrieve all bookings with user details
-- An INNER JOIN returns only records that have matching values in both tables.
SELECT
  b.booking_id,
  b.start_date,
  b.end_date,
  b.status,
  u.user_id,
  u.first_name,
  u.last_name,
  u.email
FROM
  bookings AS b
  INNER JOIN users AS u ON b.user_id = u.user_id
ORDER BY
  b.booking_id ASC;

-- LEFT JOIN: Retrieve all properties and their reviews
-- A LEFT JOIN returns all records from the left table (properties)
-- and the matched records from the right table (reviews).
SELECT
  p.property_id,
  p.host_id,
  p.name AS property_name,
  p.country,
  p.city,
  p.street_address,
  p.price_per_night,
  p.description,
  r.review_id,
  r.rating,
  r.comment,
  r.created_at AS review_date
FROM
  properties AS p
  LEFT JOIN reviews AS r ON p.property_id = r.property_id;

-- FULL OUTER JOIN: Retrieve all users and all bookings
-- A FULL OUTER JOIN returns all records when there is a match in either left or right table.
SELECT
  u.user_id AS user_id,
  u.first_name,
  u.last_name,
  u.email,
  b.booking_id,
  b.start_date,
  b.end_date
FROM
  users AS u
  FULL OUTER JOIN bookings AS b ON u.user_id = b.user_id;