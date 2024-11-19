SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DimCategory] (
    [CategoryID] INT IDENTITY(1,1) NOT NULL,
    [CategoryAltKey] INT NOT NULL,
    [CategoryName] NVARCHAR(50) NULL,
    [CategoryDescription] NVARCHAR(255) NULL
) WITH (
    DISTRIBUTION = HASH ([CategoryAltKey]),
    CLUSTERED COLUMNSTORE INDEX
);
GO

CREATE TABLE [dbo].[DimProduct] (
    [ProductID] INT IDENTITY(1,1) NOT NULL,
    [ProductAltKey] INT NOT NULL,
    [ProductName] NVARCHAR(100) NULL,
    [SupplierID] INT NULL,
    [CategoryID] INT NULL,
    [UnitPrice] DECIMAL(10,2) NULL,
    [UnitsInStock] INT NULL
) WITH (
    DISTRIBUTION = HASH ([ProductAltKey]),
    CLUSTERED COLUMNSTORE INDEX
);
GO

CREATE TABLE [dbo].[DimSupplier] (
    [SupplierID] INT IDENTITY(1,1) NOT NULL,
    [SupplierAltKey] INT NOT NULL,
    [SupplierName] NVARCHAR(100) NULL,
    [Phone] NVARCHAR(15) NULL,
    [City] NVARCHAR(50) NULL,
    [Country] NVARCHAR(50) NULL
) WITH (
    DISTRIBUTION = HASH ([SupplierAltKey]),
    CLUSTERED COLUMNSTORE INDEX
);
GO

CREATE TABLE [dbo].[DimCustomer] (
    [CustomerID] INT IDENTITY(1,1) NOT NULL,
    [CustomerAltKey] INT NOT NULL,
    [CustomerName] NVARCHAR(100) NULL,
    [Phone] NVARCHAR(15) NULL,
    [Email] NVARCHAR(100) NULL
) WITH (
    DISTRIBUTION = HASH ([CustomerAltKey]),
    CLUSTERED COLUMNSTORE INDEX
);
GO

CREATE TABLE [dbo].[DimAddress] (
    [AddressID] INT IDENTITY(1,1) NOT NULL,
    [AddressAltKey] INT NOT NULL,
    [CustomerID] INT NULL,
    [Address] NVARCHAR(100) NULL,
    [City] NVARCHAR(50) NULL,
    [Country] NVARCHAR(50) NULL,
    [PostalCode] NVARCHAR(10) NULL
) WITH (
    DISTRIBUTION = HASH ([AddressAltKey]),
    CLUSTERED COLUMNSTORE INDEX
);
GO

CREATE TABLE [dbo].[DimOrderStatus] (
    [OrderStatusID] INT IDENTITY(1,1) NOT NULL,
    [OrderStatusAltKey] INT NOT NULL,
    [Status] NVARCHAR(50)
) WITH (
    DISTRIBUTION = HASH ([OrderStatusAltKey]),
    CLUSTERED COLUMNSTORE INDEX
);
GO

CREATE TABLE [dbo].[DimEmployee] (
    [EmployeeID] INT IDENTITY(1,1) NOT NULL,
    [EmployeeAltKey] INT NOT NULL,
    [EmployeeName] NVARCHAR(100) NULL,
    [Phone] NVARCHAR(15) NULL,
    [Age] INT NULL,
    [HireDate] DATE NULL
) WITH (
    DISTRIBUTION = HASH ([EmployeeAltKey]),
    CLUSTERED COLUMNSTORE INDEX
);
GO

CREATE TABLE [dbo].[DimShipper] (
    [ShipperID] INT IDENTITY(1,1) NOT NULL,
    [ShipperAltKey] INT NOT NULL,
    [Name] NVARCHAR(100) NULL,
    [Phone] NVARCHAR(15) NULL
) WITH (
    DISTRIBUTION = HASH ([ShipperAltKey]),
    CLUSTERED COLUMNSTORE INDEX
);
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[FactOrdersAndDetails] (
    [OrderAltKey] INT NOT NULL,
    [OrderID] INT NOT NULL,
    [ProductID] INT NOT NULL,
    [CustomerID] INT NULL,
    [EmployeeID] INT NULL,
    [ShipperID] INT NULL,
    -- [SupplierID] INT NULL,
    [StatusID] INT NULL,
    [OrderDate] DATE NULL,
    [Quantity] INT NULL,
    [Price] FLOAT NULL,
    [Discount] DECIMAL(3,1) NULL,
    [TotalAmount] FLOAT NULL,
    [DistKey] INT NOT NULL
) WITH (
    DISTRIBUTION = HASH ([DistKey]),
    CLUSTERED COLUMNSTORE INDEX
);
GO


