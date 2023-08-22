/*
problem
    traffic (user_id, activity, activity_date). no primary key
    => user login for the first time for each date in the last 90 days
strategy
    filter activity_date and action_type
    use window function row_number() to mark first time login in for each user
    filter first time logine
    aggregate over activity_date to get result
note:
    we want to compute number of first time login for each date, or new user
*/
set @today = date("2019-06-30")
with temp as (
    select *
    -- we only care about first time logged in
    , row_number() over(partition by user_id order by activity_date) as rnb
    from traffic
    where activity = "login"
    and activity_date between @today and date_add(@today, interval 6 day)

)
select
activity_date as login_date
, count(*) as user_count
from temp
where rnb = 1
group by activity_date
