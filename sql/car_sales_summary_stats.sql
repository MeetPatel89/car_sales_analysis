with summary_stats as (
select top 1 'condition' col, count(condition) over () count, avg(condition) over () mean, stdev(condition) over () std,
min(condition) over () min, percentile_cont(0.25) within group (order by condition) over () first_quartile,
percentile_cont(0.5) within group (order by condition) over () [median (second_quartile)],
percentile_cont(0.75) within group (order by condition) over () third_quartile,
max(condition) over () max
from car_sales
union
-- convert odometer to bigint to account for arithmetic overflow
select top 1 'odometer' col, count(odometer) over () count, avg(convert(bigint, odometer)) over () mean, stdev(odometer) over () std,
min(odometer) over () min, percentile_cont(0.25) within group (order by odometer) over () first_quartile,
percentile_cont(0.5) within group (order by odometer) over () [median (second_quartile)],
percentile_cont(0.75) within group (order by odometer) over () third_quartile,
max(odometer) over () max
from car_sales
union
select top 1 'mmr' col, count(mmr) over () count, avg(mmr) over () mean, stdev(mmr) over () std,
min(mmr) over () min, percentile_cont(0.25) within group (order by mmr) over () first_quartile,
percentile_cont(0.5) within group (order by mmr) over () [median (second_quartile)],
percentile_cont(0.75) within group (order by mmr) over () third_quartile,
max(mmr) over () max
from car_sales
union
select top 1 'selling price' col, count(selling_price) over () count, avg(selling_price) over () mean, stdev(selling_price) over () std,
min(selling_price) over () min, percentile_cont(0.25) within group (order by selling_price) over () first_quartile,
percentile_cont(0.5) within group (order by selling_price) over () [median (second_quartile)],
percentile_cont(0.75) within group (order by selling_price) over () third_quartile,
max(selling_price) over () max
from car_sales),
derived_stats as (
select col, convert(numeric(18, 6), count) count, convert(numeric(18, 6), mean) mean, convert(numeric(18, 6), std) std, convert(numeric(18, 6), min) min,
convert(numeric(18, 6), first_quartile) first_quartile, convert(numeric(18, 6), [median (second_quartile)]) [median (second_quartile)],
convert(numeric(18, 6), third_quartile) third_quartile, convert(numeric(18, 6), max) max  from summary_stats),
unpvtStats as (
select col, stats, value from derived_stats
unpivot (value for stats in (count, mean, std, min, first_quartile, [median (second_quartile)], third_quartile, max)) tblUnPivot),
pvtStats as (
select * from unpvtStats
pivot (max(value) for col in (condition, odometer, mmr, [selling price])) pvtTbl )
select * from pvtStats