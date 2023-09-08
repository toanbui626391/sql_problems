# Write your MySQL query statement below
/*
problem
    employee (id, name, salary, departmentId). primary key id
    department (id, name). primary key id
    => find employee who have the highest salary for each department
strategy
    using rank
    filter
*/
with temp as (
    select 
    d.name as Department
    , e.name as Employee
    , e.salary as Salary
    , rank() over(partition by d.id order by e.salary desc) as rnk
    from employee as e
    left join department as d on e.departmentId = d.id
)
select Department, Employee, Salary
from temp
where rnk = 1