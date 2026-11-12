-- Run these deliberately invalid statements one at a time, outside a transaction.
-- Each should fail at the named constraint; the sample rows should remain unchanged.

-- 1. guests pk duplicate. Expected: pk_guests, SQLSTATE 23505.
INSERT INTO portfolio."guests" ("guest_id", "email", "full_name", "phone")
VALUES (1, 'new.guest@example.test', 'Taylor Stone', NULL);

-- 2. guests email duplicate. Expected: uq_guests_0, SQLSTATE 23505.
INSERT INTO portfolio."guests" ("guest_id", "email", "full_name", "phone")
VALUES (1001, 'alex.river@example.test', 'Jordan Vale', NULL);

-- 3. guests guest id null. Expected: guest_id, SQLSTATE 23502.
INSERT INTO portfolio."guests" ("guest_id", "email", "full_name", "phone")
VALUES (NULL, 'case.guestid@example.test', 'Case Guestid', NULL);

-- 4. guests email null. Expected: email, SQLSTATE 23502.
INSERT INTO portfolio."guests" ("guest_id", "email", "full_name", "phone")
VALUES (1002, NULL, 'Case Email', NULL);

-- 5. guests full name null. Expected: full_name, SQLSTATE 23502.
INSERT INTO portfolio."guests" ("guest_id", "email", "full_name", "phone")
VALUES (1003, 'case.name@example.test', NULL, NULL);

-- 6. rooms pk duplicate. Expected: pk_rooms, SQLSTATE 23505.
INSERT INTO portfolio."rooms" ("room_id", "room_number", "room_type", "nightly_rate", "active")
VALUES (101, '901', 'suite', 250, TRUE);

-- 7. rooms number duplicate. Expected: uq_rooms_0, SQLSTATE 23505.
INSERT INTO portfolio."rooms" ("room_id", "room_number", "room_type", "nightly_rate", "active")
VALUES (1004, '101', 'suite', 250, TRUE);

-- 8. rooms room id null. Expected: room_id, SQLSTATE 23502.
INSERT INTO portfolio."rooms" ("room_id", "room_number", "room_type", "nightly_rate", "active")
VALUES (NULL, '903', 'standard', 100, TRUE);

-- 9. rooms number null. Expected: room_number, SQLSTATE 23502.
INSERT INTO portfolio."rooms" ("room_id", "room_number", "room_type", "nightly_rate", "active")
VALUES (1005, NULL, 'standard', 100, TRUE);

-- 10. rooms type null. Expected: room_type, SQLSTATE 23502.
INSERT INTO portfolio."rooms" ("room_id", "room_number", "room_type", "nightly_rate", "active")
VALUES (1006, '906', NULL, 100, TRUE);

-- 11. rooms rate null. Expected: nightly_rate, SQLSTATE 23502.
INSERT INTO portfolio."rooms" ("room_id", "room_number", "room_type", "nightly_rate", "active")
VALUES (1007, '907', 'standard', NULL, TRUE);

-- 12. rooms active null. Expected: active, SQLSTATE 23502.
INSERT INTO portfolio."rooms" ("room_id", "room_number", "room_type", "nightly_rate", "active")
VALUES (1008, '908', 'standard', 100, NULL);

-- 13. reservations pk duplicate. Expected: pk_reservations, SQLSTATE 23505.
INSERT INTO portfolio."reservations" ("reservation_id", "guest_id", "room_id", "check_in", "check_out", "status", "booked_at")
VALUES (201, 2, 102, '2027-01-10', '2027-01-12', 'cancelled', '2026-10-12T08:00:00Z');

-- 14. reservations guest fk invalid. Expected: fk_reservations_0, SQLSTATE 23503.
INSERT INTO portfolio."reservations" ("reservation_id", "guest_id", "room_id", "check_in", "check_out", "status", "booked_at")
VALUES (1009, 99999, 101, '2027-01-10', '2027-01-12', 'cancelled', '2026-10-12T08:00:00Z');

-- 15. reservations room fk invalid. Expected: fk_reservations_1, SQLSTATE 23503.
INSERT INTO portfolio."reservations" ("reservation_id", "guest_id", "room_id", "check_in", "check_out", "status", "booked_at")
VALUES (1010, 1, 99999, '2027-01-10', '2027-01-12', 'cancelled', '2026-10-12T08:00:00Z');

-- 16. reservations id null. Expected: reservation_id, SQLSTATE 23502.
INSERT INTO portfolio."reservations" ("reservation_id", "guest_id", "room_id", "check_in", "check_out", "status", "booked_at")
VALUES (NULL, 1, 101, '2027-01-10', '2027-01-12', 'cancelled', '2026-10-12T08:00:00Z');

-- 17. reservations guest id null. Expected: guest_id, SQLSTATE 23502.
INSERT INTO portfolio."reservations" ("reservation_id", "guest_id", "room_id", "check_in", "check_out", "status", "booked_at")
VALUES (1011, NULL, 101, '2027-01-10', '2027-01-12', 'cancelled', '2026-10-12T08:00:00Z');

