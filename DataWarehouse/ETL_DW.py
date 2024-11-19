import pandas as pd
from sqlalchemy import create_engine, MetaData, Table, text

# Source database connection
SERVER_SOURCE = 'KHALED'
DATABASE_SOURCE = 'ECommerceDB'
DRIVER = 'ODBC Driver 17 for SQL Server'
connection_string_source = f"mssql+pyodbc://@{SERVER_SOURCE}/{DATABASE_SOURCE}?driver={DRIVER}&trusted_connection=yes"
engine_source = create_engine(connection_string_source)
metadata_source = MetaData()

# Target data warehouse connection
DATABASE_TARGET = 'ECommerceDW'
connection_string_target = f"mssql+pyodbc://@{SERVER_SOURCE}/{DATABASE_TARGET}?driver={DRIVER}&trusted_connection=yes"
engine_target = create_engine(connection_string_target)
metadata_target = MetaData()

# Define the tables from the source database
customer = Table('Customer', metadata_source, autoload_with=engine_source)
address = Table('Address', metadata_source, autoload_with=engine_source)
employee = Table('Employee', metadata_source, autoload_with=engine_source)
shipper = Table('Shipper', metadata_source, autoload_with=engine_source)
category = Table('Category', metadata_source, autoload_with=engine_source)
supplier = Table('Supplier', metadata_source, autoload_with=engine_source)
product = Table('Product', metadata_source, autoload_with=engine_source)
order_status = Table('OrderStatus', metadata_source, autoload_with=engine_source)
orders = Table('Orders', metadata_source, autoload_with=engine_source)
order_detail = Table('OrderDetail', metadata_source, autoload_with=engine_source)

# Extract data into DataFrames
df_customer = pd.read_sql_table(customer.name, engine_source)
df_address = pd.read_sql_table(address.name, engine_source)
df_employee = pd.read_sql_table(employee.name, engine_source)
df_shipper = pd.read_sql_table(shipper.name, engine_source)
df_category = pd.read_sql_table(category.name, engine_source)
df_supplier = pd.read_sql_table(supplier.name, engine_source)
df_product = pd.read_sql_table(product.name, engine_source)
df_order_status = pd.read_sql_table(order_status.name, engine_source)
df_orders = pd.read_sql_table(orders.name, engine_source)
df_order_detail = pd.read_sql_table(order_detail.name, engine_source)


# Data preparation and transformation
df_address.fillna({'PostalCode': '000000'}, inplace=True)
df_customer['ContactName'] = df_customer['FirstName'] + ' ' + df_customer['LastName']
df_employee['ContactName'] = df_employee['FirstName'] + ' ' + df_employee['LastName']
df_customer.drop(['FirstName', 'LastName'], axis=1, inplace=True)
df_employee.drop(['FirstName', 'LastName'], axis=1, inplace=True)


# # Transform DataFrames to match Dimension and Fact tables
# df_dim_customer = df_customer.rename(columns={'ContactName': 'CustomerName', 'Phone': 'Phone',
#                                               'Email': 'Email'})

# df_dim_address = df_address.rename(columns={'Street': 'Address'})

# df_dim_employee = df_employee.rename(columns={'ContactName': 'EmployeeName'})

# df_dim_shipper = df_shipper.rename(columns={'Name': 'Name'})

# df_dim_category = df_category.rename(columns={'Name': 'CategoryName', 'Description': 'CategoryDescription'})

# df_dim_product = df_product.rename(columns={'Name': 'ProductName', 'UnitPrice': 'UnitPrice',
#                                             'StockQuantity': 'UnitsInStock'})

# df_dim_supplier = df_supplier.rename(columns={'Name': 'SupplierName'})

# df_dim_order_status = df_order_status.rename(columns={'Status': 'Status'})

