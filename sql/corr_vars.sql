-- get relevant variables to compute correlation matrix for
with corr_variables as (
select 
-- get car age in days by taking difference in current date and year of car in standardized to utc time zones
datediff (
	day, 
	convert(datetime, year) at time zone 'UTC', 
	getdate() at time zone 'Eastern Standard Time' at time zone 'UTC'
	) [car_age (days)], 
	condition, odometer, mmr, selling_price
from car_sales)
select * from corr_variables