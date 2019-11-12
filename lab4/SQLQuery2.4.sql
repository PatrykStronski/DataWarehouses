---Transaction ID, TransactionDetail ID, b.OrderDate, DueDate, ShipDate –convert it to a format that will match the dimDate.
---DateID attribute formatc.Product’s surrogate key –make sure to match the correct product,d.Basic information 
--–UnitPrice, Quantity, TotalValuee.Additional Information –UnitPriceDiscount, TotalDiscountValuef.Restore necessary constraints:i.Primary Keysii.Foreign Keys –to DIMProductiii.Additional checks -if necessary

USE AdventureWorks2014;

SELECT ssoh.SalesOrderID, ssod.SalesOrderDetailID, ssod.ProductID, ssoh.OrderDate, ssoh.DueDate, ssoh.ShipDate, ssod.UnitPrice, ssod.OrderQty, ssoh.TotalDue, ssod.UnitPriceDiscount, ssod.UnitPriceDiscount * ssod.OrderQty
FROM Sales.SalesOrderHeader ssoh
INNER JOIN Sales.SalesOrderDetail ssod ON ssod.SalesOrderID = ssoh.SalesOrderID;

DROP TABLE DIMTransaction;
CREATE TABLE DIMTransaction(
	ID INTEGER PRIMARY KEY IDENTITY(1,1),
	TransactionID INTEGER NOT NULL,
	TransactionDetailID INTEGER NOT NULL,
	ProductID INTEGER NOT NULL,
	OrderDate DATE,
	DueDate DATE,
	ShipDate DATE,
	UnitPrice MONEY,
	OrderQty INTEGER,
	TotalDue Money,
	UnitPriceDiscount FLOAT,
	TotalDiscount FLOAT
);

INSERT INTO DIMTransaction(
	TransactionID,
	TransactionDetailID,
	ProductID,
	OrderDate,
	DueDate,
	ShipDate,
	UnitPrice,
	OrderQty,
	TotalDue,
	UnitPriceDiscount,
	TotalDiscount)
SELECT ssoh.SalesOrderID, ssod.SalesOrderDetailID, ssod.ProductID, ssoh.OrderDate, ssoh.DueDate, ssoh.ShipDate, ssod.UnitPrice, ssod.OrderQty, ssoh.TotalDue, ssod.UnitPriceDiscount, ssod.UnitPriceDiscount * ssod.OrderQty
FROM Sales.SalesOrderHeader ssoh
INNER JOIN Sales.SalesOrderDetail ssod ON ssod.SalesOrderID = ssoh.SalesOrderID;

SELECT * FROM DIMTransaction;