# Transform DataFrames to match Dimension and Fact tables
df_dim_customer = df_customer.rename(columns={'CustomerID': 'CustomerID', 'ContactName': 'CustomerName', 'Phone': 'Phone', 'Email': 'Email'})
df_dim_address = df_address.rename(columns={'AddressID': 'AddressID', 'CustomerID': 'CustomerID', 'Street': 'Address', 'City': 'City', 'Country': 'Country', 'PostalCode': 'PostalCode'})
df_dim_employee = df_employee.rename(columns={'EmployeeID': 'EmployeeID', 'ContactName': 'EmployeeName', 'Phone': 'Phone', 'Age': 'Age', 'HireDate': 'HireDate'})
df_dim_shipper = df_shipper.rename(columns={'ShipperID': 'ShipperID', 'Name': 'Name', 'Phone': 'Phone'})
df_dim_category = df_category.rename(columns={'CategoryID': 'CategoryID', 'Name': 'CategoryName', 'Description': 'CategoryDescription'})
df_dim_product = df_product.rename(columns={'ProductID': 'ProductID', 'Name': 'ProductName', 'SupplierID': 'SupplierID', 'CategoryID': 'CategoryID', 'UnitPrice': 'UnitPrice', 'StockQuantity': 'UnitsInStock'})
df_dim_supplier = df_supplier.rename(columns={'SupplierID': 'SupplierID', 'Name': 'SupplierName', 'Phone': 'Phone', 'City': 'City', 'Country': 'Country'})
df_dim_order_status = df_order_status.rename(columns={'OrderStatusID': 'OrderStatusID', 'Status': 'Status'})

# Drop OrderDetailID from df_order_detail to avoid invalid column name
df_order_detail.drop(columns=['OrderDetailID'], inplace=True)

df_fact_orders_details = pd.merge(df_order_detail, df_orders, on='OrderID')
df_fact_orders_details = df_fact_orders_details.rename(
    columns={'OrderID': 'OrderID', 'ProductID': 'ProductID', 'CustomerID': 'CustomerID',
            'EmployeeID': 'EmployeeID', 'ShipperID': 'ShipperID', 'SupplierID': 'SupplierID',
            'OrderStatusID': 'StatusID', 'OrderDate': 'OrderDate', 'Quantity': 'Quantity',
            'UnitPrice': 'Price', 'Discount': 'Discount', 'TotalAmount': 'TotalAmount'})

# Function to insert data with IDENTITY_INSERT ON
def insert_with_identity(df, table_name):
    with engine_target.connect() as conn:
        conn.execute(text(f"SET IDENTITY_INSERT {table_name} ON"))
        df.to_sql(table_name, conn, if_exists='replace', index=False)
        conn.execute(text(f"SET IDENTITY_INSERT {table_name} OFF"))

# # Insert data into the data warehouse tables
# insert_with_identity(df_dim_customer, 'DimCustomer')
# insert_with_identity(df_dim_address, 'DimAddress')
# insert_with_identity(df_dim_employee, 'DimEmployee')
# insert_with_identity(df_dim_shipper, 'DimShipper')
# insert_with_identity(df_dim_category, 'DimCategory')
# insert_with_identity(df_dim_product, 'DimProduct')
# insert_with_identity(df_dim_supplier, 'DimSupplier')
# insert_with_identity(df_dim_order_status, 'DimOrderStatus')

# Insert data into the data warehouse tables
df_dim_customer.to_sql('DimCustomer', engine_target, if_exists='replace', index=False)
df_dim_address.to_sql('DimAddress', engine_target, if_exists='replace', index=False)
df_dim_employee.to_sql('DimEmployee', engine_target, if_exists='replace', index=False)
df_dim_shipper.to_sql('DimShipper', engine_target, if_exists='replace', index=False)
df_dim_category.to_sql('DimCategory', engine_target, if_exists='replace', index=False)
df_dim_product.to_sql('DimProduct', engine_target, if_exists='replace', index=False)
df_dim_supplier.to_sql('DimSupplier', engine_target, if_exists='replace', index=False)
df_dim_order_status.to_sql('DimOrderStatus', engine_target, if_exists='replace', index=False)

df_fact_orders_details.to_sql('FactOrdersAndDetails', engine_target, if_exists='replace', index=False)

                              
print("Data successfully loaded from ECommerceDB to ECommerceDW.")