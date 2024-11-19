-- Sales Trends

-- Total Sales by Month
SELECT
    YEAR(OrderDate) AS Year,
    MONTH(OrderDate) AS Month,
    SUM(TotalAmount) AS TotalSales
FROM dbo.FactOrdersAndDetails
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY Year, Month;

-- Top Performing Products

-- Top 10 Products by Sales
SELECT TOP 10
    p.ProductName,
    SUM(o.Quantity) AS TotalQuantity,
    SUM(o.TotalAmount) AS TotalSales
FROM dbo.FactOrdersAndDetails o
JOIN dbo.DimProduct p ON o.ProductID = p.ProductAltKey
GROUP BY p.ProductName
ORDER BY TotalSales DESC;


-- Customer Segmentation

-- Customer Segments by Total Spend
SELECT
    c.CustomerName,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(o.TotalAmount) AS TotalSpend
FROM dbo.FactOrdersAndDetails o
JOIN dbo.DimCustomer c ON o.CustomerID = c.CustomerAltKey
GROUP BY c.CustomerName
ORDER BY TotalSpend DESC;























