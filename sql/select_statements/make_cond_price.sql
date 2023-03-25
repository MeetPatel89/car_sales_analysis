-- get top 10 popular brands by make
with top10makes as (
select top 10 make from car_sales
group by make 
order by count(*) desc),
top10_sales as (
select make, condition_bins, selling_price from condition_bins a
where exists (
select * from top10makes b
where a.make = b.make))
select * from top10_sales
pivot (avg(selling_price) for condition_bins in ([1-1.5], [1.5-2.0], [2.0-2.5], [2.5-3.0], [3.0-3.5], [3.5-4.0], [4.0-4.5], [4.5-5.0])) as pivot_tab