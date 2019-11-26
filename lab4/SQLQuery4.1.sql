USE AdventureWorks2014;
DROP TABLE DIMProductRatio
CREATE TABLE DIMProductRatio(
	ProductID INTEGER, 
	Rating FLOAT, 
	Country VARCHAR(100), 
	Continent VARCHAR(100), 
	Gender VARCHAR(100),
	RDate VARCHAR(11),
	[RYear] INTEGER, 
	[RMonth] INTEGER, 
	[RDay] INTEGER
);

SELECT "date" FROM "data-l4-rating";

INSERT INTO DIMProductRatio(ProductID,Rating,Country,Continent,Gender,RDate,RYear,RMonth,RDay) SELECT 
r.PID, r.Rating, r.Country, c.Continent, r.gender, dd.Style101,dd.year,dd.month,dd.day
FROM "data-l4-rating" r
INNER JOIN "data-l4-continent" c ON c.ContinentId = r.Continent
INNER JOIN dimDate dd ON dd.Style101 = r.Date;
