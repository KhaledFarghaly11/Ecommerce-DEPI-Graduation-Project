-- Get all customer data

SELECT * FROM Customer;
-- Join customer and their addresses
SELECT c.CustomerID, c.FirstName, c.LastName, a.Street, a.City, a.Country, a.PostalCode
FROM Customer c
JOIN Address a ON c.CustomerID = a.CustomerID;

-- Update a customer's email
UPDATE Customer
SET Email = 'new_email@example.com'
WHERE CustomerID = 1;

SELECT * 
FROM Customer
WHERE CustomerID = 1;

-- Change the stock quantity of a product
UPDATE Product
SET StockQuantity = 150
WHERE ProductID = 1;

SELECT * 
FROM Product
WHERE ProductID = 1;

-- Top 3 Total orders by each customer
SELECT TOP 3 
		c.CustomerID, c.FirstName, c.LastName, COUNT(o.OrderID) AS TotalOrders
FROM Customer c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY TotalOrders DESC;

-- Revenue generated per category

SELECT cat.Name, SUM(od.Quantity * od.UnitPrice * (1 - od.Discount/100)) AS Revenue
FROM OrderDetail od
JOIN Product p ON od.ProductID = p.ProductID
JOIN Category cat ON p.CategoryID = cat.CategoryID
GROUP BY cat.Name;




-- Analyze the average order value per customer

SELECT c.CustomerID, c.FirstName, c.LastName, AVG(o.TotalAmount) AS AvgOrderValue
FROM Customer c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName;
































