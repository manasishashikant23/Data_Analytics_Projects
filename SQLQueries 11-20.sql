--11-Create a report showing the Order ID, the name of the company that placed the order,and the first and last name of the associated employee. 
--Only show orders placed after January 1, 1998 that shipped after they were required. Sort by Company Name.
Select O.OrderID, S.CompanyName, E.FirstName+' '+E.LastName EmployeeName
From Orders O
Join Shippers S ON O.ShipVia=S.ShipperID
Join [Order Details] OD ON O.OrderID=OD.OrderID
join Employees E ON O.EmployeeID= E.EmployeeID
where O.OrderDate > '1998-01-01'
AND O.ShippedDate > O.RequiredDate
Order By S.CompanyName

--12-Get the phone numbers of all shippers, customers, and suppliers
Select 'Customer' Customers, C.Phone PhoneNumber
From Customers C
Union
Select 'Shipper' As Shipper, Ship.Phone
From Shippers Ship
Union
Select 'Supplier' As Supplier, Sup.Phone
From Suppliers Sup

--13-Create a report showing the contact name and phone numbers for all employees,customers, and suppliers.
Select 'Customer' As EntityType, C.Phone PhoneNumber, C.ContactName
From Customers C
Union
Select 'Shipper' As EntityType, Ship.Phone, O.ShipName
From Shippers Ship
Join Orders O On Ship.ShipperID= O.ShipVia
Union
Select 'Supplier' As EntityType, Sup.Phone, Sup.ContactName
From Suppliers Sup

--14-Fetch all the orders for a given customer’s phone number 030-0074321.
Select O.OrderID, C.Phone PhoneNumber, O.OrderDate, O.RequiredDate, O.Freight, O.ShipCity, O.ShipRegion, O.ShipPostalCode, O.ShipCountry
From Customers C
Join Orders O On C.CustomerID=O.CustomerID
Where c.Phone= '030-0074321'

--15-Fetch all the products which are available under Category ‘Seafood’.
Select P.ProductID, P.ProductName,P.SupplierID, C.CategoryID, C.CategoryName, P.QuantityPerUnit, P.UnitPrice, P.UnitsInStock, P.UnitsOnOrder,
P.ReorderLevel, P.Discontinued
From Products P
Join Categories C On P.CategoryID=C.CategoryID
Where C.CategoryName='Seafood'

--16-Fetch all the products which are supplied by a company called ‘Pavlova, Ltd.’
Select P.ProductID, P.ProductName, S.SupplierID, P.CategoryID, S.CompanyName, P.QuantityPerUnit, P.UnitPrice, P.UnitsInStock,
P.UnitsOnOrder, P.ReorderLevel, P.Discontinued
From Products P
Join Suppliers S On P.SupplierID=S.SupplierID
Where S.CompanyName= 'Pavlova, Ltd.'

--17-All orders placed by the customers belong to London city.
Select O.OrderID, C.ContactName CustomerName, C.Country
From Orders O
Join Customers C On O.CustomerID=C.CustomerID
Where C.Country='UK'

--18-All orders placed by the customers not belong to London city.
Select O.OrderID, C.CustomerID,  C.ContactName CustomerName, C.Country, O.OrderDate, O.ShippedDate, O.RequiredDate, O.Freight, O.ShipName,
O.ShipAddress, O.ShipCity, O.ShipRegion, O.ShipPostalCode, O.ShipCountry
From Orders O
Join Customers C On O.CustomerID=C.CustomerID
Where C.Country!='UK'

--19-All the orders placed for the product Chai.
Select O.OrderID, P.ProductName, O.OrderDate, O.ShippedDate, O.RequiredDate, O.Freight, O.ShipName, O.ShipAddress, O.ShipCity,
O.ShipRegion,O.ShipAddress, O.ShipCity, O.ShipRegion, O.ShipRegion, O.ShipPostalCode, O.ShipCountry
From Orders O
Join [Order Details] OD On O.OrderID= OD.OrderID
Join Products P On OD.ProductID=P.ProductID
Where P.ProductName='Chai'

--20-Find the name of the company that placed order 10290.
Select Ship.CompanyName CompanyName, O.OrderID
From Orders O
Join Shippers Ship On O.ShipVia= Ship.ShipperID
Where O.OrderID= 10290