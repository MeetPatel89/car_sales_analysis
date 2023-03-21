 create or alter procedure get_corr_coeff(
	@x nvarchar(128),
	@y nvarchar(128),
	@tablename nvarchar(128),
	@outvar decimal(9, 6)
 )
 as
 begin
	
	if object_id('temp_corr_temp') is not null
		drop table temp_corr;

	declare @sqlquery1 nvarchar(max),
			@sqlquery2 nvarchar(max),
			@param_def nvarchar(128)

	set @sqlquery1 = concat(N'select ', @x, ' as col1, ', @y, ' as col2', ' into temp_corr_temp from ', quotename(@tablename))
	
	exec sp_executesql @sqlquery1;

	set @sqlquery2 = N'select (sum(col1*col2) - (sum(col1)*sum(col2))/count(*)) / (sqrt(sum(col1*col1) - (sum(col1)*sum(col1))/count(*))*sqrt(sum(col2*col2) - (sum(col2)*sum(col2))/count(*))) from temp_corr_temp
	where col1 is not null
	and col2 is not null'
	set @param_def = N'@outvar decimal(9, 6)'

	exec sp_executesql @sqlquery2, @param_def, @outvar = @outvar
	
	return @outvar

 end;