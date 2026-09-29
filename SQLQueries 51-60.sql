--51-Employee wise Average Freight
Select E.EmployeeID, E.FirstName+' '+E.LastName EmployeeName, Avg(O.Freight) AvgFreight
From Orders O
Join Employees E On O.EmployeeID=E.EmployeeID
Group By E.EmployeeID, E.FirstName+' '+E.LastName

--52-Average Freight per employee
Select E.EmployeeID, E.FirstName+' '+E.LastName EmployeeName, Avg(O.Freight) AvgFreight
From Orders O
Join Employees E On O.EmployeeID=E.EmployeeID
Group By E.EmployeeID, E.FirstName+' '+E.LastName

--53-Average no. of orders per customer
SELECT AVG(OrderCount) AvgOrderCount
From(
	Select C.CustomerID, COUNT(O.OrderID) OrderCount
	From Orders O
	Join Customers C On O.CustomerID=C.CustomerID
	Group By C.CustomerID
)As CustomerOrderCounts

--54-AverageSales per product within Category
Select C.CategoryID, C.CategoryName, P.ProductID, P.ProductName, AVG(OD.UnitPrice * OD.Quantity*(1-OD.Discount)) AvgSale
From Orders O
Join [Order Details] OD On O.OrderID=OD.OrderID
Join Products P On OD.ProductID=P.ProductID
Join Categories C On P.CategoryID=C.CategoryID
Group By C.CategoryID, C.CategoryName, P.ProductID, P.ProductName

--55-PoductName which have more than 100 no.of UnitsinStock
Select P.ProductName, P.UnitsInStock
From Products P
Where P.UnitsInStock > 100

--56-Query to Provide Product Name and Sales Amount for Category Beverages
Select P.ProductName, C.CategoryName, Sum(OD.UnitPrice * OD.Quantity*(1-OD.Discount)) TotalSale
From Orders O
Join [Order Details] OD On O.OrderID=OD.OrderID
Join Products P On OD.ProductID=P.ProductID
Join Categories C On P.CategoryID = C.CategoryID
Where C.CategoryName= 'Beverages'
Group By P.ProductName, C.CategoryName

--57-Query That Will Give  CategoryWise Yearwise number of Orders
Select C.CategoryName, Year(O.OrderDate) YearwiseOrders, COUNT(O.OrderID) TotalOrders
From Orders O
Join [Order Details] OD On O.OrderID=OD.OrderID
Join Products P On OD.ProductID=P.ProductID
Join Categories C On P.CategoryID = C.CategoryID
Group By C.CategoryName, Year(O.OrderDate)
Order By C.CategoryName, YearwiseOrders

--58-Query to Get ShipperWise employeewise Total Freight for shipped year 1997
Select S.ShipperID, E.EmployeeID, E.FirstName+' '+E.LastName EmployeeName, Sum(O.Freight) TotalFreight
From Orders O
Join Employees E On O.EmployeeID = E.EmployeeID
Join Shippers S On O.ShipVia = S.ShipperID
Group By S.ShipperID, E.EmployeeID, E.FirstName+' '+E.LastName
Order By EmployeeName

--59-Query That Gives Employee Full Name, Territory Description and Region Description
Select E.FirstName+' '+E.LastName EmployeeName, T.TerritoryDescription, R.RegionDescription
From Employees E
Join EmployeeTerritories ET On E.EmployeeID= ET.EmployeeID
Join Territories T On ET.TerritoryID = T.TerritoryID
Join Region R On T.RegionID = R.RegionID
Order By EmployeeName, TerritoryDescription, RegionDescription

--60-Query That Will Give Managerwise Total Sales for each year
 Select E.Title, Year(O.OrderDate) OrderYear, Sum(OD.UnitPrice * OD.Quantity*(1-OD.Discount)) TotalSale
 From Orders O
 Join [Order Details] OD On O.OrderID=OD.OrderID
 Join Employees E On O.EmployeeID=E.EmployeeID
 Where E.Title= 'Sales Manager'
 Group By E.Title, O.OrderDate

