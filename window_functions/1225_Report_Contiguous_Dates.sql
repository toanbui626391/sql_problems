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