# Write your MySQL query statement below
/*
problem:
    point (x), x is the primary key. no two point at the same position
    => find shortest distance in a line
strategy
    using joiont to get distance between different point
*/
select 
min(abs(p1.x - p2.x)) as shortest
from point as p1
left join point as p2 on p1.x != p2.x