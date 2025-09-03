# 0x01 - Database Script

This section describes the PostgreSQL `CREATE TABLE` statements used to build the database schema. It defines entities, constraints, foreign keys, and indexes for efficient querying and data integrity.

---

## Key Features of the Schema

### 1. **Primary Keys**

- Each table uses a `UUID` as the **primary key**.
- This ensures globally unique identifiers and avoids issues with auto-incrementing IDs in distributed systems.

### 2. **Foreign Keys and Relationships**

- Relationships are enforced with **foreign keys**:
  - `properties.host_id` → `users.user_id`
  - `properties.location_id` → `locations.location_id`
  - `bookings.property_id` → `properties.property_id`
  - `bookings.user_id` → `users.user_id`
  - `payments.booking_id` → `bookings.booking_id`
  - `reviews.property_id` → `properties.property_id`
  - `reviews.user_id` → `users.user_id`
  - `messages.sender_id` → `users.user_id`
  - `messages.recipient_id` → `users.user_id`
- `ON DELETE CASCADE` is applied so that when a parent record is deleted, dependent child records are automatically removed.

### 3. **Constraints**

- **Unique Constraints**:
  - `users.email` must be unique.
- **Check Constraints**:
  - `users.role` must be one of: `guest`, `host`, `admin`.
  - `bookings.status` must be one of: `pending`, `confirmed`, `canceled`.
  - `payments.payment_method` must be one of: `credit_card`, `paypal`, `stripe`.
  - `reviews.rating` must be between `1` and `5`.

### 4. **Indexes**

Indexes are created to improve query performance:

- `users.email` → for fast lookups by email.
- `properties.host_id` → for efficient joins between users and properties.
- `bookings.property_id`, `bookings.user_id`, `bookings.status` → for filtering bookings.
- `payments.booking_id` → for finding payments by booking.
- `reviews.property_id`, `reviews.user_id`, `reviews.rating` → for aggregating reviews.
- `messages.sender_id`, `messages.recipient_id` → for fetching conversations.
- `locations.city`, `locations.country` → for filtering properties by location.

### 5. **Timestamps**

- Most tables include `created_at` with `DEFAULT CURRENT_TIMESTAMP`.
- `properties.updated_at` is included to track updates (with a note to update on modification).

---
