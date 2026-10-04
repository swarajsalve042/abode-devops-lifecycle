/*
  SQL Server – Relational Design to Tables
  Project: Users, Roles, Accounts and Statuses

  Execute in SQL Server Management Studio (SSMS).
*/

IF DB_ID('RelationalDesignDB') IS NULL
    CREATE DATABASE RelationalDesignDB;
GO

USE RelationalDesignDB;
GO

-- Drop existing tables in dependency order for repeatable execution.
IF OBJECT_ID('dbo.user_has_role', 'U') IS NOT NULL DROP TABLE dbo.user_has_role;
IF OBJECT_ID('dbo.user_has_status', 'U') IS NOT NULL DROP TABLE dbo.user_has_status;
IF OBJECT_ID('dbo.user_account', 'U') IS NOT NULL DROP TABLE dbo.user_account;
IF OBJECT_ID('dbo.role', 'U') IS NOT NULL DROP TABLE dbo.role;
IF OBJECT_ID('dbo.status', 'U') IS NOT NULL DROP TABLE dbo.status;
GO

-- 1. Role master table
CREATE TABLE dbo.role (
    id INT NOT NULL PRIMARY KEY,
    role_name VARCHAR(100) NOT NULL UNIQUE
);
GO

-- 2. User account table
CREATE TABLE dbo.user_account (
    id INT NOT NULL PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(254) NOT NULL UNIQUE,
    password VARCHAR(200) NOT NULL,
    password_salt VARCHAR(50) NULL,
    password_hash_algorithm VARCHAR(50) NULL
);
GO

-- 3. Status master table
CREATE TABLE dbo.status (
    id INT NOT NULL PRIMARY KEY,
    status_name VARCHAR(100) NOT NULL UNIQUE,
    is_user_working BIT NOT NULL
);
GO

-- 4. User-role relationship/history table
CREATE TABLE dbo.user_has_role (
    id INT NOT NULL PRIMARY KEY,
    role_start_time DATETIME2 NOT NULL,
    role_end_time DATETIME2 NULL,
    user_account_id INT NOT NULL,
    role_id INT NOT NULL,

    CONSTRAINT FK_user_has_role_user_account
        FOREIGN KEY (user_account_id)
        REFERENCES dbo.user_account(id),

    CONSTRAINT FK_user_has_role_role
        FOREIGN KEY (role_id)
        REFERENCES dbo.role(id)
);
GO

-- 5. User-status relationship/history table
CREATE TABLE dbo.user_has_status (
    id INT NOT NULL PRIMARY KEY,
    status_start_time DATETIME2 NOT NULL,
    user_account_id INT NOT NULL,
    status_id INT NOT NULL,

    CONSTRAINT FK_user_has_status_user_account
        FOREIGN KEY (user_account_id)
        REFERENCES dbo.user_account(id),

    CONSTRAINT FK_user_has_status_status
        FOREIGN KEY (status_id)
        REFERENCES dbo.status(id)
);
GO

-- Sample data: at least two rows in every table.
INSERT INTO dbo.role (id, role_name)
VALUES
    (1, 'Administrator'),
    (2, 'Developer');
GO

INSERT INTO dbo.status (id, status_name, is_user_working)
VALUES
    (1, 'Active', 1),
    (2, 'Inactive', 0);
GO

INSERT INTO dbo.user_account
    (id, user_name, email, password, password_salt, password_hash_algorithm)
VALUES
    (101, 'swaraj', 'swaraj@example.com', 'HASHED_VALUE_1', 'SALT_1', 'SHA-256'),
    (102, 'rahul', 'rahul@example.com', 'HASHED_VALUE_2', 'SALT_2', 'SHA-256');
GO

INSERT INTO dbo.user_has_role
    (id, role_start_time, role_end_time, user_account_id, role_id)
VALUES
    (1, '2026-01-01T09:00:00', NULL, 101, 1),
    (2, '2026-01-02T09:00:00', NULL, 102, 2);
GO

INSERT INTO dbo.user_has_status
    (id, status_start_time, user_account_id, status_id)
VALUES
    (1, '2026-01-01T09:00:00', 101, 1),
    (2, '2026-01-02T09:00:00', 102, 2);
GO

-- Validation 1: row counts
SELECT 'role' AS table_name, COUNT(*) AS row_count FROM dbo.role
UNION ALL
SELECT 'user_account', COUNT(*) FROM dbo.user_account
UNION ALL
SELECT 'status', COUNT(*) FROM dbo.status
UNION ALL
SELECT 'user_has_role', COUNT(*) FROM dbo.user_has_role
UNION ALL
SELECT 'user_has_status', COUNT(*) FROM dbo.user_has_status;
GO

-- Validation 2: user → role
SELECT
    ua.id AS user_id,
    ua.user_name,
    r.role_name,
    ur.role_start_time,
    ur.role_end_time
FROM dbo.user_account AS ua
INNER JOIN dbo.user_has_role AS ur
    ON ua.id = ur.user_account_id
INNER JOIN dbo.role AS r
    ON r.id = ur.role_id;
GO

-- Validation 3: user → status
SELECT
    ua.id AS user_id,
    ua.user_name,
    s.status_name,
    s.is_user_working,
    us.status_start_time
FROM dbo.user_account AS ua
INNER JOIN dbo.user_has_status AS us
    ON ua.id = us.user_account_id
INNER JOIN dbo.status AS s
    ON s.id = us.status_id;
GO

/*
  Safe deletion order:
  Child/relationship rows must be deleted before parent rows
  because foreign keys are enforced.
*/

DELETE FROM dbo.user_has_role;
DELETE FROM dbo.user_has_status;

DELETE FROM dbo.user_account;
DELETE FROM dbo.role;
DELETE FROM dbo.status;
GO

-- Post-delete verification
SELECT COUNT(*) AS user_has_role_rows FROM dbo.user_has_role;
SELECT COUNT(*) AS user_has_status_rows FROM dbo.user_has_status;
SELECT COUNT(*) AS user_account_rows FROM dbo.user_account;
SELECT COUNT(*) AS role_rows FROM dbo.role;
SELECT COUNT(*) AS status_rows FROM dbo.status;
GO
