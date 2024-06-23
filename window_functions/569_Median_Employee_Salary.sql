/*
problem
    employee (id, company, salary). primary key: id
    => find row that contain median salary of each company
solution
    if event median is cnt/2 + 1
    if odd median is cnt/2 and cnt/2 + 1
*/
with temp as (
    select *
    , rank() over(partition by company order by salary, id) as rnk
    , count(*) over(partition by company) as cnt
    from employee
)
select id, salary, company
from temp
where rnk >= cnt/2 and rnk <= cnt/2 + 1 

