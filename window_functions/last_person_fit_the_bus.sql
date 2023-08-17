/*
problem:
    given table queue: describ person queue for bus
    find the last person which is fit in the bus. bus capacity 1000
strategy
    compute accumulative sum 
    choose the first data point which over the bus capacity
*/

with temp as(
    select *
    , sum(weight) over(order by turn) as acc_weight
    from queue
)
select
person_name
from temp
where acc_weight <= 1000
order by acc_weight desc
limit 1