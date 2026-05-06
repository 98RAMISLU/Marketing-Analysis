select 
	*
from dbo.engagement_data


select 
	EngagementID,
	ContentID,
	ProductID,
	UPPER(replace(ContentType,'Socialmedia', 'Social Media')) as Content_Type,
	Likes,
	CampaignID,
	LEFT(ViewsClicksCombined,CHARINDEX('-',ViewsClicksCombined) - 1 ) AS VIEWS,
	RIGHT(ViewsClicksCombined,len(ViewsClicksCombined) - CHARINDEX('-',ViewsClicksCombined)) as clicks,
	FORMAT(CONVERT(DATE,EngagementDate),'dd-MM-yyyy') as EngagementDate
from dbo.engagement_data
where ContentType != 'NEWSLETTER'

