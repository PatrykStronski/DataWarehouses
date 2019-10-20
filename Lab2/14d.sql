SELECT Product.name FROM Product p WHERE p.Color IS NOT NULL;
SELECT Product.name FROM Product p WHERE p.Color IS NOT NULL OR p.Weight IS NOT NULL;
SELECT Product.name FROM Product p WHERE p.Size IS NOT NULL AND p.Weight IS NOT NULL;
