--41-Create a report that shows the company name, contact name and fax number of all customers that have a fax number, 
--Sort by company name.
Select C.CompanyName, C.ContactName, C.Fax
From Customers C
Where C.Fax IS NOT NULL

--42-Create a report that shows the city, company name, and contact name of all customers who are in cities 
--that begin with "A" or "B." Sort by contact name in descending order 
Select C.City, C.CompanyName, C.ContactName, C.City
From Customers C
Where C.City Like 'A%' OR
C.City Like 'B%'
Order By ContactName DESC

--43-Create a report that shows the first and last names and birth date of all employees born in the 1950s
Select E.FirstName+' '+E.LastName EmployeeName, E.BirthDate
From Employees E
Where BirthDate Between '1950-01-01' And '1959-12-31'

--44-Create a report that shows the shipping postal code, order id, and order date for all orders with a ship postal code 
--beginning with "02389".
Select O.ShipPostalCode, O.OrderID, O.OrderDate
From Orders O
Where O.ShipPostalCode Like '02389%'

--45-Create a report that shows the contact name and title and the company name for all customers whose contact title
-- does not contain the word "Sales".
Select C.ContactName, C.ContactTitle, C.CompanyName
From Customers C
Where ContactTitle Not Like '%Sales%'

--46-Create a report that shows the first and last names and cities of employees from cities other than Seattle
-- in the state of Washington.
Select E.FirstName+' '+E.LastName EmployeeName, E.City
From Employees E
Where City!='Seattle'

--47-Create a report that shows the company name, contact title, city and country of all customers in Mexico 
--or in any city in Spain except Madrid.
Select C.CompanyName, C.ContactTitle, C.City, C.Country
From Customers C
Where Country='Mexico' or
Country= 'Spain' and City != 'Madrid'

--48-List of Employees along with the Manager
Select E.FirstName+' '+E.LastName EmployeeName, E.ReportsTo
From Employees E

--49-List of Employees along with the Manager and his/her title
Select E.FirstName+' '+E.LastName EmployeeName, E.ReportsTo, E.Title
From Employees E

--50-Provide Average Sales per order
Select O.OrderID, AVG(OD.UnitPrice * OD.Quantity*(1-OD.Discount)) AvgSale
From Orders O
Join [Order Details] OD On O.OrderID=OD.OrderID
Group By O.OrderID