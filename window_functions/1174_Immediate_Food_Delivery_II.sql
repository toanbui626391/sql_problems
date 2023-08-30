/*
problem
    delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date)
    => find the percentage of immedidate order in the first order
strategy
    using window function to mark first order of each customer
    mark first order which is also immedidate
*/
with temp as (
    select *
    , row_number() over(partition by customer_id order by order_date) as rnb
    from delivery
)
select 
round(sum(if(order_date = customer_pref_delivery_date, 1, 0)) / count(*) * 100, 2) as immediate_percentage
from temp
where rnb = 1