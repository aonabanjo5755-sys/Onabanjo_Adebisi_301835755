# Hotel Reservation System — SQL queries

## 1. Show related reservations, guests, rooms records (up to 20).

```sql
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
```

| reservations_reservation_id | reservations_check_in | guests_guest_id | guests_email | rooms_room_id | rooms_room_number |
| --- | --- | --- | --- | --- | --- |
| 201 | 2026-12-01 | 1 | alex.river@example.test | 101 | 101 |
| 202 | 2026-12-05 | 2 | sam.lake@example.test | 102 | 102 |

## 2. Find rooms records where room_number matches "101" (up to 20).

```sql
SELECT * FROM portfolio."rooms"
WHERE "room_number" IS NOT DISTINCT FROM '101'
ORDER BY "room_id"
LIMIT 20;
```

| room_id | room_number | room_type | nightly_rate | active |
| --- | --- | --- | --- | --- |
| 101 | 101 | standard | 120 | true |

## 3. Count payments records for each reservation_id (up to 20 groups).

```sql
SELECT "reservation_id", count(*) AS record_count
FROM portfolio."payments"
GROUP BY "reservation_id"
ORDER BY record_count DESC, "reservation_id" NULLS LAST
LIMIT 20;
```

| reservation_id | record_count |
| --- | --- |
| 201 | 1 |


## Index comparison

| Phase | Median (ms) | Three runs (ms) | Plan nodes | Buffer hits |
| --- | --- | --- | --- | --- |
| Before index | 1.017 | 1.017, 1.008, 1.023 | Sort → Seq Scan | 112 |
| After index | 0.173 | 0.172, 0.18, 0.173 | Sort → Bitmap Heap Scan → Bitmap Index Scan | 25 |

The median execution time changed from 1.017 ms to 0.173 ms. The measured plan used p2_filter_idx. The results matched in both phases. An index adds storage and write-maintenance costs; timings depend on the selected lookup and environment.

## Execution plans

### Before index, run 1

```text
Sort (actual time=0.985..0.987 rows=20 loops=1)
  Seq Scan on reservations (actual time=0.016..0.951 rows=20 loops=1)
Planning Time: 0.347 ms
Execution Time: 1.017 ms
```

### Before index, run 2

```text
Sort (actual time=0.98..0.982 rows=20 loops=1)
  Seq Scan on reservations (actual time=0.016..0.945 rows=20 loops=1)
Planning Time: 0.32 ms
Execution Time: 1.008 ms
```

### Before index, run 3

```text
Sort (actual time=0.994..0.995 rows=20 loops=1)
  Seq Scan on reservations (actual time=0.017..0.959 rows=20 loops=1)
Planning Time: 0.356 ms
Execution Time: 1.023 ms
```

### After index, run 1

```text
Sort (actual time=0.121..0.122 rows=20 loops=1)
  Bitmap Heap Scan on reservations (actual time=0.026..0.087 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.013..0.014 rows=20 loops=1)
Planning Time: 0.592 ms
Execution Time: 0.172 ms
```

### After index, run 2

```text
Sort (actual time=0.126..0.127 rows=20 loops=1)
  Bitmap Heap Scan on reservations (actual time=0.026..0.089 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.013..0.014 rows=20 loops=1)
Planning Time: 0.546 ms
Execution Time: 0.18 ms
```

### After index, run 3

```text
Sort (actual time=0.121..0.122 rows=20 loops=1)
  Bitmap Heap Scan on reservations (actual time=0.026..0.087 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.013..0.013 rows=20 loops=1)
Planning Time: 0.518 ms
Execution Time: 0.173 ms
```

## Reproduce

Use a fresh database with the Portfolio 1 schema and sample data. Run Onabanjo_Adebisi_301835755_P2_Queries.sql, then Onabanjo_Adebisi_301835755_P2_Optimisation.sql. The optimisation script creates a separate performance table and runs EXPLAIN (ANALYZE, BUFFERS).

[Query screenshot](screenshots/Onabanjo_Adebisi_301835755_P2_QueryResults.png) · [Index comparison](screenshots/Onabanjo_Adebisi_301835755_P2_IndexComparison.png)

## References

- [PostgreSQL — EXPLAIN](https://www.postgresql.org/docs/17/using-explain.html)

