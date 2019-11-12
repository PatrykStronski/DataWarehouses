---.Product ID,ii.Basic information –name, product number, subcategory, category, list price
---iii.Additional information –color, product line, class
--iv.Specific information –weight, size
--v.Calculated information -IsPurchasedAtleastOnce, IsManufacturedvi.Surrogate key that uniquely identifies a row within DimProduct
USE AdventureWorks2014;

SELECT pp.ProductID, pp.Name, COUNT(ppod.ProductID), SUM(COALESCE(ppi.Quantity,0)), pps.Name, ppc.Name, pp.ListPrice, pp.Color, pp.ProductLine, pp.Class, pp.Weight, pp.WeightUnitMeasureCode, pp.Size FROM Production.Product pp
INNER JOIN Production.ProductInventory ppi ON ppi.ProductID = pp.ProductID
INNER JOIN Purchasing.PurchaseOrderDetail ppod ON ppod.ProductID = pp.ProductID
INNER JOIN Production.ProductSubcategory pps ON pps.ProductSubcategoryID = pp.ProductSubcategoryID
INNER JOIN Production.ProductCategory ppc ON ppc.ProductCategoryID = pps.ProductCategoryID
GROUP BY pp.ProductID, pp.Name, pps.Name, pp.ListPrice, pp.Color, pp.ProductLine, pp.Class, pp.Weight, pp.WeightUnitMeasureCode,pp.Size, pp.SizeUnitMeasureCode,ppc.Name;

DROP TABLE dimProduct;
CREATE TABLE dimProduct(
	[productId] INTEGER PRIMARY KEY,
	[name] VARCHAR(60),
	[numberSold] INTEGER,
	[numberInStock] INTEGER,
	[subcategory] VARCHAR(40),
	category VARCHAR(40),
	listPrice FLOAT,
	color VARCHAR(20),
	productLine VARCHAR(20),
	[class] VARCHAR(20),
	[weight] FLOAT,
	[weightUnit] VARCHAR(10),
	[size] VARCHAR(10),
	isPurchased AS
	CASE
		WHEN numberSold > 0 THEN 1
		WHEN numberSold = 0 THEN 0
	END,
	isManufactured AS
	CASE
		WHEN numberInStock > 0 THEN 1
		WHEN numberInStock = 0 THEN 0
	END,
);

INSERT INTO dimProduct (productId, name, numberSold, numberInStock, subcategory, category, listPrice, color, productLine, class, weight, weightUnit, size)
SELECT pp.ProductID, pp.Name, COUNT(ppod.ProductID), SUM(COALESCE(ppi.Quantity,0)), pps.Name, ppc.Name, pp.ListPrice, pp.Color, pp.ProductLine, pp.Class, pp.Weight, pp.WeightUnitMeasureCode, pp.Size FROM Production.Product pp
INNER JOIN Production.ProductInventory ppi ON ppi.ProductID = pp.ProductID
INNER JOIN Purchasing.PurchaseOrderDetail ppod ON ppod.ProductID = pp.ProductID
INNER JOIN Production.ProductSubcategory pps ON pps.ProductSubcategoryID = pp.ProductSubcategoryID
INNER JOIN Production.ProductCategory ppc ON ppc.ProductCategoryID = pps.ProductCategoryID
GROUP BY pp.ProductID, pp.Name, pps.Name, pp.ListPrice, pp.Color, pp.ProductLine, pp.Class, pp.Weight, pp.WeightUnitMeasureCode,pp.Size, pp.SizeUnitMeasureCode,ppc.Name;
