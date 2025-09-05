-- Find properties with an average rating greater than 4.0
SELECT
  p.property_id,
  p.name,
  p.description
FROM
  properties AS p
WHERE
  p.property_id IN (
    -- Subquery: find property_ids that have an average rating > 4.0
    SELECT
      property_id
    FROM
      reviews
    GROUP BY
      property_id
    HAVING
      AVG(rating) > 4.0
  );

-- Find users who have made more than 3 bookings
SELECT
  u.user_id,
  u.first_name,
  u.last_name
FROM
  users AS u
WHERE
  (
    -- Subquery: count the number of bookings for the current user (u.user_id)
    SELECT
      COUNT(b.booking_id)
    FROM
      bookings AS b
    WHERE
      b.user_id = u.user_id
  ) > 3;