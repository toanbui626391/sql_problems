/*
problem
    scores (player_name, gender, day, score_points)
strategy
    using window function to compute cummulative sume
    order by gener, day as
*/
select gender, day
, sum(score_points) over(partition by gender order by day) as total
from scores
order by gender, day