-- 18. reservations room id null. Expected: room_id, SQLSTATE 23502.
INSERT INTO portfolio."reservations" ("reservation_id", "guest_id", "room_id", "check_in", "check_out", "status", "booked_at")
VALUES (1012, 1, NULL, '2027-01-10', '2027-01-12', 'cancelled', '2026-10-12T08:00:00Z');

-- 19. reservations check in null. Expected: check_in, SQLSTATE 23502.
INSERT INTO portfolio."reservations" ("reservation_id", "guest_id", "room_id", "check_in", "check_out", "status", "booked_at")
VALUES (1013, 1, 101, NULL, '2027-01-12', 'cancelled', '2026-10-12T08:00:00Z');

-- 20. reservations check out null. Expected: check_out, SQLSTATE 23502.
INSERT INTO portfolio."reservations" ("reservation_id", "guest_id", "room_id", "check_in", "check_out", "status", "booked_at")
VALUES (1014, 1, 101, '2027-01-10', NULL, 'cancelled', '2026-10-12T08:00:00Z');

-- 21. reservations status null. Expected: status, SQLSTATE 23502.
INSERT INTO portfolio."reservations" ("reservation_id", "guest_id", "room_id", "check_in", "check_out", "status", "booked_at")
VALUES (1015, 1, 101, '2027-01-10', '2027-01-12', NULL, '2026-10-12T08:00:00Z');

-- 22. reservations booked at null. Expected: booked_at, SQLSTATE 23502.
INSERT INTO portfolio."reservations" ("reservation_id", "guest_id", "room_id", "check_in", "check_out", "status", "booked_at")
VALUES (1016, 1, 101, '2027-01-10', '2027-01-12', 'cancelled', NULL);

-- 23. reservations dates invalid. Expected: reservation_dates_valid, SQLSTATE 23514.
INSERT INTO portfolio."reservations" ("reservation_id", "guest_id", "room_id", "check_in", "check_out", "status", "booked_at")
VALUES (1017, 1, 102, '2027-01-12', '2027-01-10', 'cancelled', '2026-10-12T08:00:00Z');

-- 24. reservations confirmed start duplicate. Expected: confirmed_room_same_start_unique, SQLSTATE 23505.
INSERT INTO portfolio."reservations" ("reservation_id", "guest_id", "room_id", "check_in", "check_out", "status", "booked_at")
VALUES (1018, 2, 101, '2026-12-01', '2026-12-04', 'confirmed', '2026-10-12T08:00:00Z');

-- 25. payments pk duplicate. Expected: pk_payments, SQLSTATE 23505.
INSERT INTO portfolio."payments" ("payment_id", "reservation_id", "amount", "paid_at", "payment_method")
VALUES (301, 202, 50, '2026-12-05T10:00:00Z', 'cash');

-- 26. payments reservation fk invalid. Expected: fk_payments_0, SQLSTATE 23503.
INSERT INTO portfolio."payments" ("payment_id", "reservation_id", "amount", "paid_at", "payment_method")
VALUES (1019, 99999, 50, '2026-12-05T10:00:00Z', 'cash');

-- 27. payments id null. Expected: payment_id, SQLSTATE 23502.
INSERT INTO portfolio."payments" ("payment_id", "reservation_id", "amount", "paid_at", "payment_method")
VALUES (NULL, 201, 50, '2026-12-05T10:00:00Z', 'cash');

-- 28. payments reservation id null. Expected: reservation_id, SQLSTATE 23502.
INSERT INTO portfolio."payments" ("payment_id", "reservation_id", "amount", "paid_at", "payment_method")
VALUES (1020, NULL, 50, '2026-12-05T10:00:00Z', 'cash');

-- 29. payments amount null. Expected: amount, SQLSTATE 23502.
INSERT INTO portfolio."payments" ("payment_id", "reservation_id", "amount", "paid_at", "payment_method")
VALUES (1021, 201, NULL, '2026-12-05T10:00:00Z', 'cash');

-- 30. payments paid at null. Expected: paid_at, SQLSTATE 23502.
INSERT INTO portfolio."payments" ("payment_id", "reservation_id", "amount", "paid_at", "payment_method")
VALUES (1022, 201, 50, NULL, 'cash');

-- 31. payments method null. Expected: payment_method, SQLSTATE 23502.
INSERT INTO portfolio."payments" ("payment_id", "reservation_id", "amount", "paid_at", "payment_method")
VALUES (1023, 201, 50, '2026-12-05T10:00:00Z', NULL);

-- 32. payments amount not positive. Expected: payment_amount_positive, SQLSTATE 23514.
INSERT INTO portfolio."payments" ("payment_id", "reservation_id", "amount", "paid_at", "payment_method")
VALUES (1024, 201, 0, '2026-12-05T10:00:00Z', 'cash');
