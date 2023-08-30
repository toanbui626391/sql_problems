/*
problem
    failed (fail_date)
    succeeded (success_date)
    each date we will have record of success for fail for each talbe
    => write sql to report continuous state from 2019-01-01 to 2019-2
strategy
    use union all to combine failed and succeeded table with status
    make sequence with row_number() (partition by status order by date) as rnb1
    make sequence with row_number() (order by date) rnb2
    rnb2 - rnb1 will mark for each continuous tate
    group by rnb2-rnb2, state and compute min(date), max(date) to find start_date and end_date
*/
/*
problem:
    failed (fail_date)
    succeeded (success_date)
    => find start_date, end_date for period_state
strategy
*/
with temp as (
    select fail_date as date, "failed" as state from failed 
    union all
    select success_date as date, "succeeded" as state from succeeded
),
temp2 as (
    select *
    , row_number() over(order by date) as rnb
    , row_number() over(partition by state order by date) as rnb2
    from temp
    where date between date("2019-01-01") and date("2019-12-31")
)
select 
state as period_state
, min(date) as start_date
, max(date) as end_date
from temp2
group by rnb-rnb2, state
order by start_date