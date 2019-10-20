--TASK 1-1b
SELECT COUNT(SalesOrderID) as 'Sales Amount',SUM(SubTotal)as 'Volume', MONTH(OrderDate) as 'Month',YEAR(OrderDate) as 'Year'
FROM Sales.SalesOrderHeader
GROUP BY MONTH(OrderDate), YEAR(OrderDate)
ORDER BY MONTH(OrderDate) ASC,YEAR(OrderDate)
--TASK 1-2d
SELECT p.FirstName+' '+p.LastName as 'NAME',SUM(h.SubTotal)as 'TOTAL SUM' 
FROM Sales.SalesOrderHeader as h,Sales.Customer AS c,Person. Person as p
WHERE c.CustomerID=h.CustomerID and p.BusinessEntityID=c.PersonID 
GROUP BY  p.FirstName+' '+p.LastName
HAVING sum(h.SubTotal)>1500
ORDER BY SUM(h.SubTotal) DESC
--TASK 1-3a
SELECT UnitPrice / OrderQty as 'AVERAGE PRICE',AVG(OrderQty) as 'SALES AMOUNT',sum(LineTotal) AS 'VOLUME'
FROM Sales.SalesOrderDetail
GROUP BY ProductID,UnitPrice,OrderQty
ORDER BY ProductID
--TASK 1-4d
select Name,Color
from Production.Product
Group by Color,Name
select Name,