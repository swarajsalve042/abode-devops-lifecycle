# Zomato SQL Data Analytics Project

## Overview
SQL Server analytics project for a food-delivery dataset similar to Zomato. The assignment focuses on reusable SQL objects, transaction safety, ranking, procedural logic, views, and triggers.

## Assignment Tasks
1. Stored procedure to display restaurant name, type, and cuisine where table booking is not zero.
2. Transaction to update cuisine type from `Cafe` to `Cafeteria`, verify the result, and roll it back.
3. Use `ROW_NUMBER()` to rank areas and find the top 5 areas with the highest restaurant rating.
4. Use a `WHILE` loop to display 1 through 50.
5. Create a view containing the top 5 highest-rated restaurants.
6. Create an INSERT trigger that displays a message when a new record is inserted.

## Technologies
- Microsoft SQL Server
- T-SQL
- Stored Procedures
- Transactions / ROLLBACK
- Window Functions
- Views
- Triggers
- Control Flow

## Project Structure
- `zomato_sql_project.sql` — SQL Server implementation for all six tasks.
- `README.md` — project documentation.

## Notes
The supplied assignment image defines the required tasks but does not provide the full dataset rows. The SQL uses the field concepts shown/implied by the brief, including restaurant name, restaurant type, cuisines, table booking, area, and rating. Adjust the table/column names if the downloaded source dataset uses different names.

## PPT
A professional presentation was created for this project covering the business context, dataset model, all six SQL tasks, workflow, testing, and project summary.
