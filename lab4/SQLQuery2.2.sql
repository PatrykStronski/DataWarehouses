SELECT COUNT(*) FROM dimDate;
SELECT DISTINCT("year") FROM dimDate ORDER BY "year";
SELECT DISTINCT "year","month" FROM dimDate;
SELECT TOP 5 * FROM dimDate ORDER BY RAND();