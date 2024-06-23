# Write your MySQL query statement below
/*
problem
    cinema (seat_id, free)
    => find seat which is consecutive free
        => order result seat_id asc
strategy
    mark consecutive using window function
    filter to get result
*/
with temp as (
    select *
    , row_number() over(order by seat_id) as rnb
    from cinema
    where free = 1
),
temp2 as (
    select *
    , count(*) over(partition by seat_id-rnb) as cnt
    from temp
)
select seat_id
from temp2
where cnt >= 2
order by seat_id asc