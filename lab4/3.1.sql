USE AdventureWorks2014;

drop table DIMIndividualCustomer;

CREATE TABLE DIMIndividualCustomer (
  [ID] INTEGER IDENTITY(1,1) PRIMARY KEY,
  CustomerID   INTEGER, 
  FirstName     varchar(100) NOT NULL,
  LastName      varchar(100) NOT NULL,
  MiddleName    varchar(100),
  Title         varchar(100),
  "Address"       varchar(100),
  PostalCode    varchar(100),
  City          varchar(100),
  Province      name,
  CountryRegionCode   varchar(100),
  LocationID INTEGER,
  "Location"    geography,
);

SELECT 
	COUNT(CustomerID) AS "number", 
	CustomerID 
FROM Sales.Customer sc 
INNER JOIN Person.Person pp ON sc.PersonID = pp.BusinessEntityID
INNER JOIN Person.BusinessEntityAddress pbea ON pbea.BusinessEntityID = pp.BusinessEntityID
INNER JOIN Person.Address pa ON pa.AddressID = pbea.AddressID
INNER JOIN Person.StateProvince psp ON psp.StateProvinceID = pa.StateProvinceID
GROUP BY CustomerID
HAVING COUNT(CustomerID) > 1;

INSERT INTO DIMIndividualCustomer(CustomerID, FirstName, LastName, MiddleName, Title, "Address", PostalCode, City, Province, psp.CountryRegionCode, LocationID ,"Location") 
  SELECT 
	CustomerID, 
	FirstName, 
	LastName, 
	MiddleName, 
	Title, 
	AddressLine1, 
	PostalCode,
	City, 
	psp.Name, 
	psp.CountryRegionCode, 
	pa.StateProvinceID,
	SpatialLocation
FROM Sales.Customer sc 
INNER JOIN Person.Person pp ON sc.PersonID = pp.BusinessEntityID
INNER JOIN Person.BusinessEntityAddress pbea ON pbea.BusinessEntityID = pp.BusinessEntityID
INNER JOIN Person.Address pa ON pa.AddressID = pbea.AddressID
INNER JOIN Person.StateProvince psp ON psp.StateProvinceID = pa.StateProvinceID;


