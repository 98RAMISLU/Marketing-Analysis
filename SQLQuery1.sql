
SELECT 
	*
from dbo.products;

SELECT 
	ProductID,
	ProductName,
	Price,
	case
		when Price <50 then 'Low'
		when Price between 50 AND 200 then 'Medium'
		else 'High'
	End AS PriceCatagory
FROM 
dbo.products
