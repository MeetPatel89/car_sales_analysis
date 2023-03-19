with state_diff_to_mmr as (
select state,
selling_price - mmr diff_to_mmr
from car_sales
where model = 'F-150'
and trim = 'XLT'
and condition >= 3.5)
select state, avg(diff_to_mmr) mean_diff_to_mmr, count(*) auto_count from state_diff_to_mmr
group by state