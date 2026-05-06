select 
	c.CustomerID,
	c.CustomerName,
	c.Email,
	c.Gender,
	g.City,
	g.Country
from dbo.customers as c
inner join dbo.geography as g on  c.GeographyID = g.GeographyID 

