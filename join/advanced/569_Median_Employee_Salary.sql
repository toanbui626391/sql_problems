/*
problem
    employee (id, compnary, salary) 
    ==> find median salary for each company. 
strategy
    1.using row_number() to order sequence inside company group
    2.using count() window function to count number of element in group
note:
    when cnt/2 = 0 then rnb between cnt/2 and cnt/2 + 1
    when cnt/2 = 1 then rnb is int(cnt/2_ + 1), or between cnt/2 + cnt/2+1 

*/
with temp as (
    select *
    , row_number() over (partition by company order by salary) as rnb
    , count(*) over (partition by company) as cnt
    from employee
)
select 
id
, company
, salary 
from temp
where rnb between rnb*1.0/2 and rnb*2 + 1