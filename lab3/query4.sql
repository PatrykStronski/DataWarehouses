SELECT * FROM ProductDetails;

SELECT ListPrice, ProductName,
CASE
	WHEN ListPrice < 20.00 THEN 'Inexpensive'
	WHEN ( ListPrice >= 20.00 AND ListPrice < 75.00) THEN 'Regular'
	WHEN (ListPrice >= 75.00 AND ListPrice < 750.0) THEN 'high'
	WHEN ListPrice >=750.0 THEN 'EXPENSIVE'
	ELSE 'Error'
END AS "Cat"
FROM ProductDetails;

--- lb= 0.45 kg g = 0.001kg

SELECT ProductName,
CASE 
	WHEN (Weight IS NOT NULL AND WeightUnitMeasureCode = 'LB') THEN Weight*0.45
	WHEN (Weight IS NOT NULL AND WeightUnitMeasureCode = 'G') THEN Weight*0.001
	WHEN Weight IS NULL THEN -1
	ELSE 'Err'
END AS "Weight in kilograms"
FROM ProductDetails;

SELECT DISTINCT(YEAR(OrderDate)) FROM Details2;

SELECT Color, "2011", "2012", "2013", "2014"
FROM (
	SELECT Color, YEAR(OrderDate) AS "yr", ProductID
	FROM Details2
) qr
PIVOT (
	COUNT(ProductID)
	FOR "yr"
	IN ("2011", "2012", "2013", "2014")
) pvt

SELECT Color, 
	SUM(CASE WHEN YEAR(OrderDate)='2011' THEN 1 ELSE 0 END) AS "2011", 
	SUM(CASE WHEN YEAR(OrderDate)='2012' THEN 1 ELSE 0 END) AS "2012", 
	SUM(CASE WHEN YEAR(OrderDate)='2013' THEN 1 ELSE 0 END) AS "2013", 
	SUM(CASE WHEN YEAR(OrderDate)='2014' THEN 1 ELSE 0 END) AS "2014"
FROM Details2
GROUP BY Color;
