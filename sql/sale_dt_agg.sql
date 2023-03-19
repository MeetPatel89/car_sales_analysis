with sale_dt_diff_to_mmr as (
-- account for specific time zone in sale_date
select sale_date at time zone 'Pacific Standard Time' sale_date, 
selling_price - mmr diff_to_mmr
from car_sales
where model = 'F-150'
and trim = 'XLT'
and state = 'ut'
and condition >= 3.5)
select sale_date, avg(diff_to_mmr) mean_diff_to_mmr, count(*) auto_count from sale_dt_diff_to_mmr
group by sale_date
order by auto_count desc