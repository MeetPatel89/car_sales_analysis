if object_id('car_sales') is not null
	drop table car_sales;
create table car_sales (
ID int identity (1,1) not null,
year char(4) not null,
make varchar,
model varchar,
trim varchar,
body varchar,
transmission varchar,
vin varchar not null,
state varchar,
condition float,
odometer int,
color varchar,
interior varchar,
seller varchar,
mmr float,
selling_price float,
sale_date datetime,
Created datetime not null
constraint pk_car_sales_id primary key clustered (ID)
);