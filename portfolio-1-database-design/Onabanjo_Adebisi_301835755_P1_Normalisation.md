# Hotel Reservation System — normalisation

The example uses the saved sample records. The full set of fields is in the design and schema.

## Starting grouped records

| guest_id | reservations records (list) |
| --- | --- |
| 1 | [201] |
| 2 | [202] |


The record IDs are grouped in a list. In 1NF, each record has its own row and each cell holds one value.

## 1NF: one value per cell

| reservations.reservation_id | reservations.guest_id | reservations.room_id | reservations.status | guests.guest_id | guests.email | rooms.room_id | rooms.room_number |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 201 | 1 | 101 | confirmed | 1 | alex.river@example.test | 101 | 101 |
| 202 | 2 | 102 | held | 2 | sam.lake@example.test | 102 | 102 |

Key: reservation_id.

## 2NF: depend on the whole key

The declared candidate keys do not introduce a partial dependency here, so the 1NF rows stay unchanged at this step.

## reservations_example

| reservations.reservation_id | reservations.guest_id | reservations.room_id | reservations.status | guests.guest_id | guests.email | rooms.room_id | rooms.room_number |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 201 | 1 | 101 | confirmed | 1 | alex.river@example.test | 101 | 101 |
| 202 | 2 | 102 | held | 2 | sam.lake@example.test | 102 | 102 |

## 3NF: store each entity’s details once

The entity keys determine their own descriptions. Related records keep foreign keys rather than repeating those descriptions.

## guests

| guest_id | email | full_name | phone |
| --- | --- | --- | --- |
| 1 | alex.river@example.test | Alex River | +1-555-0101 |
| 2 | sam.lake@example.test | Sam Lake | NULL |

## rooms

| room_id | room_number | room_type | nightly_rate | active |
| --- | --- | --- | --- | --- |
| 101 | 101 | standard | 120 | true |
| 102 | 102 | deluxe | 185 | true |

## reservations

| reservation_id | guest_id | room_id | check_in | check_out | status | booked_at |
| --- | --- | --- | --- | --- | --- | --- |
| 201 | 1 | 101 | 2026-12-01 | 2026-12-03 | confirmed | 2026-10-10T09:30:00+00:00 |
| 202 | 2 | 102 | 2026-12-05 | 2026-12-07 | held | 2026-10-11T14:15:00+00:00 |

## payments

| payment_id | reservation_id | amount | paid_at | payment_method |
| --- | --- | --- | --- | --- |
| 301 | 201 | 240 | 2026-12-01T10:00:00+00:00 | card |

## Dependencies

- guests: (guest_id) → email, full_name, phone
- rooms: (room_id) → room_number, room_type, nightly_rate, active
- reservations: (reservation_id) → guest_id, room_id, check_in, check_out, status, booked_at
- payments: (payment_id) → reservation_id, amount, paid_at, payment_method

Joining the decomposed sample tables reproduces the original 2 example rows. The design assumes the declared keys describe the relevant business dependencies.
