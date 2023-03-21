declare @out_param decimal(9, 6) 
exec car_sales.dbo.get_corr_coeff 
		@x = ?, 
		@y = ?, 
		@tablename = ?,
		@outvar = @out_param output