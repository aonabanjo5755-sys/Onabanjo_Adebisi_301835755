# Portfolio 1 — Database Design and Modelling

I organised the data into guests, rooms, reservations, payments. The design document explains the fields, keys, relationships and business rules. The normalisation document shows the sample tables at 1NF, 2NF and 3NF.

## Database checks

| Table | Rows |
| --- | --- |
| guests | 2 |
| rooms | 2 |
| reservations | 2 |
| payments | 1 |

The 32 invalid inserts were rejected at their expected constraints, and the valid sample rows remained unchanged.

## Files

- [Design](Onabanjo_Adebisi_301835755_P1_Design.md)
- [ER diagram](Onabanjo_Adebisi_301835755_P1_ERDiagram.md)
- [Normalisation](Onabanjo_Adebisi_301835755_P1_Normalisation.md)
- [Schema](Onabanjo_Adebisi_301835755_P1_Schema.sql)
- [Sample data](Onabanjo_Adebisi_301835755_P1_SampleData.sql)
- [Constraint tests](Onabanjo_Adebisi_301835755_P1_ConstraintTests.sql)
- [Table and constraint evidence](screenshots/Onabanjo_Adebisi_301835755_P1_DatabaseResults.png)

## Run the SQL

Create a fresh PostgreSQL database. Run the schema first, then the sample data. Run the deliberately invalid statements in ConstraintTests.sql individually outside a transaction; each is expected to produce an error.

## References

- [PostgreSQL — constraints](https://www.postgresql.org/docs/17/ddl-constraints.html)

