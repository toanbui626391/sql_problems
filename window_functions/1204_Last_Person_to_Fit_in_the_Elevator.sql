/*
problem
    queue (person_id, person_name, weight, turn)
    => find the last person which do not exceed the weight limit
strategy
    use window function to compute cummulative sum of weight
    find the last person which not exceed limit
*/
with temp as (
    select *
    , sum(weight) over(order by turn) as cum_weight
    from queue
)
select person_name
from temp
where cum_weight <= 1000
order by cum_weight desc
limit 1