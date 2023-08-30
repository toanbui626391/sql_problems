/*
problem
    products (product_id, new_price, change_date): change price of product
    => find price of all product on 2019-08-16
strategy
    find the last change price before 2019-08-16
*/
with temp as (
    select distinct product_id from products
),
temp2 as (
    select * 
    , row_number() over(partition by product_id order by change_date desc) as rnb
    from products
    where change_date <= date("2019-08-16")
)
select 
t1.product_id as product_id
, ifnull(t2.new_price, 10) as price
from temp as t1
left join temp2 as t2 on t1.product_id = t2.product_id
where t2.rnb = 1 or t2.rnb is null

