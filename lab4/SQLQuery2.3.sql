---.Product ID,ii.Basic information –name, product number, subcategory, category, list price
---iii.Additional information –color, product line, class
--iv.Specific information –weight, size
--v.Calculated information -IsPurchasedAtleastOnce, IsManufacturedvi.Surrogate key that uniquely identifies a row within DimProduct

CREATE TABLE dimProduct(
	[productId] INTEGER PRIMARY KEY,
	[name] VARCHAR,
	[number] INTEGER,
	[subcategory] VARCHAR,
	category VARCHAR,
	listPrice FLOAT,
	color VARCHAR,
	productLine VARCHAR,
	[class] VARCHAR,
	[weight] FLOAT,
	[size] FLOAT,
	isPurchased 
	CASE
		
	END,
	isManufactured
	CASE
	END,
	CONSTRAINT pl_positive CHECK productLine > 0
);