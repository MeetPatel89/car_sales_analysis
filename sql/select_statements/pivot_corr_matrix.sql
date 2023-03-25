-- pvioting into corr matrix
select * from temp_corr_matrix2
pivot (
	max(corr) for secondary_col in (condition,  mmr, odometer, selling_price)
) pvt_tab
order by primary_col