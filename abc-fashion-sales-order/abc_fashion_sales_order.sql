-- ABC Fashion – Sales Order Processing System
-- SQL Server / T-SQL

CREATE TABLE Salesman (
    SalesmanId INT,
    SalesmanName VARCHAR(50),
    Commission INT,
    City VARCHAR(50),
    Age INT
);

CREATE TABLE Customer (
    SalesmanId INT,
    CustomerId INT,
    CustomerName VARCHAR(100),
    PurchaseAmount DECIMAL(10,2)
);

CREATE TABLE Orders (
    OrderId INT,
    CustomerId INT,
    SalesmanId INT,
    OrderDate DATE,
    Amount DECIMAL(10,2)
);

INSERT INTO Salesman (SalesmanId, SalesmanName, Commission, City, Age)
VALUES
(101, 'Joe', 50, 'California', 17),
(102, 'Simon', 75, 'Texas', 25),
(103, 'Jessie', 105, 'Florida', 35),
(104, 'Danny', 100, 'Texas', 22),
(105, 'Lia', 65, 'New Jersy', 30);

INSERT INTO Customer (SalesmanId, CustomerId, CustomerName, PurchaseAmount)
VALUES
(101, 2345, 'Andrew', 550),
(103, 1575, 'Lucky', 4500),
(104, 2345, 'Andrew', 4000),
(107, 3747, 'Remona', 2700),
(110, 4004, 'Julia', 4545);

INSERT INTO Orders (OrderId, CustomerId, SalesmanId, OrderDate, Amount)
VALUES
(5001, 2345, 101, '2021-07-04', 550),
(5003, 1234, 105, '2022-02-15', 1500);

-- Task 1: Insert a new Orders record
INSERT INTO Orders (OrderId, CustomerId, SalesmanId, OrderDate, Amount)
VALUES (5004, 2345, 101, '2022-03-10', 1250);

-- Task 2: Required constraints
ALTER TABLE Salesman
ADD CONSTRAINT PK_Salesman PRIMARY KEY (SalesmanId);

ALTER TABLE Salesman
ADD CONSTRAINT DF_Salesman_City DEFAULT 'Unknown' FOR City;

ALTER TABLE Customer
ADD CONSTRAINT FK_Customer_Salesman
FOREIGN KEY (SalesmanId)
REFERENCES Salesman(SalesmanId);

ALTER TABLE Customer
ALTER COLUMN CustomerName VARCHAR(100) NOT NULL;

-- Additional order constraint
ALTER TABLE Orders
ADD CONSTRAINT PK_Orders PRIMARY KEY (OrderId);

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Salesman
FOREIGN KEY (SalesmanId)
REFERENCES Salesman(SalesmanId);

-- Note: CustomerId is intentionally not declared UNIQUE because the
-- supplied dataset contains CustomerId 2345 more than once.

-- Task 3: Customer name ending with N and purchase > 500
SELECT CustomerId, CustomerName, PurchaseAmount
FROM Customer
WHERE CustomerName LIKE '%n'
  AND PurchaseAmount > 500;

-- Task 4: Unique SalesmanId values
SELECT SalesmanId FROM Salesman
UNION
SELECT SalesmanId FROM Customer
ORDER BY SalesmanId;

-- Task 4: SalesmanId values including duplicates
SELECT SalesmanId FROM Salesman
UNION ALL
SELECT SalesmanId FROM Customer
ORDER BY SalesmanId;

-- Task 5: Matching business data, purchase amount 500–1500
SELECT
    o.OrderDate,
    s.SalesmanName,
    c.CustomerName,
    s.Commission,
    s.City,
    c.PurchaseAmount
FROM Orders o
INNER JOIN Salesman s
    ON o.SalesmanId = s.SalesmanId
INNER JOIN Customer c
    ON o.CustomerId = c.CustomerId
   AND o.SalesmanId = c.SalesmanId
WHERE c.PurchaseAmount BETWEEN 500 AND 1500;

-- Task 6: RIGHT JOIN – all salesmen and matching orders
SELECT
    s.SalesmanId,
    s.SalesmanName,
    s.City,
    o.OrderId,
    o.OrderDate,
    o.Amount
FROM Orders o
RIGHT JOIN Salesman s
    ON o.SalesmanId = s.SalesmanId
ORDER BY s.SalesmanId;

-- Validation
SELECT * FROM Salesman;
SELECT * FROM Customer;
SELECT * FROM Orders;
