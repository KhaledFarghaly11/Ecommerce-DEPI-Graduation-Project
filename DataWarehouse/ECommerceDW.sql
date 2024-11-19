-- Create the database
CREATE DATABASE ECommerceDW;
GO

-- Use the database
USE ECommerceDW;
GO

-- Create Dimension Tables
CREATE TABLE DimCategory (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(50),
    CategoryDescription NVARCHAR(255)
);

CREATE TABLE DimProduct (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(100),
    SupplierID INT,
    CategoryID INT,
    UnitPrice DECIMAL(10,2),
    UnitsInStock INT
);

CREATE TABLE DimSupplier (
    SupplierID INT PRIMARY KEY IDENTITY(1,1),
    SupplierName NVARCHAR(100),
    Phone NVARCHAR(15),
    City NVARCHAR(50),
    Country NVARCHAR(50)
);

CREATE TABLE DimCustomer (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName NVARCHAR(100),
    Phone NVARCHAR(15),
    Email NVARCHAR(100)
);

CREATE TABLE DimAddress (
    AddressID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    Address NVARCHAR(100),
    City NVARCHAR(50),
    Country NVARCHAR(50),
    PostalCode NVARCHAR(10)
);

CREATE TABLE DimOrderStatus (
    OrderStatusID INT PRIMARY KEY IDENTITY(1,1),
    Status NVARCHAR(50) UNIQUE
);

CREATE TABLE DimEmployee (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeName NVARCHAR(100),
    Phone NVARCHAR(15),
    Age INT,
    HireDate DATE
);

CREATE TABLE DimShipper (
    ShipperID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100),
    Phone NVARCHAR(15)
);

-- Create Fact Table
CREATE TABLE FactOrdersAndDetails (
    OrderID INT,
    ProductID INT,
    CustomerID INT,
    EmployeeID INT,
    ShipperID INT,
    SupplierID INT,
    StatusID INT,
    OrderDate DATE,
    Quantity INT,
    Price FLOAT,
    Discount DECIMAL(3,1),
    TotalAmount FLOAT,
    PRIMARY KEY (OrderID, ProductID)
);