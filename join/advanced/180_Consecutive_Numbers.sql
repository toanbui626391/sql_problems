# Write your MySQL query statement below
/*
problem:
    logs (id, num). id is auto increse 
    => list num which apprear at least 3 time consecutively
strategy
    filter row which mark 3 consecutive id with lead and lag
*/
with temp as (
    select *
    , lag(num) over(order by id) as num_lag
    , lead(num) over(order by id) as num_lead
    from logs
)
select 
distinct num as ConsecutiveNums
from temp
where num = num_lag and num = num_lead