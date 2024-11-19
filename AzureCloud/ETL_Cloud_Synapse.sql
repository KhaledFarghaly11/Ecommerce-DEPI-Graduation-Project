CREATE TABLE [dbo].[DimAddress] (
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

-- Load data from DimAddress CSV file into the table
COPY INTO dbo.DimAddress
FROM 'https://datalaker9o1c4a.blob.core.windows.net/files/data/DimAddress.csv'
WITH (
    FILE_TYPE = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

--=====================================================================================

CREATE TABLE [dbo].[DimCategory] (
    [CategoryAltKey] INT NOT NULL,
    [CategoryName] NVARCHAR(50) NULL,
    [CategoryDescription] NVARCHAR(255) NULL
) WITH (
    DISTRIBUTION = HASH ([CategoryAltKey]),
    CLUSTERED COLUMNSTORE INDEX
);
GO

-- Load data from DimCategory CSV file into the table
COPY INTO dbo.DimCategory
FROM 'https://datalaker9o1c4a.blob.core.windows.net/files/data/DimCategory.csv'
WITH (
    FILE_TYPE = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

-- =====================================================================================

CREATE TABLE [dbo].[DimCustomer] (
    [CustomerAltKey] INT NOT NULL,
    [Phone] NVARCHAR(15) NULL,
    [Email] NVARCHAR(100) NULL,
    [CustomerName] NVARCHAR(100) NULL
) WITH (
    DISTRIBUTION = HASH ([CustomerAltKey]),
    CLUSTERED COLUMNSTORE INDEX
);
GO

-- Load data from DimCustomer CSV file into the table
COPY INTO dbo.DimCustomer
FROM 'https://datalaker9o1c4a.blob.core.windows.net/files/data/DimCustomer.csv'
WITH (
    FILE_TYPE = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

-- =====================================================================================

CREATE TABLE [dbo].[DimEmployee] (
    [EmployeeAltKey] INT NOT NULL,
    [Age] INT NULL,
    [HireDate] DATE NULL,
    [Phone] NVARCHAR(15) NULL,
    [EmployeeName] NVARCHAR(100) NULL
) WITH (
    DISTRIBUTION = HASH ([EmployeeAltKey]),
    CLUSTERED COLUMNSTORE INDEX
);
GO

-- Load data from DimEmployee CSV file into the table
COPY INTO dbo.DimEmployee
FROM 'https://datalaker9o1c4a.blob.core.windows.net/files/data/DimEmployee.csv'
WITH (
    FILE_TYPE = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

-- =====================================================================================

CREATE TABLE [dbo].[DimOrderStatus] (
    [OrderStatusAltKey] INT NOT NULL,
    [Status] NVARCHAR(50)
) WITH (
    DISTRIBUTION = HASH ([OrderStatusAltKey]),
    CLUSTERED COLUMNSTORE INDEX
);
GO

-- Load data from DimOrderStatus CSV file into the table
COPY INTO dbo.DimOrderStatus
FROM 'https://datalaker9o1c4a.blob.core.windows.net/files/data/DimOrderStatus.csv'
WITH (
    FILE_TYPE = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

-- =====================================================================================

CREATE TABLE [dbo].[DimProduct] (
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

-- Load data from DimProduct CSV file into the table
COPY INTO dbo.DimProduct
FROM 'https://datalaker9o1c4a.blob.core.windows.net/files/data/DimProduct.csv'
WITH (
    FILE_TYPE = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

-- =====================================================================================

CREATE TABLE [dbo].[DimShipper] (
    [ShipperAltKey] INT NOT NULL,
    [Name] NVARCHAR(100) NULL,
    [Phone] NVARCHAR(15) NULL
) WITH (
    DISTRIBUTION = HASH ([ShipperAltKey]),
    CLUSTERED COLUMNSTORE INDEX
);
GO

-- Load data from DimShipper CSV file into the table
COPY INTO dbo.DimShipper
FROM 'https://datalaker9o1c4a.blob.core.windows.net/files/data/DimShipper.csv'
WITH (
    FILE_TYPE = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

-- =====================================================================================

CREATE TABLE [dbo].[DimSupplier] (
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

-- Load data from DimSupplier CSV file into the table
COPY INTO dbo.DimSupplier
FROM 'https://datalaker9o1c4a.blob.core.windows.net/files/data/DimSupplier.csv'
WITH (
    FILE_TYPE = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

-- =====================================================================================

CREATE TABLE [dbo].[FactOrdersAndDetails] (
    [OrderAltKey] INT NOT NULL,
    [OrderID] INT NOT NULL,
    [ProductID] INT NOT NULL,
    [Quantity] INT NULL,
    [Price] FLOAT NULL,
    [Discount] DECIMAL(3,1) NULL,
    [CustomerID] INT NULL,
    [EmployeeID] INT NULL,
    [ShipperID] INT NULL,
    [OrderDate] DATE NULL,
    [StatusID] INT NULL,
    [TotalAmount] FLOAT NULL
) WITH (
    DISTRIBUTION = HASH ([OrderAltKey]),
    CLUSTERED COLUMNSTORE INDEX
);
GO

-- Load data from FactOrdersAndDetails CSV file into the table
COPY INTO dbo.FactOrdersAndDetails
FROM 'https://datalaker9o1c4a.blob.core.windows.net/files/data/FactOrdersAndDetails.csv'
WITH (
    FILE_TYPE = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);