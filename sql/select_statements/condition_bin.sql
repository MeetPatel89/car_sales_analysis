select *,
case
	when condition between 1 and 1.5 then '1-1.5' -- [1, 1.5]
	when condition > 1.5 and condition <= 2.0 then '1.5-2.0' -- (1.5, 2.0]
	when condition > 2.0 and condition <= 2.5 then '2.0-2.5' -- (2.0, 2.5]
	when condition > 2.5 and condition <= 3.0 then '2.5-3.0' -- (2.5, 3.0]
	when condition > 3.0 and condition <= 3.5 then '3.0-3.5' -- (3.0, 3.5]
	when condition > 3.5 and condition <= 4.0 then '3.5-4.0' -- (3.5, 4.0]
	when condition > 4.0 and condition <= 4.5 then '4.0-4.5' -- (4.0, 4.5]
	when condition > 4.5 and condition <= 5.0 then '4.5-5.0' -- (4.5, 5.0]
end condition_bins
from car_sales
order by condition_bins