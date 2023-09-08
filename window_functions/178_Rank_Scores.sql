# Write your MySQL query statement below
/*
problem
    scores (id, score)
    => rank score with:
        highest to lowest
        tie will have the same rank
        rank number is consecutive
*/
select score
, dense_rank() over(order by score desc) as `rank`
from scores