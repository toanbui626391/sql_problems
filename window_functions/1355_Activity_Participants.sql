/*
problem
    friends (id, name, activity)
    activity (id, name)
    => find activity which is not max or min participant
strategy
    aggregate to compute number of participant
    compare to find which is not min and max
*/
with temp as (
    select 
    activity
    , count(*) as cnt
    from friends
    group by activity
),
temp2 as (
    select 
    activity
    , rank() over(order by cnt desc) as rnk_desc
    , rank() over(order by cnt) as rnk_asc
    from temp
)
select activity 
from temp2
where rnk_desc != 1 and rnk_asc != 1
