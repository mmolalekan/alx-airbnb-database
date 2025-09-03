-- Clear all existing data from tables.
-- The order is important to respect foreign key constraints.
TRUNCATE TABLE payments CASCADE;
TRUNCATE TABLE reviews CASCADE;
TRUNCATE TABLE messages CASCADE;
TRUNCATE TABLE bookings CASCADE;
TRUNCATE TABLE properties CASCADE;
TRUNCATE TABLE locations CASCADE;
TRUNCATE TABLE users CASCADE;

-- Insert sample users with different roles
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role) VALUES
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'John', 'Doe', 'john.doe@example.com', 'hashed_password_1', '123-456-7890', 'guest'),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'Jane', 'Smith', 'jane.smith@example.com', 'hashed_password_2', '987-654-3210', 'host'),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Admin', 'User', 'admin@example.com', 'hashed_password_3', '555-123-4567', 'admin'),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Host', 'B', 'host.b@example.com', 'hashed_password_4', '111-222-3333', 'host'),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'Guest', 'C', 'guest.c@example.com', 'hashed_password_5', '444-555-6666', 'guest');

-- Insert sample locations
INSERT INTO locations (location_id, street_address, city, state, country) VALUES
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', '123 Main St', 'San Francisco', 'CA', 'USA'),
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', '45 Rue de l''Amour', 'Paris', 'Île-de-France', 'France'),
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', '88 Sakura Lane', 'Tokyo', 'Tokyo', 'Japan');

-- Insert sample properties
INSERT INTO properties (property_id, host_id, name, description, location_id, price_per_night) VALUES
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'Cozy Downtown Apartment', 'A beautiful apartment in the heart of the city.', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 150.00),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Charming Parisian Flat', 'Experience the magic of Paris from this flat.', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 200.00),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'Spacious Japanese Villa', 'Traditional villa with a modern touch.', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 350.50);

-- Insert sample bookings
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status) VALUES
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', '2025-10-01', '2025-10-05', 600.00, 'confirmed'),
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', '2025-11-10', '2025-11-12', 400.00, 'pending'),
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', '2025-12-20', '2025-12-25', 750.00, 'confirmed');

-- Insert sample payments
INSERT INTO payments (payment_id, booking_id, amount, payment_method) VALUES
('e0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'd0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 600.00, 'credit_card'),
('e0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'd0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 400.00, 'paypal'),
('e0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'd0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 750.00, 'stripe');

-- Insert sample reviews
INSERT INTO reviews (review_id, property_id, user_id, rating, comment) VALUES
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 5, 'Absolutely fantastic stay! The apartment was perfect and the host was great.'),
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 4, 'Charming flat, but the street was a bit noisy at night.');

-- Insert sample messages
INSERT INTO messages (message_id, sender_id, recipient_id, message_body) VALUES
('g0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'Hi Jane, I am looking forward to my stay!'),
('g0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Hi John, thank you! Let me know if you need anything.');
