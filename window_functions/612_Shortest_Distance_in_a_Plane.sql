# Write your MySQL query statement below
/*
problem
    point2d  (x, y)
    => find shortest distance between any two point
strategy
    using join to get distance between any point
    relation many to many
*/
select 
round(min(sqrt(power(p1.x - p2.x, 2) + power(p1.y - p2.y, 2))), 2) as shortest
from point2d as p1
left join point2d as p2 on p1.x != p2.x or p1.y != p2.y