select 
	*
from dbo.customer_journey

with duplicateRow as (
select 
	JourneyID,
	CustomerID,
	ProductID,
	VisitDate,
	Stage,
	ROW_NUMBER() over(partition by CustomerID,
	ProductID,
	VisitDate,Stage 
	order by JourneyID
	) as dp
from dbo.customer_journey
)
select 
 *
FROM duplicateRow 
where dp  > 1




select 
	JourneyID,
	CustomerID,
	ProductID,
	VisitDate,
	Action,
	coalesce(Duration,avg_duration) as Duration
from (
	select 
		JourneyID,
		CustomerID,
		ProductID,
		VisitDate,
		upper(Stage) as Stage,
		Action,
		Duration,
		AVG(Duration) over(partition by VisitDate) as avg_duration,
		ROW_NUMBER() over(partition by CustomerID,
		ProductID,
		VisitDate,upper(Stage), Action
		order by JourneyID
		) as dp
	from dbo.customer_journey
) as subquery
where dp = 1
