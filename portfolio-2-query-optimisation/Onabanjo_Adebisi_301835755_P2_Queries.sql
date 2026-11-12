-- Show related reservations, guests, rooms records (up to 20).
SELECT t0."reservation_id" AS "reservations_reservation_id",
       t0."check_in" AS "reservations_check_in",
       t1."guest_id" AS "guests_guest_id",
       t1."email" AS "guests_email",
       t2."room_id" AS "rooms_room_id",
       t2."room_number" AS "rooms_room_number"
FROM portfolio."reservations" t0
JOIN portfolio."guests" t1 ON t0."guest_id" = t1."guest_id"
JOIN portfolio."rooms" t2 ON t0."room_id" = t2."room_id"
ORDER BY t0."reservation_id", t1."guest_id", t2."room_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT t0."reservation_id" AS "reservations_reservation_id",
       t0."check_in" AS "reservations_check_in",
       t1."guest_id" AS "guests_guest_id",
       t1."email" AS "guests_email",
       t2."room_id" AS "rooms_room_id",
       t2."room_number" AS "rooms_room_number"
FROM portfolio."reservations" t0
JOIN portfolio."guests" t1 ON t0."guest_id" = t1."guest_id"
JOIN portfolio."rooms" t2 ON t0."room_id" = t2."room_id"
ORDER BY t0."reservation_id", t1."guest_id", t2."room_id"
LIMIT 20;

-- Find rooms records where room_number matches "101" (up to 20).
SELECT * FROM portfolio."rooms"
WHERE "room_number" IS NOT DISTINCT FROM '101'
ORDER BY "room_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT * FROM portfolio."rooms"
WHERE "room_number" IS NOT DISTINCT FROM '101'
ORDER BY "room_id"
LIMIT 20;

-- Count payments records for each reservation_id (up to 20 groups).
SELECT "reservation_id", count(*) AS record_count
FROM portfolio."payments"
GROUP BY "reservation_id"
ORDER BY record_count DESC, "reservation_id" NULLS LAST
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT "reservation_id", count(*) AS record_count
FROM portfolio."payments"
GROUP BY "reservation_id"
ORDER BY record_count DESC, "reservation_id" NULLS LAST
LIMIT 20;
