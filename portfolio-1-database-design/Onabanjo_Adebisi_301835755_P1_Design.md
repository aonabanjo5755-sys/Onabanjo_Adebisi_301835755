# Hotel Reservation System — database design

My case study records guests, rooms, reservations, payments.

## Users

- Front-desk staff manage guest details and reservations.
- Managers review room occupancy and payment summaries.

## Main operations

- Create and retrieve guests, rooms, reservations, and payments.
- Find active rooms available for a requested date range.
- Summarize collected payments by room type and month.
- Separate benchmark plan: generate 20000 synthetic reservations, compare the same booked_at date-range filter with and without a B-tree index, and record measured observations without presuming which plan is faster.

## Entities

| Entity | Information stored |
| --- | --- |
| guests | Stores synthetic guest contact details; guest_id is the single-column globally unique primary key. |
| rooms | Stores room number, category, nightly rate, and booking availability; room_id is the single-column globally unique primary key. |
| reservations | Stores a guest's booking of one room over a date range; reservation_id is the single-column globally unique primary key. |
| payments | Stores payments associated with reservations; payment_id is the single-column globally unique primary key. |

## guests

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| guest_id | BIGINT | PK | Yes |
| email | TEXT | Unique | Yes |
| full_name | TEXT |  | Yes |
| phone | TEXT |  | No |
- Unique key: (email).

## rooms

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| room_id | BIGINT | PK | Yes |
| room_number | TEXT | Unique | Yes |
| room_type | TEXT |  | Yes |
| nightly_rate | NUMERIC(18,2) |  | Yes |
| active | BOOLEAN |  | Yes |
- Unique key: (room_number).

## reservations

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| reservation_id | BIGINT | PK | Yes |
| guest_id | BIGINT | FK | Yes |
| room_id | BIGINT | FK | Yes |
| check_in | DATE |  | Yes |
| check_out | DATE |  | Yes |
| status | TEXT |  | Yes |
| booked_at | TIMESTAMPTZ |  | Yes |
- guest_id → guests.guest_id
- room_id → rooms.room_id

## payments

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| payment_id | BIGINT | PK | Yes |
| reservation_id | BIGINT | FK | Yes |
| amount | NUMERIC(18,2) |  | Yes |
| paid_at | TIMESTAMPTZ |  | Yes |
| payment_method | TEXT |  | Yes |
- reservation_id → reservations.reservation_id

## Relationships and business rules

- A normalized guest email address identifies at most one guest.
- Each room number identifies exactly one room.
- Every reservation references an existing guest through guest_id.
- Every reservation references an existing room through room_id.
- A reservation's check-out date must be later than its check-in date.
- At most one confirmed reservation per room may have a given check-in date; enforce with a partial unique key on room_id and check_in for confirmed rows.
- Each payment amount must be greater than zero.
- Every payment references an existing reservation through reservation_id.

## Assumptions

- IDs are generated so each primary-key value is globally unique across the model.
- Dates use the hotel's local calendar; check-in is inclusive and check-out is exclusive.
- Reservation statuses are held, confirmed, cancelled, or completed; only confirmed reservations block availability.
- The partial unique rule prevents two confirmed reservations for the same room from having the same check-in date; it does not by itself prevent every possible date-range overlap.
- Guest email addresses are normalized to lowercase before uniqueness is enforced.
- All records, names, email addresses, and identifiers used in exercises are synthetic; no student names or IDs are included.

