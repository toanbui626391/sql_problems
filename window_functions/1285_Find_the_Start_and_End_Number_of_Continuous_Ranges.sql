# Write your MySQL query statement below
/*
problem
    logs (log_id)
    => report start_id, end_id of a continous range
strategy
    use row_number - sequence, cotinuous range will have the same value
*/
with temp as (
    select * 
    , row_number() over(order by log_id) as rnb
    from logs
)
select min(log_id) as start_id, max(log_id) as end_id
from temp
group by log_id - rnb