--1- Find the number of orders sent by each shipper.
SELECT S.ShipperID Shipper, SUM(O.OrderID) TotalNoOfOrders
FROM Shippers S
JOIN Orders O ON S.ShipperID=O.ShipVia
GROUP BY S.ShipperID

--2- Find the number of orders sent by each shipper, sent by each employee
SELECT S.ShipperID Shippers, S.CompanyName ShipperCompanyName, E.FirstName + ' '+E.LastName EmployeeName, SUM(O.OrderID) TotalOrder
FROM Orders O
JOIN Shippers S ON O.ShipVia=S.ShipperID
JOIN Employees E ON O.EmployeeID=E.EmployeeID
GROUP BY S.ShipperID, E.FirstName + ' '+E.LastName, S.CompanyName

--3- Find  name  of  employees who has registered more than 100 orders.
SELECT E.FirstName+ ' '+E.LastName EmployeeName, sum(O.OrderID) TotalOrders
FROM Orders O
JOIN Employees E ON O.EmployeeID=E.EmployeeID
GROUP BY E.FirstName+ ' '+E.LastName
HAVING COUNT(O.OrderID)>100

--4-Find if the employees "Davolio" or "Fuller" have registered more than 25 orders.
SELECT E.FirstName+' '+E.LastName EmployeeName, SUM(o.OrderID) TotalOrders
FROM Orders O
JOIN Employees E ON O.EmployeeID=E.EmployeeID
where E.LastName IN('Davolio','Fuller')
GROUP BY E.FirstName+' '+E.LastName
HAVING COUNT(O.OrderID) >25

--5-Find the customer_id and name of customers who had placed orders more than one time and how many times they have placed the order
SELECT C.CustomerID, C.ContactName,Count(O.OrderID) OrderCount
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.ContactName
HAVING COUNT(O.OrderID) >1

--6-Select all the orders where the employee’s city and order’s ship city are same.
SELECT E.FirstName+' '+ E.LastName EmployeeName, O.OrderID, e.City, O.ShipCity
FROM Employees E
JOIN Orders O ON E.EmployeeID = O.EmployeeID
WHERE E.City = O.ShipCity
GROUP BY E.FirstName+' '+ E.LastName,O.OrderID, e.City, O.ShipCity

--7-Create a report that shows the order ids and the associated employee names for orders that shipped after the required date.
SELECT O.OrderID, E.FirstName+' '+LastName EmployeeName,O.ShippedDate, O.RequiredDate
FROM Orders O
JOIN Employees E ON O.EmployeeID=E.EmployeeID
WHERE O.ShippedDate > O.RequiredDate
GROUP BY O.OrderID, E.FirstName+' '+LastName,O.ShippedDate, O.RequiredDate

--8-Create a report that shows the total quantity of products ordered fewer than 200.
SELECT P.ProductName ProductName, OD.Quantity
FROM Orders O
JOIN [Order Details] OD ON O.OrderID=OD.OrderID
JOIN Employees E ON O.EmployeeID = E.EmployeeID
JOIN Products P ON OD.ProductID= P.ProductID
WHERE OD.Quantity <= 200
GROUP BY P.ProductName, OD.Quantity

--9-Create a report that shows the total number of orders by Customer since December 31, 1996 and the NumOfOrders is greater than 15. 
SELECT C.CustomerID, C.ContactName CustomerName, Count (O.OrderID) NumberOfOrders
FROM Customers C
JOIN Orders O ON C.CustomerID=O.CustomerID
WHERE O.OrderDate > '1996-12-31'
GROUP BY C.CustomerID, C.ContactName
HAVING COUNT(O.OrderID) > 15

--10-Create a report that shows the company name, order id, and total price of all products of which Northwind  has sold more than $10,000 worth.
SELECT C.CompanyName, P.ProductName, O.OrderID, SUM(OD.UnitPrice*OD.Quantity) TotalPrice
FROM Customers C 
JOIN Orders O ON C.CustomerID=O.CustomerID
JOIN [Order Details] OD ON O.OrderID=OD.OrderID
JOIN Products P ON OD.ProductID= P.ProductID
GROUP BY C.CompanyName, P.ProductName, O.OrderID
HAVING SUM(OD.UnitPrice*OD.Quantity) > 10000
