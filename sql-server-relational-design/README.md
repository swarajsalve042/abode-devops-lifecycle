# SQL Server – Relational Design to Tables

## Problem Statement
Convert a relational design containing users, roles, user accounts and statuses into SQL Server tables while preserving the relationships through primary and foreign keys.

## Project Tasks
- Define relations and attributes
- Define primary keys
- Create foreign keys
- Insert at least two rows into every table
- Validate relationships
- Delete data safely in dependency order

## Tables
1. `role`
2. `user_account`
3. `status`
4. `user_has_role`
5. `user_has_status`

## Relationship Model

```
ROLE 1 ───< USER_HAS_ROLE >─── 1 USER_ACCOUNT
STATUS 1 ───< USER_HAS_STATUS >─── 1 USER_ACCOUNT
```

The two `user_has_*` tables act as relationship/history tables and contain the foreign keys to their parent tables.

## SQL Server
Run `relational_design.sql` in SQL Server Management Studio (SSMS) or Azure Data Studio.

## Skills Demonstrated
- SQL Server
- Relational database design
- DDL and DML
- Primary and foreign keys
- Referential integrity
- JOIN validation
- Safe deletion order
