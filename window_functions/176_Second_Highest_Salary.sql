# Write your MySQL query statement below
/*
problem:
    employee (id, salary): salary for each employee
    => find second highest salary if not return non
strategy
    using dense_rank because dense_rank will not left missing rank
    use max because we will return only on value and if it is empty we have to return null
*/
with temp as (
  select *
  , dense_rank() over(order by salary desc) as drnk
  from employee
)
select max(salary) as SecondHighestSalary
from temp
where drnk = 2