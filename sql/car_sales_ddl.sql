if object_id('car_sales') is not null
	drop table car_sales;
create table car_sales (
ID int identity (1,1) not null,
year char(4) not null,
make varchar(max),
model varchar(max),
trim varchar(max),
body varchar(max),
transmission varchar(max),
vin varchar(max) not null,
state varchar(max),
condition float,
odometer float,
color varchar(max),
interior varchar(max),
seller varchar(max),
mmr float,
selling_price float,
sale_date datetime,
Created datetime not null
constraint pk_car_sales_id primary key clustered (ID)
);