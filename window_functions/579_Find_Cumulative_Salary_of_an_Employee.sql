/*
problem
    employee (id, month, salary). primary key (id, month)
    => compute cummulative salary
            do not include the most recent month
            order result by id asc, month desc
solution
*/
with temp as (
    select * 
    , sum(salary) over(partition by id order by month range between 2 preceding and current row) as cum_sum
    , rank() over(partition by id order by month desc) as rnk
    from employee
)
select id, month, cum_sum as Salary
from temp
where rnk != 1
