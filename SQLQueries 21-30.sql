--21-Find the Companies that placed orders in 1997
Select S.CompanyName, O.ShippedDate
From Orders O
Join Shippers S On O.ShipVia= S.ShipperID
Where O.ShippedDate> '1997-01-01' 
And O.ShippedDate< '1997-12-31'

--22-Get the product name , count of orders processed
Select P.ProductName, COUNT(O.OrderID) OrderCount
From Orders O
Join [Order Details] OD On O.OrderID=OD.OrderID
Join Products P On OD.ProductID=P.ProductID
Group By P.ProductName
Order By OrderCount DESC

--23-Get the top 3 products which has more orders
Select Top 3 P.ProductName, Count(O.OrderID) OrderCount
From Orders O
Join [Order Details] OD On O.OrderID=OD.OrderID
Join Products P On OD.ProductID=P.ProductID
Group By P.ProductName
Order By OrderCount Desc

--24-Get the list of employees who processed the order “chai”
Select E.FirstName+' '+LastName EmployeeName, P.ProductName
From Orders O
Join Employees E On O.EmployeeID= E.EmployeeID
Join [Order Details] OD On O.OrderID=OD.OrderID
Join Products P On OD.ProductID=P.ProductID
Where P.ProductName= 'Chai'
Group By E.FirstName+' '+LastName, P.ProductName

--25-Get the shipper company who processed the order categories “Seafood” 
Select S.CompanyName ShipperCompany, C.CategoryName OrderCategory
From Orders O
Join Shippers S On O.ShipVia= S.ShipperID
Join [Order Details] OD On O.OrderID=OD.OrderID
Join Products P On OD.ProductID=P.ProductID
Join Categories C On P.CategoryID=C.CategoryID
Where C.CategoryName='Seafood'
Group By S.CompanyName, C.CategoryName

--26-Get category name , count of orders processed by the USA employees 
Select C.CategoryName, Count(O.OrderID) OrderCount, E.Country
From Orders O
Join Employees E On E.EmployeeID= O.EmployeeID
Join [Order Details] OD On O.OrderID=OD.OrderID
Join Products P On OD.ProductID=P.ProductID
Join Categories C On P.CategoryID=C.CategoryID
Where E.Country='USA'
Group By C.CategoryName, E.Country
Order By OrderCount DESC

--27-Select CategoryName and Description from the Categories table sorted by CategoryName.
Select C.CategoryName, C.Description
From Categories C
Order By CategoryName

--28-Select ContactName, CompanyName, ContactTitle, and Phone from the Customers table sorted byPhone.
Select C.ContactName, C.CompanyName, C.ContactTitle, C.Phone
From Customers C
Order By C.Phone

--29-Create a report showing employees' first and last names and hire dates sorted from newest to oldest employee
Select E.FirstName+' '+E.LastName EmployeeName, E.HireDate
From Employees E
Order By HireDate ASC

--30-Create a report showing Northwind's orders sorted by Freight from most expensive to cheapest. Show OrderID, 
--OrderDate, ShippedDate, CustomerID, and Freight
Select O.OrderID, O.CustomerID, O.OrderDate, O.ShippedDate, O.Freight
From Orders O
Order By Freight DESC