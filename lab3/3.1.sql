SELECT DISTINCT(Color) FROM ProductDetails;
SELECT DISTINCT(pd.SubCategory ) FROM ProductDetails pd;

SELECT AVG(ListPrice), SubCategory, Color
FROM ProductDetails pd
GROUP BY SubCategory, Color;

SELECT SubCategory, "Black", "Blue", "Silver", "White", "Multi", "Red", "Yellow", "Grey", "Silver/Black"
FROM (
	SELECT SubCategory, Color, ListPrice
	FROM ProductDetails
) "Slct" 
PIVOT
(
	AVG(ListPrice)
	FOR Color
	IN ("Black", "Blue", "Silver", "White", "Multi", "Red", "Yellow", "Grey", "Silver/Black")
) AS "ListPrices";

SELECT Yr, "1","2","3","4","5","6","7","8","9","10","11","12"
FROM (
	SELECT YEAR(OrderDate)  AS "Yr", MONTH(OrderDate) AS "Mnth", SubTotal
	FROM Sales.SalesOrderHeader
) qr
PIVOT (
	AVG(SubTotal)
	FOR Mnth
	IN ("1","2","3","4","5","6","7","8","9","10","11","12")
) pvt