use EDFacts_Tableau

--Forgot to add this
--And then I need to add this
; with cte as (
select top 100 sch.File_Record_Number RecNum, 
	sch.School_Address_Location_1 + ',' + sch.School_City_Location + ',' + sch.School_USPS_State_Abbreviation_Location+ ',' + sch.School_ZIP_Code_Location Physical_Address,
	sch.School_City_Location + ',' + sch.School_USPS_State_Abbreviation_Location+ ',' + sch.School_ZIP_Code_Location Physical_Address_City
from dbo.S029_SCH sch
where sch.Latitude is null
)
update dbo.S029_SCH
set Latitude = d.Latitude, Longitude=d.Longtitude, SpatialPoint=d.SpatialPoint
--select c.*, d.*
from cte c
	inner join dbo.S029_SCH sch on c.RecNum=sch.File_Record_Number
	cross apply dbo.fn_GetLongLat(c.Physical_Address) d 
	
