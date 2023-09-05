/*
problem
    customer (custotmer_id, name, visited_on, amount): how much customer spend on visited date
    => compute moving average for 7 day
            order sult by visited_on asc
strategy
    using window function with frame clause to compute moving average
*/
#do not use avg to calculate running average
with temp as (
    select * 
    , sum(amount) over(order by visited_on range between interval 6 day preceding and current row) as total_amount
    from customer
)
select distinct visited_on
, total_amount as amount
, round(total_amount/7, 2) as average_amount
from temp
where visited_on >= (
    select date_add(min(visited_on), interval 6 day) from customer
)
order by visited_on asc