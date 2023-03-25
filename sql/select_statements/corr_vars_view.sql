go
create or alter view corr_vars 
as
-- get relevant variables to compute correlation matrix for
with corr_variables as (
select 
-- get car age in days by taking difference in current date and car sale date in standardized to utc time zones
-- convert to bigint to account for overflow to compute correlations coefficients later
convert(bigint, 
datediff (
	day, 
	sale_date at time zone 'UTC', 
	getdate() at time zone 'Eastern Standard Time' at time zone 'UTC'
	)) car_age_days, 
	condition, odometer, mmr, selling_price
from car_sales),
corr_variables_nonull as (
select * from corr_variables
where condition is not null 
and car_age_days is not null
)
select *
from corr_variables_nonull
go