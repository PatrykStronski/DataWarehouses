SELECT TOP 1 category, Rating, COUNT (dp.ProductID)
FROM dimProduct dp
INNER JOIN DIMProductRatio dpr ON dpr.ProductID =  dp.productId
GROUP BY category, Rating
ORDER BY COUNT(dp.ProductID);