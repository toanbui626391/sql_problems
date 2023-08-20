/*
problemm
    cinema(seat_id, free): is seat free (1) 0 not free
    => find query all consecutive seat_id
strategy
    filter free seat
    using row_numb() window function to mark consecutive group
*/
with temp as (
    select *
    , row_number() over(order by id) as rnb
    from cinema
    where free = 1
),
temp2 as (
    select *
    , count(*) over(partition by id-rnb) as cnt
    from temp
)
select
seat_id
from temp2
where cnt >= 2
