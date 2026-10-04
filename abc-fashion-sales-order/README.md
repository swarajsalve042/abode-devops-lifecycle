# ABC Fashion – Sales Order Processing System

## Project Overview
ABC Fashion is a retail business with a Sales Order Processing System used to manage sales representatives, customers, purchases, and orders.

This SQL Server project implements the assignment requirements using relational tables, constraints, filtering, set operators, and joins.

## Tables
- **Salesman** — SalesmanId, SalesmanName, Commission, City, Age
- **Customer** — SalesmanId, CustomerId, CustomerName, PurchaseAmount
- **Orders** — OrderId, CustomerId, SalesmanId, OrderDate, Amount

## Tasks Implemented
1. Insert a new record into the Orders table.
2. Add a PRIMARY KEY to Salesman.SalesmanId.
3. Add a DEFAULT constraint for Salesman.City.
4. Add a FOREIGN KEY from Customer.SalesmanId to Salesman.SalesmanId.
5. Add a NOT NULL constraint to Customer.CustomerName.
6. Find customers whose name ends with N and whose purchase amount is greater than 500.
7. Compare unique and duplicate SalesmanId values using UNION and UNION ALL.
8. Produce a combined report containing OrderDate, SalesmanName, CustomerName, Commission, City, and PurchaseAmount for purchases between 500 and 1500.
9. Use a RIGHT JOIN to return all salesmen and matching orders.

## Technologies
- Microsoft SQL Server
- SQL / T-SQL
- Relational Database Design
- JOINs
- Set Operators
- Constraints

## Files
- `abc_fashion_sales_order.sql` — complete SQL implementation
- `README.md` — project documentation

## Presentation
A professional project presentation was created separately for this project, covering the data model, SQL queries, constraints, joins, validation, and workflow.
