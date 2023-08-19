/*
problem
    useractivity (username, activity, startdate, endDate)
*/

with temp as (
    select *
    , row_number() over(partition by username order by endDate des) as rnb
    , count(*) over(partition by user) as cnt
    from useractivity
)
select
username
, activity
, startDate
, endDate
from temp
where rnb = 2 or cnt = 1