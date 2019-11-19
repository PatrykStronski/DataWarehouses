USE AdventureWorks2014;

SELECT * FROM FTransaction;

SELECT * FROM SalesInfo;

DROP TABLE SalesInfo;

CREATE TABLE SalesInfo(
	TranasctionID INTEGER,
	TransactionDetailID INTEGER,
	TimeID DATE,
	CustomerID INTEGER,
	LocationID INTEGER,
	ProductID INTEGER,
	UnitPrice FLOAT,
	Quantity INTEGER,
	TotalValue FLOAT,
	UnitPriceDiscount FLOAT,
	TotalDiscountValue FLOAT,

	CONSTRAINT totalValue_nonnegative CHECK(TotalValue >= 0),
	CONSTRAINT unitpricediscount_nonnegative CHECK(UnitPriceDiscount >= 0),
	CONSTRAINT TotalDiscountValue_nonnegative CHECK(TotalDiscountValue >= 0),
	CONSTRAINT qty_nonnegative CHECK(Quantity >= 0),
--	CONSTRAINT customer_FK FOREIGN KEY(CustomerID) REFERENCES DIMIndividualCustomer(CustomerID),
--	CONSTRAINT tid FOREIGN KEY (TranasctionID) REFERENCES DIMTransaction(TransactionID),
--	CONSTRAINT tdid FOREIGN KEY (TransactionDetailID) REFERENCES DIMTransaction(TransactionDetailID),
	CONSTRAINT timeid FOREIGN KEY (TimeID) REFERENCES dimDate("date"),
);

SELECT TransactionID, TransactionDetailID, OrderDate, ft.CustomerID, dic.LocationID, ProductID, UnitPrice, OrderQty, TotalDue, UnitPriceDiscount, TotalDiscount
FROM FTransaction ft
INNER JOIN DIMIndividualCustomer dic ON dic.CustomerID = ft.CustomerID;

INSERT INTO SalesInfo
SELECT TransactionID, TransactionDetailID, OrderDate, ft.CustomerID, dic.LocationID, ProductID, UnitPrice, OrderQty, TotalDue, UnitPriceDiscount, TotalDiscount
FROM FTransaction ft
INNER JOIN DIMIndividualCustomer dic ON dic.CustomerID = ft.CustomerID;