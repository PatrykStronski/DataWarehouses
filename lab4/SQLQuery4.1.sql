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

INSERT INTO DIMProductRatio(ProductID,Rating,City,Continent,Gender,RDate) SELECT 
"PID", "Rating", "Country", r.Continent, "gender", Cast("date" as datetime) 
FROM "data-l4-rating" r
INNER JOIN "data-l4-continent" c ON c.ContinentId = r.Continent;
