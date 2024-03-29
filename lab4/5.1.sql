USE msdb;  
GO 
-- DIMProduct
EXEC dbo.sp_add_job  
    @job_name = N'Create DIMProduct' ;  
GO  

EXEC sp_add_jobstep  
    @job_name = N'Create DIMProduct',  
    @step_name = N'Purge',  
    @subsystem = N'TSQL',  
    @command = N'DELETE FROM DIMProduct',
	@database_name = N'AdventureWorks2014',
    @retry_attempts = 5,  
    @retry_interval = 5 ;  
GO

EXEC sp_add_jobstep  
    @job_name = N'Create DIMProduct',  
    @step_name = N'Load',  
    @subsystem = N'TSQL',  
    @command = N'INSERT INTO dimProduct (productId, name, numberSold, numberInStock, subcategory, category, listPrice, color, productLine, class, weight, weightUnit, size)
SELECT pp.ProductID, pp.Name, COUNT(ppod.ProductID), SUM(COALESCE(ppi.Quantity,0)), pps.Name, ppc.Name, pp.ListPrice, pp.Color, pp.ProductLine, pp.Class, pp.Weight, pp.WeightUnitMeasureCode, pp.Size FROM Production.Product pp
INNER JOIN Production.ProductInventory ppi ON ppi.ProductID = pp.ProductID
INNER JOIN Purchasing.PurchaseOrderDetail ppod ON ppod.ProductID = pp.ProductID
INNER JOIN Production.ProductSubcategory pps ON pps.ProductSubcategoryID = pp.ProductSubcategoryID
INNER JOIN Production.ProductCategory ppc ON ppc.ProductCategoryID = pps.ProductCategoryID
GROUP BY pp.ProductID, pp.Name, pps.Name, pp.ListPrice, pp.Color, pp.ProductLine, pp.Class, pp.Weight, pp.WeightUnitMeasureCode,pp.Size, pp.SizeUnitMeasureCode,ppc.Name;',
	@database_name = N'AdventureWorks2014',
    @retry_attempts = 5,  
    @retry_interval = 5;  
GO

-- FTransaction

EXEC dbo.sp_add_job  
    @job_name = N'Create FTransaction' ;  
GO  

EXEC sp_add_jobstep  
    @job_name = N'Create FTransaction',  
    @step_name = N'Purge',  
    @subsystem = N'TSQL',  
    @command = N'DELETE FROM FTransaction',
	@database_name = N'AdventureWorks2014',
    @retry_attempts = 5,  
    @retry_interval = 5 ;  
GO

EXEC sp_add_jobstep  
    @job_name = N'Create FTransaction',  
    @step_name = N'Load',  
    @subsystem = N'TSQL',  
    @command = N'INSERT INTO FTransaction(
	TransactionID,
	CustomerID,
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
SELECT ssoh.SalesOrderID, CustomerID ,ssod.SalesOrderDetailID, ssod.ProductID, ssoh.OrderDate, ssoh.DueDate, ssoh.ShipDate, ssod.UnitPrice, ssod.OrderQty, ssoh.TotalDue, ssod.UnitPriceDiscount, ssod.UnitPriceDiscount * ssod.OrderQty
FROM Sales.SalesOrderHeader ssoh
INNER JOIN Sales.SalesOrderDetail ssod ON ssod.SalesOrderID = ssoh.SalesOrderID;
',
	@database_name = N'AdventureWorks2014',
    @retry_attempts = 5,  
    @retry_interval = 5;  
GO

-- schedule add

EXEC dbo.sp_add_schedule  
    @schedule_name = N'DIMTables',  
    @freq_type = 1,
	@freq_interval = 1,
    @active_start_time = 233000 ;  
USE msdb ;  
GO  

EXEC sp_attach_schedule  
   @job_name = N'Create FTransaction',  
   @schedule_name = N'DIMTables';  
GO  

EXEC sp_attach_schedule  
   @job_name = N'Create DIMProduct',  
   @schedule_name = N'DIMTables';  
GO  

EXEC dbo.sp_add_jobserver  
    @job_name = N'Create DIMProduct';  
GO  

EXEC dbo.sp_add_jobserver  
    @job_name = N'Create FTransaction';  
GO
