USE AdventureWorks2014;

CREATE TABLE DIMProductRatio(
	ProductID INTEGER, 
	Rating FLOAT, 
	City VARCHAR(100), 
	Continent VARCHAR(100), 
	Gender VARCHAR(100),
	RDate DATE,
	[RYear] AS YEAR(RDate), 
	[RMonth] AS MONTH(RDate), 
	[RDay] AS DAY(RDate)
);