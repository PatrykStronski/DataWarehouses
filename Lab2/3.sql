USE AdventureWorks2014;

CREATE VIEW BasicSales 
AS SELECT
sod.ProductID, 
soh.CustomerID,
DAY(soh.OrderDate) AS "OrderDay", 
MONTH(soh.OrderDate) AS "OrderMonth", 
YEAR(soh.OrderDate) AS "OrderYear", 
soh.TotalDue, 
sod.OrderQty
FROM Sales.SalesOrderDetail sod INNER JOIN
Sales.SalesOrderHeader soh ON soh.SalesOrderID = sod.SalesOrderID;


---  customer id, name, middle name, last name, type 

CREATE VIEW CustomerDetails
AS SELECT
p.BusinessEntityID, p.FirstName, p.MiddleName, p.LastName, p.PersonType
FROM Person.Person p INNER JOIN Sales.Customer c ON p.BusinessEntityID = c.PersonID;

---  product id, product name, category, subcategory, price, color, weight, units. 
CREATE VIEW ProductDetails
AS SELECT
p.ProductID AS "ProductIdDetails", p.Name AS "ProductName", pm.Name AS "Model", ps.Name AS "SubCategory", p.ListPrice, p.Color, p.Weight, p.SizeUnitMeasureCode, p.WeightUnitMeasureCode
FROM Production.Product p INNER JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
INNER JOIN Production.ProductModel pm ON pm.ProductModelID = p.ProductModelID;

CREATE VIEW Details
AS SELECT *
FROM BasicSales bs INNER JOIN ProductDetails pd ON bs.ProductID = pd.ProductIDDetails
INNER JOIN CustomerDetails cd ON cd.BusinessEntityID = bs.CustomerID;
