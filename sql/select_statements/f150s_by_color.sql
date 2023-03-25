with diff_to_mmr_comp as (
select color, 
selling_price - mmr as diff_to_mmr
from car_sales
where model = 'F-150'
and color is not null
and color != '—')
select color, avg(diff_to_mmr) diff_to_mmr
from diff_to_mmr_comp
group by color