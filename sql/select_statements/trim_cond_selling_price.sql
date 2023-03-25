with filtered_sales as (
select trim, condition_bins, selling_price from condition_bins
where trim in 
('XLT', 'XL', 'Platinum', 'SVT Raptor')
and color != 'orange'),
pvt_tab as (
select * from filtered_sales
pivot
(avg(selling_price) for condition_bins in ([1-1.5], [1.5-2.0], [2.0-2.5], [2.5-3.0], [3.0-3.5], [3.5-4.0], [4.0-4.5], [4.5-5.0])) as pvt_data)
select * from pvt_tab