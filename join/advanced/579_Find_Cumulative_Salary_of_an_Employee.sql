/*
problem
    employee (id, month, salary)
    for each employee id compute cummulative salary with period of 3 month but exclude the last recent month
strategy
    compute running sum salary for each employee
    filter to get result
*/
with temp as (
    select *
    , sum(salary) over(partition by id order by month desc row between 2 peceding and current row) as running_sum
    , row_number() over(partition by id order by month desc) as rnb
    from employee
)
select
Id
, Month
, running_sum as salary
from temp
where month > 1
order by id, Month desc
