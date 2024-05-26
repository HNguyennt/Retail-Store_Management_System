DROP DATABASE IF EXISTS FINAL2;
CREATE DATABASE FINAL2;
USE FINAL2;

DROP TABLE IF EXISTS DIM_TIME;
DROP TABLE IF EXISTS DIM_CUSTOMER;
DROP TABLE IF EXISTS DIM_PRODUCT;
DROP TABLE IF EXISTS DIM_LOCATION;
DROP TABLE IF EXISTS FACT_SALES;

CREATE TABLE [DIM_TIME] (
    [OrderYear] INT,
    [OrderQuarter] INT,
    [OrderMonth] INT,
    [OrderDay] INT,
    [ShipYear] INT,
    [ShipQuarter] INT,
    [ShipMonth] INT,
    [ShipDay] INT,
    [DateID] INT
)


CREATE TABLE [DIM_CUSTOMER] (
    [Customer ID] NVARCHAR(255),
    [Customer Name] NVARCHAR(255),
    [Segment] NVARCHAR(255)
)

CREATE TABLE [DIM_PRODUCT] (
    [Product ID] NVARCHAR(255),
    [Product Name] NVARCHAR(255),
    [Category] NVARCHAR(255),
    [Sub-Category] NVARCHAR(255)
)

CREATE TABLE [DIM_LOCATION] (
    [Market] NVARCHAR(255),
    [Region] NVARCHAR(255),
    [Country] NVARCHAR(255),
    [State] NVARCHAR(255),
    [City] NVARCHAR(255),
    [Postal Code] DOUBLE PRECISION,
    [LocationID] INT
)

CREATE TABLE [FACT_SALES] (
    [Row ID] float,
    [Order ID] nvarchar(255),
    [Customer ID] nvarchar(255),
    [Product ID] nvarchar(255),
    [DateID] int,
    [LocationID] int,
    [Sales] float,
    [Quantity] float,
    [Discount] float,
    [Profit] float,
    [Shipping Cost] float,
    [Order Priority] nvarchar(255)
)
