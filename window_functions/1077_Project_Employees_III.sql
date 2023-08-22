/*
problem
    project (project_id, employee_id): emmployee in project. primary key (project_id + employee_id)
    employee (employee_id, name, experience_year): employee. primary key is employee_id
    => filter most experience employee for each project
        tie choose all
strategy
    join to get years
    using rank() window function to mark most experience for each project
    filter
*/
with temp as (
    select *
    , rank() over(partition by p.project_id order by e.year desc) as rnk
    from project as p
    left join employee as e on p.employee_id = e.employee_id
)
select
project_id
, employee_id
from temp
where rnk = 1