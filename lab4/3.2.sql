CREATE TABLE  DIMSalesLocation
(
  [Location ID]   varchar(50)   PRIMARY KEY, 
  [Name]     varchar(40),
  [CountryName]      varchar(40),
  [geographic area Name]    varchar(40)  
);
INSERT into  DIMSalesLocation 
SELECT LocationID,Location.Name,CountryRegion.Name,SalesTerritory.[Group]
FROM Production.Location,person.StateProvince,Person.CountryRegion,Sales.SalesTerritory
WHERE Production.Location.LocationID=Person.StateProvince.StateProvinceID and Person.CountryRegion.CountryRegionCode=Person.StateProvince.CountryRegionCode and
StateProvince.TerritoryID=Sales.SalesTerritory.TerritoryID