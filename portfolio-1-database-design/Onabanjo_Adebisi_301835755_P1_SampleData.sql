-- Fictional sample records for Hotel Reservation System.
BEGIN;
SET LOCAL standard_conforming_strings = on;
INSERT INTO portfolio."guests" ("guest_id", "email", "full_name", "phone") VALUES (1, 'alex.river@example.test', 'Alex River', '+1-555-0101');
INSERT INTO portfolio."guests" ("guest_id", "email", "full_name", "phone") VALUES (2, 'sam.lake@example.test', 'Sam Lake', NULL);
INSERT INTO portfolio."rooms" ("room_id", "room_number", "room_type", "nightly_rate", "active") VALUES (101, '101', 'standard', 120, TRUE);
INSERT INTO portfolio."rooms" ("room_id", "room_number", "room_type", "nightly_rate", "active") VALUES (102, '102', 'deluxe', 185, TRUE);
INSERT INTO portfolio."reservations" ("reservation_id", "guest_id", "room_id", "check_in", "check_out", "status", "booked_at") VALUES (201, 1, 101, '2026-12-01', '2026-12-03', 'confirmed', '2026-10-10T09:30:00Z');
INSERT INTO portfolio."reservations" ("reservation_id", "guest_id", "room_id", "check_in", "check_out", "status", "booked_at") VALUES (202, 2, 102, '2026-12-05', '2026-12-07', 'held', '2026-10-11T14:15:00+00:00');
INSERT INTO portfolio."payments" ("payment_id", "reservation_id", "amount", "paid_at", "payment_method") VALUES (301, 201, 240, '2026-12-01T10:00:00Z', 'card');
COMMIT;
