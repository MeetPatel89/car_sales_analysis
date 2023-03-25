declare @out_param decimal(9, 6) 
exec car_sales.dbo.get_corr_coeff 
		@x = ?, 
		@y = ?, 
		@tablename = ?,
		@outvar = @out_param output
select (@out_param) as corr_coeff