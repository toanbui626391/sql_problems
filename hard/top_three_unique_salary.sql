/*
problem: 185. Department Top Three Salaries
    find top three unique salary for each department (dense_rank)
learning:
  using dense_rank() window function
    asc smaller value will get rank first
    desc larger value will get rank first
*/
-- mark top 3 unique salary for each department
with temp as (
    select d.name as Department
    , e.name as Employee
    , e.salary as Salary
    , dense_rank() over(partition by e.departmentId order by e.salary desc) as rnk
    from Employee as e
    left join Department as d
    on e.departmentId = d.id
)
select Department
, Employee
, Salary
from temp
where rnk <= 3