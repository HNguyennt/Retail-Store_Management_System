use FINAL2
select * from FACT_SALES
select* from DIM_CUSTOMER
select* from DIM_LOCATIONS
select* from DIM_PRODUCT
select* from DIM_TIME

--1.Danh mục sản phẩm nào tạo ra doanh thu cao nhất?
SELECT DP.[Product Name],DP.Category,DP.[Sub-Category],FACT_SALES.[Product ID], SUM(Sales) AS TotalSales  
FROM FACT_SALES 
INNER JOIN DIM_PRODUCT DP ON FACT_SALES.[Product ID]=DP.[Product ID]
GROUP BY DP.[Product Name],DP.Category,DP.[Sub-Category],FACT_SALES.[Product ID]
ORDER BY TotalSales DESC;

--2.Doanh thu như thế nào khi so sánh giữa các vùng?
SELECT DL.Region, SUM(Sales) AS TotalSales
FROM FACT_SALES INNER JOIN DIM_LOCATIONS DL ON DL.LocationID=FACT_SALES.LocationID
GROUP BY DL.Region, FACT_SALES.LocationID
ORDER BY TotalSales DESC;

--3.Có bao nhiêu bang tất cả?
SELECT COUNT(DISTINCT State) AS [Number of States] 
FROM DIM_LOCATIONS;

--3.1.Số lần các bang xuất hiện
SELECT State, COUNT(*) AS [Count]
FROM DIM_LOCATIONS
GROUP BY State
ORDER BY State;

--4.Sản phẩm nào có lợi nhuận âm liên tục và tổng số tiền âm là bao nhiêu?
SELECT DP.[Product Name],DP.Category,DP.[Sub-Category], FS.[Product ID], SUM(FS.Profit) AS [Sum of Negative Profit], COUNT(*) AS [Negative Profit count]
FROM FACT_SALES FS inner join DIM_PRODUCT DP ON DP.[Product ID]= FS.[Product ID]
WHERE Profit < 0 
GROUP BY DP.[Product Name],DP.Category,DP.[Sub-Category],FS.[Product ID]
ORDER BY [Negative Profit count] DESC;

--5.Tổng số đơn hàng theo quý?
SELECT OrderYear, OrderQuarter,COUNT(*) AS [Total Orders]
FROM DIM_TIME
GROUP BY  OrderYear, OrderQuarter
ORDER BY OrderYear, OrderQuarter;

--6. Trong năm 2013, liệt kê 5 khách hàng có tổng số đơn mua hàng nhiều nhất
SELECT TOP 5 
    dc.[Customer ID],
    dc.[Customer Name],
    COUNT(fs.[Product ID]) AS [Total Orders]
FROM 
    FACT_SALES fs
JOIN 
    DIM_CUSTOMER dc ON dc.[Customer ID] = fs.[Customer ID]
JOIN 
    DIM_TIME dt ON dt.DateID = fs.DateID
WHERE 
    dt.OrderYear = 2013
GROUP BY 
    dc.[Customer ID],
    dc.[Customer Name]
ORDER BY 
    [Total Orders] DESC;

--7. 3 tháng có số lượng đơn hàng nhiều nhất tại New York
SELECT TOP 3 
    dt.OrderYear, 
    dt.OrderMonth,
    dl.City,
    COUNT(fs.[Product ID]) AS [Total Orders]
FROM 
    FACT_SALES fs
JOIN 
    DIM_LOCATIONS dl ON dl.LocationID = fs.LocationID
JOIN 
    DIM_TIME dt ON dt.DateID = fs.DateID
WHERE 
    dl.City = 'New York City'
GROUP BY 
    dt.OrderYear, 
    dt.OrderMonth,
    dl.City
ORDER BY 
    [Total Orders] DESC;

--8. liệt kê sản phẩm và khách hàng mua khi có discount= 0.8
SELECT 
    dc.[Customer ID], 
    dc.[Customer Name],
	dc.Segment,
    dp.[Product ID], 
    dp.[Product Name],
	dp.[Sub-Category],
    fs.[Discount]
FROM 
    FACT_SALES fs
JOIN 
    DIM_CUSTOMER dc ON dc.[Customer ID] = fs.[Customer ID]
JOIN 
    DIM_PRODUCT dp ON dp.[Product ID] = fs.[Product ID]
WHERE 
    fs.[Discount] = 0.8;

--9. thành phố và bang nào có orderpriority là critical nhiều nhất
SELECT TOP 1
    dl.City,
    dl.State,
    COUNT(fs.[Product ID]) AS [Total Critical Orders]
FROM 
    FACT_SALES fs
JOIN 
    DIM_LOCATIONS dl ON dl.LocationID = fs.LocationID
WHERE 
    fs.[Order Priority] = 'Critical'
GROUP BY 
    dl.City,
    dl.State
ORDER BY 
    [Total Critical Orders] DESC;

--10. lợi nhuận trung bình 1 tháng đối với mỗi category
SELECT 
    dp.Category,
    dt.[OrderYear],
    dt.[OrderMonth],
    AVG(fs.[Profit]) AS [Average Monthly Profit]
FROM 
    FACT_SALES fs
JOIN 
    DIM_PRODUCT dp ON dp.[Product ID] = fs.[Product ID]
JOIN 
    DIM_TIME dt ON dt.[DateID] = fs.[DateID]
GROUP BY 
    dp.Category,
    dt.[OrderYear],
    dt.[OrderMonth]
ORDER BY 
    dp.Category, 
    dt.[OrderYear], 
    dt.[OrderMonth];

--11. Sub-category của category nào bán chạy nhất
SELECT TOP 1
    dp.Category,
	dp.[Sub-Category],
    SUM(fs.Quantity) AS [Total Quantity Sold]
FROM 
    FACT_SALES fs
JOIN 
    DIM_PRODUCT dp ON dp.[Product ID] = fs.[Product ID]
GROUP BY 
    dp.Category,
	dp.[Sub-Category]
ORDER BY 
    [Total Quantity Sold] DESC;

--12. tổng số sale trong mỗi tháng ở mỗi năm
SELECT 
    OrderYear,
	OrderMonth,
    SUM(fs.Sales) AS TotalSales
FROM 
    FACT_SALES fs
JOIN 
    DIM_TIME dt ON fs.DateID = dt.DateID
GROUP BY 
    OrderYear,
	OrderMonth
ORDER BY 
    OrderMonth,
	OrderYear








