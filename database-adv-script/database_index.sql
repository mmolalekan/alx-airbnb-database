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