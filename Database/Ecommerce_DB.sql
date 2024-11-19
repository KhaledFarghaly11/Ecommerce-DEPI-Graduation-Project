-- Create the database
CREATE DATABASE ECommerceDB;
GO

-- Use the database
USE ECommerceDB;
GO

-- Create the tables

-- Customer Table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Phone NVARCHAR(15),
    Email NVARCHAR(100)
);

-- Address Table
CREATE TABLE Address (
    AddressID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID),
    Street NVARCHAR(100),
    City NVARCHAR(50),
    Country NVARCHAR(50),
    PostalCode NVARCHAR(10)
);

-- Employee Table
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Age INT,
    HireDate DATE,
    Phone NVARCHAR(15)
);

-- Shipper Table
CREATE TABLE Shipper (
    ShipperID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100),
    Phone NVARCHAR(15)
);

-- Category Table
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50),
    Description NVARCHAR(255)
);

-- Supplier Table
CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100),
    Phone NVARCHAR(15),
    City NVARCHAR(50),
    Country NVARCHAR(50)
);

-- Product Table
CREATE TABLE Product (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100),
    SupplierID INT FOREIGN KEY REFERENCES Supplier(SupplierID),
    CategoryID INT FOREIGN KEY REFERENCES Category(CategoryID),
    UnitPrice DECIMAL(10,2),
    StockQuantity INT
);

-- OrderStatus Table
CREATE TABLE OrderStatus (
    OrderStatusID INT PRIMARY KEY IDENTITY(1,1),
    Status NVARCHAR(50)
);

-- Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID),
    EmployeeID INT FOREIGN KEY REFERENCES Employee(EmployeeID),
    ShipperID INT FOREIGN KEY REFERENCES Shipper(ShipperID),
    OrderDate DATE,
    OrderStatusID INT FOREIGN KEY REFERENCES OrderStatus(OrderStatusID),
    TotalAmount DECIMAL(10,2)
);

-- OrderDetail Table
CREATE TABLE OrderDetail (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    Discount DECIMAL(3,2)
);
ALTER TABLE OrderDetail
ALTER COLUMN Discount DECIMAL(3,1);