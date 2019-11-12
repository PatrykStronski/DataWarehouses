USE AdventureWorks2014;

SELECT SUM(TotalDue) AS "income", SUM(numberSold) AS "Number Sold", d.year FROM DIMTransaction t
INNER JOIN dimDate d ON t.OrderDate = d.date
INNER JOIN dimProduct p ON p.productId = t.ProductID
GROUP BY d.year
ORDER BY d.year;

SELECT TOP 1 p.category, SUM(t.TotalDue) AS "Best Selling in VALUE" FROM DIMTransaction t
INNER JOIN dimProduct p ON p.productId = t.ProductID
GROUP BY p.category
ORDER BY SUM(t.TotalDue);
SELECT TOP 1 p.category, SUM(t.OrderQty) AS "Best Selling in Quantity" FROM DIMTransaction t
INNER JOIN dimProduct p ON p.productId = t.ProductID
GROUP BY p.category
ORDER BY SUM(t.OrderQty);

SELECT TOP 1 p.color, SUM(t.TotalDue) AS "Best Selling on weekends in VALUE" FROM DIMTransaction t
INNER JOIN dimProduct p ON p.productId = t.ProductID
INNER JOIN dimDate d ON t.OrderDate = d.date
WHERE d.isWeekend = 1
GROUP BY p.color
ORDER BY SUM(t.TotalDue);
SELECT TOP 1 p.color, SUM(t.OrderQty) AS "Best Selling on weekends in Quantity" FROM DIMTransaction t
INNER JOIN dimProduct p ON p.productId = t.ProductID
INNER JOIN dimDate d ON t.OrderDate = d.date
WHERE d.isWeekend = 1
GROUP BY p.color
ORDER BY SUM(t.OrderQty);

SELECT p.category, AVG(p.listPrice) AS "AVG price", AVG(t.totalDiscount) AS "AVG discount" FROM DIMTransaction t
INNER JOIN dimProduct p ON p.productId = t.ProductID
WHERE p.isManufactured = 1 AND p.isPurchased = 1
GROUP BY p.category;

SELECT p.subcategory , AVG(DATEDIFF(day,t.OrderDate,t.ShipDate)) AS "avg time to ship" FROM DIMTransaction t
INNER JOIN dimProduct p ON p.productId = t.ProductID
GROUP BY p.subcategory;