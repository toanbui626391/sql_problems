# Write your MySQL query statement below
/*
problem: 615. Average Salary: Departments VS Company
    compare department average to company average for each month
learning
  using window function to compute average for a group with partition
  using case when then else syntax
  using date_format() function
  using distinct
*/
with temp as (
    -- get department information and compute department avg and com avg
    select date_format(s.pay_date, "%Y-%m") as pay_month
    , e.department_id as department_id
    , avg(s.amount) over(partition by date_format(s.pay_date, "%Y-%m"), e.department_id) as avg_dept
    , avg(s.amount) over(partition by date_format(s.pay_date, "%Y-%m")) as avg_com
    from Salary as s
    left join Employee as e
    on s.employee_id = e.employee_id
)
select distinct pay_month
, department_id
, case
    when avg_dept > avg_com then "higher"
    when avg_dept = avg_com then "same"
    else "lower"
end as comparison
from temp


