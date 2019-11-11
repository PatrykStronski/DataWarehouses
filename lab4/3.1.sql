drop view DIMIndividualCustomer
CREATE TABLE DIMIndividualCustomer
(
  [Customer ID]   varchar(50)   PRIMARY KEY, 
  [FirstName]     varchar(40),
  [LastName]      varchar(40),
  [MiddleName]    varchar(40),
  [Title]         varchar(40),
  [Address]       varchar(40),
  [PostalCode]    varchar(40),
  [City]          varchar(40),
  [Province]      varchar(40),
  [CountryCode]   varchar(40),
  [Region]        varchar(40),
  [Geographic area name]    varchar(100),
  
);
INSERT into DIMIndividualCustomer 
  SELECT CustomerID, FirstName, LastName, MiddleName, Title, AddressLine1, PostalCode,
  City, StateProvince.Name ,CountryRegion.CountryRegionCode, CountryRegion.Name ,
  SpatialLocation
FROM Sales.Customer, Person.Person, Person.Address, Person.StateProvince,person.CountryRegion
WHERE Person.rowguid=Customer.rowguid and Person.rowguid=Address.rowguid 
and Person.rowguid=StateProvince.rowguid
