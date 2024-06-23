/*
problem
    numbers (num, frequency) 
    => report median after decompress table
strategy
*/
with temp as (
    select *
    , sum(frequency) over(order by num) as cum_sum
    , sum(frequency) over() as sum_freq
    from numbers
)
select avg(num) as median
from temp
where sum_freq/2 >= cum_sum - frequency and sum_freq/2 <= cum_sum
