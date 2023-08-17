# Write your MySQL query statement below
/*
problem:
    given table delivery: about delivery infration 
    compute percentage of immedidate delivery of the first delivery
strategy
    find first order using window function
    find immedidate order by compare between order_date and pref_delivery_date
    compute percentage of immediate order among the first order
*/

with temp as (
    select 
    *
    , row_number() over(partition by customer_id order by order_date asc) as sequence
    from delivery
)
select
round(sum(if(order_date = customer_pref_delivery_date, 1, 0)) / count(*) * 100, 2) as immediate_percentage
from temp
where sequence = 1