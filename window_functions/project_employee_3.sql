/*
problem:
    find employee with maximum year of experience for each project
strategy to solve problem
    1. join employee table with project table
    2. find most experience employee for each project with rank
    3. filter to keep the most experience
*/

with temp as (
    select *
    , rank() over(partition by p.project_id order by e.experience_years desc) as marker --tie will have the same rank
    from employee as e
    inner join project as p on p.employee_id = e.employee_id
)
select
project_id
,employee_id
from temp
where marker = 1