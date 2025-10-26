create database olist;
use olist;

show variables like 'secure_file_priv';
-- we copy all csv file at C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\

create table customers(customer_id varchar(50) primary key,
	customer_unique_id varchar(50),
	customer_zip_code_prefix int,
	customer_city varchar(50),
	customer_state varchar(50));

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customers.csv"
into table customers
fields terminated by','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;



create table products(product_id varchar(50) primary key,
	product_category_name varchar(50),
	product_name_length varchar(50),
	product_description_length varchar(50),
	product_photos_qty varchar(50),
	product_weight_g varchar(50),
	product_length_cm varchar(50),
	product_height_cm varchar(50),
	product_width_cm varchar(50));


load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/products.csv"
into table products
fields terminated by','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;



create table orders(order_id varchar(50) primary key,
	customer_id varchar(50),
	order_status varchar(50),
	order_purchase_timestamp varchar(50),
	order_approved_at varchar(50),
	order_delivered_carrier_date varchar(50),
	order_delivered_customer_date varchar(50),
	order_estimated_delivery_date varchar(50),
    foreign key (customer_id) references customers(customer_id));


load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/orders.csv"
into table orders
fields terminated by','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;



create table items(order_id varchar(50),
	order_item_id int,
	product_id varchar(50),
	seller_id varchar(50),
	shipping_limit_date datetime,
	price float,
	freight_value float,
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id)
	);


load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/order_items.csv"
into table items
fields terminated by','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;


create table payments(order_id varchar(50),
	payment_sequential int,
	payment_type varchar(50),
	payment_installments int,
	payment_value float,
    foreign key (order_id) references orders(order_id));


load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/order_payments.csv"
into table payments
fields terminated by','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;



create table products_trans(
product_category_name varchar(50),
product_category_name_english varchar(50));


load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/product_category_name_translation.csv"
into table products_trans
fields terminated by','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

create table reviews(review_id varchar(50),
order_id varchar(60),
review_score int,
review_creation_date varchar(50),
review_answer_timestamp	varchar(50),
foreign key (order_id) references orders(order_id) );


load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/reviews.csv"
into table reviews	
fields terminated by','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;


create table geolocation(geolocation_zip_code_prefix int,
geo_lat float,
geo_long float,
geolocation_city varchar(50),
geolocation_state varchar(50));


load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/geolocation.csv"
into table geolocation	
fields terminated by','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

create table geolocation1 as(    
	with geo as(  
	select *, row_number() over (partition by geolocation_zip_code_prefix order by geolocation_zip_code_prefix) as rnk from geolocation
	)
	select geolocation_zip_code_prefix,geo_lat,geo_long,geolocation_city,geolocation_state from geo
	where rnk=1);	


alter table products
add column product_category_name_english varchar(50);

update products p
left join products_trans pt
on p.product_category_name=pt.product_category_name
set p.product_category_name_english=pt.product_category_name_english;


/*to export resulted query
	QUERY
	INTO OUTFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/result.csv"
	FIELDS TERMINATED BY ',' 
	ENCLOSED BY '"'
	LINES TERMINATED BY '\n';
*/


create table full_dataset as (
select 
	i.order_id, 
    i.product_id, 
    pr.product_category_name_english,
    r.review_score,
    i.seller_id,
    i.price,
    i.freight_value,
    o.order_status,
    c.customer_id,
    c.customer_zip_code_prefix,
    g.geo_lat,
    g.geo_long,
    c.customer_state,
    pa.payment_type,
	pa.payment_value,
    i.shipping_limit_date,
    o.order_purchase_timestamp,
	o.order_approved_at,
	o.order_delivered_carrier_date,
	o.order_delivered_customer_date,
	o.order_estimated_delivery_date
from items i 
	inner join orders o on i.order_id=o.order_id
    inner join products pr on i.product_id=pr.product_id
	inner join customers c on o.customer_id=c.customer_id
	inner join reviews r on o.order_id=r.order_id
    inner join payments pa on o.order_id=pa.order_id
    inner join geolocation1 g on c.customer_zip_code_prefix=g.geolocation_zip_code_prefix);



create table sellers(seller_id	varchar(50) primary key,
seller_zip_code_prefix int,
seller_city varchar(50),	
seller_state varchar(50)
);


load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sellers.csv"
into table sellers	
fields terminated by','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

alter table items
add foreign key (seller_id) references sellers(seller_id);


alter table full_dataset
add column seller_state varchar(50);

update full_dataset f
left join sellers s
on f.seller_id=s.seller_id
set f.seller_state=s.seller_state;


select * from full_dataset
	INTO OUTFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_complete.csv"
	FIELDS TERMINATED BY ',' 
	ENCLOSED BY '"'
	LINES TERMINATED BY '\n';	

describe full_dataset;