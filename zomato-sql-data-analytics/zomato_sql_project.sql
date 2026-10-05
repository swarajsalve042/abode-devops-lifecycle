-- Zomato SQL Data Analytics Project
-- Microsoft SQL Server / T-SQL
-- Adjust table/column names to match the supplied source dataset if required.

-- 1. Stored procedure: restaurants where table booking is not zero
CREATE OR ALTER PROCEDURE dbo.usp_GetAvailableRestaurants
AS
BEGIN
    SET NOCOUNT ON;

    SELECT restaurant_name,
           restaurant_type,
           cuisines
    FROM dbo.Zomato
    WHERE ISNULL(table_booking, 'No') <> 'Yes'
      AND ISNULL(table_booking, 'No') <> '0';
END;
GO

EXEC dbo.usp_GetAvailableRestaurants;
GO

-- 2. Transaction: Cafe -> Cafeteria, verify, then rollback
BEGIN TRANSACTION;

UPDATE dbo.Zomato
SET cuisines = 'Cafeteria'
WHERE cuisines = 'Cafe';

SELECT restaurant_name, cuisines
FROM dbo.Zomato
WHERE cuisines = 'Cafeteria';

ROLLBACK TRANSACTION;

SELECT restaurant_name, cuisines
FROM dbo.Zomato
WHERE cuisines = 'Cafe';
GO

-- 3. ROW_NUMBER(): top 5 areas by average restaurant rating
WITH AreaRatings AS
(
    SELECT
        area,
        AVG(CAST(rating AS DECIMAL(4,2))) AS avg_rating
    FROM dbo.Zomato
    WHERE rating IS NOT NULL
    GROUP BY area
),
RankedAreas AS
(
    SELECT
        area,
        avg_rating,
        ROW_NUMBER() OVER (ORDER BY avg_rating DESC) AS row_num
    FROM AreaRatings
)
SELECT row_num, area, avg_rating
FROM RankedAreas
WHERE row_num <= 5
ORDER BY row_num;
GO

-- 4. WHILE loop: display 1 to 50
DECLARE @i INT = 1;

WHILE @i <= 50
BEGIN
    PRINT @i;
    SET @i = @i + 1;
END;
GO

-- 5. View: top 5 highest-rated restaurants
CREATE OR ALTER VIEW dbo.vw_Top5RatedRestaurants
AS
SELECT TOP 5
       restaurant_name,
       restaurant_type,
       cuisines,
       area,
       rating
FROM dbo.Zomato
WHERE rating IS NOT NULL
ORDER BY rating DESC;
GO

SELECT *
FROM dbo.vw_Top5RatedRestaurants;
GO

-- 6. INSERT trigger: display a message for every new record
CREATE OR ALTER TRIGGER dbo.trg_Zomato_Insert
ON dbo.Zomato
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    PRINT 'New restaurant record inserted successfully.';
END;
GO

-- Example trigger test:
-- INSERT INTO dbo.Zomato (restaurant_name, restaurant_type, cuisines)
-- VALUES ('Demo Restaurant', 'Casual Dining', 'Indian');
