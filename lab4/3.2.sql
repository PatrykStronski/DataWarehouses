USE AdventureWorks2014;
DROP TABLE DIMSalesLocation;

CREATE TABLE  DIMSalesLocation
(
  [LocationID]   INTEGER   PRIMARY KEY, 
  [LocationName]     varchar(40),
  [Country]      varchar(40) 
);
INSERT INTO DIMSalesLocation(LocationID, LocationName, Country) 
SELECT sst.TerritoryID, sst.Name, pcr.Name
FROM Sales.SalesTerritory sst
INNER JOIN Person.CountryRegion pcr ON pcr.CountryRegionCode = sst.CountryRegionCode;