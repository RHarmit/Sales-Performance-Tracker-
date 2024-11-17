-- Create a table for sales representatives
CREATE TABLE SalesReps (
    RepID INTEGER PRIMARY KEY AUTOINCREMENT,
    FullName TEXT NOT NULL,
    Region TEXT NOT NULL
);

-- Create a table for sales transactions
CREATE TABLE SalesData (
    SaleID INTEGER PRIMARY KEY AUTOINCREMENT,
    RepID INTEGER NOT NULL,
    SaleDate TEXT NOT NULL,
    SaleAmount REAL NOT NULL,
    FOREIGN KEY (RepID) REFERENCES SalesReps(RepID)
);

-- Insert data into SalesReps table
INSERT INTO SalesReps (FullName, Region)
VALUES 
('Alice Johnson', 'North'),
('Bob Smith', 'South'),
('Charlie Brown', 'East');

-- Insert data into SalesData table
INSERT INTO SalesData (RepID, SaleDate, SaleAmount)
VALUES 
(1, '2023-10-01', 1200.50),
(2, '2023-10-03', 800.75),
(3, '2023-10-05', 1500.00),
(1, '2023-10-10', 900.00),
(2, '2023-10-15', 700.25);

-- Query to calculate total sales by region
SELECT 
    sr.Region,
    SUM(sd.SaleAmount) AS TotalSales
FROM 
    SalesReps sr
JOIN 
    SalesData sd ON sr.RepID = sd.RepID
GROUP BY 
    sr.Region;

-- Query to find the top sales representative
SELECT 
    sr.FullName,
    SUM(sd.SaleAmount) AS TotalSales
FROM 
    SalesReps sr
JOIN 
    SalesData sd ON sr.RepID = sd.RepID
GROUP BY 
    sr.RepID
ORDER BY 
    TotalSales DESC
LIMIT 1;

-- Query to calculate monthly sales trends
SELECT 
    strftime('%m', SaleDate) AS Month,
    SUM(SaleAmount) AS MonthlySales
FROM 
    SalesData
GROUP BY 
    Month
ORDER BY 
    Month;

-- Example: Insert a new sale directly (no stored procedures in SQLite)
INSERT INTO SalesData (RepID, SaleDate, SaleAmount)
VALUES (3, '2023-10-20', 1100.00);
