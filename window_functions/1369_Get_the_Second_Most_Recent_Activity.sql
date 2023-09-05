/*
problem
    useractivity (username, activity, startDate, endDate)
    => find the second most recent activity
        if have only one record recent that
strategy
    using dense_rank to mark the second most recent activity
    using count to count number of activity by eadh user name
*/
with temp as (
    select *
    , dense_rank() over(partition by username order by startDate desc) as rnk
    , count(*) over(partition by username) as cnt
    from useractivity
)
select username, activity, startDate, endDate
from temp
where rnk=2 or cnt=1