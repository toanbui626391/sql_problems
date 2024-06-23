/*
problem
    stadium (id, visit_date, people). visit_date is unique. number of people visit the stadium
    => fin dates which have 3 or more date which have more than 100 people
solution
    mark condition
        3 or more consecutive id
        greater than or equal 100 people
    filter
    order by visit_date
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
select id, visit_date, people
from temp2
where cnt >= 3
order by visit_date
