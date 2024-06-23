/*
problem: 571. Find Median Given Frequency of Numbers
  find median given num and frequency of nums
solution:
  filter num with middle point
    total_e/2 is the middle point of the numbers
    totl_e/2 >= cum_e - frequency and total_e/2 <= cum_e
*/
-- compu cumulative element
with temp as (
    select * 
    , sum(frequency) over(order by num) as cum_e
    , sum(frequency) over() as total_e
    from Numbers
)
select avg(num) as median
from temp
where total_e/2 >= cum_e-frequency and total_e/2 <= cum_e
