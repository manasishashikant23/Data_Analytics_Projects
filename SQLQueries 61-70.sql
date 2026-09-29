--61-Names of customers to whom we are sellinng less than average sales per cusotmer
GO
WITH AverageSalePerCustomer AS
(
SELECT SUM((OD.UnitPrice*OD.Quantity)*(1-OD.Discount))/COUNT(DISTINCT O.CustomerID)AvgSalePerCustomer
FROM [Order Details] OD
JOIN Orders O ON OD.OrderID = O.OrderID
JOIN Customers C ON O.CustomerID = C.CustomerID
)
SELECT C.CompanyName Customer,ROUND(SUM((OD.UnitPrice*OD.Quantity)*(1-OD.Discount)),2)TotalSale,
aspc.AvgSalePerCustomer
FROM AverageSalePerCustomer ASPC,[Order Details] OD
JOIN Orders O ON OD.OrderID = O.OrderID
JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY C.CompanyName,aspc.AvgSalePerCustomer
HAVING SUM((OD.UnitPrice*OD.Quantity)*(1-OD.Discount))<= ASPC.AvgSalePerCustomer
ORDER BY 2 DESC

--62-Query That Gives Average Freight Per Employee and Average Freight Per Customer
WITH AvgEmpwiseFreight AS
(
SELECT SUM(O.Freight)/ COUNT(DISTINCT E.EmployeeID) AvgEmpwiseFreight
FROM Orders O
JOIN Employees E ON O.EmployeeID=E.EmployeeID
),
AvgtCustwiseFreight AS
(
SELECT SUM(O.Freight)/ COUNT(DISTINCT C.CustomerID) AvgCustwiseFreight
FROM Orders O
JOIN Customers C ON O.CustomerID=C.CustomerID
)
SELECT AEF.AvgEmpwiseFreight, ACF.AvgCustwiseFreight
FROM AvgEmpwiseFreight AEF
CROSS JOIN AvgtCustwiseFreight ACF

--63-Query That Gives Category Wise Total Sale Where Category Total Sale < the Average Sale Per Category
GO
WITH CatwiseTotSales AS
(
SELECT C.CategoryName, ROUND(SUM((OD.UnitPrice*OD.Quantity)*(1-OD.Discount)),2)  SalesAmount
FROM [Order Details] OD
JOIN Products P ON OD.ProductID = P.ProductID
JOIN Categories C ON P.CategoryID=C.CategoryID
GROUP BY  C.CategoryName
),AvgSale AS
(
SELECT ROUND(AVG(SalesAmount),2)  AvgSalesAmt
FROM CatwiseTotSales CTS
)
SELECT  C.CategoryName,C.SalesAmount, AvgSalesAmt
FROM CatwiseTotSales C
CROSS JOIN AvgSale
WHERE C.SalesAmount < AvgSalesAmt

--64-Query That Provides Month No and Month OF Total Sales < Average Sale for Month for Year 1997
WITH MthTotSales AS
(
SELECT Month(O.OrderDate) MthNo, FORMAT(O.OrderDate,'MMM') MthName,
ROUND(SUM((OD.UnitPrice*OD.Quantity)*(1-OD.Discount)),2)  SalesAmount
FROM [Order Details] OD
JOIN Orders O ON OD.OrderID=O.OrderID
WHERE Year(O.OrderDate)=1997
GROUP BY Month(O.OrderDate), FORMAT(O.OrderDate,'MMM')
),AvgSale AS
(
SELECT ROUND(AVG(SalesAmount),2)  AvgSalesAmt
FROM MthTotSales CustTot
)
SELECT M.MthNo, M.MthName, M.SalesAmount,AvgSalesAmt
FROM MthTotSales M , AvgSale
WHERE M.SalesAmount < AvgSalesAmt
ORDER BY 1

--65-Find out the contribution of each employee towards the total sales done by Northwind for selected year
WITH EmpwiseSalesTot AS
(
SELECT E.FirstName+ ' '+ E.LastName EmpName,
 ROUND(SUM((OD.UnitPrice*OD.Quantity)*(1-OD.Discount)),2)  SalesAmount
FROM [Order Details] OD
JOIN Orders O ON OD.OrderID = O.OrderID
JOIN Employees E ON O.EmployeeID = E.EmployeeID
WHERE YEAR(O.OrderDate) = 1997
GROUP BY E.FirstName+ ' '+ E.LastName
),TotSales AS
(
SELECT ROUND(SUM((OD.UnitPrice*OD.Quantity)*(1-OD.Discount)),2)  TotSalesAmount
FROM [Order Details] OD
JOIN Orders O ON OD.OrderID = O.OrderID
WHERE YEAR(O.OrderDate) = 1997
)
SELECT EST.EmpName, ROUND((EST.SalesAmount/TS.TotSalesAmount)*100,2) AS ContributionPercentage
FROM EmpwiseSalesTot EST, TotSales TS
ORDER BY 2 DESC

