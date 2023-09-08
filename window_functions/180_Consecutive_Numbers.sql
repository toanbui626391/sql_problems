/*
problem: 
    logs (id, num)
    => find all num that apprear at least 3 time consecutively
solution
    using lead, lag to 
*/
with temp as (
    select *
    , lag(num, 1) over(order by id) as lag_num
    , lead(num, 1) over(order by id) as lead_num
    from logs
)
select
distinct num as ConsecutiveNums
from temp
where num = lag_num and num =  lead_num