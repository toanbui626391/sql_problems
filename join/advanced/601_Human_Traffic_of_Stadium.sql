/*
problem
    stadium (id, event_date, people): number of people visit stadium each date
    => find event_date which three or more consecutive id. and people more greater than or equal 100. order visit_date asc
strategy
    filter all day people >= 100
    using window function to find consecutive date
    count() to compute number of date in that consecutive group
*/
with temp as (
    select *
    , row_number() over(order by id) as rnb
    from stadium
    where people >= 100
),
temp2 as (
    select *
    , count(*) over(partition by id-rnb) as cnt
    from temp
)
select id
, visit_date
, people
from temp2
where cnt >= 3
order by visit_date asc

