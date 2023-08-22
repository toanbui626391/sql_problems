# Write your MySQL query statement below
/*
problem
    insurance (pid, tiv_2015, tiv_2016, lat, lon)
    ==> sum tiv_2016
            have the same with one or more tiv_2015
            not located in the same city
            round to 2 digit
strategy
    mark and filter data
        same tiv_2015 with other
        not located in the same city
    filter and compute total
*/
with temp as (
    select *
    , count(*) over(partition by tiv_2015) as cnt
    , count(*) over(partition by lat, lon) as p_cnt
    from insurance
)
select
round(sum(tiv_2016), 2) as tiv_2016
from temp
where temp.cnt > 1 and temp.p_cnt = 1