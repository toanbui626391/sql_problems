# Write your MySQL query statement below
/*
problem:
    sales (sale_id, product_id, year, quantity, price). primary key is sale_id+year
    product (product_id, name)
    => first year sale for each product
solution
    mark first year sale for each product 
    filter to get result
note: 
    using rank instead of row_number because product_id is not primary key and we can have duplicate data point with key (product_id+year)
*/
with temp as (
    select *
    , rank() over(partition by product_id order by year) as rnb
    from sales
)
select
product_id
, year as first_year
, quantity as quantity
, price as price
from temp
where rnb = 1

