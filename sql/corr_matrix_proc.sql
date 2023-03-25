-- the big stored procedure to compute correlation matrix for given columns array and table array
create or alter procedure get_corr_matrix (
	@json_var as nvarchar(max)
)
as
begin

	set nocount on

	if object_id('temp_corr_matrix') is not null
		drop table temp_corr_matrix

	select *
	into temp_corr_matrix
	from openjson(@json_var)
		with(
			cols nvarchar(max) '$.cols' as json,
			table_name nvarchar(128) '$.table'
		)
	outer apply openjson(cols)
	with (col nvarchar(128) '$');

	alter table temp_corr_matrix
	add row_id int identity(1, 1) primary key not null

	declare @table_var table (
		primary_col nvarchar(128),
		secondary_col nvarchar(128),
		corr decimal(9, 6)
	)

	declare	@table_name nvarchar(128),
			@out_param decimal(9, 6),
			@outer_length int,
			@length int,
			@inner_counter int,
			@outer_counter int,
			@primary_var nvarchar(128),
			@secondary_var nvarchar(128)
	--select * from temp_corr_matrix
	select @table_name = table_name from temp_corr_matrix
	select @length = count(col) from temp_corr_matrix
	set @outer_counter = 1
	
	while @outer_counter <= @length 
		begin
			select @primary_var = col from temp_corr_matrix
			where row_id = @outer_counter
			
			set	@inner_counter = 1
			while @inner_counter <= @length 
				begin
					
					select @secondary_var = col from temp_corr_matrix
					where row_id = @inner_counter 

					exec car_sales.dbo.get_corr_coeff 
						@x = @primary_var, 
						@y = @secondary_var, 
						@tablename = @table_name,
						@outvar = @out_param output

					insert into @table_var
					(primary_col, secondary_col, corr)
					values
					(@primary_var, @secondary_var, @out_param)

					set @inner_counter = @inner_counter + 1
				
				end
			
			set @outer_counter = @outer_counter + 1
			
			if @outer_counter > @length
				begin				
					
                    if object_id('temp_corr_matrix2') is not null
                        drop table temp_corr_matrix2
					select *
					into temp_corr_matrix2
					from @table_var
                    
				end
		end
end