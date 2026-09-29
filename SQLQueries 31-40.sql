--31-Select CompanyName, Fax, Phone, HomePage and Country from the Suppliers table sorted by Country in descending 
--order and then by CompanyName in ascending order
Select S.CompanyName, S.Fax, S.Phone, S.HomePage, S.Country
From Suppliers S
Where S.Fax IS NOT NULL and S.HomePage IS NOT NULL
Order By Country DESC, CompanyName ASC


--32-Create a report showing all the company names and contact names of Northwind's customers in Buenos Aires
Select C.CompanyName, C.ContactName, C.City
From Customers C
Where C.City='Buenos Aires'

--33-Create a report showing the product name, unit price and quantity per unit of all products that are out of stock
Select P.ProductName, P.UnitPrice, P.QuantityPerUnit, P.UnitsInStock
From Products P
Where P.UnitsInStock=0

--34-Create a report showing the order date, shipped date, customer id, and freight of all orders placed on May 19, 1997
Select O.OrderDate, O.ShippedDate, O.CustomerID,O.Freight
From Orders O
Where O.ShippedDate= '1997-05-19'


--35-Create a report showing the first name, last name, and country of all employees not in the United States.
Select E.FirstName + ' '+ E.LastName EmployeeFullName, E.Country
From Employees E
Where E.Country!= 'USA'

--36-Create a report that shows the city, company name, and contact name of all customers who are in cities that begin with "A" or "B."
Select C.City, C.CompanyName, C.ContactName
From Customers C
Where C.City Like 'A%' Or 
C.City Like 'B%'

--37-Create a report that shows all orders that have a freight cost of more than $500.00.
Select *
From Orders O
Where O.Freight > '500.00'

--38-Create a report that shows the product name, units in stock, units on order, and reorder level of all
-- products that are up for reorder
Select P.ProductName, P.UnitsInStock, P.UnitsOnOrder, P.ReorderLevel
From Products P
Where UnitsInStock <= ReorderLevel

--39-Create a report that shows the company name, contact name and fax number of all customers that have a fax number.
Select C.CompanyName, C.ContactName, C.Fax
From Customers C
Where C.Fax IS NOT NULL

--40-Create a report that shows the first and last name of all employees who do not report to anybody
--Select E.FirstName+' '+E.LastName EmployeeName, E.ReportsTo
Select E.FirstName, E.LastName
From Employees E
Where E.ReportsTo Is Null