--66-Give the Customer names that contribute 80% of the total sale done by Northwind for given year
WITH CustwiseSalesTot AS
(
SELECT C.CompanyName CustomerName, round(SUM((OD.UnitPrice*OD.Quantity)*(1-OD.Discount)),2)  SalesAmount
FROM [Order Details] OD
JOIN Orders O ON OD.OrderID = O.OrderID
JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE YEAR(O.OrderDate) = 1996
GROUP BY C.CompanyName
),EightyPercentOfTotSales AS
(
SELECT ROUND(0.80*SUM((OD.UnitPrice*OD.Quantity)*(1-OD.Discount)),2)  EightyPercentSalesAmount
FROM [Order Details] OD
JOIN Orders O ON OD.OrderID = O.OrderID
WHERE YEAR(O.OrderDate) = 1996
),CummulativeSale AS
(
SELECT CWS.CustomerName,CWS.SalesAmount,
SUM(CWS.SalesAmount) OVER (ORDER BY CWS.SalesAmount DESC) CummulativeSales
FROM CustwiseSalesTot CWS , EightyPercentOfTotSales ETS
)
SELECT CWS.CustomerName, CWS.SalesAmount, CWS.CummulativeSales,ETS.EightyPercentSalesAmount
FROM CummulativeSale CWS , EightyPercentOfTotSales ETS
WHERE CWS.CummulativeSales <= ETS.EightyPercentSalesAmount

--67-Top 3 performing employees by freight cost for given year
WITH EmpwiseTotalFreight AS
(
SELECT E.FirstName+ ' ' + E.LastName EmployeeName, SUM(O.Freight) AS TotalFreight,
RANK() OVER ( ORDER BY SUM(O.Freight) desc)EmpRank
FROM Orders O
JOIN Employees E ON O.EmployeeID=E.EmployeeID
WHERE year(O.OrderDate) = 1998
GROUP BY E.FirstName+ ' ' + E.LastName
)
SELECT ETF.*
FROM EmpwiseTotalFreight ETF
WHERE ETF.Emprank <=3

--68-Find the bottom 5 customers per product based on Sales Amount
WITH ProductwiseCustWiseTotSales AS
(
SELECT P.ProductName, C.CompanyName Customer, round(SUM((OD.UnitPrice*OD.Quantity)*(1-OD.Discount)),2)
SalesAmount,
row_number() OVER (PARTITION BY P.ProductName ORDER BY SUM((OD.UnitPrice*OD.Quantity)*(1-OD.Discount)))
ProuctwiseTotRank
FROM [Order Details] OD
JOIN Products P ON OD.ProductID = P.ProductID
JOIN Orders O ON OD.OrderID = O.OrderID
JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY P.ProductName, C.CompanyName
)
SELECT PCT.ProductName,PCT.Customer,PCT.SalesAmount
FROM ProductwiseCustWiseTotSales PCT
WHERE PCT.ProuctwiseTotRank <= 5

--69-Display first and the last row of the table
with Employee AS
(
SELECT EmployeeID ,LastName,FirstName,Rank() over(Order by EmployeeID Desc) as FirstRow,
Rank() over(Order by EmployeeID Asc) as LastRow
FROM Employees
Group by EmployeeID ,LastName,FirstName
)
SELECT EmployeeID ,LastName,FirstName
From Employee
where FirstRow = 1 or LastRow = 1

select *
from Employees

--70-Display employee doing highest sale and lowest sale in each year
GO
WITH EmployeewiseYearwiseTotalSaleAsc AS
(
SELECT YEAR(O.OrderDate)Year,E.FirstName+' '+ E.LastName EmployeeName,
round(SUM((OD.UnitPrice*OD.Quantity)*(1-OD.Discount)),2)SalesAmount,
DENSE_RANK() OVER (PARTITION BY YEAR(O.OrderDate)
 ORDER BY round(SUM((OD.UnitPrice*OD.Quantity)*(1-OD.Discount)),2) ASC )Rank
FROM [Order Details] OD
JOIN Orders O ON OD.OrderID = O.OrderID
JOIN Employees E ON O.EmployeeID = E.EmployeeID
GROUP BY YEAR(O.OrderDate),E.FirstName+' '+ E.LastName
), EmployeewiseYearwiseTotalSaleDesc AS
(
SELECT YEAR(O.OrderDate)Year,E.FirstName+' '+ E.LastName EmployeeName,
round(SUM((OD.UnitPrice*OD.Quantity)*(1-OD.Discount)),2)SalesAmount,
DENSE_RANK() OVER (PARTITION BY YEAR(O.OrderDate)
 ORDER BY round(SUM((OD.UnitPrice*OD.Quantity)*(1-OD.Discount)),2) DESC )Rank
FROM [Order Details] OD
JOIN Orders O ON OD.OrderID = O.OrderID
JOIN Employees E ON O.EmployeeID = E.EmployeeID
GROUP BY YEAR(O.OrderDate),E.FirstName+' '+ E.LastName
)
SELECT EYSA.Year,EYSA.EmployeeName,EYSA.SalesAmount LowestSale,EYSD.EmployeeName,EYSD.SalesAmount
Highestsale
FROM EmployeewiseYearwiseTotalSaleAsc EYSA
JOIN EmployeewiseYearwiseTotalSaleDesc EYSD ON EYSA.Year = EYSD.Year
WHERE EYSA.Rank = 1
AND EYSD.Rank = 1