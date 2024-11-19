import pandas as pd

from sqlalchemy import create_engine, MetaData, Table


SERVER = 'KHALED'
DATABASE = 'ECommerceDB'
DRIVER = 'ODBC Driver 17 for SQL Server'
connection_string = f"mssql+pyodbc://@{SERVER}/{DATABASE}?driver={DRIVER}&trusted_connection=yes"
engine = create_engine(connection_string)
metadata = MetaData()

# Define the tables
tables = ['Customer', 'Address', 'Employee', 'Shipper', 
          'Category', 'Supplier', 'Product', 'OrderStatus', 'Orders', 'OrderDetail']

# Define the tables
customer = Table('Customer', metadata, autoload_with=engine)
address = Table('Address', metadata, autoload_with=engine)
employee = Table('Employee', metadata, autoload_with=engine)
shipper = Table('Shipper', metadata, autoload_with=engine)
category = Table('Category', metadata, autoload_with=engine)
supplier = Table('Supplier', metadata, autoload_with=engine)
product = Table('Product', metadata, autoload_with=engine)
order_status = Table('OrderStatus', metadata, autoload_with=engine)
orders = Table('Orders', metadata, autoload_with=engine)
order_detail = Table('OrderDetail', metadata, autoload_with=engine)

# Extract data into DataFrames
df_customer = pd.read_sql_table(customer.name, engine)
df_address = pd.read_sql_table(address.name, engine)
df_employee = pd.read_sql_table(employee.name, engine)
df_shipper = pd.read_sql_table(shipper.name, engine)
df_category = pd.read_sql_table(category.name, engine)
df_supplier = pd.read_sql_table(supplier.name, engine)
df_product = pd.read_sql_table(product.name, engine)
df_order_status = pd.read_sql_table(order_status.name, engine)
df_orders = pd.read_sql_table(orders.name, engine)
df_order_detail = pd.read_sql_table(order_detail.name, engine)

# Data preparation and transformation
df_address.fillna({'PostalCode':'000000'}, inplace=True)

# Concatenating first and last names
df_customer['ContactName'] = df_customer['FirstName'] + ' ' + df_customer['LastName']
df_employee['ContactName'] = df_employee['FirstName'] + ' ' + df_employee['LastName']

# Dropping original first and last name columns
df_customer.drop(['FirstName', 'LastName'], axis=1, inplace=True)
df_employee.drop(['FirstName', 'LastName'], axis=1, inplace=True)

# DimCustomer
df_dim_customer = df_customer.rename(
                    columns={'ContactName': 'CustomerName', 'Phone': 'Phone', 'Email': 'Email'})

# DimAddress
df_dim_address = df_address.rename(columns={'Street': 'Address'})

# DimEmployee
df_dim_employee = df_employee.rename(columns={'ContactName': 'EmployeeName'})

# DimShipper
df_dim_shipper = df_shipper.rename(columns={'Name': 'Name'})

# DimCategory
df_dim_category = df_category.rename(
                    columns={'Name': 'CategoryName', 'Description': 'CategoryDescription'})

# DimProduct
df_dim_product = df_product.rename(
                    columns={'Name': 'ProductName', 'UnitPrice': 'UnitPrice',
                             'StockQuantity': 'UnitsInStock'})

# DimSupplier
df_dim_supplier = df_supplier.rename(columns={'Name': 'SupplierName'})

# DimOrderStatus
df_dim_order_status = df_order_status.rename(columns={'Status': 'Status'})

# FactOrdersAndDetails
df_fact_orders_details = pd.merge(df_order_detail, df_orders, on='OrderID')
df_fact_orders_details = df_fact_orders_details.rename(columns={
    'Quantity': 'Quantity',
    'UnitPrice': 'Price',
    'Discount': 'Discount',
    'TotalAmount': 'TotalAmount'
})

# Save as CSV files
df_dim_customer.to_csv('DimCustomer.csv', index=False)
df_dim_address.to_csv('DimAddress.csv', index=False)
df_dim_employee.to_csv('DimEmployee.csv', index=False)
df_dim_shipper.to_csv('DimShipper.csv', index=False)
df_dim_category.to_csv('DimCategory.csv', index=False)
df_dim_product.to_csv('DimProduct.csv', index=False)
df_dim_supplier.to_csv('DimSupplier.csv', index=False)
df_dim_order_status.to_csv('DimOrderStatus.csv', index=False)
df_fact_orders_details.to_csv('FactOrdersAndDetails.csv', index=False)

print("Data warehouse CSV files with concatenated and cleaned columns generated.")