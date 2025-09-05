-- Find the total number of bookings made by each user
SELECT
  user_id,
  COUNT(booking_id) AS total_bookings
FROM
  bookings
GROUP BY
  user_id
ORDER BY
  total_bookings DESC;

-- Rank properties based on the total number of bookings
SELECT
  property_id,
  total_bookings,
  ROW_NUMBER() OVER (
    ORDER BY
      COUNT(booking_id) DESC
  ) AS property_row,
  RANK() OVER (
    ORDER BY
      total_bookings DESC
  ) AS booking_rank
FROM
  (
    -- Subquery to get the total number of bookings for each property
    SELECT
      property_id,
      COUNT(booking_id) AS total_bookings
    FROM
      bookings
    GROUP BY
      property_id
  ) AS ranked_properties
ORDER BY
  booking_rank ASC;